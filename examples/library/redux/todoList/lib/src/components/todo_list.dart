import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/src/components/todo_tile.dart';
import 'package:flutter_tutorial/src/model/models.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final TodoTapFunction onTodoTap;

  TodoList({
    @required this.todos,
    @required this.onTodoTap,
  });

  List<Widget> _buildListItems() {
    return todos
        .map((todo) => TodoTile(
            key: Key(todo.id.toString()), onTap: onTodoTap, todo: todo))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildListItems(),
    );
  }
}
