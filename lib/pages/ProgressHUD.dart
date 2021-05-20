import 'package:flutter/material.dart';

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool isAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color> valueColour;

  const ProgressHUD(
      {Key key,
      @required this.child,
      @required this.isAsyncCall,
      this.opacity = 0.3,
      this.color = Colors.grey,
      this.valueColour})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    List<Widget> widgetList = new List<Widget>();
    widgetList.add(child);
    if (isAsyncCall) {
      final model = Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            Opacity(
              opacity: opacity,
              child: ModalBarrier(dismissible: false, color: color),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  const Text(
                    "Please wait...",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
      widgetList.add(model);
    }
    return Stack(
      children: widgetList,
    );
  }
}
