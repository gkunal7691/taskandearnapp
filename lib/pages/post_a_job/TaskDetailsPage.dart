import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_and_earn/models/Task_Model.dart';
import 'package:task_and_earn/models/post_a_job/PostAJob.dart';
import 'package:task_and_earn/util/Util.dart';
import 'package:task_and_earn/util/Variables.dart';
import '../../models/post_a_job/Category.dart';
import 'CategoriesPage.dart';
import 'TaskAddressPage.dart';

class TaskDetailsPage extends StatelessWidget {
  final CategoryData categoryData;
  final Task task;
  final Address address;

  TaskDetailsPage({
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
      home: TaskDetailsPageWidget(
        categoryData: categoryData,
        task: task,
        address: address,
      ),
    );
  }
}

// ignore: must_be_immutable
class TaskDetailsPageWidget extends StatefulWidget {
  CategoryData categoryData;
  Task task;
  Address address;

  TaskDetailsPageWidget({
    Key key,
    @required this.categoryData,
    @required this.task,
    @required this.address,
  }) : super(key: key);

  @override
  _TaskDetailsPageWidgetState createState() => _TaskDetailsPageWidgetState();
}

class _TaskDetailsPageWidgetState extends State<TaskDetailsPageWidget> {
  Task task = new Task();
  final _taskDetailsFormKey = GlobalKey<FormState>();
  final taskTitleController = TextEditingController();
  final taskDescController = TextEditingController();
  final taskPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("tdp categoryData ${widget.categoryData.toJson()}");
    if(widget.task != null) {
      print("tdp taskDetails ${widget.task.toJson()}");
      setState(() {
        task = widget.task;
        taskTitleController.text = widget.task.title;
        taskDescController.text = widget.task.description;
        taskPriceController.text = widget.task.price.toString();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    taskTitleController.dispose();
    taskDescController.dispose();
    taskPriceController.dispose();
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
        body: SingleChildScrollView(
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
                        onRouteSubCategoriesPage();
                      },
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 30.0),
                        child: Text(
                          "Please enter details about your task",
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
                      key: _taskDetailsFormKey,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Card(
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
                                      "Task Title",
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
                                      controller: taskTitleController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      maxLines: 3,
                                      style: TextStyle(fontSize: Variables.textSizeS.sp),
                                      decoration: InputDecoration.collapsed(
                                        hintText: "Please enter your task title",
                                      ),
                                      onSaved: (input) {
                                        setState(() {
                                          task.title = input;
                                        });
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Task title cannot be blank";
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
                                      "Task Description",
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
                                      controller: taskDescController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      maxLines: 7,
                                      style: TextStyle(fontSize: Variables.textSizeS.sp),
                                      decoration: InputDecoration.collapsed(
                                        hintText: "Please enter task description in details",
                                      ),
                                      onSaved: (input) {
                                        setState(() {
                                          task.description = input;
                                        });
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Task description cannot be blank";
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
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                side: new BorderSide(color: Colors.lightBlue, width: 1.0),
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
                                      "Price (Rs)",
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
                                      controller: taskPriceController,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      maxLines: 1,
                                      style: TextStyle(fontSize: Variables.textSizeS.sp),
                                      decoration: InputDecoration.collapsed(
                                        hintText: "Please enter task price",
                                      ),
                                      onSaved: (input) {
                                        setState(() {
                                          task.price = int.tryParse(input);
                                        });
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Task price cannot be blank";
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
                            margin: EdgeInsets.only(top: 15.0, bottom: 20.0),
                            child: ElevatedButton(
                              child: Text(
                                "Next",
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
                                onSubmitTaskDetails();
                              },
                            ),
                          ),
                        ],
                      )
                    ),
                  ],
                ),
              ],
            ),
        ),
    );
  }

  void onSubmitTaskDetails() {
    if(_taskDetailsFormKey.currentState.validate()) {
      _taskDetailsFormKey.currentState.save();
      onRouteTaskAddressPage();
    }
  }

  // For back.
  void onRouteSubCategoriesPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        CategoriesPage(
          categoryData: widget.categoryData,
          task: task != null ? task : widget.task,
          address: widget.address,
        )));
  }

  // For forward.
  void onRouteTaskAddressPage() {
    Util.onShowToast(context, "Please enter address", 2);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        TaskAddressPage(
            categoryData: widget.categoryData,
            task: task != null ? task : widget.task,
            address: widget.address,
        )));
  }
}