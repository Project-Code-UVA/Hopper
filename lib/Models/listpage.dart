import 'package:flutter/material.dart';
import 'package:hopper/Models/profilepage.dart';
import 'package:hopper/Views/main.dart';

void main() {
  runApp(MaterialApp(
    home: ListPage(),
  ));
}

class ListPage extends StatelessWidget {
  const ListPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Center(
              child: Transform.scale(
                scale: 1.3, // Adjust the scale factor as needed
                child: Image.asset('assets/Default_Map.jpeg'),
              ),
            ),
          ),
          Opacity(
            opacity: 0.4,
            child: Container(
              color: Colors.black,
            ),
          ),
          _buildRoundedRectangles(),
        ],
      ),
      bottomNavigationBar: const AppBar(),
    );
  }

  Widget _buildRoundedRectangles() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      child: ListView(
        // Wrap the list with a ListView for scrolling
        children: <Widget>[
          BarListItem(
            title: 'Trininity',
          ),
          BarListItem(
            title: 'Coupes',
          ),
          BarListItem(
            title: 'Boylan',
          ),
          BarListItem(
            title: 'Virginian',
          ),
          BarListItem(
            title: 'Biltmore',
          ),
        ],
      ),
    );
  }
}

class BarListItem extends StatelessWidget {
  final String title;

  BarListItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            width: 400.0,
            height: 150.0,
            color: Colors.black,
            child: Center(
              child: ListTile(
                title: Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TransparentRoute extends PageRoute<void> {
  TransparentRoute({
    required this.builder,
    RouteSettings? settings,
  }) : super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final result = builder(context);
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: result,
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      // color: const Color.fromRGBO(35, 45, 75, 1),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            iconData: Icons.map_rounded,
            onTap: () {
              Navigator.push(
                context,
                TransparentRoute(
                    builder: (BuildContext context) => const Home()),
              );
            },
          ),
          IconButton(
            iconData: Icons.list_alt,
            isPageIcon: true,
            onTap: () {},
          ),
          IconButton(
            iconData: Icons.person,
            onTap: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ProfilePage(),
                  transitionDuration: Duration(
                      seconds: 0), // Set the duration to zero for no animation
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class IconButton extends StatelessWidget {
  final IconData iconData;
  final double iconSize; // Add a size parameter for the icon size
  final VoidCallback onTap;
  final bool isPageIcon; // Add a boolean flag to determine if it's a map icon

  IconButton({
    required this.iconData,
    this.iconSize = 40, // Default icon size
    required this.onTap,
    this.isPageIcon = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: isPageIcon
                ? const Color.fromRGBO(229, 114, 0, 1)
                : const Color.fromRGBO(64, 80, 123, 1),
            size: iconSize, // Set the size of the icon
          ),
        ],
      ),
    );
  }
}
