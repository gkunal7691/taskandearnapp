import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:task_and_earn/models/Task_Model.dart';
import 'package:task_and_earn/pages/shared/tne-footer.dart';
import 'package:task_and_earn/services/TaskService.dart';
import 'package:task_and_earn/util/SharedPref.dart';
import 'package:task_and_earn/util/Variables.dart';
import 'HomePage.dart';
import '../shared/ProgressHUD.dart';

class TasksPage extends StatelessWidget {
  final bool isShowAllTasks;

  TasksPage({
    Key key,
    @required this.isShowAllTasks
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      title: "Task and Earn",
      home: TasksPageWidget(
        isShowAllTasks: isShowAllTasks
      )
    );
  }
}

class TasksPageWidget extends StatefulWidget {
  final bool isShowAllTasks;

  TasksPageWidget({
    Key key,
    @required this.isShowAllTasks
  }) : super(key: key);

  @override
  _TasksPageWidgetState createState() => _TasksPageWidgetState();
}

class _TasksPageWidgetState extends State<TasksPageWidget> {
  bool isApiCallProcess = false;
  final _searchQueryKey = TextEditingController();
  String _searchQuery;
  ScrollController _scrollController = ScrollController(initialScrollOffset: 0.0);
  String token;
  SharedPref sharedPref = new SharedPref();
  TaskService taskService =  new TaskService();
  List<Task> taskList = [];
  List<Task> tempTasks = [];

  @override
  void initState() {
    super.initState();
    onGetToken();
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
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: Variables.headerMenuSize.h,
                          color: Variables.blueColor,
                        ),
                      ),
                      onTap: () {
                        onRouteToHome();
                      },
                    ),
                    Container(
                      child: Text(
                        widget.isShowAllTasks ? "All Tasks" : "My Tasks",
                        style: TextStyle(
                            fontSize: Variables.headerTextSize.sp,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(padding: EdgeInsets.only(top: 7.0)),
                Center(
                  child: Form(
                    child: Container(
                      height: 40.0,
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: TextFormField(
                        controller: _searchQueryKey,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          labelText: "Search for task",
                          labelStyle: TextStyle(
                            fontSize: Variables.textSizeXs.sp,
                          ),
                          hintText: "Search for task",
                          hintStyle: TextStyle(
                            fontSize: Variables.textSizeXs.sp,
                          ),
                          contentPadding: EdgeInsets.only(left: 20.0),
                          suffixIcon:
                            _searchQuery == null || _searchQuery.isEmpty ?
                            Icon(Icons.search) :
                            GestureDetector(
                              onTap: () {
                                onClearSearchText();
                              },
                              child: Icon(
                                Icons.clear,
                              )
                            ),
                        ),
                        style: TextStyle(fontSize: Variables.textSizeXs.sp),
                        textInputAction: TextInputAction.search,
                        onChanged: (input) {
                          setState(() {
                            _searchQuery = input;
                          });
                          onFilterTasks();
                        },
                      ),
                    ),
                  ),
                ),

                Container(
                  height: MediaQuery.of(context).size.height * 0.67,
                  margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Scrollbar(
                    isAlwaysShown: true,
                    controller: _scrollController,
                    thickness: 8.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: taskList.length,
                      itemBuilder: _taskItemBuilder,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }

  Widget _taskItemBuilder(BuildContext context, int index) {
    if(taskList.length != 0) {
      Task task = new Task();
      task = this.taskList[index];
      print("index $index");
      print("task ${task.toJson()}");
      return _taskItemUiBuilder(task);
    } else {
      return Container();
    }
  }

  Widget _taskItemUiBuilder(Task task) {
    return Container(
      child: Card(
        elevation: 3.0,
        margin: EdgeInsets.only(bottom: 15.0, left: 20.0, right: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Icon(
                      Icons.watch_later_rounded,
                      color: Colors.black54,
                      size: Variables.textSizeS.sp,
                    ),
                  ),
                  Text(
                    Jiffy(DateTime(task.createdAt.year, task.createdAt.month, task.createdAt.day)).format("do MMMM, yyyy"),
                    style: TextStyle(
                      fontSize: Variables.textSizeNormal.sp,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 10.0)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.screen_search_desktop,
                      color: Colors.black54,
                      size: Variables.textSizeS.sp,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: Variables.textSizeXs.sp,
                        color: Variables.blueColor,
                        fontWeight: FontWeight.w600,
                        height: 1.2.sp,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 5.0)),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Icon(
                      Icons.person,
                      color: Colors.black54,
                      size: Variables.textSizeM.sp,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      task.user != null ? task.user.firstName + " " + task.user.lastName : "N/A",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Variables.textSizeNormal.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 5.0)),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.black54,
                      size: Variables.textSizeS.sp,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      task.address != null ? task.address.street : "N/A",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Variables.textSizeNormal.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 2.0)),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Text(
                      "City:",
                      style: TextStyle(
                        fontSize: Variables.textSizeNormal.sp,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      task.address != null ? task.address.city : "N/A",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Variables.textSizeNormal.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 2.0)),
              Row(
                children: [
                  Text(
                    "Country: ",
                    style: TextStyle(
                      fontSize: Variables.textSizeNormal.sp,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      task.address != null ? task.address.country : "N/A",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Variables.textSizeNormal.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Text(
                    "\u{20B9}" + task.price.toString(),
                    style: TextStyle(
                      fontSize: Variables.textSizeNormal.sp,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onRouteToHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void onClearSearchText() {
    setState(() {
      _searchQuery = null;
      _searchQueryKey.clear();
    });
    onFilterTasks();
  }

  Future onGetToken() async {
    setState(() {
      isApiCallProcess = true;
    });
    token = await sharedPref.onGetSharedPreferencesValue("tokenKey");

    setState(() {
      token = token;
    });

    if(token != null) {
      widget.isShowAllTasks ? await onGetAllTasks() : await onGetUserPostedTasks();
    } else {
      setState(() {
        isApiCallProcess = false;
      });
    }
  }

  Future onGetAllTasks() async {
    setState(() {
      isApiCallProcess = true;
    });
    await taskService.getAllTasks(token).then((res) => {
      if(res.success) {
        setState(() {
          taskList = res.data.toList();
          tempTasks = res.data.toList();
          print("ts allTasks len ${taskList.length}");
          isApiCallProcess = false;
        }),
      }
    }).catchError((e) {
      setState(() {
        isApiCallProcess = false;
      });
    });
  }

  Future onGetUserPostedTasks() async {
    setState(() {
      isApiCallProcess = true;
    });
    await taskService.getUserPostedTasks(token).then((res) => {
      if(res.success) {
        setState(() {
          taskList = res.data.toList();
          tempTasks = res.data.toList();
          print("ts userPostedTasks len ${taskList.length}");
          isApiCallProcess = false;
        }),
      }
    }).catchError((e) {
      setState(() {
        isApiCallProcess = false;
      });
    });
  }

  void onFilterTasks() {
    if(_searchQueryKey.text != null) {
      taskList.clear();
      tempTasks.forEach((element) {
        if (element.title.toLowerCase().contains(_searchQueryKey.text.toLowerCase())) {
          taskList.add(element);
        }
      });
    } else {
      taskList = tempTasks;
    }
    setState(() {
      taskList = taskList;
    });
  }
}