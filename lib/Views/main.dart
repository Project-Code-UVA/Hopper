import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hopper/Models/listpage.dart';
import 'package:hopper/Models/mapscreen.dart';
import 'package:hopper/Models/profilepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MapScreen(),
        bottomNavigationBar: IconBar(),
      ),
    );
  }
}

// Navigation Bar
class IconBar extends StatefulWidget {
  const IconBar({super.key});

  @override
  State<IconBar> createState() => _IconBarState();
}

class _IconBarState extends State<IconBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: Colors.black,
            indicatorColor: Colors.white,
            labelTextStyle: MaterialStateProperty.all(const TextStyle(
                fontSize: 14, color: Color.fromRGBO(167, 167, 167, 1))),
          ),
          child: NavigationBar(
            height: 56,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
                if (currentPageIndex == 0) {
                  currentPageIndex = 0;
                }
              });
            },
            indicatorColor: Color.fromARGB(255, 22, 26, 31),
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            surfaceTintColor: Colors.black,
            selectedIndex: currentPageIndex,
            destinations: const <Widget>[
              NavigationDestination(
                  selectedIcon: Icon(Icons.location_on,
                      color: Color.fromARGB(255, 116, 171, 216), size: 30),
                  icon: Icon(Icons.location_on_outlined,
                      size: 30, color: Color.fromRGBO(167, 167, 167, 1)),
                  label: 'Map' // Set the text color to red
                  ),
              NavigationDestination(
                selectedIcon: Icon(Icons.list_alt,
                    color: Color.fromARGB(255, 116, 171, 216), size: 30),
                icon: Icon(Icons.list_alt_outlined,
                    size: 30, color: Color.fromRGBO(167, 167, 167, 1)),
                label: 'Bars',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 116, 171, 216),
                  size: 30,
                ),
                icon: Icon(Icons.person,
                    size: 30, color: Color.fromRGBO(167, 167, 167, 1)),
                label: 'Profile',
              ),
            ],
          )),
      body: <Widget>[
        const MapScreen(),
        const ListPage(),
        const ProfilePage()
      ][currentPageIndex],
    );
  }
}
