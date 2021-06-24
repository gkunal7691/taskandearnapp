import 'package:flutter/material.dart';
import 'package:task_and_earn/pages/post_a_job/CategoriesPage.dart';
import 'package:task_and_earn/util/Util.dart';
import 'package:toast/toast.dart';
import '../HomePage.dart';

class TneFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void onShowToast(String msg, int timeInSec) {
      Toast.show(msg, context, duration: timeInSec, gravity:  Toast.BOTTOM);
    }

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
          onShowToast("Redirecting to Become a Learner", 2);
          Util.launchURL("https://taskandearn-dev.herokuapp.com/become-earner-login");
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