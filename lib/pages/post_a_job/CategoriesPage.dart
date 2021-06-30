import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_and_earn/models/Task_Model.dart';
import 'package:task_and_earn/models/post_a_job/PostAJob.dart';
import 'package:task_and_earn/util/SharedPref.dart';
import 'package:task_and_earn/util/Util.dart';
import 'package:task_and_earn/util/Variables.dart';
import '../../models/post_a_job/Category.dart';
import 'package:task_and_earn/services/CategoryService.dart';
import '../basic/HomePage.dart';
import '../shared/ProgressHUD.dart';
import 'TaskDetailsPage.dart';

class CategoriesPage extends StatelessWidget {
  final CategoryData categoryData;
  final Task task;
  final Address address;

  CategoriesPage({
    Key key,
    @required this.categoryData,
    @required this.task,
    @required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task and Earn",
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      home: CategoriesPageWidget(
        categoryData: categoryData,
        task: task,
        address: address,
      ),
    );
  }
}

class CategoriesPageWidget extends StatefulWidget {
  final CategoryData categoryData;
  final Task task;
  final Address address;

  CategoriesPageWidget({
    Key key,
    @required this.categoryData,
    @required this.task,
    @required this.address,
  }) : super(key: key);

  @override
  _CategoriesPageWidgetState createState() => _CategoriesPageWidgetState();
}

class _CategoriesPageWidgetState extends State<CategoriesPageWidget> {
  CategoryService categoryService = new CategoryService();
  SharedPref sharedPref = new SharedPref();
  bool isApiCallProcess = false;
  String token;
  ScrollController _scrollController = ScrollController();
  final _searchFormKey = GlobalKey<FormState>();
  final _searchQuery = TextEditingController();
  final nameController = TextEditingController();
  List<Category> categories = [];
  List<Category> tempCategories = [];
  CategoryData categoryData = new CategoryData();

  @override
  void initState() {
    super.initState();
    onGetToken();
    onGetCategories();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _searchQuery.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: _uiSetUp(context), isAsyncCall: isApiCallProcess, opacity: 0.3);
  }

  Widget _uiSetUp(BuildContext context) {
    ScreenUtil.init(BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height),
    );
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
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: Variables.headerMenuSize.sp,
                        color: Color(0xFF098CC3),
                      ),
                    ),
                    onTap: () {
                      onRouteToHome();
                    },
                  ),
                  Container(
                    child: Text(
                      "Post a Job",
                      style: TextStyle(
                        fontSize: Variables.headerTextSize.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 55.0),
                    child: Text(
                      "Select task category.",
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 10.0)),
              Container(
                height: 40.0,
                child: Form(
                  key: _searchFormKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: TextFormField(
                      controller: _searchQuery,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                        hintText: "Search for category",
                        labelText: "Search for category",
                        contentPadding: EdgeInsets.only(left: 25.0),
                        suffixIcon: Icon(Icons.search),
                      ),
                      style: TextStyle(
                        fontSize: Variables.textSizeS.sp,
                      ),
                      onChanged: (value) {
                        onFilterCategories();
                      },
                    ),
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 5.0)),
              Container(
                height: MediaQuery.of(context).size.height * 0.50,
                child: Scrollbar(
                  isAlwaysShown: true,
                  controller: _scrollController,
                  thickness: 8.0,
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: PageScrollPhysics(),
                    itemCount: categories.length,
                    itemBuilder: _listViewItemBuilder,
                  ),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 5.0,
                      blurRadius: 7.0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Card(
                  elevation: 0.0,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Row(
                          children: [
                            Radio(
                              value: PostType.individual,
                              groupValue: categoryData.postType,
                              onChanged: (value) {
                                setState(() {
                                  categoryData.postType = value;
                                });
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  categoryData.postType = PostType.individual;
                                });
                              },
                              child: Text(
                                "Individual",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Variables.textSizeS.sp,
                                ),
                              ),
                            ),
                            Radio(
                              value: PostType.company,
                              groupValue: categoryData.postType,
                              onChanged: (value) {
                                setState(() {
                                  categoryData.postType = value;
                                });
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  categoryData.postType = PostType.company;
                                });
                              },
                              child: Text(
                                "Company",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Variables.textSizeS.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Form(
                          child: TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              labelText: "Enter name",
                              labelStyle: TextStyle(
                                fontSize: Variables.textSizeXs.sp,
                              ),
                              hintText: "Name",
                              hintStyle: TextStyle(
                                fontSize: Variables.textSizeXs.sp,
                              ),
                            ),
                            style: TextStyle(fontSize: Variables.textSizeXs.sp),
                            onChanged: (input) {
                              setState(() {
                                categoryData.name = input;
                              });
                            },
                          ),
                        ),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.50,
                        margin: EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          child: Text(
                            "Next",
                            style: TextStyle(
                              fontSize: Variables.textSizeSl.sp,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            primary: Colors.blue.shade600,
                          ),
                          onPressed: () {
                            onClickNext();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward, size: 35.0),
        onPressed: () {
          onPressGoUp();
        },
      ),
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var category = this.categories[index];
    bool isSelected = categoryData.category == category.categoryId ? true : false;
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          side: isSelected ? BorderSide(color: Colors.blue, width: 1.5) : BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10.0,
        shadowColor: isSelected ? Variables.blueColor : Colors.grey,
        margin: EdgeInsets.only(left: 20, right: 20, top: 8.0, bottom: 8.0),
        child: ListTile(
          contentPadding: EdgeInsets.all(10.0),
          leading: _itemThumbnail(category),
          title: _itemTitle(category),
        ),
      ),
      onTap: () {
        // print("onSelectCategory ${category.toJson()}");
        setState(() {
          categoryData.selectedCategory = category;
          categoryData.category = category.categoryId;
        });
      },
    );
  }

  Widget _itemThumbnail(Category category) {
    String img = "https://miro.medium.com/max/74/1*LDhO2cZl9_ROLxXT_W4qhw.png";
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      constraints: BoxConstraints.tightFor(height: 40.0, width: 40.0),
      child: category.imagePath == null ? null :
        Image.network(
          img,
          fit: BoxFit.fitWidth,
          color: Color(0xFF098CC3),
        ),
    );
  }

  Widget _itemTitle(Category category) {
    return Text(
      category.categoryName,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Future onGetToken() async {
    token = await sharedPref.onGetSharedPreferencesValue("tokenKey");
    setState(() {
      token = token;
    });
  }

  Future onGetCategories() async {
    setState(() {
      isApiCallProcess = true;
    });
    await categoryService.onGetCategories(token).then((res) => {
      if(res.success) {
        setState(() {
          categories = res.data.toList();
          tempCategories = res.data.toList();
          isApiCallProcess = false;

          if(widget.categoryData != null) {
            print("cp category ${widget.categoryData.toJson()}");
            setState(() {
              categoryData = widget.categoryData;
              nameController.text = categoryData.name;
            });
          }
        }),
      }
    });
  }

  void onFilterCategories() {
    if(_searchQuery.text != null) {
      categories.clear();
      tempCategories.forEach((element) {
        if (element.categoryName.toLowerCase().contains(_searchQuery.text.toLowerCase())) {
          categories.add(element);
        }
      });
    } else {
      categories = tempCategories;
    }
    setState(() {
      categories = categories;
    });
  }

  void onPressGoUp() {
    _scrollController.animateTo(100.0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void onRouteToHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void onClickNext() {
    // print("CategoryData ${categoryData.toJson()}");
    if(categoryData.selectedCategory != null && categoryData.category != null &&
        categoryData.postType != null && categoryData.name != null) {
      Util.onShowToast(context, "Enter details to proceed", 2);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
          TaskDetailsPage(
            categoryData: categoryData,
            task: widget.task,
            address: widget.address,
          )));
    } else {
      if(categoryData.selectedCategory == null || categoryData.category == null) {
        Util.onShowToast(context, "Please select one category", 2);
      }
      else if(categoryData.postType == null) {
        Util.onShowToast(context, "Please select one post type", 2);
      }
      else if(categoryData.name == null) {
        Util.onShowToast(context, "Please enter name", 2);
      }
    }
  }
}