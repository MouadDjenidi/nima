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
      //------------------------------------------------------------------appbare-------------------------------------------------------------
      //---------------------------------------------------------------------body-----------------------------------------------------------
      body:  CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.grey[100],
            leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black45),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
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
          ),
        ],
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
