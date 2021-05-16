import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:nima/Utils/custom_connctivity.dart';
import 'package:nima/Widgets/custom_app_bar.dart';
import 'package:nima/Widgets/export_custom_widgets.dart';
import 'package:nima/modules/models/model_shop.dart';
import 'package:nima/modules/models/product_model.dart';
import 'package:http/http.dart' as http;


class VendorPromoProducts extends StatefulWidget {
  VendorPromoProducts({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _VendorPromoProductsState createState() => _VendorPromoProductsState();
}

class _VendorPromoProductsState extends State<VendorPromoProducts> {
 
  List<Product> products;
  Future<List<shop>> futureShops;
  @override
  void initState() {
    super.initState();
    CustomeConnectivity().isConnected(context);
    futureShops = fetchShops();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child:  CustomAppBar(
         // leading: Image.asset('assets/images/note.png',width: 10,),
          actionIcons: [
            IconButton(
                   icon : Icon(Icons.add_box_sharp, color: Colors.blue[400] ,size: 35,),
                    onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert_sharp, color: Colors.blue[400] ,size: 35,),
               onPressed: () {},
            ),
          ],
          title: CustomText(method: CustomTextAppBar(text: 'Mes promotions',),),
          appBar: AppBar(),
      ),
      ), 

      body: SafeArea(
        child : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Container(
              height: 40,
              color: Colors.white,
            ),
            Expanded(child: 
          Container(
            
            height: 200,
            child: FutureBuilder<List<shop>>(
            future: futureShops,  
            builder: (context, snapshot) {
              if (snapshot.hasData) {
              //---------listview-----------
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context,int index){
                    return new Card(
                      child:  ListTile(
                        leading: Icon(FrinoIcons.f_shop),
                        trailing: Icon(FrinoIcons.f_mark, color: Colors.blue[400],size: 20),
                        title: Text(
                          snapshot.data[index].shopname,
                          style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600,color: Colors.blue[400]),
                        ),
                        subtitle: Column(
                          children : <Widget>[
                            Row(
                             children: <Widget>[
                               Text(
                                 'Téléphone : '+snapshot.data[index].shopphone,
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0),
                               ), 
                             ]),
                             Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: <Widget>[
                                   Text("Rang : ", style: TextStyle(fontSize: 13.0)),  
                                   Padding(padding: EdgeInsets.all(16.0)),
                                   RatingBar.builder(
                                   itemSize: 15 ,
                                   initialRating: snapshot.data[index].shoprank.toDouble(),
                                   minRating: 1,
                                   direction: Axis.horizontal,
                                   allowHalfRating: true,
                                   itemCount: 5,                                   
                                   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
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
                          ]
                        ),
                        
                     )
                    );
                                         
                  },
                );
      
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
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
  final response = await http.get(Uri.https('ni3ma.free.beeceptor.com', 'shops'));
  // Use the compute function to run parsePhotos in a separate isolate.
  if (response.statusCode == 200) {
     Iterable l = json.decode(response.body);
      List<shop> shops = List<shop>.from(l.map((model)=> shop.fromJson(model)));
      shops.sort((b, a) => a.shoprank.compareTo(b.shoprank));
      return shops;
  }else{
      throw Exception('Failed to load shops');
  }  
}

}


