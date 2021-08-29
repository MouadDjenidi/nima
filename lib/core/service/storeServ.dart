import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:nima/constants/app_constants.dart';
import 'package:nima/modules/SharedPreferences/store_pref.dart';
import 'package:nima/modules/models/model_store.dart';

class StoreServ {
  Future<dynamic> createStore(Store store) async {
    var idToken;
    try {
      User user = FirebaseAuth.instance.currentUser;
      await user.getIdToken().then((value) => idToken = value);
      final response = await http.post(
        Uri.parse(apiUrl + '/createstore'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $idToken',
        },
        body: jsonEncode(store),
      );
      if (response.statusCode == 200) {
        if (store.isdefault) {
          print("passed by defaultUserStore api call");
          saveDefaultStore(response.body);
          userStores();
        }
      }
      return response.statusCode;
    } catch (err) {
      return err;
    }
  }

  Future<dynamic> defaultUserStore() async {
    var idToken;
    try {
      User user = FirebaseAuth.instance.currentUser;
      await user.getIdToken().then((value) => idToken = value);
      final response = await http.get(
        Uri.parse(apiUrl + '/defaultstore/${user.uid}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $idToken',
        },
      );
      if (response.statusCode == 200) {
        print("passed by defaultUserStore api call");
        saveDefaultStore(response.body);
        userStores();
      }
      return response.statusCode;
    } catch (err) {
      return err;
    }
  }

  Future<dynamic> userStores() async {
    var idToken;
    try {
      User user = FirebaseAuth.instance.currentUser;
      await user.getIdToken().then((value) => idToken = value);
      final response = await http.get(
        Uri.parse(apiUrl + '/userstores/${user.uid}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $idToken',
        },
      );
      if (response.statusCode == 200) {
        print("passed by userStores api call");
        addPreferencesAsString("listofstores",response.body);
      }
      return response.statusCode;
    } catch (err) {
      return err;
    }
  }
}
