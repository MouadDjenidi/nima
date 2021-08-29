
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:nima/Widgets/custom_map.dart';


class MyMapPage extends StatefulWidget {
  MyMapPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyMapPageState createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {
 
   final Color appBarColor = Colors.blue[400];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: NimaMap(), 
    );
  }
}

class NimaMap extends StatefulWidget {
  @override
  State createState() => NimaMapState();
}


class NimaMapState extends State<NimaMap> {

  GoogleMapController mapController;
  CameraPosition _initialLocation =  CameraPosition(target: LatLng(0.0, 0.0),zoom: 25.0,);
  Location location = new Location(); 
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition  ;

  List<Marker> allMarkers = [];

  @override
  void initState() {
    super.initState();
    _onMapCreated;
  }

   @override
   build(context) {
    return Scaffold(
      body : Stack(
      children: [
         CustomMap(),
      ],
    ),
    );
    
  }

   void _onMapCreated(GoogleMapController _cntlr) 
  {
    mapController = _cntlr;
    location.onLocationChanged.listen((l) { 
      _lastMapPosition = LatLng(l.latitude, l.longitude);
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 14.0,),
          ),
          
      );
      allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
        },
        position: _lastMapPosition));
    });
  }
  
  // Update the position on CameraMove
 _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

   _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
            title: 'This is a Title',
            snippet: 'This is a snippet',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blue,
      child: Icon(
        icon,
        size: 36.0,
      ),
    );
  }
}
