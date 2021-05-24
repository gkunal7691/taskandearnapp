import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:task_and_earn/Util/SharedPref.dart';
import 'package:task_and_earn/models/PopularService.dart';
import 'package:task_and_earn/models/Task_Model.dart';
import 'package:task_and_earn/models/become_a_earner/Professional.dart';
import 'package:task_and_earn/services/CategoryService.dart';
import 'package:task_and_earn/services/ProfessionalService.dart';
import 'ProgressHUD.dart';
import 'basic/AllTasks.dart';
import 'post_a_job/CategoriesPage.dart';
import 'package:task_and_earn/pages/LoginPage.dart';
import 'package:toast/toast.dart';
import "package:task_and_earn/util/StringExtension.dart";

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task and Earn",
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
  ProfessionalService professionalService = new ProfessionalService();
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
  ScrollController _topProfScrollController = new ScrollController();
  List<TopProfessional> topProfessionals = [];

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
      drawer: _drawer(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Icon(
                        Icons.menu,
                        size: 40.0,
                        color: Color(0xFF098CC3)
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
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Image.asset(
                    "assets/images/hello.png",
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
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 15.0)),
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
                              fontSize: 20.0,
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
                    onRouteToCategory(false);
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
                              fontSize: 20.0,
                              color: Color(0xff858585),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(padding: EdgeInsets.only(top: 10.0)),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 20.0)),
                Text(
                  "Popular Services",
                  style: TextStyle(
                    // fontSize: 22.0,
                    fontSize: 22.sp,
                    color: Color(0xFF098CC3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Container(
              height: MediaQuery.of(context).size.width * 0.58,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                controller: _serviceScrollController,
                scrollDirection: Axis.horizontal,
                itemCount: popularServices.length,
                itemBuilder: _serviceItemBuilder,
              ),
            ),

            Padding(padding: EdgeInsets.only(top: 10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Recent Tasks",
                    style: TextStyle(
                      fontSize: 22.0,
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
                          fontSize: 19.0,
                          color: Color(0xFF098CC3),
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                  ),
                ),
              ],
            ),

            Container(
              height: MediaQuery.of(context).size.width * 0.59,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                controller: _taskScrollController,
                scrollDirection: Axis.horizontal,
                itemCount: popularServices.length,
                itemBuilder: _taskItemBuilder,
              ),
            ),

            Padding(padding: EdgeInsets.only(top: 10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Top Professionals",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Color(0xFF098CC3),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Text(
                    "see all",
                    style: TextStyle(
                      fontSize: 19.0,
                      color: Color(0xFF098CC3),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            Container(
              height: MediaQuery.of(context).size.width * 0.68,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                controller: _topProfScrollController,
                scrollDirection: Axis.horizontal,
                itemCount: topProfessionals.length,
                itemBuilder: _topProfItemBuilder,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "Hello " + loggedInUserFName.capitalize(),
              style: TextStyle(
                fontSize: 23.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(""),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.account_circle_sharp, size: 70.0),
            ),
          ),
          ListTile(
            title: Text(
              "My Profile",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap:() {
              onShowToast("My Profile Feature is in under process", 2);
            },
          ),
          ListTile(
            title: Text(
              "My Tasks",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap:() {
              onShowToast("My Tasks Feature is in under process", 2);
            },
          ),
          Divider(
            color: Colors.black,
            height: 5.0,
          ),
          ListTile(
            title: Text(
              "All Tasks",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap:() {
              onShowToast("All Tasks Feature is in under process", 2);
            },
          ),
          ListTile(
            title: Text(
              "All Professionals",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap:() {
              onShowToast("All Professionals Feature is in under process", 2);
            },
          ),
          Divider(
            color: Colors.black,
            height: 5.0,
          ),
          ListTile(
            title: Text(
              "About",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap:() {
              onShowToast("About Feature is in under process", 2);
            },
          ),
          ListTile(
            title: Text(
              "Why Taskandearn?",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap:() {
              onShowToast("This Feature is in under process", 2);
            },
          ),
          ListTile(
            title: Text(
              "Support",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap:() {
              onShowToast("Support Feature is in under process", 2);
            },
          ),
          ListTile(
            title: Text(
              "Logout",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap:() async {
              await onLogout();
            },
          ),
          Container(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              "V " + appVersion,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ]
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
          margin: EdgeInsets.only(right: 15.0, bottom: 10.0),
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
                padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                child: Text(
                  popService.popularServiceName,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF098CC3),
                    fontWeight: FontWeight.bold,
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
        margin: EdgeInsets.only(right: 15.0, bottom: 10.0),
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
                      size: 20.0,
                    ),
                  ),
                  Text(
                    Jiffy(DateTime(task.createdAt.year, task.createdAt.month, task.createdAt.day)).format("do MMMM, yyyy"),
                    style: TextStyle(
                      fontSize: 16.0,
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
                      size: 18.0,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      task.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
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
                      size: 22.0,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      task.user != null ? task.user.firstName + " " + task.user.lastName : "N/A",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
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
                      Icons.location_pin,
                      color: Colors.black54,
                      size: 22.0,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      task.address != null ? task.address.street : "N/A",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 8.0)),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Text(
                      "City:",
                      style: TextStyle(
                        fontSize: 14.0,
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
                        fontSize: 14.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 8.0)),
              Row(
                children: [
                  Text(
                    "Country: ",
                    style: GoogleFonts.poppins(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      task.address != null ? task.address.country : "N/A",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    "\u{20B9}" + task.price.toString(),
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              Center(
                child: Container(
                  height: 30.0,
                  margin: EdgeInsets.only(top: 13.0),
                  child: ElevatedButton(
                    child: Text(
                      "Become a Earner",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      primary: Colors.blue.shade600,
                    ),
                    onPressed: () {
                      onRouteToCategory(false);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topProfItemBuilder(BuildContext context, int index) {
    if(topProfessionals.length != 0) {
      var topProfessional = this.topProfessionals[index];
      if(_topProfScrollController.offset == _topProfScrollController.position.minScrollExtent) {
        _topProfScrollController.animateTo(
            MediaQuery.of(context).size.width * 0.23,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      } else {
        _topProfScrollController.position.restoreOffset(_topProfScrollController.offset);
      }
      return _topProfItemUiBuilder(topProfessional);
    } else {
      return Container();
    }
  }

  Widget imgWidget(TopProfessional topProf) {
    var img = "";
    if(topProf.professional.proId == 35) {
      img = "https://taskandearn.com/assets/image/user.PNG";
    }
    else if(topProf.professional.proId == 36) {
      img = "https://taskandearn.com/assets/image/top-2.jpeg";
    }
    else if(topProf.professional.proId == 37) {
      img = "https://taskandearn.com/assets/image/top.png";
    }
    else if(topProf.professional.proId == 38) {
      img = "https://taskandearn.com/assets/image/top-3 - Copy.jpeg";
    }
    else if(topProf.professional.proId == 41) {
      img = "https://taskandearn.com/assets/image/top1.jpeg";
    }

    if(img.isNotEmpty) {
      return CircleAvatar(
        backgroundImage: NetworkImage(img),
        minRadius: 50.0,
        maxRadius: 50.0,
      );
    }
    else {
      return Icon(
        Icons.person,
        color: Colors.black,
        size: 100.0,
      );
    }
  }

  Widget _topProfItemUiBuilder(TopProfessional topProf) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.50,
      child: Card(
        elevation: 3.0,
        margin: EdgeInsets.only(right: 15.0, bottom: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child:  Center(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 10.0)),
              imgWidget(topProf),

              Padding(padding: EdgeInsets.only(top: 8.0)),
              Text(
                topProf.firstName,
                style: TextStyle(
                  fontSize: 17.0,
                  color: Color(0xFF098CC3),
                  fontWeight: FontWeight.bold,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                child: Text(
                  topProf.professional.category.categoryName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                      // overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 5.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Colors.black45,
                    size: 20.0,
                  ),
                  Text(
                    topProf.professional.address.city,
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 30.0,
                    margin: EdgeInsets.only(bottom: 8.0),
                    child: ElevatedButton(
                      child: Text(
                        "View Profile",
                        style: TextStyle(
                          // fontSize: 23.0,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        primary: Colors.blue.shade600,
                      ),
                      onPressed: () {
                        // onTapContinue();
                        onShowToast("Feature under process", 2);
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
      await onGetTasks();
      await onGetTopProfessionals();
    } else {
      setState(() {
        isApiCallProcess = false;
      });
    }
  }

  Future onGetPopularServices() async {
    await categoryService.getPopularServices(token).then((res) => {
      // print("hp res.data ${res.data}"),
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

  Future onGetTasks() async {
    setState(() {
      isApiCallProcess = true;
    });
    await categoryService.getTasks(token).then((res) => {
      if(res.success) {
        setState(() {
          recentTasks = res.data.toList();
          print("hp recentTasks len ${recentTasks.length}");
          // print("hp recentTasks ${recentTasks.elementAt(1).toJson()}");
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

  Future onGetTopProfessionals() async {
    setState(() {
      isApiCallProcess = true;
    });
    await professionalService.getTopProfessionals(token).then((res) => {
      if(res.success) {
        setState(() {
          topProfessionals = res.data.toList();
          print("hp topProfessionals len ${topProfessionals.length}");
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
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AllTasksPage()));
  }

  void onShowToast(String msg, int timeInSec) {
    Toast.show(msg, context, duration: timeInSec, gravity:  Toast.BOTTOM);
  }
}