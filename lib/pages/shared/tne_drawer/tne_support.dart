import 'package:flutter/material.dart';
import '../ProgressHUD.dart';
import '../tne-footer.dart';

class TneSupport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        title: "Task and Earn",
        home: TneSupportWidget()
    );
  }
}

class TneSupportWidget extends StatefulWidget {
  @override
  _TneSupportWidgetState createState() => _TneSupportWidgetState();
}

class _TneSupportWidgetState extends State<TneSupportWidget> {
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
        child: Text("Tne Support"),
      ),
    );
  }
}