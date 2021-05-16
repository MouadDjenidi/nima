import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:nima/constants/app_constants.dart';

class CustomMap extends StatefulWidget {
  final String widgetMpppMode;
  const CustomMap({Key key, this.widgetMpppMode}) : super(key: key);

  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  //------ Widget vars ------------
  GoogleMapController controller;
  List<Marker> allMarkers = [];
  LatLng currentPosition;
  List<LatLng> positions;
  BitmapDescriptor mapMarker;
  Location location = new Location();
  String singlePin = 'assets/images/pin.png';
  String multiPin  = 'assets/images/iconfinder_map-marker_299087.png';


  @override
  void initState() {
    super.initState();
    myCurrentPosition();
    setCustomMerker();
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

  void onCameraMove(CameraPosition position) {
    currentPosition = position.target;
  }

  void myCurrentPosition() {
    Geolocator.getCurrentPosition().then((currloc) {
      currentPosition = LatLng(currloc.latitude, currloc.longitude);
      markes();
    }).onError((error, stackTrace) => null);
  }

  void setCustomMerker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), isVendor == true ? singlePin : multiPin );
  }

  void markes() {
    setState(() {
      allMarkers.add(Marker(
          markerId: MarkerId('currentPostion'),
          icon: mapMarker,
          draggable: true,
          onTap: () {
            print('Marker Tapped');
          },
          position: currentPosition));
    });
  }

  @override
  Widget build(BuildContext context) {
    return currentPosition == null
        ? Container(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.cyan,
                strokeWidth: 5,
              ),
            ),
          )
        : Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: _GoogleMap(),
              ),
              SafeArea(
                child: Container(
                  height: 45.0,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: TextField(
                    cursorColor: Colors.grey,
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.blue[400],
                        size: 20,
                      ),
                      //border: InputBorder.none,
                      hintText: "Chercher un produit",
                      hintStyle:
                          TextStyle(color: Colors.black38, fontSize: 16.0),

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black38,
                          width: 1.0,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue[400],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  GoogleMap _GoogleMap() {
    return GoogleMap(
      initialCameraPosition:
          CameraPosition(target: currentPosition, zoom: 16),
      markers: Set.from(allMarkers),
      onMapCreated: onMapCreated,
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
      onCameraMove: onCameraMove,
      trafficEnabled: true,
    );
  }
}
