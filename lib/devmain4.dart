import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Changing Widget',
    home: MyHome(),
  ));
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Changing Widget'),
      ),
      body: Counter(),
    );
  }
}

class Counter extends StatefulWidget {
  // This class is the configuration for the state.
  // It holds the values (in this case nothing) provided by the parent
  // and used by the build method of the State.
  // Fields in Widget subclass are always marked "final".
  @override
  _Counter createState() => _Counter();
}

class _Counter extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      // This call to 'setState' tells the Flutter framework
      // that something has changed in this 'State',
      // which causes it to rerun the build method below
      // so that the display can reflect the updated values.
      // If you change '_counter' without calling 'setState()',
      // then the build method won't be called again,
      // and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time 'setState' is called,
    // for instance, as done by the '_increment' method above.
    // The Flutter framework has been optimized to make reruning build methods fast,
    // so that you can just rebuild anything that needs updating
    // rather than having to individually change instances of wigets
    return Center(
        child: Column(
      children: <Widget>[
        Text('Count: $_counter'),
        ElevatedButton(onPressed: _increment, child: Text('Increment')),
      ],
    ));
  }
}
