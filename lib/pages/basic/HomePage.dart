import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:task_and_earn/Util/SharedPref.dart';
import 'package:task_and_earn/models/PopularService.dart';
import 'package:task_and_earn/models/Task_Model.dart';
import 'package:task_and_earn/pages/shared/tne_drawer/tne-drawer.dart';
import 'package:task_and_earn/services/CategoryService.dart';
import 'package:task_and_earn/services/TaskService.dart';
import 'package:task_and_earn/util/Util.dart';
import 'package:task_and_earn/util/Variables.dart';
import '../shared/ProgressHUD.dart';
import 'Tasks.dart';
import '../post_a_job/CategoriesPage.dart';
import 'LoginPage.dart';
import 'package:toast/toast.dart';
import "package:task_and_earn/util/StringExtension.dart";

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task and Earn",
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        body: HomePageWidget(),
      ),
    );
  }
}

class HomePageWidget extends StatefulWidget {
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  CategoryService categoryService = new CategoryService();
  TaskService taskService =  new TaskService();
  SharedPref sharedPref = new SharedPref();
  bool isApiCallProcess = false;
  String token;
  String appVersion = "";
  dynamic loggedInUserId;
  String loggedInUserFName;
  String loggedInUserLName;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _serviceScrollController = new ScrollController();
  List<PopularService> popularServices = [];
  ScrollController _taskScrollController = new ScrollController();
  List<Task> recentTasks = [];

  @override
  void initState() {
    super.initState();
    onGetToken();
  }

  @override
  void dispose() {
    super.dispose();
    _serviceScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: _uiSetUp(context), isAsyncCall: isApiCallProcess, opacity: 0.6);
  }

  Widget _uiSetUp(BuildContext context) {
    ScreenUtil.init(BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height),
    );
    return Scaffold(
      key: _scaffoldKey,
      drawer: TneDrawer(
        appVersion: appVersion != null ? appVersion : "",
        loggedInUserFName: loggedInUserFName != null ? loggedInUserFName : "",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Icon(
                        Icons.menu,
                        size: Variables.headerMenuSize.sp,
                        color: Color(0xFF098CC3),
                    ),
                  ),
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Hi " + loggedInUserFName.capitalize(),
                    style: TextStyle(
                      fontSize: Variables.headerTextSize.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Image.asset(
                    "assets/images/hello.png",
                    height: Variables.headerMenuSizeS.sp,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Earn anytime anywhere for what you do Best.",
                    style: TextStyle(
                      fontSize: Variables.headerSubTextSize.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            Padding(padding: EdgeInsets.only(top: 10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    onRouteToCategory(true);
                  },
                  child: Container(
                    width: 140,
                    height: 150,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: new BorderSide(color: Colors.lightBlue, width: 1.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 20,
                      shadowColor: Colors.lightBlue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/head_hunting.png",
                          ),
                          Padding(padding: EdgeInsets.only(top: 10.0)),
                          Text(
                            "Post a Job",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Variables.cardTextSizeM.sp,
                              color: Color(0xFF098CC3),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(padding: EdgeInsets.only(right: 20.0)),
                GestureDetector(
                  onTap: () {
                    Util.launchURL("https://taskandearn-dev.herokuapp.com/become-earner-login");
                  },
                  child: Container(
                    width: 140,
                    height: 150,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/salary.png",
                          ),
                          Padding(padding: EdgeInsets.only(top: 10.0)),
                          Text(
                            "Become a Earner",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Variables.cardTextSizeM.sp,
                              color: Color(0xff858585),
                              fontWeight: FontWeight.bold,
                              height: 1.2.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(padding: EdgeInsets.only(top: 5.0)),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 20.0)),
                Text(
                  "Popular Services",
                  style: TextStyle(
                    fontSize: Variables.textSizeM.sp,
                    color: Color(0xFF098CC3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Container(
              height: Variables.serviceCardH.h,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 5.0),
              child: ListView.builder(
                controller: _serviceScrollController,
                scrollDirection: Axis.horizontal,
                itemCount: popularServices.length,
                itemBuilder: _serviceItemBuilder,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Recent Tasks",
                    style: TextStyle(
                      fontSize: Variables.textSizeM.sp,
                      color: Color(0xFF098CC3),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: TextButton(
                    onPressed: () {
                      onRouteAllTasks();
                    },
                    child: Text(
                      "see all",
                      style: TextStyle(
                        fontSize: Variables.textSizeS.sp,
                        color: Color(0xFF098CC3),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Container(
              height: Variables.recentTaskCardH.h,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 0.0),
              child: ListView.builder(
                controller: _taskScrollController,
                scrollDirection: Axis.horizontal,
                itemCount: recentTasks.length,
                itemBuilder: _taskItemBuilder,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _serviceItemBuilder(BuildContext context, int index) {
    var popService = this.popularServices[index];
    if(_serviceScrollController.offset == _serviceScrollController.position.minScrollExtent) {
      _serviceScrollController.animateTo(
          MediaQuery.of(context).size.width * 0.47,
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    } else {
      _serviceScrollController.position.restoreOffset(_serviceScrollController.offset);
    }
    return _serviceItemUiBuilder(popService);
  }

  Widget _serviceItemUiBuilder(PopularService popService) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.40,
      width: MediaQuery.of(context).size.width * 0.66,
      child: Card(
          elevation: 3.0,
          margin: EdgeInsets.only(right: 15.0, bottom: 3.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  popService.imagePath,
                  fit: BoxFit.fitWidth,
                  height: MediaQuery.of(context).size.width * 0.40,
                  width: MediaQuery.of(context).size.width * 0.63,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                child: Text(
                  popService.popularServiceName,
                  style: TextStyle(
                    fontSize: Variables.cardTextSizeS.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  Widget _taskItemBuilder(BuildContext context, int index) {
    if(recentTasks.length != 0) {
      var task = this.recentTasks[index];
      if(_taskScrollController.offset == _taskScrollController.position.minScrollExtent) {
        _taskScrollController.animateTo(
            MediaQuery.of(context).size.width * 0.47,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      } else {
        _taskScrollController.position.restoreOffset(_taskScrollController.offset);
      }
      return _taskItemUiBuilder(task);
    } else {
      return Container();
    }
  }

  Widget _taskItemUiBuilder(Task task) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.66,
      child: Card(
        elevation: 3.0,
        margin: EdgeInsets.only(right: 15.0, bottom: 5.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Icon(
                      Icons.watch_later_rounded,
                      color: Colors.black54,
                      size: Variables.textSizeS.sp,
                    ),
                  ),
                  Text(
                    Jiffy(DateTime(task.createdAt.year, task.createdAt.month, task.createdAt.day)).format("do MMMM, yyyy"),
                    style: TextStyle(
                      fontSize: Variables.textSizeNormal.sp,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 10.0)),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.screen_search_desktop,
                      color: Colors.black54,
                      size: Variables.textSizeS.sp,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      task.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Variables.textSizeXs.sp,
                        color: Color(0xFF098CC3),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 5.0)),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Icon(
                      Icons.person,
                      color: Colors.black54,
                      size: Variables.textSizeM.sp,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      task.user != null ? task.user.firstName + " " + task.user.lastName : "N/A",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Variables.textSizeNormal.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 5.0)),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.black54,
                      size: Variables.textSizeS.sp,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      task.address != null ? task.address.street : "N/A",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Variables.textSizeNormal.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 2.0)),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Text(
                      "City:",
                      style: TextStyle(
                        fontSize: Variables.textSizeNormal.sp,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      task.address != null ? task.address.city : "N/A",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Variables.textSizeNormal.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 2.0)),
              Row(
                children: [
                  Text(
                    "Country: ",
                    style: TextStyle(
                      fontSize: Variables.textSizeNormal.sp,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      task.address != null ? task.address.country : "N/A",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Variables.textSizeNormal.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Text(
                    "\u{20B9}" + task.price.toString(),
                    style: TextStyle(
                      fontSize: Variables.textSizeNormal.sp,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),

              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 25.0,
                    child: ElevatedButton(
                      child: Text(
                        "Become a Earner",
                        style: TextStyle(
                          fontSize: Variables.textSizeNormal.sp,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        primary: Colors.blue.shade600,
                      ),
                      onPressed: () {
                        Util.launchURL("https://taskandearn-dev.herokuapp.com/become-earner-login");
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future onGetToken() async {
    setState(() {
      isApiCallProcess = true;
    });
    token = await sharedPref.onGetSharedPreferencesValue("tokenKey");
    loggedInUserId = await sharedPref.onGetSharedPreferencesValue("loggedInUserId");
    loggedInUserFName = await sharedPref.onGetSharedPreferencesValue("loggedInUserFName");
    loggedInUserLName = await sharedPref.onGetSharedPreferencesValue("loggedInUserLName");
    appVersion = await sharedPref.onGetSharedPreferencesValue("appVersion");
    setState(() {
      token = token;
      loggedInUserId = loggedInUserId;
      loggedInUserFName = loggedInUserFName;
      loggedInUserLName = loggedInUserLName;
      appVersion = appVersion;
    });

    if(token != null) {
      await onGetPopularServices();
      await onGetAllTasks();
    } else {
      setState(() {
        isApiCallProcess = false;
      });
    }
  }

  Future onGetPopularServices() async {
    await categoryService.getPopularServices(token).then((res) => {
      if(res.success) {
        setState(() {
          popularServices = res.data.toList();
          print("hp popularServices ${popularServices.length}");
          isApiCallProcess = false;
        }),
      }
    }).catchError((e) {
      setState(() {
        isApiCallProcess = false;
      });
      print("$e");
    });
  }

  Future onGetAllTasks() async {
    setState(() {
      isApiCallProcess = true;
    });
    await taskService.getAllTasks(token).then((res) => {
      if(res.success) {
        setState(() {
          recentTasks = res.data.toList();
          print("hp recentTasks len ${recentTasks.length}");
          isApiCallProcess = false;
        }),
      }
    }).catchError((e) {
      setState(() {
        isApiCallProcess = false;
      });
      print(e);
    });
  }

  Future onLogout() async {
    onShowToast("Logout Successful", 3);
    await sharedPref.onEmptySharedPreference();
    await sharedPref.onGetSharedPreferencesValue("tokenKey");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void onRouteToCategory(bool isPostAJob) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        CategoriesPage(isPostAJob: isPostAJob)));
  }

  void onRouteAllTasks() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TasksPage(isShowAllTasks: true)));
  }

  void onShowToast(String msg, int timeInSec) {
    Toast.show(msg, context, duration: timeInSec, gravity: Toast.BOTTOM);
  }
}