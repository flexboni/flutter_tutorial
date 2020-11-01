import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter tutorial',
    home: MyTutorialHome(),
  ));
}

class MyTutorialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 'Scaffold' is a layout for the major Material Component.
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation Menu',
          onPressed: null,
        ),
        title: Text('Example title'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          )
        ],
      ),
      // 'body' is the majority of the screen.
      body: Center(
        child: Text('Hello flutter'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
