import 'package:flutter/material.dart';

void main() {
  runApp(SampleApp());
}

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
          // 'primarySwatch' is material color.
          primarySwatch: Colors.blue),
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  _SampleAppPage createState() => _SampleAppPage();
}

class _SampleAppPage extends State<SampleAppPage> {
  bool toggle = true;
  void _toggle() {
    setState(() {
      toggle = !toggle;
    });
  }

  _getToggleChild() {
    if (toggle)
      return Text('Toggle One');
    else
      return ElevatedButton(onPressed: () {}, child: Text('Toggle Two'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
      ),
      body: Center(child: _getToggleChild()),
      floatingActionButton: FloatingActionButton(
          onPressed: _toggle,
          tooltip: 'Update Text',
          child: Icon(Icons.update)),
    );
  }
}
