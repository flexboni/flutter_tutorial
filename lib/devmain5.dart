import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'CounterDisplay',
    home: Counter(),
  ));
}

class CounterDisplay extends StatelessWidget {
  CounterDisplay({this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text('Counter : $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  CounterIncrementor({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text('Increment'));
  }
}

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      ++_counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Count Display')),
      body: Center(
        child: Column(children: <Widget>[
          CounterDisplay(count: _counter),
          CounterIncrementor(onPressed: _increment),
        ]),
      ),
    );
  }
}
