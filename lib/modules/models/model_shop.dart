import 'package:flutter/material.dart';

class shop {

  final int shopid;
  final String shopname;
  final String shopadress;
  final String shopphone;
  final String shopemail;
  final num shoprank;

  shop({@required this.shopid, @required this.shopname, @required this.shopadress , @required this.shopphone, @required this.shopemail ,@required this.shoprank});

  factory shop.fromJson(Map<String, dynamic> json) {
    return shop(
      shopid:    json['shop_id'],
      shopname:  json['shop_name'],
      shopadress:json['shop_adress'],
      shopphone: json['shop_phone'],
      shopemail: json['shop_email'],
      shoprank:  json['shop_rank'],
    );
  }
}