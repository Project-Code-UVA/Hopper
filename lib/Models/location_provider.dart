import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier {
  LatLng currentLocation = LatLng(38.0345,
      -78.4990); // Default location, change this to your actual current location

  void updateLocation(LatLng newLocation) {
    currentLocation = newLocation;
    notifyListeners();
  }
}
