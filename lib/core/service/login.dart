import 'dart:ffi';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nima/Utils/custom_snack_bar.dart';
import 'package:nima/Utils/show_custom_dialog.dart';
import 'package:nima/core/auth/Login/authentication_service.dart';
import 'package:provider/provider.dart';

class Login{

  CustomSnackBar customSnackBar = new CustomSnackBar();
  ShowDialog showCustomDialog = new ShowDialog();
  Color color= Colors.white.withOpacity(0.5);

  Future<Void> loginWithGoogle(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        await context.read<AuthenticationService>().googleSignInServ();
      } catch (err) {
        customSnackBar.snackBarWarning(
            context, 'erreur inconnue! essayez de contacter le fournisseur',color);
      }
    } else {
      customSnackBar.snackBarWarning(context, 'connexion réseau indisponible',color);
    }
  }

   Future<Void> loginWithUserAndPass(BuildContext context, String email, String password) async {
    String resMsg = "";
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      await context
          .read<AuthenticationService>()
          .signIn(
            email: email,
            password: password,
          )
          .then((value) => resMsg = value);

      User user = FirebaseAuth.instance.currentUser;
      switch (resMsg) {
        case "signed-in":
          if (user.emailVerified == false) {
            TextButton textButton = new TextButton(
              child: Text("envoyer à nouveau"),
              onPressed: () {
                user.sendEmailVerification();
              },
            );
            showCustomDialog.showCustomDialog(
                "Attention",
                "Veuillez vérifier cet e-mail ${user.email}  !",
                "quitter",
                Colors.red[400],
                textButton,
                context);
          }
          break;
        case "wrong-password":
          showCustomDialog.showCustomDialog("Attention", "mot de passe est invalide !", "quitter",
              Colors.red[400], null, context);
          break;  
        case "user-not-found":
          showCustomDialog.showCustomDialog("Attention", "utilisateur non trouvé !", "quitter",
              Colors.red[400], null, context);
          break;
        case "invalid-email":
          showCustomDialog.showCustomDialog("Attention", "email est invalide !", "quitter",
              Colors.red[400], null, context);
          break;
        default: showCustomDialog.showCustomDialog("Attention", "erreur inconnue! essayez de contacter le fournisseur", "quitter",
              Colors.red[400], null, context);
      }
    } else {
      customSnackBar.snackBarWarning(context, 'connexion réseau indisponible',color);
    }
  }

}