import 'package:flutter/material.dart';
import 'package:hopper/Models/listpage.dart';
import 'package:hopper/Models/mapscreen.dart';
import 'package:hopper/Models/profilepage.dart';

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
        body: MapScreen(),
        bottomNavigationBar: const AppBar(),
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
            isPageIcon: true,
            onTap: () {},
          ),
          IconButton(
            iconData: Icons.list_alt,
            onTap: () {
              Navigator.push(
                context,
                TransparentRoute(
                    builder: (BuildContext context) => const ListPage()),
              );
            },
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
