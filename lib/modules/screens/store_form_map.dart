import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class StoreFormMap extends StatefulWidget {
  @override
  _StoreFormMap createState() => _StoreFormMap();
}

class _StoreFormMap extends State<StoreFormMap> {
  GoogleMapController controller;
  LatLng currentPosition;
  Location location = new Location();
  Future<LatLng> position;

  @override
  void initState() {
    super.initState();
    position = myCurrentPosition();
  }

  @override
  void dispose() {
    controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<LatLng>(
          future: position,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _GoogleMap();
            }
            return Container(
              color: Colors.white,
              child: Text(
                "chargement...",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            );
          }),
    );
  }

  // Container(color: Colors.white,),

  GoogleMap _GoogleMap() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: currentPosition, zoom: 30),
      // markers: Set.from(allMarkers),
      onMapCreated: onMapCreated,
      mapType: MapType.satellite,
      //myLocationButtonEnabled: false,
      //zoomGesturesEnabled: true,
      //zoomControlsEnabled: false,
      //onCameraMove: onCameraMove,
      //trafficEnabled: true,
    );
  }

  Future<LatLng> myCurrentPosition() async {
    Position res = await Geolocator.getCurrentPosition();
    currentPosition = LatLng(res.latitude, res.longitude);
    return currentPosition;
  }

  void onMapCreated(controller) {
    setState(() {
      controller = controller;
      location.onLocationChanged.listen((l) {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(l.latitude, l.longitude),
              zoom: 16,
            ),
          ),
        );
      });
    });
  }
}
