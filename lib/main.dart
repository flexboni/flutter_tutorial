import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_tutorial/src/components/app.dart';
import 'package:flutter_tutorial/src/model/models.dart';
import 'package:flutter_tutorial/src/redux/reducers.dart';
import 'package:redux/redux.dart';

void main() {
  runApp(new TodoApp());
}

class TodoApp extends StatelessWidget {
  final Store store =
      Store<TodoState>(todoAppReducer, initialState: TodoState.initialState());

  @override
  Widget build(BuildContext context) {
    return StoreProvider<TodoState>(
      store: store,
      child: MaterialApp(
        title: 'todo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: App(),
      ),
    );
  }
}
