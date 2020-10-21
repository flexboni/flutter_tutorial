import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) { // A widget’s main job is to provide a build() method that describes how to display the widget in terms of other, lower level widgets.
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold( // from the Material library
          appBar: AppBar(title: Text('Welcome to Flutter')), // provides a default app bar
          body: Center(child: Text('Hello World') // a body property that holds the widget tree for the home screen.
          )),
    );
  }
}
