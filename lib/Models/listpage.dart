import 'package:flutter/material.dart';

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
                scale: 1.1, // Adjust the scale factor as needed
                child: Image.asset('assets/Default_Map.jpeg'),
              ),
            ),
          ),
          Opacity(
            opacity: 0.7,
            child: Container(
              color: Colors.black,
            ),
          ),
          _buildRoundedRectangles(),
        ],
      ),
      bottomNavigationBar: const MyBottomAppBar(),
    );
  }

  Widget _buildRoundedRectangles() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      child: ListView(
        // Wrap the list with a ListView for scrolling
        children: <Widget>[
          CustomRoundedRectangle(
            title: 'Trin',
          ),
          CustomRoundedRectangle(
            title: 'Coupes',
          ),
          // Add more instances of CustomRoundedRectangle with different content
        ],
      ),
    );
  }
}

class CustomRoundedRectangle extends StatelessWidget {
  final String title;

  CustomRoundedRectangle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.6,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                    style: TextStyle(
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

class MyBottomAppBar extends StatelessWidget {
  const MyBottomAppBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromRGBO(35, 45, 75, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            iconData: Icons.home,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          // Add more buttons or widgets as needed
        ],
      ),
    );
  }
}

class IconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;

  IconButton({
    Key? key,
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
          Icon(iconData, color: const Color.fromRGBO(229, 114, 0, 1)),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ListPage(),
  ));
}
