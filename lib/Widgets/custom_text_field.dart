import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  TextEditingController controller;
  TextInputType textInputType;
  String hintText;
  Icon icon;
  Function(String) validator;
  bool isOscureText =  false;
  Widget suffixIcon;

  CustomTextFormField({this.controller, this.textInputType, this.hintText, this.icon, this.validator , this.isOscureText, this.suffixIcon, });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        validator: validator,
        obscureText: isOscureText,
        //keyboardType: TextInputType.,
        controller: controller,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon:  icon,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          isDense: true,
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[350],
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black45,
              width: 1.0,
            ),
          ),
          fillColor: Colors.white.withOpacity(.3),
          filled: true,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

class CustomTextFormField1 extends StatelessWidget {
  TextEditingController controller;
  TextInputType textInputType;
  String hintText;
  Icon icon;
  Function(String) validator;
  bool isOscureText =  false;
  Widget suffixIcon;

  CustomTextFormField1({this.controller, this.textInputType, this.hintText, this.icon, this.validator , this.isOscureText, this.suffixIcon, });

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
        validator: validator,
        obscureText: isOscureText,
        controller: controller,
        cursorColor: Colors.blue[400],
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon:  icon,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          isDense: true,
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[350],
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black45,
              width: 1.0,
            ),
          ),
          fillColor: Colors.blue[400].withOpacity(.8),
          filled: true,
          suffixIcon: suffixIcon,
        ),
      );
  }
}

class CustomTextFormField2 extends StatelessWidget {
  TextEditingController controller;
  TextInputType textInputType;
  String hintText;
  Icon icon;
  Function(String) validator;
  bool isOscureText =  false;
  Widget suffixIcon;
  int minLines ;
  bool readonly;
   

  CustomTextFormField2({this.controller, this.textInputType, this.hintText, this.icon, this.validator , this.isOscureText, this.suffixIcon, this.minLines , this.readonly,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: TextFormField(
        readOnly: readonly,
        minLines: minLines,
        keyboardType: textInputType,
         maxLines: null,
        validator: validator,
        obscureText: isOscureText,
        controller: controller,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          prefixIcon:  icon,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
          hoverColor: Colors.black,
          focusColor: Colors.black,
          isDense: true,
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          fillColor: Colors.grey[300].withOpacity(.3),
          filled: true,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

