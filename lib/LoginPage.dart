import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: LoginPageWidget(),
    );
  }
}

class LoginPageWidget extends StatefulWidget {
  @override
  _LoginPageWidgetSate createState() => _LoginPageWidgetSate();
}

class _LoginPageWidgetSate extends State<LoginPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.asset(
                  "assets/images/login_upper_image.png",
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
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 55.0),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.blueAccent,
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        child: RaisedButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 35.0),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.lightBlue,
                              ),
                            ),
                            splashColor: Colors.purple,
                            onPressed: () {
                              onPressedSignUpButton();
                            }),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(26.0),
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Enter email or username",
                            suffixIcon: Icon(Icons.email),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                            suffixIcon: Icon(Icons.visibility_off),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30.0),
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: MediaQuery.of(context).size.width * 0.25),
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
                      color: Colors.blueAccent,
                      splashColor: Colors.purple,
                      elevation: 9.0,
                      highlightElevation: 6.0,
                      onPressed: () {
                        onPressedLoginButton();
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

  onPressedLoginButton() {
    print("onLoginButtonPressed");
  }

  onPressedSignUpButton() {
    print("onPressedSignUpButton");
  }
}
