import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_and_earn/util/SharedPref.dart';
import 'package:task_and_earn/pages/HomePage.dart';
import 'package:task_and_earn/services/UserAuthService.dart';
import 'package:toast/toast.dart';
import 'LoginPage.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task and Earn",
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        body: SplashScreenWidget(),
      ),
    );
  }
}

class SplashScreenWidget extends StatefulWidget {
  @override
  _SplashScreenWidgetState createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  UserAuthService userAuthService = new UserAuthService();
  SharedPref sharedPref = new SharedPref();
  String token, appVersion;
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
    onGetAppVersion();
    onCheckLastLogin();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset(
              "assets/icon/app_icon.png",
              height: 300,
              color: Colors.black,
            ),
          ),
          // Padding(padding: EdgeInsets.only(top: 20.0)),
          Text(
            'Task and Earn',
            style: TextStyle(
                fontSize: 33.0,
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 8.0)),
          Text(
            "Version " + appVersion,
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.lightBlue,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          CircularProgressIndicator(
            backgroundColor: Colors.white,
            strokeWidth: 2,
          ),
        ],
      ),
    );
  }

  onCheckLastLogin() async {
    print("sp onCheckLastLogin");
    setState(() => {
      isApiCallProcess = false,
    });
    token = await sharedPref.onGetSharedPreferencesValue("tokenKey");
    print("sp token: $token");
    if(token != null) {
      userAuthService.onCheckToken(token).then((res) => {
        //print("value.success ${value.success}"),
        setState(() => {
          isApiCallProcess = false,
        }),
        if (res.success) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Last login found, redirected to Home Page"))),
          if(res.user != null) {
            if(res.user.userId != null) {
              sharedPref.onSetSharedPreferencesValue("loggedInUserId", res.user.userId.toString()),
            },
            if(res.user.firstName != null) {
              sharedPref.onSetSharedPreferencesValue("loggedInUserFName", res.user.firstName),
            },
            if(res.user.lastName != null) {
              sharedPref.onSetSharedPreferencesValue("loggedInUserLName", res.user.lastName),
            }
          },
          onRoute(),
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Type details to login"))),
          token = null,
          onRoute(),
        }
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("$e", textAlign: TextAlign.center)));
        token = null;
        startTimer();
      });
    } else {
      startTimer();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Type details to login!")));
    }
  }

  onGetAppVersion() async {
    appVersion = await userAuthService.onGetAppVersion();
    setState(() {
      appVersion = appVersion;
      sharedPref.onSetSharedPreferencesValue("appVersion", appVersion);
    });
  }

  startTimer() async {
    var duration = Duration(seconds: 2);
    return Timer(duration, onRoute);
  }

  onRoute() {
    // print("on routing");
    if(token != null) {
      print("lp on routing to HomePage");
      onShowToast("Login Successful", 4);
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => HomePage(),
      ));
    } else {
      print("lp on routing to LoginPage");
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => LoginPage(),
      ));
    }
  }

  onShowToast(String msg, int timeInSec) {
    Toast.show(msg, context, duration: timeInSec, gravity:  Toast.BOTTOM);
  }
}