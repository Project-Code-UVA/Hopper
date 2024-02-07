import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: ListPage(),
  ));
}

final List<String> bars = ['Biltmore', 'Boylan', 'Coupes', 'Crozet', 'Trinity'];

class ListPage extends StatelessWidget {
  const ListPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 37, 37, 37),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(150),
            child: AppBar(
              title: Text('Bars'),
              backgroundColor: const Color.fromARGB(255, 37, 37, 37),
            )),
        body: ListView.separated(
            itemCount: bars.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(bars[index]),
                subtitle: Text('Subtitle $index'),
                textColor: Colors.blue,
                trailing: Checkbox(
                  value: false,
                  onChanged: (bool? value) {},
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            }));
  }
}
