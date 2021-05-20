import 'package:flutter/material.dart';
import 'package:task_and_earn/util/SharedPref.dart';
import '../../models/post_a_job/Category.dart';
import '../../models/post_a_job/SubCategory.dart';
import 'package:task_and_earn/services/CategoryService.dart';
import 'package:toast/toast.dart';
import '../ProgressHUD.dart';
import 'CategoriesPage.dart';
import 'TaskDetailsPage.dart';

// ignore: must_be_immutable
class SubCategoriesPage extends StatelessWidget {
  final bool isPostAJob;
  Category selectedCategory;
  List<int> selectedSubCategories;
  TaskDetails taskDetails;
  Address address;

  SubCategoriesPage({
    Key key,
    @required this.isPostAJob,
    @required this.selectedCategory,
    @required this.selectedSubCategories,
    @required this.taskDetails,
    @required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task and Earn",
      home: SubCategoriesPageWidget(
        isPostAJob: isPostAJob,
        selectedCategory: selectedCategory,
        selectedSubCategories: selectedSubCategories,
        taskDetails: taskDetails,
        address: address,
      ),
    );
  }
}

// ignore: must_be_immutable
class SubCategoriesPageWidget extends StatefulWidget {
  final bool isPostAJob;
  Category selectedCategory;
  List<int> selectedSubCategories;
  TaskDetails taskDetails;
  Address address;

  SubCategoriesPageWidget({
    Key key,
    @required this.isPostAJob,
    @required this.selectedCategory,
    @required this.selectedSubCategories,
    @required this.taskDetails,
    @required this.address,
  }) : super(key: key);

  @override
  _SubCategoriesPageWidgetState createState() => _SubCategoriesPageWidgetState();
}

class _SubCategoriesPageWidgetState extends State<SubCategoriesPageWidget> {
  CategoryService categoryService = new CategoryService();
  SharedPref sharedPref = new SharedPref();
  bool isShowEmptyError = false;
  bool isApiCallProcess = false;
  String token;

  ScrollController _scrollController = ScrollController();
  List<SubCategory> subCategories = [];
  List<int> selectedSubCategories = [];

  @override
  void initState() {
    super.initState();
    onGetToken();
    onGetSubCategories();
    print("scp selectedCategory ${widget.selectedCategory.toJson()}");
    print("scp selectedSubCategories ${widget.selectedSubCategories}");
    if(widget.selectedSubCategories != null) {
      setState(() {
        selectedSubCategories = widget.selectedSubCategories;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: _uiSetUp(context), isAsyncCall: isApiCallProcess, opacity: 0.3);
  }

  Widget _uiSetUp(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 20.0)),
                Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Icon(Icons.arrow_back_ios, size: 35.0, color: Color(0xFF098CC3)),
                      ),
                      onTap: () {
                        onRouteCategoriesPage();
                      },
                    ),
                    Container(
                      child: Text(
                        widget.selectedCategory.categoryName,
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 55.0, top: 10.0),
                      child: Text(
                        "Select other services",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
                !isShowEmptyError ? Row() : Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          "No services for this category",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15.0),
                      height: MediaQuery.of(context).size.height - 180.0,
                      child: Scrollbar(
                        isAlwaysShown: true,
                        controller: _scrollController,
                        thickness: 8.0,
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: subCategories.length,
                          itemBuilder: _listViewItemBuilder,
                        ),
                      ),
                    ),
                  ],
                ),
                subCategories.isEmpty ? Center() : Center(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        margin: EdgeInsets.only(top: 10.0),
                        child: ElevatedButton(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 23.0,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            primary: Colors.blue.shade600,
                          ),
                          onPressed: selectedSubCategories.isEmpty ? null : () {
                            onPressSubmit();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ),
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var subCategory = this.subCategories[index];
    bool isSel = selectedSubCategories.contains(subCategory.subCategoryId) ? true : false;
    return Card(
      shape: RoundedRectangleBorder(
        side: isSel ? BorderSide(color: Colors.blue, width: 1.5) : BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10.0),
      ),
      shadowColor: isSel ? Colors.blue : Colors.grey,
      elevation: 15.0,
      margin: EdgeInsets.only(left: 20, right: 20, top: 7.0, bottom: 7.0),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 5.0),
        leading: _buildCheckBox(subCategory),
        title: _itemTitle(subCategory),
        onTap: () {
          onSelectSubCategory(subCategory);
        },
      ),
    );
  }

  Widget _buildCheckBox(SubCategory subCategory) {
    return Checkbox(
      value: selectedSubCategories.contains(subCategory.subCategoryId) ? true : false,
      onChanged: (value) {
        onSelectSubCategory(subCategory);
      },
    );
  }

  Widget _itemTitle(SubCategory subCategory) {
    bool isSel = selectedSubCategories.contains(subCategory.subCategoryId) ? true : false;
    return Text(
      subCategory.SubCategoryName,
      style: TextStyle(
        fontSize: 16.0,
        color: isSel ? Colors.blue : Colors.grey.shade600,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  onSelectSubCategory(SubCategory subCategory) {
    // print("onCheckedSubCategory ${subCategory.subCategoryId} ${subCategory.SubCategoryName}");
    if(selectedSubCategories.contains(subCategory.subCategoryId)) {
      setState(() {
        selectedSubCategories.remove(subCategory.subCategoryId);
      });
    } else {
      setState(() {
        selectedSubCategories.add(subCategory.subCategoryId);
      });
    }
    // print("onCheckedSubCategory $selectedSubCategories");
  }

  Future onGetToken() async {
    token = await sharedPref.onGetSharedPreferencesValue("tokenKey");
    setState(() {
      token = token;
    });
  }

  Future onGetSubCategories() async {
    setState(() {
      isApiCallProcess = true;
    });
    await categoryService.onGetSubCategories(token, widget.selectedCategory.categoryId).then((value) => {
      // print("scp ${value.toJson()}"),
      if(value.success) {
        setState(() {
          subCategories = value.data.toList();
          isApiCallProcess = false;
          if(subCategories.isEmpty) {
            isShowEmptyError = true;
          }
        }),
      }
    }).catchError((onError) {
      setState(() {
        isApiCallProcess = false;
      });
      onShowToast("$onError", 3);
    });
  }

  void onRouteCategoriesPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        CategoriesPage(isPostAJob: widget.isPostAJob)));
  }

  void onPressSubmit() {
    // print("selectedCategories.length ${selectedSubCategories.length}");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        TaskDetailsPage(
            isPostAJob: widget.isPostAJob,
            selectedCategory: widget.selectedCategory,
            selectedSubCategories: selectedSubCategories,
            taskDetails: widget.taskDetails,
            address: widget.address,
        )));
  }

  onShowToast(String msg, int timeInSec) {
    Toast.show(msg, context, duration: timeInSec, gravity: Toast.BOTTOM);
  }
}