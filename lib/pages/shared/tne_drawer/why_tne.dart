import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_and_earn/util/Util.dart';
import 'package:task_and_earn/util/Variables.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Why Task And Earn?",
              style: TextStyle(
                fontSize: Variables.textSizeL.sp,
                color: Variables.blueColor,
                fontWeight: FontWeight.bold,
              ),
            ),

            Padding(padding: EdgeInsets.only(top: 10.0)),
            Text(
              "What is certainly better than a free service? That’s right, "
                  "to use Task and Earn, we aim to provide help with no cost for "
                  "all of you eager champs who needs help with any tasks on real time basis. "
                  "You get to choose your Tasker, and we will connect you to them hassle-free. "
                  "Avoid unnecessary subscriptions and registrations like other sites. We will "
                  "get you the right person at the right time for free and for you Taskers, "
                  "you can earn as you choose the right client.",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),

            Padding(padding: EdgeInsets.only(top: 30.0)),
            Row(
              children: [
                Text(
                  "Contact us:",
                  style: TextStyle(
                    fontSize: Variables.textSizeXs.sp,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Util.sendMail("info@taskandearn.com");
                  },
                  child: Text("info@taskandearn.com"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}