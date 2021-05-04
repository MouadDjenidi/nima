
import 'package:flutter/material.dart';
import 'package:nima/Widgets/custom_app_bar.dart';
import 'package:nima/Widgets/export_custom_widgets.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Text("Accueil"),appBar: AppBar(),),
      body: SafeArea(child: Center(),),
      bottomNavigationBar: CustomBottomNavigationBar(),    
    );
  }
}
