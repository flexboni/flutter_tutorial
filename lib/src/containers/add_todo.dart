import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/src/model/models.dart';
import 'package:flutter_tutorial/src/redux/actions.dart';

class _ViewModel {
  final AddTodoPressedFunction onAddPressed;

  _ViewModel({@required this.onAddPressed});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<TodoState, _ViewModel>(
      distinct: true,
      converter: (store) => _ViewModel(
          onAddPressed: (todoText) =>
              store.dispatch(AddTodoAction(text: todoText))),
      builder: (context, viewModel) => TextField(
        controller: _controller,
        decoration: InputDecoration(labelText: 'Add todo'),
        onSubmitted: (todoText) {
          viewModel.onAddPressed(todoText);
          _controller.text = '';
        },
      ),
    );
  }
}
