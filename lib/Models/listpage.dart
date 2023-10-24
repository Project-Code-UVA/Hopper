import 'package:flutter/material.dart';
import 'package:hopper/Views/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Services/firebase_options.dart';


class ListPage extends StatelessWidget {

  //useful resource that explains how this reads in data: https://firebase.flutter.dev/docs/firestore/usage/
  final Stream<QuerySnapshot> streamFruitItems = FirebaseFirestore.instance.collection('Bars').snapshots();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Page'),
        backgroundColor: Color.fromRGBO(35, 45, 75, 1),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: streamFruitItems,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          //if error, return error
          if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()));
          }
          //if connected, fetch data
          if(snapshot.connectionState==ConnectionState.active){
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> listQueryDocumentSnapshot = querySnapshot.docs;

            return ListView.builder(
              itemCount: listQueryDocumentSnapshot.length,
              itemBuilder: (content, index){
                QueryDocumentSnapshot document = listQueryDocumentSnapshot[index];
                return Text(document['Name']);
              }
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
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
