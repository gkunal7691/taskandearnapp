import 'package:flutter/material.dart';
import 'package:task_and_earn/models/User.dart';
import 'package:task_and_earn/pages/shared/ProgressHUD.dart';
import 'package:task_and_earn/services/UserService.dart';
import 'package:task_and_earn/util/Util.dart';
import 'package:task_and_earn/util/Variables.dart';
import "package:task_and_earn/util/extensions.dart";

void showForgotPasswordDialog({
  @required BuildContext context,
}) {
  assert(context != null);
  showDialog<void>(
    context: context,
    builder: (context) {
      return ForgotPasswordDialog();
    },
    barrierDismissible: false,
  );
}

class ForgotPasswordDialog extends StatefulWidget {
  @override
  _ForgotPasswordDialog createState() => new _ForgotPasswordDialog();
}

// ignore: must_be_immutable
class _ForgotPasswordDialog extends State<ForgotPasswordDialog> {
  bool isApiCallProcess = false;
  bool isEmailSent = false;
  bool isInvalidEmail = true;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  ForgotPasswordRequest forgotPasswordRequest = new ForgotPasswordRequest();
  UserService userService = new UserService();

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: _uiSetUp(context), isAsyncCall: isApiCallProcess, opacity: 0.6);
  }

  Widget _uiSetUp(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      scrollable: true,
      content: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Forgot Password",
              style: TextStyle(
                color: Variables.blueColor,
                fontSize: Variables.textSizeSl,
              ),
            ),

            isEmailSent ? _mailSentWidget() : _forgotPasswordForm(),

            TextButton(
              onPressed: () {
                Util.onShowToast(context, "Login to explore", 2);
                Navigator.pop(context);
              },
              child: Text("Back to Login Page"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _forgotPasswordForm() {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Container(
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Enter email",
                labelStyle: TextStyle(
                  fontSize: Variables.textSizeXs,
                ),
                hintText: "Email",
                hintStyle: TextStyle(
                  fontSize: Variables.textSizeXs,
                ),
              ),
              onSaved: (input) => {
                forgotPasswordRequest.email = input,
              },
              validator: (input) {
                if (input.isEmpty) {
                  return "Please enter Email";
                }
                if(!isInvalidEmail) {
                  return "Please enter valid Email";
                }
                return null;
              },
            ),
          ),
        ),

        Padding(padding: EdgeInsets.only(top: 10.0)),
        Text(
          "If your email exists, we will send you a link to reset your password.",
          style: TextStyle(
            fontWeight: FontWeight.w100,
            fontSize: Variables.textSizeNormal,
            color: Colors.orangeAccent,
          ),
        ),

        Padding(padding: EdgeInsets.only(top: 20.0)),
        ElevatedButton(
          onPressed: () {
            onSubmitEmail();
          },
          child: Text("Submit"),
        ),
      ],
    );
  }

  Widget _mailSentWidget() {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 10.0)),
        Text(
          "Mail sent to:",
        ),
        Text(
          forgotPasswordRequest.email,
          style: TextStyle(
            fontSize: Variables.textSizeNormal,
          ),
        ),

        Padding(padding: EdgeInsets.only(top: 20.0)),
        Text(
          "Check your email for a link to reset your password. If it "
              "doesn’t appear within a few minutes, check your spam folder.",
          style: TextStyle(
            fontSize: Variables.textSizeNormal,
          ),
        ),
      ],
    );
  }

  Future onSubmitEmail() async {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        isApiCallProcess = true;
      });
      await userService.sendMail(forgotPasswordRequest).then((res) async => {
        setState(() {
          isApiCallProcess = false;
          isInvalidEmail = res.success;
        }),
        if(res.success) {
          setState(() {
            isEmailSent = true;
          }),
        }
      });
    } else {
      setState(() {
        isInvalidEmail = false;
      });
    }
  }
}