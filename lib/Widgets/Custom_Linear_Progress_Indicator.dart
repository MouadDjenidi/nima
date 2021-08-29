import 'package:flutter/material.dart';



class CustomLinearProgressIndicator extends StatelessWidget {

  bool visible = false;   
  double left = 0;
  double right = 0; 
  Color color = Colors.blue;

  CustomLinearProgressIndicator({this.visible ,this.left, this.right, this.color,});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: left, right: right),
      child: Visibility(
        visible: visible,
        child: LinearProgressIndicator(
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation(color),
          minHeight: 3,
        ),
      ),
    );
  }
}
