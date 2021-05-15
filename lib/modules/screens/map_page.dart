
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class MyMapPage extends StatelessWidget {
  MyMapPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      title: 'Google Map Place Picker Demo',
      themeMode: ThemeMode.light,
      home: NimaMap(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class NimaMap extends StatefulWidget {
  @override
  NimaMapState createState() => NimaMapState();
}


class NimaMapState extends State<NimaMap> {

  GoogleMapController mapController;
  Firestore firestore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();
  List<DocumentSnapshot> stream ;
  double radius = 50;
  CameraPosition _initialLocation =  CameraPosition(target: LatLng(41.40338, 2.17403),zoom : 15);
  CameraPosition _currentLocation =CameraPosition(target: LatLng(0, 0),zoom : 15);
 
  final Set<Marker> _markers = {};

   @override
   build(context) {
    return Scaffold(
      body: 
        GoogleMap(
          initialCameraPosition: _initialLocation,
         // onMapCreated: _onMapCreated,
          myLocationEnabled: true, // Add little blue dot for device location, requires permission from user
          mapType: MapType.normal,  
          markers: _markers,
          onCameraMove: (CameraPosition position) { 
            _currentLocation=position;
          },       
        ),
      
        floatingActionButton : FloatingActionButton(
                child: Icon(Icons.pin_drop_outlined),
                onPressed : () => _addGeoPoint(),
        ),
      
    );
    
  }

   void _onMapCreated(GoogleMapController _cntlr)
  {
    setState(() {
      mapController = _cntlr;
    });   
  }

  _addMarker(CameraPosition position) {
   setState(() {
     var marker = Marker(
        markerId: MarkerId(position.target.toString()),
        position: position.target,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: 'magic marker' )
      );
     _markers.add(marker);
   });
  }


  Future<DocumentReference> _addGeoPoint() {
   
  GeoFirePoint point = geo.point(latitude: 36.350527, longitude: 6.648496);
  return firestore.collection('locations').add({ 
    'position': point.data,
    'name': 'Yay I can be queried!' 
  });
  
}

 _startQuery() async {
    // Get users location

    // Make a referece to firestore
    var ref = firestore.collection('locations');
    GeoFirePoint center = geo.point(latitude: 36.350527, longitude: 6.648496);

    // subscribe to query
    stream = 
       geo.collection(collectionRef: ref).within(
        center: center, 
        radius: radius, 
        field: 'position', 
        strictMode: true
      ) as List<DocumentSnapshot>;
    _updateMarkers(stream);  
   
  }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    
   
    documentList.forEach((DocumentSnapshot document) {
        GeoPoint pos = document.data['position']['geopoint'];
        double distance = document.data['distance'];
        var marker = Marker(
          position: LatLng(pos.latitude, pos.longitude),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title:'$distance kilometers from query center'), markerId: null
        );


        _markers.add(marker);
    });
  }

}
