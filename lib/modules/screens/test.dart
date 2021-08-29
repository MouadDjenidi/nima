import 'package:flutter/material.dart';
import 'package:nima/core/auth/Login/authentication_service.dart';
import 'package:provider/provider.dart';

class LogOutPage extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: new Column(children: <Widget>[
         
              
                FlatButton(
                  color: Colors.blue[400],
                  onPressed: () {
                   
                    context.read<AuthenticationService>().signOut();
                  },
                  child: Text(
                    "login",
                    style: TextStyle(color: Colors.white),
                  ),
                )
           
            
          ]),
        ),
      ),
    );
  }
}
