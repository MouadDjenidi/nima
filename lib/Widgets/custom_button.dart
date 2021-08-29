import 'package:flutter/material.dart';

class CustomSocialButton extends StatelessWidget {
   String imagePath;
   String buttonText;
   Function onPressed;

  CustomSocialButton({this.imagePath ,this.buttonText, this.onPressed, });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 40.0,
      buttonColor: Colors.white,
      child: RaisedButton(
        onPressed: onPressed,
        child: Center(
          child: Row(children: <Widget>[
            Container(
              height: 38.0, // 40dp - 2*1dp border
              width: 38.0, // matches above
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(
                    imagePath,
                  ),
                  height: 30.0,
                  width: 30.0,
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(buttonText,
                style: TextStyle(
                    color: Colors.blue[400],
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
          ]),
        ),
      ),
    );
  }
}
