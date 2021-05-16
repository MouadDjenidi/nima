import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:nima/modules/screens/home_page.dart';
import 'package:nima/modules/screens/map_page.dart';
import 'package:nima/modules/screens/test_map.dart';
import 'package:nima/modules/screens/vendor_promo_products.dart';


final bool isVendor   = true;
//----- application colors --------
final Color appBarColor     = Colors.blue[400];
final Color textAppBarColor = Colors.black;
final Color activeIconColor = Colors.blue[400];
final Color iconsColor      = Colors.blue[400];

 var currentTab = [
    MyHomePage(),
    TestMap() ,
    isVendor == true ? VendorPromoProducts() : MyMapPage(),
    MyMapPage(),
    MyMapPage(),
  ];

 final int defualtIndex = 2;


