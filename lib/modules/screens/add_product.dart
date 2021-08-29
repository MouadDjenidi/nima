import 'package:flutter/material.dart';
import 'package:nima/Widgets/custom_app_bar.dart';
import 'package:nima/Widgets/export_custom_widgets.dart';

class AddProoduct extends StatefulWidget {
  AddProoduct({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddProoductState createState() => _AddProoductState();
}

class _AddProoductState extends State<AddProoduct> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue[400]),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: CustomText(
              method: CustomTextAppBar(
            text: 'Ajouter nouvelle promotion',
          )),
        ),
      ),

      /* body: SafeArea(
        child: Center(
          
        ),
       
      ),*/

      body: new SingleChildScrollView(
        child: new Container(
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: new Column(children: <Widget>[
            TextField(
  
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.home, color: Colors.grey,),
                hintText: 'pass word',
                labelText: 'pass',
                labelStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.blue[400],
                ),



                 isDense: true, 
                 contentPadding: EdgeInsets.all(10) ,




                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[350],
                            width: 1.0,
                          ),
                        ),
                focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black45,
                            width: 1.0,
                          ),
                        ),        
                fillColor: Colors.white,
                filled: true,
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              
              //maxLength: 10,
              //maxLines: 10,
            ),
            SizedBox(height: 10,),
            
          ]
          ),
        ),
        ),
      ),
    );
  }
}
