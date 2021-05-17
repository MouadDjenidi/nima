
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';




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
  StreamSubscription stream ;
 
  BehaviorSubject<double> radius = BehaviorSubject(seedValue: 50.0);
 
  CameraPosition _initialLocation =  CameraPosition(target: LatLng(36.120128,6.359548),zoom : 8);
  Location location = new Location();
  LocationData _locationData;

 
  final Set<Marker> _markers = {};
 
   @override
   build(context) {
    return Scaffold(
      body: 
        GoogleMap(
          initialCameraPosition: _initialLocation,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true, // Add little blue dot for device location, requires permission from user
          mapType: MapType.normal,  
          markers: _markers,
         /* onCameraMove: (CameraPosition position) { 
            _currentLocation=position;
          }, */       
        ),
      
        floatingActionButton : FloatingActionButton(
                child: Icon(Icons.pin_drop_outlined),
              //  onPressed : () => _addGeoPoint(),
        ),
      
    );
    
  }

   void _onMapCreated(GoogleMapController _cntlr)
  {
    _startQuery();
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
   
  GeoFirePoint point = geo.point(latitude: 36.158944 , longitude: 5.684335);
  return firestore.collection('locations').add({ 
    'position': point.data,
    'name': 'el eulma' 
  });
  
}

 _startQuery() async{
    // Get users location
    // Make a referece to firestore
    var ref = firestore.collection('locations');
    _locationData = await location.getLocation();
    GeoFirePoint center = geo.point(latitude: 36.120128 , longitude: 6.359548);

    // subscribe to query
    stream = 
       radius.switchMap((rad) {
      return geo.collection(collectionRef: ref).within(
        center: center, 
        radius: rad, 
        field: 'position', 
        strictMode: true
      );
    }).listen(_updateMarkers);
      
  //  _updateMarkers(stream);  
   
  }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    
   // print(documentList.elementAt(0).data.toString());
    documentList.forEach((DocumentSnapshot document) {
        GeoPoint pos = document.data['position']['geopoint'];
        double distance = document.data['distance'];
        var marker = Marker(
          markerId: MarkerId(document.data['name']),
          position: LatLng(pos.latitude, pos.longitude),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title:'$distance kilometers from your location')
        );
     setState(() {
        _markers.add(marker);
     });
    });
}

}
