import '../Models/listpage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Services/firebase_options.dart';

// void main() {
//   runApp(const MyApp());
// }

//note about importing 'firebase_options.dart' and using it within the main method
//had to first run npm install -g firebase-tools
//then ran firebase login to login to the firebase
//after i ran flutterfire configure and chose "Hopper" and then "android"
//good resource: https://stackoverflow.com/questions/72895721/firebasecloudmessaging-platformexception-platformexceptionnull-error-host-p 

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 35, 45, 75),
          title: Text('Hopper'), // Name of the app)
        ),
        body: MapScreen(), // Your map screen widget
        bottomNavigationBar: MyBottomAppBar(),
      ),
    );
  }
} // Custom bottom app bar

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GoogleMap(
        key: ValueKey(
            'AIzaSyBfoDZ-MJWx231WVeEq_N4vqi2hYRUTguY'), // Add your API key as a string
        initialCameraPosition: CameraPosition(
          target: LatLng(38.0345, -78.4990), // Set the initial map coordinates
          zoom: 16.2, // Set the initial zoom level
        ),
        onMapCreated: (GoogleMapController controller) {
          // You can customize the map using the controller here
        },
      ),
    );
  }
}

class MyBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color:
          Color.fromRGBO(35, 45, 75, 1), // Set the background color of the bar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            iconData: Icons.list_alt,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class IconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;

  IconButton({
    required this.iconData,
    required this.onTap,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, color: Color.fromRGBO(229, 114, 0, 1)),
        ],
      ),
    );
  }
}