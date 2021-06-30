import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_and_earn/models/Task_Model.dart';
import 'package:task_and_earn/models/post_a_job/PostAJob.dart';
import 'package:task_and_earn/services/ApiManager.dart';
import 'package:task_and_earn/services/TaskService.dart';
import 'package:task_and_earn/util/Util.dart';
import 'package:task_and_earn/util/Variables.dart';
import '../../models/post_a_job/Category.dart';
import '../../models/post_a_job/Task.dart';
import 'package:task_and_earn/models/User.dart';
import 'package:task_and_earn/util/SharedPref.dart';
import '../shared/ProgressHUD.dart';
import 'JobPostedSuccessPage.dart';
import 'TaskDetailsPage.dart';

class TaskAddressPage extends StatelessWidget {
  final CategoryData categoryData;
  final Task task;
  final Address address;

  TaskAddressPage({
    Key key,
    @required this.categoryData,
    @required this.task,
    @required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task and Earn",
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      home: TaskAddressPageWidget(
        categoryData: categoryData,
        task: task,
        address: address,
      ),
    );
  }
}

// ignore: must_be_immutable
class TaskAddressPageWidget extends StatefulWidget {
  CategoryData categoryData;
  Task task;
  Address address;

  TaskAddressPageWidget({
    Key key,
    @required this.categoryData,
    @required this.task,
    @required this.address,
  }) : super(key: key);

  @override
  _TaskAddressPageWidgetState createState() => _TaskAddressPageWidgetState();
}

class _TaskAddressPageWidgetState extends State<TaskAddressPageWidget> {
  TaskService taskService = new TaskService();
  SharedPref sharedPref = new SharedPref();
  String token;
  String loggedInUserId;
  String loggedInUserFName;
  String loggedInUserLName;
  bool isApiCallProcess = false;

  Address address = new Address();
  final _taskAddressFormKey = GlobalKey<FormState>();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final pinCodeController = TextEditingController();
  final countryController = TextEditingController();
  final contactController = TextEditingController();
  bool _isCheckedTermsCondition = false;

  TaskRequest taskRequest = new TaskRequest();
  User user = new User();

  @override
  void initState() {
    super.initState();
    if(widget.address != null) {
      print("tap address ${widget.address.toJson()}");
      setState(() {
        address = widget.address;
        streetController.text = widget.address.street;
        cityController.text = widget.address.city;
        pinCodeController.text = widget.address.pincode;
        countryController.text = widget.address.country;
      });
    }
    onGetToken();
  }

  @override
  void dispose() {
    super.dispose();
    taskRequest = null;
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: _uiSetUp(context), isAsyncCall: isApiCallProcess, opacity: 0.3);
  }

  Widget _uiSetUp(BuildContext context) {
    ScreenUtil.init(BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height),
    );
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Row(
                      children: [
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: Variables.headerMenuSize.sp,
                              color: Color(0xFF098CC3),
                            ),
                          ),
                          onTap: () {
                            onRouteBackPage();
                          },
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(right: 30.0),
                            child: Text(
                              "Please enter address details",
                              style: TextStyle(
                                  fontSize: Variables.headerTextSize.sp,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: _taskAddressFormKey,
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 8,
                                  shadowColor: Colors.lightBlue,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 5.0),
                                        child: Text(
                                          "Street",
                                          style: TextStyle(
                                            fontSize: Variables.textSizeS.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.blue,
                                        height: 0.0,
                                        indent: 10.0,
                                        endIndent: 20.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: TextFormField(
                                          controller: streetController,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          maxLines: 3,
                                          style: TextStyle(fontSize: Variables.textSizeS.sp),
                                          decoration: InputDecoration.collapsed(
                                            hintText: "Please enter your street name",
                                          ),
                                          onSaved: (input) {
                                            setState(() {
                                              address.street = input;
                                            });
                                          },
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "Street cannot be blank";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 8,
                                  shadowColor: Colors.lightBlue,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 5.0),
                                        child: Text(
                                          "City",
                                          style: TextStyle(
                                            fontSize: Variables.textSizeS.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.blue,
                                        height: 0.0,
                                        indent: 10.0,
                                        endIndent: 20.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: TextFormField(
                                          controller: cityController,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          maxLines: 1,
                                          style: TextStyle(fontSize: Variables.textSizeS.sp),
                                          decoration: InputDecoration.collapsed(
                                            hintText: "Please enter city name",
                                          ),
                                          onSaved: (input) {
                                            setState(() {
                                              address.city = input;
                                            });
                                          },
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "City cannot be blank";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 8,
                                  shadowColor: Colors.lightBlue,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 5.0),
                                        child: Text(
                                          "PinCode",
                                          style: TextStyle(
                                            fontSize: Variables.textSizeS.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.blue,
                                        height: 0.0,
                                        indent: 10.0,
                                        endIndent: 20.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: TextFormField(
                                          controller: pinCodeController,
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.next,
                                          maxLines: 1,
                                          style: TextStyle(fontSize: Variables.textSizeS.sp),
                                          decoration: InputDecoration.collapsed(
                                            hintText: "Please enter pincode",
                                          ),
                                          onSaved: (input) {
                                            setState(() {
                                              address.pincode = input;
                                            });
                                          },
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "PinCode can't be blank";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 8,
                                  shadowColor: Colors.lightBlue,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 5.0),
                                        child: Text(
                                          "Country",
                                          style: TextStyle(
                                            fontSize: Variables.textSizeS.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.blue,
                                        height: 0.0,
                                        indent: 10.0,
                                        endIndent: 20.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: TextFormField(
                                          controller: countryController,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          maxLines: 1,
                                          style: TextStyle(fontSize: Variables.textSizeS.sp),
                                          decoration: InputDecoration.collapsed(
                                            hintText: "Please enter country name",
                                          ),
                                          onSaved: (input) {
                                            setState(() {
                                              address.country = input;
                                            });
                                          },
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "Country cannot be blank";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 8,
                                  shadowColor: Variables.blueColor,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 5.0),
                                        child: Text(
                                          "Contact",
                                          style: TextStyle(
                                            fontSize: Variables.textSizeS.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.blue,
                                        height: 0.0,
                                        indent: 10.0,
                                        endIndent: 20.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: TextFormField(
                                          controller: contactController,
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.done,
                                          maxLines: 1,
                                          style: TextStyle(fontSize: Variables.textSizeS.sp),
                                          decoration: InputDecoration.collapsed(
                                            hintText: "Please enter contact number",
                                          ),
                                          onSaved: (input) {
                                            setState(() {
                                              address.contact = input;
                                            });
                                          },
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "Contact number can't be blank";
                                            }
                                            else if (value.length < 10) {
                                              return "Contact number can't be less than 10";
                                            }
                                            else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 8,
                                  shadowColor: Variables.blueColor,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 5.0),
                                        child: Text(
                                          "Do you wish to provide your contact details to the professionals?",
                                          style: TextStyle(
                                            fontSize: Variables.textSizeS.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.blue,
                                        height: 0.0,
                                        indent: 10.0,
                                        endIndent: 20.0,
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                            value: "Yes",
                                            groupValue: address.contactStatus,
                                            onChanged: (value) {
                                              setState(() {
                                                address.contactStatus = value;
                                              });
                                            },
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                address.contactStatus = "Yes";
                                              });
                                            },
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: Variables.textSizeS.sp,
                                              ),
                                            ),
                                          ),
                                          Radio(
                                            value: "No",
                                            groupValue: address.contactStatus,
                                            onChanged: (value) {
                                              setState(() {
                                                address.contactStatus = value;
                                              });
                                            },
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                address.contactStatus = "No";
                                              });
                                            },
                                            child: Text(
                                              "No",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: Variables.textSizeS.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      Flex(
                                          direction: Axis.horizontal,
                                          children: [
                                            Checkbox(
                                              value: _isCheckedTermsCondition,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  _isCheckedTermsCondition = value;
                                                });
                                              },
                                            ),
                                            Flexible(
                                              child: Text(
                                                "I accept  ",
                                              ),
                                            ),
                                            GestureDetector(
                                              child: Text(
                                                "terms and conditions",
                                                style: TextStyle(
                                                  color: Variables.blueColor,
                                                ),
                                              ),
                                              onTap: () {
                                                Util.onShowToast(context, "Redirecting to ${ApiManager.tneBaseUrl + "/terms"}", 2);
                                                Util.launchURL(ApiManager.tneBaseUrl + "/terms");
                                              },
                                            ),
                                          ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                margin: EdgeInsets.only(top: 15.0, bottom: 20.0),
                                child: ElevatedButton(
                                  child: Text(
                                    "Submit",
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
                                    onSubmitAddress();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            ),
        ),
    );
  }

  Future onGetToken() async {
    token = await sharedPref.onGetSharedPreferencesValue("tokenKey");
    loggedInUserId = await sharedPref.onGetSharedPreferencesValue("loggedInUserId");
    loggedInUserFName = await sharedPref.onGetSharedPreferencesValue("loggedInUserFName");
    loggedInUserLName = await sharedPref.onGetSharedPreferencesValue("loggedInUserLName");
    setState(() {
      token = token;
      loggedInUserId = loggedInUserId;
      loggedInUserFName = loggedInUserFName;
      loggedInUserLName = loggedInUserLName;
    });
  }

  void onRouteBackPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        TaskDetailsPage(
          categoryData: widget.categoryData,
          task: widget.task,
          address: address != null ? address : widget.address,
        )));
  }

  Future onSubmitAddress() async {
    if(_taskAddressFormKey.currentState.validate()) {
      if(address.contactStatus != null) {
        if(_isCheckedTermsCondition) {
          _taskAddressFormKey.currentState.save();
          await onPostJob();
        } else {
          Util.onShowToast(context, "Please select Terms", 2);
        }
      } else {
        Util.onShowToast(context, "Please select your wish to provide details", 2);
      }
    }
  }

  Future onPostJob() async {
    try {
      setState(() {
        isApiCallProcess = true;
        user.userId = int.tryParse(loggedInUserId);
        user.firstName = loggedInUserFName;//
        user.lastName = loggedInUserLName;//

        taskRequest.categoryData = widget.categoryData;
        taskRequest.task = widget.task;
        taskRequest.user = user;
        taskRequest.address = address != null ? address : widget.address;
      });

      print(taskRequest.toJson());
      await taskService.onPostAJob(taskRequest).then((res) => {
        setState(() {
          isApiCallProcess = false;
        }),
        if(res.success) {
          Util.onShowToast(context, "Job Posted Successfully", 3),
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) =>
              JobPostedSuccessPage(
                taskRequest: taskRequest, createdTask: res.data,
              ))),
        } else {
          Util.onShowToast(context, "Something went wrong!", 2),
        }
      });
    } catch (e) {
      print(e);
      setState(() {
        isApiCallProcess = false;
        Util.onShowToast(context, "Something went wrong!", 2);
      });
    }
  }
}