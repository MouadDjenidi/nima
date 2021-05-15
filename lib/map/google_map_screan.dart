import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' show cos, sqrt, asin;


class GoogleMapScrean extends StatefulWidget {
  @override
 _GoogleMapScreanState createState() => _GoogleMapScreanState();
  
}

class _GoogleMapScreanState extends State<GoogleMapScrean> {

 Marker marker1 = Marker(
    markerId: MarkerId('Marker1'),
    position: LatLng(36.357136, 6.6417208),
    infoWindow: InfoWindow(title: 'Business 1'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  );
  Marker marker2 = Marker(
    markerId: MarkerId('Marker2'),
    position: LatLng(31.2509423, 6.575004),
    infoWindow: InfoWindow(title: 'Business 2'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  );

   Marker marker3 = Marker (
    markerId: MarkerId("1") ,
    position:   LatLng(36.2627618,6.5814348),
    infoWindow: InfoWindow(title: 'Business 3'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
   );
  List<Marker> list = [];

  Set<Circle> circles = Set.from([Circle(
    circleId: CircleId("circle"),
    center: LatLng(36.357136, 6.6417208),
    radius: 4000,
)]);
  @override
  void initState() {
    list = [marker1, marker2,marker3];
    // _markers.addAll(list);
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container( child :
         GoogleMap(
          markers: Set<Marker>.of(list),
          initialCameraPosition:  CameraPosition(
            target: LatLng(36.2627618,6.5814348),
            zoom: 15),
            circles: circles
              )
    );
  }

double calculateDistance(lat1, lon1, lat2, lon2){
var p = 0.017453292519943295;
var c = cos;
var a = 0.5 - c((lat2 - lat1) * p)/2 +
c(lat1 * p) * c(lat2 * p) *
(1 - c((lon2 - lon1) * p))/2;
return 12742 * asin(sqrt(a));
} 

}