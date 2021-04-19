import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'NotFoundPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task and Earn',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: WelcomePage.routeName,
      routes: <String, WidgetBuilder>{
        WelcomePage.routeName: (context) => WelcomePage(),
        PageNotFound.routeName: (context) => PageNotFound(),
        ' ': (context) => WelcomePage()
      },
      onUnknownRoute: (RouteSettings setting) {
        return new MaterialPageRoute(builder: (context) => PageNotFound());
      },
    );
  }
}

class WelcomePage extends StatefulWidget {
  final String title = 'Welcome Page';
  static const String routeName = "/";

  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/taskandearn_logo.png', height: 300),
                )
              ],
            ),
          ),
          Container(
            child: Align(
              alignment: Alignment.center,
              child: Text("Task and Earn",
                style: TextStyle(color: Colors.lightBlue, fontSize: 33, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}