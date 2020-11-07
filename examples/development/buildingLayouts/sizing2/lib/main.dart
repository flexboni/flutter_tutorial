import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  debugPaintSizeEnabled = true; // Remove to suppress visual layout
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Sizing Images demo',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Sizing Images demo'),
          ),
          // Change to 'buildFoo()' for the other example
          body: Center(child: buildExpandedImagesWithFlex()),
        ));
  }

  Widget buildExpandedImagesWithFlex() =>
      // #docregion expanded-images
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset('images/pic1.jpg'),
          ),
          Expanded(
            flex: 2,
            child: Image.asset('images/pic2.jpg'),
          ),
          Expanded(
            child: Image.asset('images/pic3.jpg'),
          ),
        ],
      );
  // #enddocregion Row
}
