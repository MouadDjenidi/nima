import 'package:flutter/material.dart';
import 'package:nima/Widgets/custom_map.dart';


class MyMapPage extends StatefulWidget {
  MyMapPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyMapPage createState() => _MyMapPage();
}

class _MyMapPage extends State<MyMapPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomMap(),   
    );
  }
}
