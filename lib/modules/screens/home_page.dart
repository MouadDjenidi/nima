
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
 
   final Color appBarColor = Colors.blue[400];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child:  CustomAppBar(
          leading: Icon(Icons.menu , color: Colors.blue[400]),
          actionIcons: [
            Icon(Icons.search, color: Colors.blue[400]),
          ] ,
          title: CustomText(method: CustomTextAppBar(text: 'Accueil',),),
          appBar: AppBar(),
      ),
      ),
     
      body: SafeArea(
        child: Center(
          
        ),
       
      ),


       
    );
  }
}
