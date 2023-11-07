import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  //creation of markers and initialization of marker image --------------------
  late BitmapDescriptor pinLocationIcon;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = {};

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
    setCustomMapPin();
    getMarkerData();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_map_marker.png');
  }

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
        icon: pinLocationIcon,
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

  //start of user location tracking
  Future<Position> getCurrentLocation() async {
    var permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error("Location permission denied");
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final markerId = MarkerId("currentLocation");
    final marker = Marker(
        markerId: markerId,
        position: LatLng(position!.latitude, position.longitude),
      );
    markers[markerId] = marker;
    return position;
  }

  late GoogleMapController googleMapController;

  @override
Widget build(BuildContext context) {
  return FutureBuilder<Position>(
    future: getCurrentLocation(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
        final position = snapshot.data;

        return GoogleMap(
          key: ValueKey('AIzaSyBfoDZ-MJWx231WVeEq_N4vqi2hYRUTguY'), // Add your API key as a string
          initialCameraPosition: CameraPosition(
            // target: LatLng(position!.latitude, position.longitude),
            target: LatLng(38.0345, -78.4990), // Adjust the initial map position
            zoom: 15.0,
          ),
          markers: Set<Marker>.of(markers.values),
          //FEATURE: uncomment when you want to center camera around user.
          // onMapCreated: (controller) {
          //   controller.animateCamera(
          //     CameraUpdate.newCameraPosition(
          //       CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 15.0),
          //     ),
          //   );
          // },
        );
      } else if (snapshot.connectionState == ConnectionState.waiting) {
        // Display a loading indicator while waiting for the initial location.
        return CircularProgressIndicator();
      } else {
        // Handle any errors or fallback to a default location if necessary.
        return Text('Error or default location');
      }
    },
  );
}
}