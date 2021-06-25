import 'package:flutter/material.dart';
import '../ProgressHUD.dart';
import '../tne-footer.dart';

class WhyTne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        title: "Task and Earn",
        home: WhyTneWidget()
    );
  }
}

class WhyTneWidget extends StatefulWidget {
  @override
  _WhyTneWidgetState createState() => _WhyTneWidgetState();
}

class _WhyTneWidgetState extends State<WhyTneWidget> {
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
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
        child: Text("Why Tne"),
      ),
    );
  }
}