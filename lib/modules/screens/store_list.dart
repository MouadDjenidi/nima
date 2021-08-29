import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:nima/Widgets/custom_app_bar.dart';
import 'package:nima/Widgets/custom_text.dart';
import 'package:nima/modules/models/model_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreList extends StatefulWidget {
  @override
  _StoreList createState() => _StoreList();
}

class _StoreList extends State<StoreList> {
  Future<List<Store>> stores;

  @override
  void initState() {
    super.initState();
    stores = listOfStores();
  }

  /* @override
  void dispose() {
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      //------------------------------------------------------------------appbare--------------------------------------------------------------
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black45),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actionIcons: [
            IconButton(
              icon: Icon(
                Icons.add_box_rounded,
                color: Colors.blue[400],
                size: 25,
              ),
              onPressed: () {},
            ),
            SizedBox(
              width: 5,
            )
          ],
          title: CustomText(
            method: CustomTextAppBar(
              text: 'Votre magasins',
            ),
          ),
          appBar: AppBar(),
        ),
      ),
      //---------------------------------------------------------------------body-----------------------------------------------------------
      body: SafeArea(
        child: Column(
          children: <Widget>[
            /* SizedBox(
              height: 20,
            ),*/
            Expanded(
              child: Center(
                child: FutureBuilder<List<Store>>(
                  future: stores,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return new Card(
                              elevation: 3,
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(
                                      FrinoIcons.f_shop,
                                      color: snapshot.data[index].isdefault
                                          ? Colors.blue[400]
                                          : null,
                                    ),
                                    title: Container(
                                      // color: Colors.blue[400],
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 3,
                                          right: 3,
                                        ),
                                        child: Center(
                                          child: Text(
                                            snapshot.data[index].storeName,
                                            style: TextStyle(
                                                //fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            softWrap: false,
                                          ),
                                        ),
                                      ),

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.blue[300],
                                      ),
                                    ),
                                    subtitle: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.email,
                                                size: 14,
                                                color: Colors.blue[400],
                                              ),
                                              Text(
                                                "  " +
                                                    snapshot.data[index].email,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.0),
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                softWrap: false,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.phone,
                                                size: 14,
                                                color: Colors.blue[400],
                                              ),
                                              Text(
                                                "  " +
                                                    snapshot.data[index].phone,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                                              
                                
                                             Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Text("magasin actuellement utilisé"),
                                                  Switch(
                                                value: true,
                                                onChanged: (value) {
                                                  /* setState(() {
              isSwitched=value;
              print(isSwitched);
            });*/
                                                },
                                                activeTrackColor:
                                                    Colors.blue[100],
                                                activeColor: Colors.blue[300],
                                              ),
                                                ],
                                              ),
                                          
                                            
                                         
                                        
                                      
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                FrinoIcons.f_blog,
                                                color: Colors.blue[400],
                                                size: 20,
                                              ),
                                              onPressed: () {},
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                FrinoIcons.f_delete,
                                                color: Colors.blue[400],
                                                size: 20,
                                              ),
                                              onPressed: () {},
                                            ),
                                            /*FlatButton(
                                                onPressed: () => {},
                                                child: Text('Aceptar')),*/
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                    return CircularProgressIndicator(
                      strokeWidth: 2,
                      backgroundColor: Colors.white,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Store>> listOfStores() async {
    List<Store> stores;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.reload();
    if (sharedPreferences.getString("listofstores") != null) {
      Iterable list = json.decode(sharedPreferences.getString("listofstores"));
      stores = List<Store>.from(list.map((model) => Store.fromJson(model)));
    }
    return stores;
  }
}
