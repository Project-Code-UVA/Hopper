import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late BitmapDescriptor pinLocationIcon;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = {};

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        key: ValueKey('AIzaSyBfoDZ-MJWx231WVeEq_N4vqi2hYRUTguY'), // Add your API key as a string
        initialCameraPosition: CameraPosition(
          target: LatLng(38.0345, -78.4990), // Adjust the initial map position
          zoom: 15.0,
        ),
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }
}