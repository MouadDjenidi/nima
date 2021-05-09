import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:nima/modules/screens/home_page.dart';
import 'package:nima/modules/screens/map_page.dart';


//----- application colors --------
final Color appBarColor     = Colors.blue[400];
final Color textAppBarColor = Colors.blue[400];
final Color activeIconColor = Colors.blue[400];

 var currentTab = [
    MyHomePage(),
    MyMapPage(),
    MyMapPage(),
    MyMapPage(),
    MyMapPage(),
  ];

 final int defualtIndex = 2;


