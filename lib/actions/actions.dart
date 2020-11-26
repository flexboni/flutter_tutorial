library actions;

import 'package:built_redux/built_redux.dart';
import 'package:built_redux_sample/models/todo.dart';

part 'actions.g.dart';

abstract class AppActions extends ReduxActions {
  ActionDispatcher<Null> fetchTodosAction;

  AppActions._();

  factory AppActions() => _$AppActions();
}
