import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const initialLat = 38.0345;
    const intialLong = -78.4990;
    return Center(
      child: RepaintBoundary(
        child: FutureBuilder(
          future: rootBundle.loadString('assets/dark_map_style.json'),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(initialLat, intialLong),
                  zoom: 16.2,
                ),
                onMapCreated: (GoogleMapController controller) {
                  controller.setMapStyle(snapshot.data!);
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
