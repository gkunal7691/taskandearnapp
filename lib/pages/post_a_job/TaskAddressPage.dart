import 'package:flutter/material.dart';
import '../../models/post_a_job/Category.dart';
import '../../models/post_a_job/Task.dart';
import 'package:task_and_earn/models/User.dart';
import 'package:task_and_earn/models/become_a_earner/About_Model.dart';
import 'package:task_and_earn/models/become_a_earner/Professional.dart';
import 'package:task_and_earn/pages/become_a_earner/AboutYourself.dart';
import 'package:task_and_earn/services/CategoryService.dart';
import 'package:task_and_earn/services/ProfessionalService.dart';
import 'package:task_and_earn/util/SharedPref.dart';
import 'package:toast/toast.dart';
import '../ProgressHUD.dart';
import 'JobPostedSuccessPage.dart';
import 'TaskDetailsPage.dart';

// ignore: must_be_immutable
class TaskAddressPage extends StatelessWidget {
  final bool isPostAJob;
  Category selectedCategory;
  List<int> selectedSubCategories;
  TaskDetails taskDetails;
  Address address;
  final About about;

  TaskAddressPage({
    Key key,
    @required this.isPostAJob,
    @required this.selectedCategory,
    @required this.selectedSubCategories,
    @required this.taskDetails,
    @required this.address,
    @required this.about,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task and Earn",
      home: TaskAddressPageWidget(
        isPostAJob: isPostAJob,
        selectedCategory: selectedCategory,
        selectedSubCategories: selectedSubCategories,
        taskDetails: taskDetails,
        address: address, about: about,
      ),
    );
  }
}

// ignore: must_be_immutable
class TaskAddressPageWidget extends StatefulWidget {
  final bool isPostAJob;
  Category selectedCategory;
  List<int> selectedSubCategories;
  TaskDetails taskDetails;
  Address address;
  About about;

  TaskAddressPageWidget({
    Key key,
    @required this.isPostAJob,
    @required this.selectedCategory,
    @required this.selectedSubCategories,
    @required this.taskDetails,
    @required this.address,
    @required this.about,
  }) : super(key: key);

  @override
  _TaskAddressPageWidgetState createState() => _TaskAddressPageWidgetState();
}

class _TaskAddressPageWidgetState extends State<TaskAddressPageWidget> {
  CategoryService categoryService = new CategoryService();
  ProfessionalService professionalService = new ProfessionalService();
  SharedPref sharedPref = new SharedPref();
  String token;
  dynamic loggedInUserId;
  String loggedInUserFName;
  String loggedInUserLName;
  bool isApiCallProcess = false;

  Address address = new Address();
  final _taskAddressFormKey = GlobalKey<FormState>();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final pinCodeController = TextEditingController();
  final countryController = TextEditingController();

  TaskRequest taskRequest = new TaskRequest();
  User user = new User();
  ProfessionalRequest professionalRequest = new ProfessionalRequest();

  @override
  void initState() {
    super.initState();
    // print("tap selectedCategory ${widget.selectedCategory.toJson()}");
    // print("tap selectedSubCategories ${widget.selectedSubCategories}");
    // print("tap taskDetails ${widget.taskDetails.toJson()}");
    if(widget.address != null) {
      print("tap address ${widget.address.toJson()}");
      setState(() {
        address = widget.address;
        // streetController.text = widget.address.street;
        // cityController.text = widget.address.city;
        // pinCodeController.text = widget.address.pincode;
        // countryController.text = widget.address.country;
      });
    }
    if(widget.about != null) {
      print("tap about ${widget.about.toJson()}");
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
                            child: Icon(Icons.arrow_back_ios, size: 35.0, color: Color(0xFF098CC3)),
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
                                  fontSize: 23.0,
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
                                height: MediaQuery.of(context).size.height * 0.25,
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
                                          'Street',
                                          style: TextStyle(
                                            fontSize: 17.0,
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
                                          maxLines: 3,
                                          style: TextStyle(fontSize: 19.0),
                                          decoration: InputDecoration.collapsed(
                                            hintText: "Please enter your street name",
                                          ),
                                          onSaved: (input) {
                                            setState(() {
                                              // address.street = input;
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
                                height: MediaQuery.of(context).size.height * 0.17,
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
                                          'City',
                                          style: TextStyle(
                                            fontSize: 17.0,
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
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 19.0),
                                          decoration: InputDecoration.collapsed(
                                            hintText: "Please enter city name",
                                          ),
                                          onSaved: (input) {
                                            setState(() {
                                              // address.city = input;
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
                                height: MediaQuery.of(context).size.height * 0.17,
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
                                          'PinCode',
                                          style: TextStyle(
                                            fontSize: 17.0,
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
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 19.0),
                                          decoration: InputDecoration.collapsed(
                                            hintText: "Please enter pinCode",
                                          ),
                                          onSaved: (input) {
                                            setState(() {
                                              // address.pincode = input;
                                            });
                                          },
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "PinCode cannot be blank";
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
                                height: MediaQuery.of(context).size.height * 0.17,
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
                                          'Country',
                                          style: TextStyle(
                                            fontSize: 17.0,
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
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 19.0),
                                          decoration: InputDecoration.collapsed(
                                            hintText: "Please enter country name",
                                          ),
                                          onSaved: (input) {
                                            setState(() {
                                              // address.country = input;
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
                                width: MediaQuery.of(context).size.width * 0.7,
                                margin: EdgeInsets.only(top: 18.0),
                                child: ElevatedButton(
                                  child: Text(
                                    "Submit",
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

  Future onSubmitAddress() async {
    if(_taskAddressFormKey.currentState.validate()) {
      _taskAddressFormKey.currentState.save();
      // print("tap widget.isPostAJob ${widget.isPostAJob}");
      if(widget.isPostAJob) {
        await onPostJob();
      } else {
        await onCreateProfessional();
      }
    }
  }

  void onRouteBackPage() {
    if(widget.isPostAJob) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
          TaskDetailsPage(
            isPostAJob: widget.isPostAJob,
            selectedCategory: widget.selectedCategory,
            selectedSubCategories: widget.selectedSubCategories,
            taskDetails: widget.taskDetails,
            address: address != null ? address : widget.address,
          )));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
          AboutYourselfPage(
            isPostAJob: widget.isPostAJob,
            about: widget.about, selectedCategory: widget.selectedCategory,
          )));
    }
  }

  Future onPostJob() async {
    if(widget.isPostAJob) {
      try {
        setState(() {
          isApiCallProcess = true;
          user.userId = int.tryParse(loggedInUserId);
          user.firstName = loggedInUserFName;//
          user.lastName = loggedInUserLName;//

          taskRequest.title = widget.taskDetails.taskTitle;
          taskRequest.description = widget.taskDetails.taskDescription;
          taskRequest.price = widget.taskDetails.taskPrice;

          taskRequest.categoryId =
              widget.selectedCategory.categoryId.toString();
          taskRequest.address = address != null ? address : widget.address;
          taskRequest.subCatagoriesId =
              List.from(widget.selectedSubCategories.map((e) => e));
          taskRequest.user = user;
        });
      } catch (e) {
        setState(() {
          isApiCallProcess = false;
          onShowToast("Something went wrong!", 2);
        });
      }
      await categoryService.onPostAJob(taskRequest).then((res) => {
        setState(() {
          isApiCallProcess = false;
        }),
        if(res.success) {
          onShowToast("Job Posted Successfully", 3),
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) =>
              JobPostedSuccessPage(
                taskRequest: taskRequest, createdTask: res.data,
                professional: null, professionalRequest: null, isPostAJob: widget.isPostAJob,
              ))),
        } else {
            onShowToast("Something went wrong!", 2),
        }
      });
    }
  }

  Future onCreateProfessional() async {
    print("tap onCreateProfessional");
    if(!widget.isPostAJob) {
      try{
        setState(() {
          isApiCallProcess = true;
          professionalRequest.address = address != null ? address : widget.address;
          professionalRequest.categoryId = widget.selectedCategory.categoryId;
          professionalRequest.categoryName = widget.selectedCategory.categoryName;//

          professionalRequest.title = widget.about.title;
          professionalRequest.gender = widget.about.gender;
          professionalRequest.phone = widget.about.phone;
          professionalRequest.dob = widget.about.dob;
          professionalRequest.skills = widget.about.skills;
          professionalRequest.introduction = widget.about.introduction;
          professionalRequest.price = widget.about.price;

          user.userId = int.tryParse(loggedInUserId);
          user.firstName = loggedInUserFName;//
          user.lastName = loggedInUserLName;//
          professionalRequest.user = user;
        });
        // print("tap professionalRequest ${professionalRequest.toJson()}");
      } catch(e) {
        setState(() {
          isApiCallProcess = false;
        });
        onShowToast("Something went wrong!", 2);
      }
      await professionalService.onCreateProfessional(professionalRequest).then((res) => {
        setState(() {
          isApiCallProcess = false;
        }),
        if(res.success) {
          onShowToast("Profile created Successfully", 3),
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) =>
              JobPostedSuccessPage(
                taskRequest: taskRequest, createdTask: null,
                professionalRequest: professionalRequest,
                professional: res.data, isPostAJob: widget.isPostAJob,
              ))),
        } else {
          onShowToast("Something went wrong!", 2),
        }
      }).catchError((e) {
        print("$e");
        setState(() {
          isApiCallProcess = false;
        });
        onShowToast("$e", 2);
      });
    }
  }

  void onShowToast(String msg, int timeInSec) {
    Toast.show(msg, context, duration: timeInSec, gravity: Toast.BOTTOM);
  }
}