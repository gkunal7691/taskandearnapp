import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:task_and_earn/models/Task_Model.dart';
import 'package:task_and_earn/pages/shared/tne-footer.dart';
import 'package:task_and_earn/services/TaskService.dart';
import 'package:task_and_earn/util/SharedPref.dart';
import 'package:task_and_earn/util/Util.dart';
import 'package:task_and_earn/util/Variables.dart';
import '../HomePage.dart';
import '../ProgressHUD.dart';

class AllTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      title: "Task and Earn",
      home: AllTasksPageWidget(),
    );
  }
}

class AllTasksPageWidget extends StatefulWidget {
  @override
  _AllTasksPageWidgetState createState() => _AllTasksPageWidgetState();
}

class _AllTasksPageWidgetState extends State<AllTasksPageWidget> {
  bool isApiCallProcess = false;
  final _searchQueryKey = TextEditingController();
  String _searchQuery;
  ScrollController _scrollController = ScrollController(initialScrollOffset: Variables.recentTaskCardH.h);
  String token;
  SharedPref sharedPref = new SharedPref();
  TaskService taskService =  new TaskService();
  List<Task> allTasks = [];
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
                          color: Variables.blueColor
                        ),
                      ),
                      onTap: () {
                        onRouteToHome();
                      },
                    ),
                    Container(
                      child: Text(
                        "All Tasks",
                        style: TextStyle(
                            fontSize: Variables.headerTextSize.sp,
                            fontWeight: FontWeight.bold
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
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.only(top: 10.0),
                  child: Scrollbar(
                    isAlwaysShown: true,
                    controller: _scrollController,
                    thickness: 8.0,
                    child: ListView.builder(
                      itemCount: allTasks.length,
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
    if(allTasks.length != 0) {
      var task = this.allTasks[index];
      return _taskItemUiBuilder(task);
    } else {
      return Container();
    }
  }

  Widget _taskItemUiBuilder(Task task) {
    return Container(
      height: Variables.recentTaskCardH.h,
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
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Variables.textSizeXs.sp,
                        color: Color(0xFF098CC3),
                        fontWeight: FontWeight.w600,
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

              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 25.0,
                    child: ElevatedButton(
                      child: Text(
                        "Become a Earner",
                        style: TextStyle(
                          fontSize: Variables.textSizeNormal.sp,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        primary: Colors.blue.shade600,
                      ),
                      onPressed: () {
                        Util.launchURL("https://taskandearn-dev.herokuapp.com/become-earner-login");
                      },
                    ),
                  ),
                ),
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
      await onGetTasks();
    } else {
      setState(() {
        isApiCallProcess = false;
      });
    }
  }

  Future onGetTasks() async {
    setState(() {
      isApiCallProcess = true;
    });
    await taskService.getTasks(token).then((res) => {
      if(res.success) {
        setState(() {
          allTasks = res.data.toList();
          tempTasks = res.data.toList();
          print("hp allTasks len ${allTasks.length}");
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
    print("_searchQueryKey.text ${_searchQueryKey.text.toLowerCase()}");
    if(_searchQueryKey.text != null) {
      allTasks.clear();
      tempTasks.forEach((element) {
        if (element.title.toLowerCase().contains(_searchQueryKey.text.toLowerCase())) {
          allTasks.add(element);
        }
      });
    } else {
      allTasks = tempTasks;
    }
    setState(() {
      allTasks = allTasks;
    });
    print("allTasks len ${allTasks.length}");
  }
}