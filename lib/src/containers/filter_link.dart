import 'dart:io';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/src/components/link.dart';
import 'package:flutter_tutorial/src/model/models.dart';
import 'package:flutter_tutorial/src/redux/actions.dart';

class _ViewModel {
  final bool active;
  final VoidCallback onPressed;

  _ViewModel({
    @required this.active,
    @required this.onPressed,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          active == other.active;

  @override
  int get hashCode => active.hashCode;
}

class FilterLink extends StatelessWidget {
  final VisibilityFilter filter;
  final String text;

  FilterLink({@required this.filter, @required this.text});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<TodoState, _ViewModel>(
        distinct: true,
        converter: (store) => _ViewModel(
            active: filter == store.state.visibilityFilter,
            onPressed: () =>
                store.dispatch(SetVisibilityFilterAction(filter: filter))),
        builder: (context, viewModel) => Link(
            active: viewModel.active,
            text: text,
            onPressed: viewModel.onPressed));
  }
}
