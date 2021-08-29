import 'package:flutter/material.dart';

class CustomSimpleDialog extends StatelessWidget {
  String titleText;
  String contentText;
  List<Widget> actions;

  CustomSimpleDialog({
    this.titleText,
    this.contentText,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titleText),
      content: Text(contentText),
      actions: actions,
    );
  }
}

class CustomProcessingDialog extends StatelessWidget {
  String contentText;

  CustomProcessingDialog({
    this.contentText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        content: Container(
            width: 250.0,
            height: 100.0,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 20,
              ),
              CircularProgressIndicator(),
              SizedBox(
                width: 20,
              ),
              Center(
                child: Text(contentText,
                    style: TextStyle(
                        fontFamily: "OpenSans", color: Color(0xFF5B6978))),
              ),
            ])));
  }
}
