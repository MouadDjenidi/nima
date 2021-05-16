import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:nima/Utils/custom_snack_bar.dart';

class CustomeConnectivity{

  void isConnected(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar().setSnackBar(Colors.blue[400], Icon(Icons.warning,color: Colors.white,), Text("Internet non disponible"),));
    }
  }

}