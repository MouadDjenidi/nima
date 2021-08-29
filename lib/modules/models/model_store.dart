import 'package:flutter/material.dart';

class Store {
  String storeId;
  String storeName;
  double storeGeopointLatitude;
  double storeGeopointLongitude;
  String storeUrl;
  String storeImage;
  String description;
  bool isdefault;
  String email;
  String phone;
  String userId;

  Store({
    @required this.storeId,
    @required this.storeName,
    @required this.storeGeopointLatitude,
    @required this.storeGeopointLongitude,
    @required this.storeUrl,
    @required this.storeImage,
    @required this.description,
    @required this.isdefault,
    @required this.email,
    @required this.phone,
    @required this.userId,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      storeId: json['store_id'],
      storeName: json['store_name'],
      storeGeopointLatitude: json['store_geopoint']['_Latitude'],
      storeGeopointLongitude: json['store_geopoint']['Longitude'],
      storeUrl: json['store_url'],
      storeImage: json['store_image'],
      description: json['description'],
      isdefault: json['isdefault'],
      email: json['email'],
      phone: json['phone'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "store_name": storeName,
        "store_geopoint": {
          "Latitude": storeGeopointLatitude,
          "Longitude": storeGeopointLongitude
        },
        "store_url": storeUrl,
        "store_image": storeImage,
        "description": description,
        "isdefault": isdefault,
        "email": email,
        "phone": phone,
        "user_id": userId
      };
}
