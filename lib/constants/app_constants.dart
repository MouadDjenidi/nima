import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:nima/modules/screens/home_page.dart';
import 'package:nima/modules/screens/map_page.dart';
import 'package:nima/modules/screens/test.dart';
import 'file:///opt/mobile/apps/nima/test_map.dart';
import 'package:nima/modules/screens/vendor_promo_products.dart';
import 'package:shared_preferences/shared_preferences.dart';


final apiUrl = 'https://us-central1-ni3ma-311800.cloudfunctions.net/app';
final bool isVendor = true;

//----- application colors --------
final Color appBarColor     = Colors.blue[400];
final Color textAppBarColor = Colors.black;
final Color activeIconColor = Colors.blue[400];
final Color iconsColor      = Colors.blue[400];

//bool isshop ;

Future<bool> storedate() async {
    final prefs = await SharedPreferences.getInstance();
    //isVendor = prefs.getBool('isshop');
    return prefs.getBool('isshop');
}   

var currentTabb = [
    MyHomePage(),
    TestMap() ,
   // storedate().then((value) => value == true ? VendorPromoProducts() : MyMapPage()),
    isVendor == true ? VendorPromoProducts() : MyMapPage(),
    MyMapPage(),
    LogOutPage(),];

int defualtIndex = 2;


