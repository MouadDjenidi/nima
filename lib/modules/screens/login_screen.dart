import 'package:flutter/material.dart';
import 'package:nima/Widgets/custom_button.dart';
import 'package:nima/Widgets/custom_divider.dart';
import 'package:nima/Widgets/custom_text_field.dart';
import 'package:nima/Widgets/reset_password_widget.dart';
import 'package:nima/core/service/login.dart';
import 'package:nima/modules/screens/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class Loginscreen extends StatefulWidget {
  @override
  _Loginscreen createState() => _Loginscreen();
}

class _Loginscreen extends State<Loginscreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var _loginFormKey = GlobalKey<FormState>();
  bool isProgress = false;
  bool isPasswordOscure = true;
  double height1 = 15;
  Login login;

  @override
  void initState() {
    login = new Login();
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
                height: 70,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 40,
                  ),
                  _title(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    'Connectez-vous avec votre compte.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )
                ],
              ),
              SizedBox(
                height: 65,
              ),
              //-------------------------------------------------------------------------------------------------------------------------------------
              Form(
                  key: _loginFormKey,
                  child: new Column(children: <Widget>[
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
                      controller: emailController,
                      textInputType: TextInputType.visiblePassword,
                      hintText: 'Adresse Email',
                      icon: Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                      isOscureText: false,
                    ),
                    SizedBox(
                      height: height1,
                    ),
                    CustomTextFormField(
                      validator: (String value) {
                        if (value.length == 0) {
                          return "Obligatoire * ";
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
                  ])),
              //-------------------------------------------------------------------------------------------------------------------------------------
              SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ResetPasswordWidget();
                          });
                    },
                    child: Container(
                      child: Text(
                        'Mot de passe oublié ?',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ButtonTheme(
                  buttonColor: Colors.white,
                  minWidth: MediaQuery.of(context).size.width,
                  child: ButtonTheme(
                      buttonColor: Colors.white,
                      minWidth: MediaQuery.of(context).size.width,
                      height: 40,
                      child: RaisedButton(
                        onPressed: () async {
                          //------------------------------- Login button action ------------------------------------
                          if (_loginFormKey.currentState.validate()) {
                            setState(() {
                              isProgress = true;
                            });
                            await login.loginWithUserAndPass(
                                context,
                                emailController.text.trim(),
                                passwordController.text.trim());
                            setState(() {
                              isProgress = false;
                            });
                          }

                          //------------------------------- End Of Login button action -----------------------------------
                        },
                        child: Text(
                          'Connexion',
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
              ),

              CustomLoginScreenDivider(
                dividerText: 'OU',
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: CustomSocialButton(
                  imagePath: "assets/images/google.png",
                  buttonText: 'Connectez-vous avec Google',
                  onPressed: () {
                    login.loginWithGoogle(context);
                  },
                ),
              ),

              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Vous n'avez pas de compte ?",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      /*Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => SignUpScreen()));*/
                       Navigator.of(context).push(_createProductPgae());

                    },
                    child: Text(
                      "S'inscrire",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 50,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Visibility(
                  visible: isProgress,
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

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Ni3ma app',
        style: GoogleFonts.indieFlower(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

   Route _createProductPgae() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignUpScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}
