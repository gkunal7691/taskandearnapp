import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_and_earn/models/User.dart';
import 'package:task_and_earn/services/ApiManager.dart';
import 'package:task_and_earn/services/UserService.dart';
import "package:task_and_earn/util/extensions.dart";
import 'package:task_and_earn/pages/basic/HomePage.dart';
import 'package:task_and_earn/util/SharedPref.dart';
import 'package:task_and_earn/util/Variables.dart';
import 'package:toast/toast.dart';
import '../ProgressHUD.dart';
import '../tne-footer.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        title: "Task and Earn",
        home: MyProfileWidget()
    );
  }
}

class MyProfileWidget extends StatefulWidget {
  @override
  _MyProfileWidgetState createState() => _MyProfileWidgetState();
}

class _MyProfileWidgetState extends State<MyProfileWidget> {
  bool isApiCallProcess = false;
  SharedPref sharedPref = new SharedPref();
  String token;
  dynamic loggedInUserId;
  UserService userService = new UserService();
  User userDetails = new User();

  @override
  void initState() {
    super.initState();
    onGetToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: _uiSetUp(context), isAsyncCall: isApiCallProcess, opacity: 0.6);
  }

  Widget _uiSetUp(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      bottomNavigationBar: TneFooter(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: Variables.headerMenuSize.h,
                        color: Variables.blueColor
                      ),
                    ),
                    onTap: () {
                      onRouteToHome();
                    },
                  ),
                  Container(
                    child: Text(
                      "My Profile",
                      style: TextStyle(
                        fontSize: Variables.headerTextSize.sp,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),

              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      userDetails != null ? "Welcome " + userDetails.firstName.capitalize() : "Welcome User",
                      style: TextStyle(
                        fontSize: Variables.headerSubTextSize.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 10.0)),
              Stack(
                children: [
                  CircularProfileAvatar(
                    ApiManager.tneBaseUrl + "/assets/icon/undraw_profile.png",
                    radius: 85,
                    backgroundColor: Colors.transparent,
                    borderWidth: 3,
                    elevation: 10.0,
                    cacheImage: true,
                  ),
                  Positioned(
                    top: 7,
                    right: 15,
                    child: Container(
                      height: 27,
                      width: 27,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Variables.blueColor,
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                        ),
                      ),
                      child: Icon(
                        Icons.edit_outlined,
                        color: Variables.blueColor,
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                height: MediaQuery.of(context).size.height * 0.50,
                margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                child: Card(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5.0),
                              child: Text(
                                "First name:",
                                style: TextStyle(
                                  fontSize: Variables.textSizeS.sp,
                                  color: Variables.blueColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                userDetails != null ? userDetails.firstName.capitalize() : "N/A",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: Variables.textSizeS.sp,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5.0),
                              child: Text(
                                "Last name:",
                                style: TextStyle(
                                  fontSize: Variables.textSizeS.sp,
                                  color: Variables.blueColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                userDetails != null ? userDetails.lastName.capitalize() : "N/A",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: Variables.textSizeS.sp,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5.0),
                              child: Text(
                                "Email:",
                                style: TextStyle(
                                  fontSize: Variables.textSizeS.sp,
                                  color: Variables.blueColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                userDetails != null ? userDetails.email != null ? userDetails.email : "N/A" : "N/A",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: Variables.textSizeS.sp,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Divider(
                          color: Variables.blueColor,
                          thickness: 1.0,
                          endIndent: 20.0,
                        ),

                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 30.0,
                              margin: EdgeInsets.only(bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    child: Text(
                                      "Edit User Profile",
                                      style: TextStyle(
                                        fontSize: Variables.textSizeNormal.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(horizontal: 13.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                      ),
                                      primary: Colors.blue.shade600,
                                    ),
                                    onPressed: () {
                                      onShowToast("Edit User Profile", 2);
                                    }
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: ElevatedButton(
                                      child: Text(
                                        "Password Reset",
                                        style: TextStyle(
                                          fontSize: Variables.textSizeNormal.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(horizontal: 13.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                        ),
                                        primary: Colors.blue.shade600,
                                      ),
                                      onPressed: () {
                                        onShowToast("Password Reset", 2);
                                      }
                                    ),
                                  )
                                ],
                              )
                            ),
                          ),
                        ),
                      ],
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
    setState(() {
      token = token;
      loggedInUserId = loggedInUserId;
    });

    if(token != null && loggedInUserId != null) {
      await onGetUserDetails();
    } else {
      setState(() {
        isApiCallProcess = false;
      });
    }
  }

  Future onGetUserDetails() async {
    setState(() {
      isApiCallProcess = true;
    });
    await userService.getUserDetails(token, loggedInUserId).then((res) => {
      if(res.success) {
        setState(() {
          userDetails = res.user;
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

  void onRouteToHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void onShowToast(String msg, int timeInSec) {
    Toast.show(msg, context, duration: timeInSec, gravity: Toast.BOTTOM);
  }
}