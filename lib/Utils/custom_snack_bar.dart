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

   void snackBarWarning(BuildContext context,String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(setSnackBar(
      color,
      Icon(
        Icons.warning,
        color: Colors.white,
      ),
      Text(message),
    ));
   }

   

}