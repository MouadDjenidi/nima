import 'package:flutter/material.dart';

class ShowDialog {
  void showCustomDialog(String title, String content, String buttonText,
      Color color, TextButton textButton, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(color: color),
            ),
            content: Text(content),
            actions: [
              textButton,
              TextButton(
                child: Text(buttonText),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}