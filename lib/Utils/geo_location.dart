import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoLocation {
  Future<LatLng> currentPosition() async {
    LatLng currentPosition;
    await Geolocator.getCurrentPosition().then((currloc) {
      currentPosition = LatLng(currloc.latitude, currloc.longitude);
    }).onError((error, stackTrace) => null);
    return currentPosition;
  }

  Future<String> geoPointsAddress(LatLng position) async {
    String address = "";
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    address = "${first.countryName} - ${first.adminArea} - ${first.locality}";
    if (first.postalCode != null) {
      address = "$address-${first.postalCode}";
    }
    return address;
  }
}
