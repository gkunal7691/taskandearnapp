import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../models/post_a_job/Category.dart';
import 'package:task_and_earn/models/become_a_earner/About_Model.dart';
import 'package:task_and_earn/pages/post_a_job/CategoriesPage.dart';
import 'package:task_and_earn/pages/post_a_job/TaskAddressPage.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class AboutYourselfPage extends StatelessWidget {
  final bool isPostAJob;
  final Category selectedCategory;
  About about;

  AboutYourselfPage({
    Key key,
    @required this.isPostAJob,
    @required this.selectedCategory,
    @required this.about,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task and Earn",
      home: AboutYourselfPageWidget(
        isPostAJob: isPostAJob,
        selectedCategory: selectedCategory,
        about: about,
      ),
    );
  }
}

// ignore: must_be_immutable
class AboutYourselfPageWidget extends StatefulWidget {
  final bool isPostAJob;
  final Category selectedCategory;
  About about;

  AboutYourselfPageWidget({
    Key key,
    @required this.isPostAJob,
    @required this.selectedCategory,
    @required this.about,
  }) : super(key: key);

  @override
  _AboutYourselfPageWidgetState createState() => _AboutYourselfPageWidgetState();
}

class _AboutYourselfPageWidgetState extends State<AboutYourselfPageWidget> {
  About about = new About();
  final _aboutYourselfFormKey = GlobalKey<FormState>();
  final aboutYouShortController = TextEditingController();
  final phoneNumController = TextEditingController();
  final dobController = TextEditingController();
  final skillsController = TextEditingController();
  final aboutYouDetailsController = TextEditingController();
  final costPerHrController = TextEditingController();
  bool isMale = true;

  @override
  void initState() {
    super.initState();
    // print("ay widget.selectedCategory ${widget.selectedCategory.toJson()}");
    if(widget.about != null) {
      print("ay widget.about ${widget.about.toJson()}");
      isMale = widget.about.gender == "Male" ? true : false;
      aboutYouShortController.text = widget.about.title;
      phoneNumController.text = widget.about.phone;
      dobController.text = widget.about.dob;
      skillsController.text = widget.about.skills;
      aboutYouDetailsController.text = widget.about.introduction;
      costPerHrController.text = widget.about.price.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    aboutYouShortController.dispose();
    phoneNumController.dispose();
    dobController.dispose();
    skillsController.dispose();
    aboutYouDetailsController.dispose();
    costPerHrController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Icon(Icons.arrow_back_ios, size: 35.0, color: Color(0xFF098CC3)),
                      ),
                      onTap: () {
                        onRouteCategoriesPage();
                      },
                    ),
                    Expanded(
                      child: Container(
                        // padding: EdgeInsets.only(right: 30.0),
                        child: Text(
                          "Please describe about yourself",
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
                Form(
                  key: _aboutYourselfFormKey,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: MediaQuery.of(context).size.height * 0.22,
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
                                  "Write about yourself in short",
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
                                  controller: aboutYouShortController,
                                  keyboardType: TextInputType.text,
                                  maxLines: 3,
                                  style: TextStyle(fontSize: 19.0),
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Write here",
                                  ),
                                  onSaved: (input) {
                                    setState(() {
                                      about.title = input;
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "This field cannot be blank";
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

                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 17.0),
                            child: Icon(
                              MdiIcons.genderMaleFemale,
                              size: 25.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text(
                              "Select Gender",
                              style: TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ToggleButtons(
                            borderRadius: BorderRadius.circular(50.0),
                            fillColor: Color(0xFF039BE5),
                            splashColor: Colors.purple,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50.0),
                                child: Text(
                                  "Male",
                                  style: TextStyle(
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.bold,
                                    color: isMale ? Colors.white : Color(0xFF039BE5),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50.0),
                                child: Text(
                                  "Female",
                                  style: TextStyle(
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.bold,
                                    color: isMale ? Color(0xFF039BE5) : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                            onPressed: (int index) {
                              setState(() {
                                if(index == 0) {
                                  isMale = true;
                                } else {
                                  isMale = false;
                                }
                              });
                            },
                            isSelected: isMale ? <bool>[true, false] : <bool>[false, true],
                          ),
                        ],
                      ),

                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 17.0),
                            child: Icon(
                              Icons.phone,
                              size: 22.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text(
                              "Phone Number",
                              style: TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: TextFormField(
                          controller: phoneNumController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(top: 11.0),
                              child: Text(
                                "+91",
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                            ),
                            prefixStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onSaved: (input) {
                            setState(() {
                              about.phone = input;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Phone Number cannot be blank";
                            }
                            else if (value.length != 10) {
                              return "Phone Number must be 10 digits";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),

                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 17.0),
                            child: Icon(
                              Icons.calendar_today,
                              // Icons.date_range_outlined,
                              size: 25.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text(
                              "Date of Birth",
                              style: TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: TextFormField(
                          controller: dobController,
                          textInputAction: TextInputAction.next,
                          toolbarOptions: ToolbarOptions(
                            copy: true,
                            cut: true,
                            paste: false,
                            selectAll: true,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.date_range_outlined,
                            ),
                          ),
                          focusNode: AlwaysDisabledFocusNode(),
                          onTap: () {
                            _selectDateDialog(context);
                          },
                          onSaved: (input) {
                            setState(() {
                              about.dob = input;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Date of Birth cannot be blank";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),

                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        // height: MediaQuery.of(context).size.height * 0.22,
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
                                  "Write your skills here",
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
                                  controller: skillsController,
                                  keyboardType: TextInputType.text,
                                  maxLines: 3,
                                  style: TextStyle(fontSize: 19.0),
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Write here",
                                  ),
                                  onSaved: (input) {
                                    setState(() {
                                      about.skills = input;
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Skills cannot be blank";
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

                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        // height: MediaQuery.of(context).size.height * 0.22,
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
                                  "Write about yourself in details",
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
                                  controller: aboutYouDetailsController,
                                  keyboardType: TextInputType.text,
                                  maxLines: 6,
                                  style: TextStyle(fontSize: 19.0),
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Write here",
                                  ),
                                  onSaved: (input) {
                                    setState(() {
                                      about.introduction = input;
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "This field cannot be blank";
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

                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        // height: MediaQuery.of(context).size.height * 0.22,
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
                                  "How much you cost per hour",
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
                                  controller: costPerHrController,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 19.0),
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Write here",
                                  ),
                                  onSaved: (input) {
                                    setState(() {
                                      about.price = double.tryParse(input);
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "This field cannot be blank";
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
                        margin: EdgeInsets.only(top: 15.0),
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
                            onSubmitAboutDetails();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  _selectDateDialog(BuildContext context) async {
    // final DateFormat dateFormat = DateFormat("yyyy/dd/MM");
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      helpText: "Select Date of Birth",
    );
    if (pickedDate != null) {
      setState(() {
        dobController.text = pickedDate.toLocal().toString().split(' ')[0];
      });
    }
    // print("dobController.text2 ${dobController.text}");
  }

  void onSubmitAboutDetails() {
    print("ay isMale $isMale");
    if(_aboutYourselfFormKey.currentState.validate()) {
      _aboutYourselfFormKey.currentState.save();
      about.gender = isMale ? "Male" : "Female";
      print("ay about ${about.toJson()}");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
          TaskAddressPage(
            isPostAJob: widget.isPostAJob,
            selectedSubCategories: [],
            selectedCategory: widget.selectedCategory,
            address: null, taskDetails: null, about: about,
          )));
    } else {
      onShowToast("Please give correct values for all fields", 2);
    }
  }

  onShowToast(String msg, int timeInSec) {
    Toast.show(msg, context, duration: timeInSec, gravity:  Toast.BOTTOM);
  }

  void onRouteCategoriesPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        CategoriesPage(isPostAJob: widget.isPostAJob)));
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}