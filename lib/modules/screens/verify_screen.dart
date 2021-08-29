import 'dart:async';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nima/core/auth/Login/authentication_service.dart';
import 'package:nima/modules/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

class VerifyScreen extends StatefulWidget {
  VerifyScreen({
    Key key,
  }) : super(key: key);

  @override
  _VerifyScreen createState() => _VerifyScreen();
}

class _VerifyScreen extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState() {
    user = auth.currentUser;
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/1.png'), fit: BoxFit.cover),
          gradient: LinearGradient(
              colors: [Colors.blue[400], Colors.blue],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 180,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      LinearProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation(Colors.green[400]),
                        minHeight: 3,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.send,
                          color: Colors.green[400],
                        ),
                        title: Text(
                            "Bonjour ${user != null ? user.displayName : ''} "),
                        subtitle: Text(
                            "un email a été envoyé à ${user != null ? user.email : ''} Veuillez vérifier!"),
                      ),
                      ButtonBarTheme(
                        // make buttons use the appropriate styles for cards
                        data: ButtonBarThemeData(),
                        child: ButtonBar(
                          children: <Widget>[
                            TextButton(
                              child: const Text('renvoyer Email'),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  elevation: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Void> checkEmailVerified() async {
    user = auth.currentUser;
    if (user != null) {
      user.reload();
      if (user.emailVerified) {
        timer.cancel();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => AuthenticationWrapper(),
            ));
      }
    }
  }
}
