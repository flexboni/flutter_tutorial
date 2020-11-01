import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter tutorial',
    home: MyButtonHome(),
  ));
}

class MyButtonHome extends StatelessWidget {
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
      body: MyButton(),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Center(
          child: Text('Engage'),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen[500],
        ),
        height: 36.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
      ),
      onTap: () {
        print('My Button is Tapped!!');
      }
    );
  }
}
