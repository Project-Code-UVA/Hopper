import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hopper/Models/listpage.dart';
import 'package:hopper/Models/mapscreen.dart';
import 'package:hopper/Models/profilepage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: MapScreen(),
            ),
            AppBar(),
          ],
        ),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.blue,
          tabBackgroundColor: Colors.grey.shade800,
          gap: 2,
          padding: const EdgeInsets.all(16),
          tabs: const [
            GButton(icon: Icons.location_on, text: 'Map'),
            GButton(icon: Icons.list_alt, text: 'List'),
            GButton(icon: Icons.person, text: 'Profile')
          ],
        ),
      ),
    );
  }
}
