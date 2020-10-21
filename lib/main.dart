import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// Stateless widgets are immutable, meaning that their properties can’t change—all values are final.
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // A widget’s main job is to provide a build() method that describes how to display the widget in terms of other, lower level widgets.
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();

    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
          // from the Material library
          appBar: AppBar(
              title: Text('Welcome to Flutter')), // provides a default app bar
          body: Center(
              child:
                  //// a body property that holds the widget tree for the home screen.
                  // Text(wordPair.asPascalCase)
                  RandomWords())),
    );
  }
}

// start typing stful. The editor asks if you want to create a Stateful widget.
//Press Return to accept. The boilerplate code for two classes appears, and the cursor is positioned for you to enter the name of your stateful widget.
class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }
}
