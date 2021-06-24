import 'package:flutter/material.dart';
import 'package:task_and_earn/util/SharedPref.dart';
import "package:task_and_earn/util/StringExtension.dart";
import 'package:toast/toast.dart';

import '../LoginPage.dart';

class TneDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TneDrawerWidget(),
      ),
    );
  }
}

class TneDrawerWidget extends StatefulWidget {
  @override
  _TneDrawerWidgetState createState() => _TneDrawerWidgetState();
}

class _TneDrawerWidgetState extends State<TneDrawerWidget> {
  SharedPref sharedPref = new SharedPref();
  String appVersion = "";
  String loggedInUserFName;
  String loggedInUserLName;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

  Future onLogout() async {
    onShowToast("Logout Successful", 3);
    await sharedPref.onEmptySharedPreference();
    await sharedPref.onGetSharedPreferencesValue("tokenKey");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void onShowToast(String msg, int timeInSec) {
    Toast.show(msg, context, duration: timeInSec, gravity:  Toast.BOTTOM);
  }
}