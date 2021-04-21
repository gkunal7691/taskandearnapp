import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpPageWidget(),
    );
  }
}

class SignUpPageWidget extends StatefulWidget {
  @override
  _SignUpPageWidgetSate  createState() => _SignUpPageWidgetSate();
}

class _SignUpPageWidgetSate extends State<SignUpPageWidget> {
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
                        "assets/images/signup.png",
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
                      ],
                    ),
                  ],
                ),
            ),
        ),
    );
  }
}