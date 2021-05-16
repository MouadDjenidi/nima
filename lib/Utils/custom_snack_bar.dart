import 'package:flutter/material.dart';


class CustomSnackBar{

   SnackBar setSnackBar(Color backgroundColor,Icon icon,Text text){
    return SnackBar(
      backgroundColor: backgroundColor,
      content: Row(
        children: <Widget>[
          icon,
          SizedBox(width: 10),
          text,
        ],
      ),
    );
  }

}