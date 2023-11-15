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
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    addCustomIcon();
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/bar_icon.png",
    ).then((icon) {
      setState(() {
        markerIcon = icon;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Stack(
          children: [
            buildGoogleMap(),
            buildSearchTextField(),
            buildLocationButton(),
          ],
        ),
      ),
    );
  }

  void showMenuBar(BuildContext context, String barName) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8.0),
        ),
      ),
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          color: const Color.fromRGBO(24, 24, 24, 1),
          height: 350,
          child: Column(
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2.5),
                ),
                margin: const EdgeInsets.only(top: 10),
              ),
              const SizedBox(height: 20),
              // Use Row and Align for the menu bar
              Row(
                children: [
                  // Align the menu bar to the left
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                  // Centered Text
                  Expanded(
                    child: Center(
                      child: Text(
                        barName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildGoogleMap() {
    return FutureBuilder(
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
              markers: buildMarkers(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Set<Marker> buildMarkers() {
    return {
      Marker(
        markerId: const MarkerId("Trinity"),
        position: const LatLng(38.034935, -78.5003),
        onDragEnd: (value) {},
        icon: markerIcon,
        onTap: () {
          showMenuBar(context, "Trinity");
        },
      ),
      Marker(
        markerId: const MarkerId("Boylan"),
        position: const LatLng(38.0341, -78.4994),
        onDragEnd: (value) {},
        icon: markerIcon,
        onTap: () {
          showMenuBar(context, "Boylan");
        },
      ),
      Marker(
        markerId: const MarkerId("Biltmore"),
        position: const LatLng(38.036305, -78.50051),
        icon: markerIcon,
        onTap: () {
          showMenuBar(context, "Biltmore");
        },
      ),
      Marker(
        markerId: const MarkerId("Coupes"),
        position: const LatLng(38.03596, -78.50038),
        icon: markerIcon,
        onTap: () {
          showMenuBar(context, "Coupes");
        },
      ),
      Marker(
        markerId: const MarkerId("Crozet"),
        position: const LatLng(38.036695, -78.50039),
        icon: markerIcon,
        onTap: () {
          showMenuBar(context, "Crozet");
        },
      ),
    };
  }

  Widget buildSearchTextField() {
    return Positioned(
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
            color: Colors.white,
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
                Color.fromRGBO(229, 114, 0, 1),
                BlendMode.srcIn,
              ),
              child: Icon(Icons.search),
            ),
          ),
          cursorColor: Colors.white,
        ),
      ),
    );
  }

  Widget buildLocationButton() {
    return Align(
      alignment: const Alignment(1.0388, 1.0172),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Transform.scale(
          scale: 1.1,
          child: FloatingActionButton(
            onPressed: () {
              if (_controller != null) {
                CameraPosition newPosition = CameraPosition(
                  target: LatLng(initialLat, initialLong),
                  zoom: 16.2,
                );
                _controller!
                    .animateCamera(CameraUpdate.newCameraPosition(newPosition));
              }
            },
            backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
            foregroundColor: const Color.fromRGBO(229, 114, 0, 1),
            elevation: 4.0,
            child: const Icon(Icons.location_searching),
          ),
        ),
      ),
    );
  }
}
