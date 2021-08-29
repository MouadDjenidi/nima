import 'package:flutter/material.dart';

class Account {

   String displayName;
   String password;
   String email;
   bool shopmanager;
   bool paid;

  Account({@required this.displayName, @required this.password, @required this.email, @required this.shopmanager, @required this.paid});

  factory Account.fromJson(Map<String, dynamic> json) {
  return Account(
      displayName:    json['displayName'],
      password:       json['password'],
      email:          json['email'],
      shopmanager:    json['claims']['shopmanager'],
      paid:           json['claims']['paid'],
    );
  }
}