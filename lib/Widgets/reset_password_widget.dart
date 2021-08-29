import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nima/Widgets/Custom_Linear_Progress_Indicator.dart';
import 'package:nima/Widgets/custom_text_field.dart';
import 'package:nima/Utils/custom_snack_bar.dart';

class ResetPasswordWidget extends StatefulWidget {
  @override
  _ResetPasswordWidget createState() => _ResetPasswordWidget();
}

class _ResetPasswordWidget extends State<ResetPasswordWidget> {
  final TextEditingController emailController = TextEditingController();
  var _resetPasswordFormKey = GlobalKey<FormState>();
  bool progress = false;
  bool isValidationMessage = false;
  bool isValidationForm = true;
  String validationMessage = "";
  String contentText = "entrez l'adresse e-mail associée à votre compte";
  CustomSnackBar customSnackBar;

  @override
  void initState() {
    customSnackBar = new CustomSnackBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        "mot de passe oublié",
        style: TextStyle(
          color: Colors.blue[400],
          fontSize: 15,
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Column(
            children: <Widget>[
              Text(
                contentText,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Visibility(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                        key: _resetPasswordFormKey,
                        child: new Column(children: <Widget>[
                          CustomTextFormField1(
                            validator: (String value) {
                              if (value.length == 0) {
                                return "Obligatoire * ";
                              }
                            },
                            controller: emailController,
                            textInputType: TextInputType.visiblePassword,
                            hintText: 'Email',
                            icon: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                            isOscureText: false,
                          ),
                        ])),
                  ],
                ),
                visible: isValidationForm,
              ),
              SizedBox(
                height: 5,
              ),
              Visibility(
                child: Text(validationMessage),
                visible: isValidationMessage,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Visibility(
                    child: TextButton(
                      child: Text("envoyer"),
                      onPressed: () {
                        if (_resetPasswordFormKey.currentState.validate()) {
                          resetUserPassword(emailController.text.trim());
                        } else {
                          setState(() {
                            isValidationMessage = false;
                            validationMessage = "";
                          });
                        }
                      },
                    ),
                    visible: isValidationForm,
                  ),
                  TextButton(
                    child: Text("quitter"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              CustomLinearProgressIndicator(
                color: Colors.blue[400],
                left: 0,
                right: 0,
                visible: progress,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> resetUserPassword(String email) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult != ConnectivityResult.none) {
      setState(() {
        progress = true;
      });
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        emailController.clear();
        setState(() {
          isValidationForm = false;
          isValidationMessage = false;
          validationMessage = "";
          contentText = "un e-mail a été envoyé à l'adresse " + email;
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          isValidationMessage = true;
          switch (e.code) {
            case "user-not-found":
              validationMessage = "utilisateur non trouvé";

              break;
            case "invalid-email":
              validationMessage = "email invalide";
              break;

            default:
              validationMessage = e.code.toString();
          }
        });
        print('Failed with error code: ${e.code}');
      } finally {
        setState(() {
          progress = false;
        });
      }
    } else {
      setState(() {
        progress = false;
      });
      customSnackBar.snackBarWarning(context, 'connexion réseau indisponible',Colors.white.withOpacity(0.5));
    }
  }
}
