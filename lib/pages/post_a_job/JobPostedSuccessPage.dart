import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:task_and_earn/models/Task_Model.dart';
import 'package:task_and_earn/models/post_a_job/Task.dart';
import 'package:task_and_earn/pages/shared/tne-footer.dart';
import 'package:task_and_earn/util/Util.dart';
import 'package:task_and_earn/util/Variables.dart';
import '../basic/HomePage.dart';

class JobPostedSuccessPage extends StatelessWidget {
  final TaskRequest taskRequest;
  final Task createdTask;

  JobPostedSuccessPage({
    Key key,
    @required this.taskRequest,
    @required this.createdTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task and Earn",
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      home: JobPostedSuccessPageWidget(
          taskRequest: taskRequest,
          createdTask: createdTask,
      ),
    );
  }
}

class JobPostedSuccessPageWidget extends StatefulWidget {
  final TaskRequest taskRequest;
  final Task createdTask;

  JobPostedSuccessPageWidget({
    Key key,
    @required this.taskRequest,
    @required this.createdTask,
  }) : super(key: key);

  @override
  _JobPostedSuccessPageWidgetState createState() => _JobPostedSuccessPageWidgetState();
}

class _JobPostedSuccessPageWidgetState extends State<JobPostedSuccessPageWidget> {
  var createdTaskDate;
  String createdTaskDesc;
  String userFirstName;
  String userLastName;
  String addressStreet;
  String addressCity;
  String addressCountry;

  @override
  void initState() {
    super.initState();
    if(widget.createdTask != null) {
      // print("jsp createdTask ${widget.createdTask.toJson()}");
      createdTaskDate = DateFormat.yMMMMd().format(widget.createdTask.createdAt);
      setState(() {
        createdTaskDate = createdTaskDate;
        createdTaskDesc = widget.createdTask.description;
        if(widget.taskRequest != null) {
          // print("jsp taskRequest ${widget.taskRequest.toJson()}");
          userFirstName = widget.taskRequest.user.firstName;
          userLastName = widget.taskRequest.user.lastName;
          addressStreet = widget.taskRequest.address.street;
          addressCity = widget.taskRequest.address.city;
          addressCountry = widget.taskRequest.address.country;
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height),
    );
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      bottomNavigationBar: TneFooter(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              color: Colors.pink.shade100,
              // color: Color(0xFFFFD8D9),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/images/mail_sent.png",
                        width: MediaQuery.of(context).size.width * 0.35,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Job posted successfully",
                        style: TextStyle(
                          fontSize: Variables.textSizeSl.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(left: 20.0, top: 15.0),
              child: Text(
                "You posted",
                style: TextStyle(
                  fontSize: Variables.textSizeSl.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Card(
                  elevation: 10.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.createdTask != null ? widget.createdTask.title : "N/A",
                          style: TextStyle(
                            fontSize: Variables.textSizeS.sp,
                            color: Color(0xFF098CC3),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.black,
                              size: Variables.textSizeSl.sp,
                            ),
                            Padding(padding: EdgeInsets.only(left: 10.0)),
                            Text(
                              userFirstName,
                              style: TextStyle(
                                fontSize: Variables.textSizeS.sp,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(left: 3.0)),
                            Text(
                              userLastName,
                              style: TextStyle(
                                fontSize: Variables.textSizeS.sp,
                              ),
                            ),
                          ],
                        ),

                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: Colors.black,
                              size: Variables.textSizeSl.sp,
                            ),
                            Padding(padding: EdgeInsets.only(left: 10.0)),
                            Text(
                              addressStreet,
                              style: TextStyle(
                                fontSize: Variables.textSizeS.sp,
                              ),
                            ),
                          ],
                        ),

                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    "City:",
                                    style: TextStyle(
                                      fontSize: Variables.textSizeS.sp,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 3.0)),
                                  Text(
                                    addressCity,
                                    style: TextStyle(
                                      fontSize: Variables.textSizeS.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.watch_later_rounded,
                                    color: Colors.black,
                                    size: Variables.textSizeSl.sp,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 3.0)),
                                  Text(
                                    createdTaskDate,
                                    style: TextStyle(
                                      fontSize: Variables.textSizeS.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    "Country:",
                                    style: TextStyle(
                                      fontSize: Variables.textSizeS.sp,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 3.0)),
                                  Text(
                                    addressCountry,
                                    style: TextStyle(
                                      fontSize: Variables.textSizeS.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    '\u{20B9}',
                                    style: TextStyle(
                                      fontSize: Variables.textSizeS.sp,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 3.0)),
                                  Text(
                                    "${widget.createdTask.price}",
                                    style: TextStyle(
                                      fontSize: Variables.textSizeS.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        Text(
                          "Task Description:   " + createdTaskDesc,
                          style: TextStyle(
                            fontSize: Variables.textSizeS.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                margin: EdgeInsets.symmetric(vertical: 18.0),
                child: ElevatedButton(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: Variables.textSizeSl.sp,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    primary: Colors.blue.shade600,
                  ),
                  onPressed: () {
                    onTapContinue();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapContinue() {
    Util.onShowToast(context, "Redirected to Home", 2);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
