import 'package:flutter/material.dart';
import 'package:nima/modules/screens/home_page.dart';
import 'package:nima/modules/screens/map_page.dart';
import 'routes_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings){
 
  switch (settings.name) {
    case HomeViewRoute:
      return  MaterialPageRoute(builder: (context) => MyHomePage());
    case MapViewRoute:
      return  MaterialPageRoute(builder: (context) => MyMapPage());
    default:
     return  MaterialPageRoute(builder: (context) => MyHomePage());
  }

}