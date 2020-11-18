import 'package:flutter/material.dart';

void main() {
  runApp(SampleApp());
}

class SampleApp extends StatelessWidget {
  final title = 'Fade App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
          // 'primarySwatch' is material color.
          primarySwatch: Colors.blue),
      home: MyFadeTest(title: title),
    );
  }
}

class MyFadeTest extends StatefulWidget {
  MyFadeTest({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyFadeTest createState() => _MyFadeTest();
}

class _MyFadeTest extends State<MyFadeTest> with TickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      // vsync: this,
    );
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Container(
              child: FadeTransition(
                  opacity: curve,
                  child: FlutterLogo(
                    size: 100.0,
                  )))),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.forward();
          },
          tooltip: 'Fade',
          child: Icon(Icons.brush)),
    );
  }
}
