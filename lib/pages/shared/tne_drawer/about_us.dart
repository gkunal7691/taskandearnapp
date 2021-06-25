import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_and_earn/util/Variables.dart';
import '../tne-footer.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        title: "Task and Earn",
        home: AboutUsWidget()
    );
  }
}

class AboutUsWidget extends StatefulWidget {
  @override
  _AboutUsWidgetState createState() => _AboutUsWidgetState();
}

class _AboutUsWidgetState extends State<AboutUsWidget> {
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      bottomNavigationBar: TneFooter(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: [
            Container(
              child: Image.network(
                "https://taskandearn-dev.herokuapp.com//assets/image/IMG-20210611-WA0008.jpg",
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),

            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 5.0),
                  child: Text(
                    "Our Story",
                    style: TextStyle(
                      fontSize: Variables.textSizeL,
                      color: Variables.blueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
              child: Text(
                "Taskandearn is a trusted gig network launched to link people "
                    "who need to outsource tasks and find services, with people looking for employment.",
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
              child: Text(
                "Started in 2018, Task And Earn (T&E) provides an online platform "
                    "for everyone to meet their task needs. T&E partners with our customers "
                    "and business associates all over India to focus on what matters most, "
                    "thus enabling customers and job seekers to succeed in their tasks with "
                    "full potential. We will help you with everything ranging from housecleaning "
                    "to handyman jobs, admin work, Interior designing, Digital marketing, photography, "
                    "graphic design, copy writing, web developer and many more such tasks.",
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
              child: Text(
                'Our platform aims to empower skilled people and get them to the doorstep of the '
                    'recruiters irrespective of their specialization so that they benefit mutually. '
                    'Through this platform, anyone can build a career in any field of their choice '
                    'and earn. You can be an "earner" or can "post a job" and get your task done '
                    'in no time. Job seekers can apply for the job of their choice and employers '
                    'can see the profiles and choose the right one to get their task done.',
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
              child: Text(
                "So are you someone looking for an internship or a job? We have multiple opportunities "
                    "available for you! Find the field or task you are interested to work for and "
                    "upload your profile along with your skills and work to get hired. No matter if "
                    "you are in school or college if you have the relevant skills and talent "
                    "anyone can outsource remote task to you!",
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
              child: Text(
                "Moreover, we have myriad professionals as well in various fields who will serve you as per the requirement.",
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
              child: Text(
                "Now, you may go online or download the app 'Taskandearn' to meet all your needs.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}