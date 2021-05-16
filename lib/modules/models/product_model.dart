import 'package:flutter/material.dart';

class Product {
  
  int productID;
  int userID;
  int shopID;
  String name;
  double taux;
  double priceBefor;
  double priceAfter;
  num rank;
  DateTime startDate;
  DateTime endDate;
  DateTime created;
  DateTime updated;
  String status;
  String description;
  int amount;

  int get sysProductID {
    return productID;
  }

  set sysProductID(int ID) {
    this.productID = ID;
  }

  int get sysUserID {
    return userID;
  }

  set sysUserID(int ID) {
    this.userID = ID;
  }

  int get sysShopID {
    return shopID;
  }

  set sysShopID(int ID) {
    this.shopID = ID;
  }

  String get sysName {
    return name;
  }

  set sysName(String name) {
    this.name = name;
  }

  double get sysTaux {
    return taux;
  }

  set sysTaux(double taux) {
    this.taux = taux;
  }

  double get sysPriceBefor {
    return priceBefor;
  }

  set sysPriceBefor(double price) {
    this.priceBefor = price;
  }

  double get sysPriceAfter {
    return priceAfter;
  }

  set sysPriceAfter(double price) {
    this.priceAfter = price;
  }

  num get sysRank {
    return rank;
  }

  set sysRank(num rank) {
    this.rank = rank;
  }

  DateTime get sysStartDate {
    return startDate;
  }

  set sysStartDate(DateTime date) {
    this.startDate = date;
  }

  DateTime get sysEndDate {
    return endDate;
  }

  set sysEndDate(DateTime date) {
    this.endDate = date;
  }

  DateTime get sysCreated {
    return created;
  }

  set sysCreated(DateTime date) {
    this.created = date;
  }

  DateTime get sysUpdated {
    return updated;
  }

  set sysUpdated(DateTime date) {
    this.updated = date;
  }

  String get sysStatus {
    return status;
  }

  set sysStatus(String status) {
    this.status = status;
  }

  String get sysdescription {
    return description;
  }

  set sysdescription(String description) {
    this.description = description;
  }

  int get sysAmount {
    return amount;
  }

  set sysAmount(int amount) {
    this.amount = amount;
  }

  Product(
      {@required this.productID,
      @required this.userID,
      @required this.shopID,
      @required this.name,
      @required this.taux,
      @required this.priceBefor,
      @required this.priceAfter,
      @required this.rank,
      @required this.startDate,
      @required this.endDate,
      @required this.created,
      @required this.updated,
      @required this.status,
      @required this.description,
      @required this.amount});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productID: json['productID'],
      userID: json['userID'],
      shopID: json['shopID'],
      name: json['name'],
      taux: json['taux'],
      priceBefor: json['priceBefor'],
      priceAfter: json['priceAfter'],
      rank: json['rank'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      created: json['created'],
      updated: json['updated'],
      status: json['status'],
      description: json['description'],
      amount: json['amount']
    );
  }

  Map<String, dynamic> toJson() => {
        'productID': productID,
        'userID': userID,
        'shopID': shopID,
        'name': name,
        'taux': taux,
        'priceBefor': priceBefor,
        'priceAfter': priceAfter,
        'rank': rank,
        'startDate': startDate,
        'endDate': endDate,
        'created': created,
        'updated': updated,
        'status': status,
        'description':description,
        'amount':amount
      };
}
