import 'package:flutter/material.dart';
import 'package:task_and_earn/Util/SharedPref.dart';
import 'post_a_job/CategoriesPage.dart';
import 'package:task_and_earn/pages/LoginPage.dart';
import 'package:toast/toast.dart';
import "package:task_and_earn/util/StringExtension.dart";

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  SharedPref sharedPref = new SharedPref();
  String token;
  String appVersion = "";
  dynamic loggedInUserId;
  String loggedInUserFName;
  String loggedInUserLName;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    onGetToken();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _drawer(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Icon(
                        Icons.sort,
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
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Popular Services",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Color(0xFF098CC3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
              print("on tap My Profile");
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
              print("on tap My Tasks");
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
              print("on tap All Tasks");
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
              print("on tap All Professionals");
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
              print("on tap About");
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
              print("on tap Why Task and earn?");
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
              print("on tap Support");
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

  Future onGetToken() async {
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
  }

  Future onLogout() async {
    onShowToast("Logout Successful", 3);
    await sharedPref.onEmptySharedPreference();
    await sharedPref.onGetSharedPreferencesValue("tokenKey");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void onShowToast(String msg, int timeInSec) {
    Toast.show(msg, context, duration: timeInSec, gravity:  Toast.BOTTOM);
  }

  void onRouteToCategory(bool isPostAJob) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        CategoriesPage(isPostAJob: isPostAJob)));
  }
}