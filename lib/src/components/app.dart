import 'package:flutter/material.dart';
import 'package:flutter_tutorial/src/components/footer.dart';
import 'package:flutter_tutorial/src/containers/add_todo.dart';
import 'package:flutter_tutorial/src/containers/visible_todo_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Todos')),
      body: Container(
        child: Column(children: <Widget>[
          AddTodo(),
          VisibleTodoList(),
          Footer(),
        ],),
      ),
    );
  }
}
