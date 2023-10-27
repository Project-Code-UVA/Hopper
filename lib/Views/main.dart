import 'package:flutter/material.dart';
import 'package:hopper/Models/listpage.dart';
import 'package:hopper/Models/mapscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: MapScreen(),
        bottomNavigationBar: AppBar(),
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
  Duration get transitionDuration => Duration(milliseconds: 300);

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
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      // color: const Color.fromRGBO(35, 45, 75, 1),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            iconData: Icons.list_alt,
            onTap: () {
              Navigator.push(
                context,
                TransparentRoute(builder: (BuildContext context) => ListPage()),
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
  final double iconSize; // Add a size parameter for the icon size
  final VoidCallback onTap;

  IconButton({
    required this.iconData,
    this.iconSize = 35.0, // Default icon size
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: const Color.fromRGBO(229, 114, 0, 1),
            size: iconSize, // Set the size of the icon
          ),
        ],
      ),
    );
  }
}
