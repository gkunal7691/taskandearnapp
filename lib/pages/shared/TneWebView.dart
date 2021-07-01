import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:task_and_earn/pages/basic/HomePage.dart';
import 'package:task_and_earn/util/Variables.dart';

class TneWebView extends StatelessWidget {
  final String launchUrl;

  TneWebView({
    Key key,
    @required this.launchUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task and Earn",
      home: TneWebViewWidget(launchUrl: launchUrl),
    );
  }
}

class TneWebViewWidget extends StatefulWidget {
  final String launchUrl;

  TneWebViewWidget({
    Key key,
    @required this.launchUrl
  }) : super(key: key);

  @override
  _TneWebViewWidgetState createState() => _TneWebViewWidgetState();
}

class _TneWebViewWidgetState extends State<TneWebViewWidget> {
  FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();

  Future _onWillPop(BuildContext context) async {
    flutterWebviewPlugin.canGoBack().then((value) {
      if (value) {
        flutterWebviewPlugin.goBack();
      } else {
        // Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    flutterWebviewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _onWillPop(context),
      child: WebviewScaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.clear),
            color: Colors.black,
            onPressed: () {
              print("go back");
              _onWillPop(context);
            },
          ),
          leadingWidth: 40.0,
          titleSpacing: 0.0,
          title: Text(
            widget.launchUrl,
            style: TextStyle(
              fontSize: Variables.textSizeXs.sp,
            ),
          ),
          elevation: 1.0,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => flutterWebviewPlugin.reload(),
            )
          ],
        ),
        url: widget.launchUrl,
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initialChild: Container(
          child: Center(
            child: Text(
              "Waiting....",
              style: TextStyle(
                fontSize: Variables.textSizeS.sp,
                color: Variables.blueColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}