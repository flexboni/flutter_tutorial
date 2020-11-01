import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'My App',
    home: MyScaffold(),
  ));
}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      // Column is a veritcal, linear layout,
      child: Column(children: <Widget>[
        MyAppBar(
            title: Text('Example title',
                style: Theme.of(context).primaryTextTheme.headline6)),
        Expanded(
            child: Center(
          child: Text('Hello world!'),
        ))
      ]),
    );
  }
}

class MyAppBar extends StatelessWidget {
  MyAppBar({this.title});

  // Fieldes in a Widget subclass are always marked 'final'
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 56.0, // in logical pixel
        // When you declare padding, use 'EdgeInsets'.
        padding: const EdgeInsets.symmetric(
            horizontal:
                8.0), // symmetric() is set 'horizonal' or 'vertical' padding value
        decoration: BoxDecoration(color: Colors.blue[500]),
        // Row is a horizonal, linear layout.
        child: Row(
          // '<Widget>' is the type of items in the list.
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.menu),
                tooltip: 'Navigation Menu',
                onPressed: null),
            // 'Expanded' expands its child to fill the available space.
            Expanded(
              child: title,
            ),
            IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search',
              onPressed: null,
            )
          ],
        ));
  }
}
