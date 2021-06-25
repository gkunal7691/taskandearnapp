import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_and_earn/pages/basic/LoginPage.dart';
import 'package:task_and_earn/pages/basic/Tasks.dart';
import 'package:task_and_earn/pages/shared/tne_drawer/tne_support.dart';
import 'package:task_and_earn/pages/shared/tne_drawer/why_tne.dart';
import 'package:task_and_earn/util/SharedPref.dart';
import "package:task_and_earn/util/StringExtension.dart";
import 'package:task_and_earn/util/Variables.dart';
import 'package:toast/toast.dart';
import 'about_us.dart';
import 'my_profile.dart';

class TneDrawer extends StatelessWidget {
  final String appVersion;
  final String loggedInUserFName;

  const TneDrawer({
    Key key,
    @required this.appVersion,
    @required this.loggedInUserFName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onShowToast(String msg, int timeInSec) {
      Toast.show(msg, context, duration: timeInSec, gravity: Toast.BOTTOM);
    }

    Future onLogout() async {
      onShowToast("Logout Successful", 3);
      SharedPref sharedPref = new SharedPref();
      await sharedPref.onEmptySharedPreference();
      await sharedPref.onGetSharedPreferencesValue("tokenKey");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }

    return Drawer(
      child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 70.0,
              decoration: BoxDecoration(
                color: Variables.blueColor,
              ),
              child: Center(
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 10.0),
                  horizontalTitleGap: 5.0,
                  leading: Icon(
                    Icons.account_circle_sharp,
                    size: 50.0,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Hello " + loggedInUserFName.capitalize(),
                    style: TextStyle(
                      fontSize: Variables.textSizeL.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                "My Profile",
                style: TextStyle(
                  fontSize: Variables.textSizeM.sp,
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap:() {
                onShowToast("Redirecting to My Profile...", 2);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyProfile()));
              },
            ),
            ListTile(
              title: Text(
                "My Tasks",
                style: TextStyle(
                  fontSize: Variables.textSizeM.sp,
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap:() {
                onShowToast("Redirecting to My Tasks...", 2);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TasksPage(isShowAllTasks: false)));
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
                  fontSize: Variables.textSizeM.sp,
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap:() {
                onShowToast("Redirecting to All Tasks...", 2);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TasksPage(isShowAllTasks: true)));
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
                  fontSize: Variables.textSizeM.sp,
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap:() {
                onShowToast("Redirecting...", 2);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
            ListTile(
              title: Text(
                "Why Taskandearn?",
                style: TextStyle(
                  fontSize: Variables.textSizeM.sp,
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap:() {
                onShowToast("Redirecting...", 2);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WhyTne()));
              },
            ),
            ListTile(
              title: Text(
                "Support",
                style: TextStyle(
                  fontSize: Variables.textSizeM.sp,
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap:() {
                onShowToast("Redirecting...", 2);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TneSupport()));
              },
            ),
            ListTile(
              title: Text(
                "Logout",
                style: TextStyle(
                  fontSize: Variables.textSizeM.sp,
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap:() async {
                onShowToast("Logging you out...", 2);
                await onLogout();
              },
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "V " + appVersion,
                style: TextStyle(
                  fontSize: Variables.textSizeXs.sp,
                ),
              ),
            ),
          ]
      ),
    );
  }
}