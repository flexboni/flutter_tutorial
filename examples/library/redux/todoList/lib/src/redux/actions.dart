import 'package:flutter/material.dart';
import 'package:flutter_tutorial/src/model/models.dart';

abstract class TodoAction {
  String toString() {
    return '$runtimeType';
  }
}

class AddTodoAction extends TodoAction {
  static int _id = 0;
  final String text;

  AddTodoAction({@required this.text}) {
    _id++;
  }

  int get id => _id;
}

class SetVisibilityFilterAction extends TodoAction {
  final VisibilityFilter filter;

  SetVisibilityFilterAction({@required this.filter});
}

class ToggleTodoAction extends TodoAction {
  final int id;

  ToggleTodoAction({@required this.id});
}
