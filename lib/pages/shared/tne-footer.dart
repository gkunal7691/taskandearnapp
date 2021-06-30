import 'package:flutter/material.dart';
import 'package:task_and_earn/pages/post_a_job/CategoriesPage.dart';
import 'package:task_and_earn/services/ApiManager.dart';
import 'package:task_and_earn/util/Util.dart';
import '../basic/HomePage.dart';

class TneFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        if(index == 0) {
          Util.onShowToast(context, "Redirected to Home", 2);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        }
        else if(index == 1) {
          Util.onShowToast(context, "Redirected to Post a Job", 2);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
              CategoriesPage(
                categoryData: null, address: null, task: null,
              )));
        }
        else if(index == 2) {
          Util.onShowToast(context, "Redirecting to Become a Learner", 2);
          Util.launchURL(ApiManager.tneBaseUrl + "/become-earner-login");
        }
      },
      elevation: 30.0,
      selectedItemColor: Color(0xFF098CC3),
      unselectedItemColor: Color(0xFF098CC3),
      selectedFontSize: 14.0,
      unselectedFontSize: 14.0,
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
            height: 32.0,
          ),
          label: "Post a Job",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/images/salary.png",
            color: Colors.blue.shade600,
            height: 32.0,
          ),
          label: "Become a Earner",
        ),
      ],
    );
  }
}