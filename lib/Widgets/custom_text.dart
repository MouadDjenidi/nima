import 'package:flutter/material.dart';
import 'package:nima/constants/app_constants.dart';

class CustomText extends StatelessWidget {
  final Widget method;

  const CustomText({Key key, this.method}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return method;
  }
}

class CustomTextAppBar extends StatelessWidget {
  final String text;
  const CustomTextAppBar({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
           color: textAppBarColor,
           letterSpacing: .5,
           fontSize: 18,
      ),
           
    );
  }
}