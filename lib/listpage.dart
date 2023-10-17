import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Page'),
      ),
      body: Center(
        child: Text('This is the List Page content'),
      ),
      bottomNavigationBar: MyBottomAppBar(),
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
            iconData: Icons.map_rounded,
            onTap: () {
              // Handle the map view button press
            },
          ),
          IconButton(
            iconData: Icons.home,
            onTap: () {
              // Handle the home button press
            },
          ),
          IconButton(
            iconData: Icons.list_alt,
            onTap: () {
              // Do Nothing
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
