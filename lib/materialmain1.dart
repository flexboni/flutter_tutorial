import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter material layout demo',
        home: Scaffold(
          appBar: AppBar(title: Text('Flutter material layout demo')),
          body: Center(
            child: Text('Hello world'),
          ),
        ));
  }
}
