import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_tutorial/src/components/todo_list.dart';

import 'package:flutter_tutorial/src/model/models.dart';
import 'package:flutter_tutorial/src/redux/actions.dart';

class _ViewModel {
  final List<Todo> todos;
  final TodoTapFunction onTodoTap;

  _ViewModel({
    this.todos,
    this.onTodoTap,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          ListEquality<Todo>().equals(todos, other.todos);

  @override
  int get hashCode => todos.hashCode;
}

class VisibleTodoList extends StatelessWidget {
  List<Todo> _getVisibleTodos(List<Todo> todos, VisibilityFilter filter) {
    switch (filter) {
      case VisibilityFilter.SHOW_ALL:
        return todos;
      case VisibilityFilter.SHOW_COMPLETED:
        return todos.where((todo) => todo.completed).toList();
      case VisibilityFilter.SHOW_ACTIVE:
        return todos.where((todo) => !todo.completed).toList();
      default:
        return <Todo>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<TodoState, _ViewModel>(
      distinct: true,
      converter: (store) => _ViewModel(
        todos:
            _getVisibleTodos(store.state.todos, store.state.visibilityFilter),
        onTodoTap: (id) => store.dispatch(ToggleTodoAction(id: id)),
      ),
      builder: (context, viewModel) => TodoList(
        todos: viewModel.todos,
        onTodoTap: viewModel.onTodoTap,
      ),
    );
  }
}
