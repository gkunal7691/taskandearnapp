import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class Util {
  static onShowToast(BuildContext context, String msg, int timeInSec) {
    Toast.show(msg, context, duration: timeInSec, gravity:  Toast.BOTTOM);
  }

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  static sendMail(mailId) async {
    final url = "mailto:$mailId";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  static sendSMS() async {
    const url = "sms:7978993074";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }
}