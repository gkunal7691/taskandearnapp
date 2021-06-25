import 'package:flutter/material.dart';
import 'package:task_and_earn/pages/become_a_earner/AboutYourself.dart';
import 'package:task_and_earn/util/SharedPref.dart';
import '../../models/post_a_job/Category.dart';
import 'SubCategoriesPage.dart';
import 'package:task_and_earn/services/CategoryService.dart';
import 'package:toast/toast.dart';
import '../basic/HomePage.dart';
import '../shared/ProgressHUD.dart';

class CategoriesPage extends StatelessWidget {
  final bool isPostAJob;

  const CategoriesPage({Key key, @required this.isPostAJob}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task and Earn",
      home: CategoriesPageWidget(isPostAJob: isPostAJob),
    );
  }
}

class CategoriesPageWidget extends StatefulWidget {
  final bool isPostAJob;

  const CategoriesPageWidget({Key key, @required this.isPostAJob}) : super(key: key);

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
  List<Category> categories = [];
  List<Category> tempCategories = [];

  @override
  void initState() {
    super.initState();
    print("cp isPostAJob ${widget.isPostAJob}");
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
                      onRouteHome();
                    },
                  ),
                  Container(
                    child: Text(
                      widget.isPostAJob ? "Post a Job" : "Become a earner",
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
                    padding: EdgeInsets.only(left: 55.0),
                    child: Text(
                      widget.isPostAJob ? "Select task category." : "Select the category you want to work.",
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 15.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
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
                          fontSize: 20.0,
                        ),
                        onChanged: (value) {
                          onFilterCategories();
                        },
                      ),
                    ),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 175.0,
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
                ],
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
    return GestureDetector(
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.only(left: 20, right: 20, top: 8.0, bottom: 8.0),
        child: ListTile(
          contentPadding: EdgeInsets.all(10.0),
          leading: _itemThumbnail(category),
          title: _itemTitle(category),
        ),
      ),
      onTap: () {
        onSelectCategory(category);
      },
    );
  }

  Widget _itemThumbnail(Category category) {
    String img = "https://miro.medium.com/max/74/1*LDhO2cZl9_ROLxXT_W4qhw.png";
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      constraints: BoxConstraints.tightFor(height: 40.0, width: 40.0),
      child: category.imagePath == null ? null : Image.network(img, fit: BoxFit.fitWidth, color: Color(0xFF098CC3)),
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

  onPressGoUp() {
    // print("onPressGoUp");
    _scrollController.animateTo(100.0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void onSelectCategory(Category category) {
    // print("cp category: ${category.toJson()}");
    if(widget.isPostAJob) {
      if(category != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
            SubCategoriesPage(
                isPostAJob: widget.isPostAJob,
                selectedCategory: category,
                selectedSubCategories: [],
                taskDetails: null, address: null,
            )));
      } else {
        onShowToast("Something went wrong, please try again", 2);
      }
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
          AboutYourselfPage(
            isPostAJob: widget.isPostAJob,
            selectedCategory: category, about: null,
          )));
    }
  }

  void onRouteHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  onShowToast(String msg, int timeInSec) {
    Toast.show(msg, context, duration: timeInSec, gravity:  Toast.BOTTOM);
  }
}