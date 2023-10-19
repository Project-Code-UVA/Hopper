import 'package:flutter/material.dart';
import 'package:hopper/Views/main.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Page'),
        backgroundColor: Color.fromRGBO(35, 45, 75, 1),
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
              iconData: Icons.home,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              })
          // Do something
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
