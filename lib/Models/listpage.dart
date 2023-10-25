import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Page'),
        backgroundColor: const Color.fromRGBO(35, 45, 75, 1),
      ),
      body: Container(
          child: Center(
        child: Text('This is the List Page content'),
      )),
      bottomNavigationBar: const MyBottomAppBar(),
    );
  }
}

class TransparentRoute extends PageRouteBuilder {
  final Widget page;

  TransparentRoute({required this.page})
      : super(
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            const begin = Offset(0, 1);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: Opacity(
                opacity: animation.value,
                child: child,
              ),
            );
          },
        );
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
              // Use Navigator to pop the current screen and go back to the previous one
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
