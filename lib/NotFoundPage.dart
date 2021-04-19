import 'package:flutter/material.dart';

class PageNotFound extends StatelessWidget {
  static const String routeName = "/notFound";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageNotFoundWidget(title: 'Page not found!'),
    );
  }
}

class PageNotFoundWidget extends StatefulWidget {
  PageNotFoundWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PageNotFoundWidgetState createState() => _PageNotFoundWidgetState();
}

class _PageNotFoundWidgetState extends State<PageNotFoundWidget> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: new Text(widget.title),
      ),
    );
  }
}