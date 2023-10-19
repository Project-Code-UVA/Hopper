import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final double initialLatitude;
  final double initialLongitude;

  MapScreen({
    required this.initialLatitude,
    required this.initialLongitude,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLatitude, widget.initialLongitude),
          zoom: 15.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId('marker_id'),
            position: LatLng(widget.initialLatitude, widget.initialLongitude),
            infoWindow: InfoWindow(title: 'Marker Title'),
          ),
        },
      ),
    );
  }
}
