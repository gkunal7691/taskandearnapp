import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task_and_earn/LoginPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StartState();
  }
}

class StartState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => LoginPage()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task and Earn"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset("assets/images/app_logo.png", height: 300),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
                "Task and Earn",
              style: TextStyle(
                  fontSize: 33.0,
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 2,
            )
          ],
        ),
      ),
    );
  }
}