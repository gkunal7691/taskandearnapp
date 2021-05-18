import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_and_earn/util/SharedPref.dart';
import 'package:task_and_earn/models/Login_Model.dart';
import 'package:task_and_earn/pages/HomePage.dart';
import 'package:task_and_earn/pages/ProgressHUD.dart';
import 'package:task_and_earn/services/UserAuthService.dart';
import 'package:toast/toast.dart';
import 'SignUpPage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task and Earn",
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        body: LoginPageWidget(),
      ),
    );
  }
}

class LoginPageWidget extends StatefulWidget {
  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  UserAuthService userAuthService = new UserAuthService();
  SharedPref sharedPref = new SharedPref();
  LoginRequestModel loginRequestModel;
  bool isApiCallProcess = false;
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isHidePassword = true;
  List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = <bool>[true, false];
    loginRequestModel = new LoginRequestModel();
    userNameController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: _uiSetUp(context), isAsyncCall: isApiCallProcess, opacity: 0.3);
  }

  Widget _uiSetUp(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.asset(
                  "assets/images/login.png",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.24,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Column(
                children: [
                  Container(
                    child: Text(
                      "Welcome Back",
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Color(0xFF039BE5),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ToggleButtons(
                        borderRadius: BorderRadius.circular(50.0),
                        selectedColor: Colors.white,
                        fillColor: Color(0xFF039BE5),
                        splashColor: Colors.purple,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 23.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 23.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF039BE5),
                              ),
                            ),
                          ),
                        ],
                        onPressed: (int index) {
                          setState(() {
                            for (int i = 0; i < isSelected.length; i++) {
                              isSelected[i] = i == index;
                            }
                          });
                          if(index == 1) {
                            onPressedSignUpButton();
                          }
                        },
                        isSelected: isSelected,
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(26.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: userNameController,
                          onSaved: (input) => loginRequestModel.email = input,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Enter email or username",
                            labelText: "Enter email or username",
                            suffixIcon: Icon(Icons.email),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter email or username";
                            }
                            return null;
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        TextFormField(
                          controller: passwordController,
                          onSaved: (input) => {
                            loginRequestModel.password = input,
                          },
                          obscureText: isHidePassword,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                            labelText: "Password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isHidePassword = !isHidePassword;
                                });
                              },
                              icon: Icon(isHidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter Password";
                            }
                            else if(value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30.0),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: MediaQuery.of(context).size.width * 0.25),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.white,
                        ),
                      ),
                      color: Color(0xFF039BE5),
                      splashColor: Colors.purple,
                      elevation: 15.0,
                      highlightElevation: 6.0,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          setState(() {
                            isApiCallProcess = true;
                          });
                          await userAuthService.onLogin(loginRequestModel).then((value) async {
                            setState(() {
                              isApiCallProcess = false;
                            });
                            // print("value.success ${value.success}");
                            if(value.success && value.data.token.isNotEmpty) {
                              print("lp value.data.token: ${value.data.token}");
                              await onCheckToken(value.data.token);
                              sharedPref.onSetSharedPreferencesValue("tokenKey", value.data.token);
                              onRouteToHome();
                            }
                            else if(!value.success && value.error.name != null) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(value.error.name)));
                            }
                          });

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Data is in processing.')));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  onPressedLoginButton(key) {
    print("onLoginButtonPressed " + key.currentState.validate().toString());
  }

  onPressedSignUpButton() {
    print("onPressedSignUpButton");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  onRouteToHome() {
    // print("onRouteToHome");
    onShowToast("Login Successful", 4);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  Future onCheckToken(String token) async {
    await userAuthService.onCheckToken(token).then((res) => {
      if (res.success) {
        //print("lp value.user: ${value.user.toJson()}"),
        sharedPref.onSetSharedPreferencesValue("loggedInUserId", res.user.userId.toString()),
        if(res.user.firstName != null) {
          sharedPref.onSetSharedPreferencesValue("loggedInUserFName", res.user.firstName),
        },
        if(res.user.lastName != null) {
          sharedPref.onSetSharedPreferencesValue("loggedInUserLName", res.user.lastName),
        }
      }
    });
  }

  onShowToast(String msg, int timeInSec) {
    Toast.show(msg, context, duration: timeInSec, gravity:  Toast.BOTTOM);
  }
}