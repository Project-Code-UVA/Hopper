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
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          FutureBuilder(
            future: rootBundle.loadString('assets/dark_map_style.json'),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
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
                } else if (snapshot.hasError) {
                  // Handle the error case, e.g., show an error message.
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              } else {
                // You might want to show a loading indicator here as well.
                return CircularProgressIndicator();
              }
            },
          ),
          GestureDetector(
            onTap: () {
              // When you tap somewhere other than the search bar, unfocus the text field.
              FocusScope.of(context).unfocus();
            },
            child: Container(
              // Use a transparent container to cover the entire screen except the search bar
              color: Colors.transparent,
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextField(
                controller: searchController,
                style: const TextStyle(
                  color: Colors.white, // Set the text color to white
                ),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                  prefixIcon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Color.fromRGBO(229, 114, 0, 1), // Set the icon color here
                      BlendMode.srcIn,
                    ),
                    child: Icon(Icons.search),
                  ),
                ),
                cursorColor: Colors.white, // Set the cursor color to white
              ),
            ),
          ),
          Align(
            alignment: Alignment(1.0388, 1.0172),
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
                backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
                foregroundColor: const Color.fromRGBO(229, 114, 0, 1),
                elevation: 4.0,
                child: const Icon(Icons.location_searching),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
