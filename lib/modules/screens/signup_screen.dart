import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nima/Utils/custom_snack_bar.dart';
import 'package:nima/Widgets/custom_dialog.dart';
import 'package:nima/Widgets/custom_text_field.dart';
import 'package:nima/constants/app_constants.dart';
import 'package:nima/core/auth/Login/authentication_service.dart';
import 'package:nima/modules/models/model_account.dart';
import 'package:nima/modules/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:nima/modules/screens/verify_screen.dart';

import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _nameState createState() => _nameState();
}

class _nameState extends State<SignUpScreen> {
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var _signupFormKey = GlobalKey<FormState>();
  bool isShopType = false;
  double height1 = 15;
  double height2 = 15;
  bool isPasswordOscure = true;
  bool progress = false;

  CustomSnackBar customSnackBar;
  @override
  void initState() {
    customSnackBar = new CustomSnackBar();
    super.initState();
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
                height: 50,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    'créer un compte',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Choisissez votre type de compte',
                    style: TextStyle(
                        color: Colors.white,
                        //fontWeight: FontWeight.normal,
                        fontSize: 15),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width,
                          height: 100,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color:
                                      isShopType ? Colors.green : Colors.white,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(2)),
                          child: FlatButton(
                            color: isShopType
                                ? Colors.white.withOpacity(0.5)
                                : Colors.transparent,
                            onPressed: () => {
                              setState(() {
                                isShopType = true;
                              }),
                            },
                            child:
                                Image.asset('assets/images/icons8shop96.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ButtonTheme(
                        buttonColor: Colors.white.withOpacity(0.1),
                        minWidth: MediaQuery.of(context).size.width,
                        height: 100,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.white,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(2)),
                        child: FlatButton(
                          color: isShopType
                              ? Colors.transparent
                              : Colors.white.withOpacity(0.5),
                          onPressed: () {
                            setState(() {
                              isShopType = false;
                            });
                          },
                          child: Image.asset('assets/images/icons8user96.png'),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _signupFormKey,
                child: new Column(
                  children: <Widget>[
                    //------------------------------------------- user name -----------------------------------
                    CustomTextFormField(
                      validator: (String value) {
                        if (value.length == 0) {
                          setState(() {
                            height1 = 5;
                          });
                          return "Obligatoire * ";
                        } else {
                          setState(() {
                            height1 = 15;
                          });
                        }
                      },
                      controller: displayNameController,
                      textInputType: TextInputType.visiblePassword,
                      hintText: "Nom d'utilisateur",
                      icon: Icon(
                        Icons.supervisor_account,
                        color: Colors.white,
                      ),
                      isOscureText: false,
                    ),
                    //------------------------------------------- end user name -----------------------------------
                    SizedBox(
                      height: height1,
                    ),
                    //------------------------------------------- email -----------------------------------
                    CustomTextFormField(
                      validator: (String value) {
                        if (value.length == 0) {
                          setState(() {
                            height2 = 5;
                          });
                          return "Obligatoire * ";
                        } else {
                          setState(() {
                            height2 = 15;
                          });
                        }
                      },
                      controller: emailController,
                      textInputType: TextInputType.visiblePassword,
                      hintText: 'Adresse Email',
                      icon: Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                      isOscureText: false,
                    ),
                    //------------------------------------------- end email -----------------------------------
                    SizedBox(
                      height: height2,
                    ),
                    //------------------------------------------- password -----------------------------------
                    CustomTextFormField(
                      validator: (String value) {
                        if (value.length < 6) {
                          return "Mot de passe doit être d'au moins 6 caractères";
                        }
                      },
                      controller: passwordController,
                      textInputType: TextInputType.visiblePassword,
                      hintText: 'Mot de passe',
                      icon: Icon(
                        Icons.security,
                        color: Colors.white,
                      ),
                      isOscureText: isPasswordOscure,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPasswordOscure = !isPasswordOscure;
                            if (isPasswordOscure)
                              isPasswordOscure = true;
                            else
                              isPasswordOscure = false;
                          });
                        },
                        child: Icon(
                          isPasswordOscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    //------------------------------------------- end password -----------------------------------
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ButtonTheme(
                    buttonColor: Colors.white,
                    minWidth: MediaQuery.of(context).size.width,
                    height: 40,
                    child: RaisedButton(
                      onPressed: () async {
                        //------------------------------------ button logic ------------------------------------------
                        if (_signupFormKey.currentState.validate()) {
                          bool isUSerCreated = false;

                          Account account = new Account();
                          account.displayName =
                              displayNameController.text.trim();
                          account.email = emailController.text.trim();
                          account.password = passwordController.text.trim();
                          account.shopmanager = isShopType;
                          account.paid = false;

                          await createUser(account)
                              .then((value) => isUSerCreated = value);

                          if (isUSerCreated) {
                            displayNameController.clear();
                            emailController.clear();
                            passwordController.clear();

                            await context.read<AuthenticationService>().signIn(
                                  email: account.email.trim(),
                                  password: account.password.trim(),
                                );

                            User user = FirebaseAuth.instance.currentUser;
                            //Navigator.of(context).pop();
                            setState(() {
                              progress = false;
                            });

                            if (!user.emailVerified) {
                              user.sendEmailVerification();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => VerifyScreen()));
                            }
                          }
                        }
                        //------------------------------------ end of button logic -----------------------------------
                      },
                      child: Text(
                        'Créer un compte',
                        style: TextStyle(
                          color: Colors.blue[400],
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Avez-vous déjà un compte ?",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => Loginscreen()));
                    },
                    child: Text(
                      "Connexion",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Visibility(
                  visible: progress,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                    minHeight: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> createUser(Account account) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult != ConnectivityResult.none) {
      try {
        //showProcessingDialog();
        setState(() {
          progress = true;
        });
        final response = await http.post(
          Uri.parse(apiUrl + '/createuser'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "displayName": account.displayName,
            "password": account.password,
            "email": account.email,
            "claims": {
              "shopmanager": account.shopmanager,
              "paid": account.paid
            },
          }),
        );
        if (response.statusCode == 201) {
          return true;
        } else {
          Navigator.of(context).pop();
          final res = jsonDecode(response.body);
          if (res["message"] != null) {
            final String message = res["message"];
            if (message.contains("email-already-exists")) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Attention!"),
                      content: Text(
                          "L'adresse e-mail est déjà utilisée par un autre compte !"),
                      actions: [
                        TextButton(
                          child: Text("Ok"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            }
          }
          return false;
        }
      } catch (e) {
        customSnackBar.snackBarWarning(
            context, 'Erreur lors de la récupération des données',Colors.white.withOpacity(0.5));
      }
    } else {
      customSnackBar.snackBarWarning(context, 'connexion réseau indisponible',Colors.white.withOpacity(0.5));
    }
  }

  void showProcessingDialog() async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CustomProcessingDialog(
            contentText: "en cours de création...",
          );
        });
  }
}
