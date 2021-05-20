import 'package:flutter/material.dart';
import '../../models/post_a_job/Category.dart';
import 'SubCategoriesPage.dart';
import 'TaskAddressPage.dart';

// ignore: must_be_immutable
class TaskDetailsPage extends StatelessWidget {
  final bool isPostAJob;
  Category selectedCategory;
  List<int> selectedSubCategories;
  TaskDetails taskDetails;
  Address address;

  TaskDetailsPage({
    Key key,
    @required this.isPostAJob,
    @required this.selectedCategory,
    @required this.selectedSubCategories,
    @required this.taskDetails,
    @required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task and Earn",
      home: TaskDetailsPageWidget(
        isPostAJob: isPostAJob,
        selectedCategory: selectedCategory,
        selectedSubCategories: selectedSubCategories,
        taskDetails: taskDetails,
        address: address,
      ),
    );
  }
}

// ignore: must_be_immutable
class TaskDetailsPageWidget extends StatefulWidget {
  final bool isPostAJob;
  Category selectedCategory;
  List<int> selectedSubCategories;
  TaskDetails taskDetails;
  Address address;

  TaskDetailsPageWidget({
    Key key,
    @required this.isPostAJob,
    @required this.selectedCategory,
    @required this.selectedSubCategories,
    @required this.taskDetails,
    @required this.address,
  }) : super(key: key);

  @override
  _TaskDetailsPageWidgetState createState() => _TaskDetailsPageWidgetState();
}

class _TaskDetailsPageWidgetState extends State<TaskDetailsPageWidget> {
  TaskDetails taskDetails = new TaskDetails();
  final _taskDetailsFormKey = GlobalKey<FormState>();
  final taskTitleController = TextEditingController();
  final taskDescController = TextEditingController();
  final taskPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("tdp selectedCategory ${widget.selectedCategory.toJson()}");
    print("tdp selectedSubCategories ${widget.selectedSubCategories}");
    if(widget.taskDetails != null) {
      print("tdp taskDetails ${widget.taskDetails.toJson()}");
      setState(() {
        taskDetails = widget.taskDetails;
        taskTitleController.text = widget.taskDetails.taskTitle;
        taskDescController.text = widget.taskDetails.taskDescription;
        taskPriceController.text = widget.taskDetails.taskPrice;
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
                        child: Icon(Icons.arrow_back_ios, size: 35.0, color: Color(0xFF098CC3)),
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
                      key: _taskDetailsFormKey,
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
                                      'Task Title',
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
                                      controller: taskTitleController,
                                      keyboardType: TextInputType.text,
                                      maxLines: 3,
                                      style: TextStyle(fontSize: 19.0),
                                      decoration: InputDecoration.collapsed(
                                        hintText: "Please enter your task title",
                                      ),
                                      onSaved: (input) {
                                        setState(() {
                                          taskDetails.taskTitle = input;
                                        });
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Task title cannot be blank";
                                        }
                                        else if (value.length < 20) {
                                          return "Task title must be at least 20 characters";
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
                            height: MediaQuery.of(context).size.height * 0.35,
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
                                      controller: taskDescController,
                                      keyboardType: TextInputType.text,
                                      maxLines: 7,
                                      style: TextStyle(fontSize: 19.0),
                                      decoration: InputDecoration.collapsed(
                                        hintText: "Please enter task description in details",
                                      ),
                                      onSaved: (input) {
                                        setState(() {
                                          taskDetails.taskDescription = input;
                                        });
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Task description cannot be blank";
                                        }
                                        else if (value.length < 50) {
                                          return "Task description must be at least 50 characters";
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
                            height: MediaQuery.of(context).size.height * 0.18,
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
                                      'Price (Rs)',
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
                                      controller: taskPriceController,
                                      keyboardType: TextInputType.number,
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 19.0),
                                      decoration: InputDecoration.collapsed(
                                        hintText: "Please enter task price",
                                      ),
                                      onSaved: (input) {
                                        setState(() {
                                          taskDetails.taskPrice = input;
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
    // print("${taskTitleController.text} ${taskDescController.text} ${taskPriceController.text}");
    if(_taskDetailsFormKey.currentState.validate()) {
      _taskDetailsFormKey.currentState.save();
      onRouteTaskAddressPage();
    }
  }

  void onRouteSubCategoriesPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        SubCategoriesPage(
          isPostAJob: widget.isPostAJob,
          selectedCategory: widget.selectedCategory,
          selectedSubCategories: widget.selectedSubCategories,
          taskDetails: taskDetails != null ? taskDetails : widget.taskDetails,
          address: widget.address,
        )));
  }

  void onRouteTaskAddressPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        TaskAddressPage(
            isPostAJob: widget.isPostAJob,
            selectedCategory: widget.selectedCategory,
            selectedSubCategories: widget.selectedSubCategories,
            taskDetails: taskDetails != null ? taskDetails : widget.taskDetails,
            address: widget.address, about: null,
        )));
  }
}