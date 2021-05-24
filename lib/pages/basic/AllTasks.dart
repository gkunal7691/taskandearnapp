import 'package:flutter/material.dart';
import '../HomePage.dart';
import '../ProgressHUD.dart';

class AllTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

  @override
  void initState() {
    super.initState();
    // onGetToken();
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
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
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
                        onRouteHome();
                      },
                    ),
                    Container(
                      child: Text(
                        "All Tasks",
                        style: TextStyle(
                            fontSize: 25.0,
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
                      height: 45.0,
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
                          hintText: "Search for task",
                          labelText: "Search for task",
                          contentPadding: EdgeInsets.only(top: 5.0),
                          prefixIcon: Icon(Icons.search),
                          suffixIcon:
                            _searchQuery == null ? null :
                            GestureDetector(
                              onTap: () {
                                onClearSearchText();
                              },
                              child: Icon(
                                Icons.clear,
                              ),
                            ),
                        ),
                        style: TextStyle(fontSize: 20.0),
                        textInputAction: TextInputAction.done,
                        onChanged: (input) {
                          setState(() {
                            _searchQuery = input;
                          });
                          print("_searchQuery $_searchQuery");
                          // onFilterTasks();
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

  void onRouteHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  onClearSearchText() {
    setState(() {
      _searchQuery = null;
      _searchQueryKey.clear();
    });
    print(_searchQuery);
  }
}