
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


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
  CameraPosition _initialLocation =  CameraPosition(target: LatLng(0.0, 0.0));
  Location location = new Location(); 
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition  ;

   @override
   build(context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _initialLocation,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true, // Add little blue dot for device location, requires permission from user
          mapType: MapType.normal, 
          myLocationButtonEnabled: false,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
          onCameraMove: _onCameraMove,
          markers: _markers,
        ),
      ],
    );
    
  }

   void _onMapCreated(GoogleMapController _cntlr)
  {
    mapController = _cntlr;
    location.onLocationChanged.listen((l) { 
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 14.0,),
          ),
      );
      _markers.add(
        Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: LatLng(l.latitude, l.longitude),
          infoWindow: InfoWindow(
            title: 'This is a Title',
            snippet: 'This is a snippet',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
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
}
