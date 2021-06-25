import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/post_a_job/Task.dart';
import 'package:task_and_earn/models/become_a_earner/Professional.dart';
import 'package:toast/toast.dart';
import '../basic/HomePage.dart';
import 'CategoriesPage.dart';

// ignore: must_be_immutable
class JobPostedSuccessPage extends StatelessWidget {
  final bool isPostAJob;
  TaskRequest taskRequest;
  Task createdTask;
  ProfessionalRequest professionalRequest;
  Professional professional;

  JobPostedSuccessPage({
    Key key,
    @required this.isPostAJob,
    @required this.taskRequest,
    @required this.createdTask,
    @required this.professionalRequest,
    @required this.professional,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task and Earn",
      home: JobPostedSuccessPageWidget(
          isPostAJob: isPostAJob,
          taskRequest: taskRequest,
          createdTask: createdTask,
          professionalRequest: professionalRequest,
          professional: professional,
      ),
    );
  }
}

// ignore: must_be_immutable
class JobPostedSuccessPageWidget extends StatefulWidget {
  final bool isPostAJob;
  TaskRequest taskRequest;
  Task createdTask;
  ProfessionalRequest professionalRequest;
  Professional professional;

  JobPostedSuccessPageWidget({
    Key key,
    @required this.isPostAJob,
    @required this.taskRequest,
    @required this.createdTask,
    @required this.professionalRequest,
    @required this.professional,
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
  String price;

  @override
  void initState() {
    super.initState();
    print("jsp isPostAJob ${widget.isPostAJob}");
    // print("jsp taskRequest ${widget.taskRequest.toJson()}");
    // print("jsp createdTask ${widget.createdTask.toJson()}");
    if(widget.createdTask != null) {
      var strDt = DateTime.parse(widget.createdTask.createdAt);
      createdTaskDate = DateFormat.yMMMMd().format(strDt);
      setState(() {
        createdTaskDate = createdTaskDate;
        createdTaskDesc = widget.createdTask.description;
        if(widget.taskRequest != null) {
          userFirstName = widget.taskRequest.user.firstName;
          userLastName = widget.taskRequest.user.lastName;
          // addressStreet = widget.taskRequest.address.street;
          // addressCity = widget.taskRequest.address.city;
          // addressCountry = widget.taskRequest.address.country;
          price = widget.createdTask.price;
        }
      });
    }
    else if(widget.professional != null) {
      createdTaskDate = DateFormat.yMMMMd().format(widget.professional.createdAt);
      setState(() {
        createdTaskDate = createdTaskDate;
        createdTaskDesc = widget.professional.introduction;
        price = widget.professional.price.toString();
        // print("jsp price $price");
        if(widget.professionalRequest != null) {
          userFirstName = widget.professionalRequest.user.firstName;
          userLastName = widget.professionalRequest.user.lastName;
          // addressStreet = widget.professionalRequest.address.street;
          // addressCity = widget.professionalRequest.address.city;
          // addressCountry = widget.professionalRequest.address.country;
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      bottomNavigationBar: _bottomNavigationBar(context),
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
                        widget.isPostAJob ? "assets/images/mail_sent.png" : "assets/images/undraw_profile.png",
                        width: MediaQuery.of(context).size.width * 0.35,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(
                        widget.isPostAJob ? "Job posted successfully" : "Profile created successfully",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                        // style: GoogleFonts.poppins(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(left: 20.0, top: 15.0),
              child: Text(
                widget.isPostAJob ? "You posted" : "Your profile",
                style: TextStyle(
                  fontSize: 22.0,
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
                          widget.createdTask != null ? widget.createdTask.title : widget.professional.title,
                          style: TextStyle(
                            fontSize: 18.0,
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
                              size: 25.0,
                            ),
                            Padding(padding: EdgeInsets.only(left: 10.0)),
                            Text(
                              userFirstName,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(left: 3.0)),
                            Text(
                              userLastName,
                              style: TextStyle(
                                fontSize: 18.0,
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
                              size: 25.0,
                            ),
                            Padding(padding: EdgeInsets.only(left: 10.0)),
                            Text(
                              addressStreet,
                              style: TextStyle(
                                fontSize: 18.0,
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
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 3.0)),
                                  Text(
                                    addressCity,
                                    style: TextStyle(
                                      fontSize: 18.0,
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
                                    size: 27.0,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 3.0)),
                                  Text(
                                    createdTaskDate,
                                    style: TextStyle(
                                      fontSize: 18.0,
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
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 3.0)),
                                  Text(
                                    addressCountry,
                                    style: TextStyle(
                                      fontSize: 18.0,
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
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 3.0)),
                                  Text(
                                    price,
                                    style: TextStyle(
                                      fontSize: 18.0,
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
                            fontSize: 18.0,
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
                margin: EdgeInsets.only(top: 18.0),
                child: ElevatedButton(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 23.0,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
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

  Widget _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        print("onTap BottomNavigationBarItem $index");
        if(index == 0) {
          onShowToast("Redirected to Home", 2);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        }
        else if(index == 1) {
          onShowToast("Redirected to Post a Job", 2);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
              CategoriesPage(isPostAJob: true)));
        }
        else if(index == 2) {
          onShowToast("Redirected to Become a Learner", 2);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
              CategoriesPage(isPostAJob: false)));
        }
      },
      elevation: 30.0,
      selectedItemColor: Color(0xFF098CC3),
      unselectedItemColor: Color(0xFF098CC3),
      selectedFontSize: 15.0,
      unselectedFontSize: 15.0,
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.house_outlined,
              size: 35.0,
            ),
            label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/images/head_hunting.png",
            color: Colors.blue.shade600,
            height: 30.0,
          ),
          label: "Post a Job",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/images/salary.png",
            color: Colors.blue.shade600,
            height: 30.0,
          ),
          label: "Become a Learner",
        ),
      ],
    );
  }

  void onTapContinue() {
    onShowToast("Redirected to Home", 2);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void onShowToast(String msg, int timeInSec) {
    Toast.show(msg, context, duration: timeInSec, gravity:  Toast.BOTTOM);
  }
}
