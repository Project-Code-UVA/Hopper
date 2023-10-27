import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final initialLat = 38.0345;
  final initialLong = -78.4990;

  GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          FutureBuilder(
            future: rootBundle.loadString('assets/dark_map_style.json'),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(initialLat, initialLong),
                    zoom: 16.2,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                    controller.setMapStyle(snapshot.data!);
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          Align(
            alignment:
                Alignment(1.035, 1.0154), // Adjust these values for positioning
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FloatingActionButton(
                onPressed: () {
                  if (_controller != null) {
                    CameraPosition newPosition = CameraPosition(
                      target: LatLng(initialLat, initialLong),
                      zoom: 16.2,
                    );
                    _controller!.animateCamera(
                        CameraUpdate.newCameraPosition(newPosition));
                  }
                },
                backgroundColor: const Color.fromRGBO(
                    0, 0, 0, 1), // Change the background color here
                foregroundColor: const Color.fromRGBO(
                    229, 114, 0, 1), // Change the icon color here
                elevation:
                    4.0, // Adjust the elevation for a slightly bigger button
                child: Icon(Icons.location_searching),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
