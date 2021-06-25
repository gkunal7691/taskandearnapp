import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_and_earn/models/SignUp_Model.dart';
import 'package:task_and_earn/services/UserService.dart';
import 'package:toast/toast.dart';
import 'LoginPage.dart';
import '../shared/ProgressHUD.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task and Earn",
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        body: SignUpPageWidget(),
      ),
    );
  }
}

class SignUpPageWidget extends StatefulWidget {
  @override
  _SignUpPageWidgetSate  createState() => _SignUpPageWidgetSate();
}

class _SignUpPageWidgetSate extends State<SignUpPageWidget> {
  UserService userAuthService = new UserService();
  SignUpRequestModel signUpRequestModel;
  bool isApiCallProcess = false;
  final _singUpFormKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  final confPwdController = TextEditingController();
  bool isHidePassword = true;
  List<bool> isSelected;
  // bool _autoValidateMode = true;

  @override
  void initState() {
    super.initState();
    isSelected = <bool>[false, true];
    signUpRequestModel = new SignUpRequestModel();
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    pwdController.clear();
    confPwdController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    pwdController.dispose();
    confPwdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: _uiSetUp(context), isAsyncCall: isApiCallProcess, opacity: 0.3);
  }

  Widget _uiSetUp(BuildContext context) {
    return Form(
      // autovalidateMode: _autoValidateMode ? AutovalidateMode.always : AutovalidateMode.disabled,
      key: _singUpFormKey,
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.asset(
                  "assets/images/sign_up.png",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.27,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Create an Account",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Color(0xFF039BE5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 7.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleButtons(
                    isSelected: isSelected,
                    borderRadius: BorderRadius.circular(50.0),
                    // selectedColor: Colors.white,
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
                              color: Color(0xFF039BE5),
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
                            color: Colors.white,
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
                      if(index == 0) {
                        onRouteToLoginPage();
                      }
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        width: MediaQuery.of(context).size.width * 0.475,
                        child: TextFormField(
                          controller: firstNameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "First Name",
                            labelText: "Enter First Name",
                          ),
                          onSaved: (input) => {
                            signUpRequestModel.firstName = input,
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "First Name cannot be blank";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        width: MediaQuery.of(context).size.width * 0.475,
                        child: TextFormField(
                          controller: lastNameController,
                          keyboardType: TextInputType.text,
                          onSaved: (input) => {
                            signUpRequestModel.lastName = input,
                          },
                          decoration: InputDecoration(
                            hintText: "Last Name",
                            labelText: "Enter Last Name",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Last Name cannot be blank";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.text,
                      onSaved: (input) => {
                        signUpRequestModel.email = input,
                      },
                      decoration: InputDecoration(
                        hintText: "Email or username",
                        labelText: "Enter email or username",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Email or username cannot be blank";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextFormField(
                      controller: pwdController,
                      obscureText: isHidePassword,
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (input) => {
                        signUpRequestModel.password = input,
                      },
                      decoration: InputDecoration(
                        hintText: "Password",
                        labelText: "Enter Password",
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
                          return "Password cannot be blank";
                        }
                        else if(value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextFormField(
                      controller: confPwdController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (input) => {
                        signUpRequestModel.confirmPassword = input,
                      },
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        labelText: "Enter Confirm Password",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Confirm Password cannot be blank";
                        } else {
                          if(value != pwdController.text) {
                            return "Password & Confirm Password must be same";
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: MediaQuery.of(context).size.width * 0.25),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.white,
                    ),
                  ),
                  color: Color(0xFF039BE5),
                  splashColor: Colors.purple,
                  elevation: 9.0,
                  highlightElevation: 6.0,
                  onPressed: () {
                    if (_singUpFormKey.currentState.validate()) {
                      _singUpFormKey.currentState.save();
                      setState(() {
                        isApiCallProcess = true;
                      });
                      userAuthService.onSignUp(signUpRequestModel).then((res) => {
                        setState(() {
                          isApiCallProcess = false;
                          // _autoValidateMode = false;
                        }),
                        //print(value.success),
                        if(!res.success) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Something went wrong, please try again!"))),
                        },
                        if(res.success) {
                          onShowToast("User created successfully, please login now", 4),
                          onRouteToLoginPage(),
                        }
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Data is in processing.')));
                    } else {
                      // setState(() {
                      //   _autoValidateMode = true;
                      // });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onRouteToLoginPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => LoginPage()
    ));
  }

  void onShowToast(String msg, int timeInSec) {
    Toast.show(msg, context, duration: timeInSec, gravity:  Toast.BOTTOM);
  }
}