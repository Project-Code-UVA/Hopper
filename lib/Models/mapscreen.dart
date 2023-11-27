import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

final Stream<QuerySnapshot> barData = FirebaseFirestore.instance.collection('Bars').snapshots();

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final initialLat = 38.0345;
  final initialLong = -78.4990;
  LatLng? currentLocation;
  GoogleMapController? _controller;
  TextEditingController searchController = TextEditingController();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor userIcon = BitmapDescriptor.defaultMarker;
  bool locationServiceActive = true;
  Map<MarkerId, Marker> markers = {};
  LatLng? userLocation;

  @override
  void initState() {
    super.initState();
    addCustomIcon();
    getCurrentLocation();
    getMarkerData();
  }
  
  //creates the bar icon and the user icon
  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/bar_icon.png",
    ).then((icon) {
      setState(() {
        markerIcon = icon;
      });
    });
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: .1),
      "assets/user_icon.png",
    ).then((icon) {
      setState(() {
        userIcon = icon;
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
  //start of user location tracking
  Future<Position> getCurrentLocation() async {
    //requests the user's location access
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }
    
    //gets the user's location using Geolocator
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Update user's marker
    updateMarkers(position);

    // Move the camera to the new user location
    if (_controller != null) {
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 15.0),
        ),
      );
    }

    return position;
  }
  

  void showMenuBar(BuildContext context, String barName) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8.0),
        ),
      ),
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          color: Color.fromRGBO(24, 24, 24, 1),
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
                margin: EdgeInsets.only(top: 10),
              ),
              SizedBox(
                  height: 20), // Add some space between the rectangle and text
              Text(
                barName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //updates the markers everytime updateMarkers() is called from the user's 
  //location being updated
  void updateMarkers(Position userLocation) {
  markers[MarkerId("userLocation")] = Marker(
    markerId: MarkerId("userLocation"),
    position: LatLng(userLocation.latitude, userLocation.longitude),
    icon: userIcon,
  );
  setState(() {}); // Trigger a rebuild to update the markers
}

//Main Google Map Build
Widget buildGoogleMap() {
  return FutureBuilder(
    future: rootBundle.loadString('assets/dark_map_style.json'),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasData) {
          return GoogleMap(
            key: ValueKey('AIzaSyBfoDZ-MJWx231WVeEq_N4vqi2hYRUTguY'),
            initialCameraPosition: CameraPosition(
              target: userLocation ?? LatLng(initialLat, initialLong),
              zoom: 16.2,
            ),
            markers: Set<Marker>.of(markers.values),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
              controller.setMapStyle(snapshot.data!);
            },
            /*if you would like the camera to continually follow the user, 
            uncomment. Otherwise, it only initially places the camera on the 
            user and when you click the bottom right button it moves back to 
            the bars*/
            onCameraMove: (CameraPosition position) {
              // userLocation = LatLng(position.target.latitude, position.target.longitude);
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}

//start of marker creation from firebase --------------------------------
FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<UserCredential> signInAnonymously() async {
  return await FirebaseAuth.instance.signInAnonymously();
}

getMarkerData() {
  signInAnonymously().then((userCredential) {
    firestore.collection('Bars').get().then((QuerySnapshot querySnapshot) {
      print("User ID: ${userCredential.user?.uid}");
      print("Query Snapshot Length: ${querySnapshot.size}");
      
      querySnapshot.docs.forEach((doc) {
        print("Document ID: ${doc.id}");
        print("Document Data: ${doc.data()}");
        initMarker(doc.data(), doc.id);
      });
      
      // Also, fetch the user's location and update the marker
      getCurrentLocation().then((userLocation) {
        final markerId = MarkerId("userLocation");
        final marker = Marker(
          markerId: markerId,
          position: LatLng(userLocation.latitude, userLocation.longitude),
          icon: userIcon,
        );
        markers[markerId] = marker;
      });

    }).catchError((error) {
      print("Error fetching data from Firestore: $error");
    });
  });
}

void initMarker(specify, specifyId) {
  final location = specify['Location'];
  if (location != null && location.latitude != null && location.longitude != null) {
    final markerIdVal = specifyId;
    final markerId = MarkerId(markerIdVal);
    final marker = Marker(
      markerId: markerId,
      position: LatLng(location.latitude, location.longitude),
      infoWindow: InfoWindow(title: specify['name']),
      icon: markerIcon,
    );
    setState(() {
      markers[markerId] = marker;
    });

      // Print marker information for debugging
      print("Initialized Marker: $markerIdVal, Lat: ${location.latitude}, Lng: ${location.longitude}, Name: ${specify['name']}");
    } else {
      print("Invalid location data for marker: $specifyId");
    }
  }
  //end of marker creation --------------------------------------

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
      alignment: Alignment(1.0388, 1.0172),
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