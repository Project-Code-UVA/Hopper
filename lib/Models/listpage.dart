import 'package:flutter/material.dart';

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
