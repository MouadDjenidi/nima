import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:nima/Utils/custom_snack_bar.dart';
import 'package:nima/Widgets/custom_app_bar.dart';
import 'package:nima/Widgets/export_custom_widgets.dart';
import 'package:nima/modules/models/model_shop.dart';
import 'package:nima/modules/models/product_model.dart';
import 'package:http/http.dart' as http;

import 'add_product.dart';

class VendorPromoProducts extends StatefulWidget {
  VendorPromoProducts({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _VendorPromoProductsState createState() => _VendorPromoProductsState();
}

class _VendorPromoProductsState extends State<VendorPromoProducts> {
  List<Product> products;
  Future<List<shop>> futureShops;
  final bool fetchShopsRrror = false;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    futureShops = fetchShops();
  }

  Route _createProductPgae() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AddProoduct(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(
          // leading: Image.asset('assets/images/note.png',width: 10,),
          actionIcons: [
            IconButton(
              icon: Icon(
                Icons.add_box_sharp,
                color: Colors.blue[400],
                size: 35,
              ),
              onPressed: () {
               Navigator.of(context).push(_createProductPgae());
               },
            ),
            IconButton(
              icon: Icon(
                Icons.more_vert_sharp,
                color: Colors.blue[400],
                size: 35,
              ),
              onPressed: () {},
            ),
          ],
          title: CustomText(
            method: CustomTextAppBar(
              text: 'Mes promotions',
            ),
          ),
          appBar: AppBar(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              /*decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.green, spreadRadius: 3),
                ],
              ),*/

              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: IconButton(
                      icon: Icon(Icons.search_rounded),
                      color: Colors.black87,
                      onPressed: () => print('suffixIcon pressed'),
                    ),
                    //onTap: () => print("hmm"),
                  ),
                  Flexible(
                    child: TextField(
                      cursorColor: Colors.white,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      decoration: InputDecoration(
                        //border: InputBorder.none,
                        hintText: "Chercher un produit",
                        hintStyle:
                            TextStyle(color: Colors.black38, fontSize: 16.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: IconButton(
                        icon: Icon(Icons.tune),
                        color: Colors.black87,
                        onPressed: () => {
                              FocusScope.of(context).unfocus(),
                            }),
                  ),
                ],
              ),

              /* Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          print("am here");
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.blue[400],
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),*/
            ),
            Expanded(
              child: Center(
                child: FutureBuilder<List<shop>>(
                  future: futureShops,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //---------listview-----------
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return new Card(
                              child: ListTile(
                            leading: Icon(FrinoIcons.f_shop),
                            trailing: Icon(FrinoIcons.f_mark,
                                color: Colors.blue[400], size: 20),
                            title: Container(
                              color:Colors.black,
                              child:  Text(
                              snapshot.data[index].shopname,
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue[400]),
                            ),
                            ),
                            
                            
                           

                            subtitle: Column(children: <Widget>[
                              Row(children: <Widget>[
                                Text(
                                  'Téléphone : ' +
                                      snapshot.data[index].shopphone,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.0),
                                ),
                              ]),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Rang : ",
                                        style: TextStyle(fontSize: 13.0)),
                                    Padding(padding: EdgeInsets.all(16.0)),
                                    RatingBar.builder(
                                      itemSize: 15,
                                      initialRating: snapshot
                                          .data[index].shoprank
                                          .toDouble(),
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        FrinoIcons.f_star_outline,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ));
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
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

  Future<List<shop>> fetchShops() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult != ConnectivityResult.none) {
      try {
        final response =
            await http.get(Uri.https('ni3ma.free.beeceptor.com', 'shops'));

        if (response.statusCode == 200) {
          Iterable l = json.decode(response.body);
          List<shop> shops =
              List<shop>.from(l.map((model) => shop.fromJson(model)));
          shops.sort((b, a) => a.shoprank.compareTo(b.shoprank));
          return shops;
        }
      } catch (e) {
        snackBarWarning('Erreur lors de la récupération des données');
      }
    } else {
      snackBarWarning('Internet non disponible');
    }
  }

  void snackBarWarning(String message) {
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar().setSnackBar(
      Colors.blue[400],
      Icon(
        Icons.warning,
        color: Colors.white,
      ),
      Text(message),
    ));
  }
}
