import 'package:built_redux/built_redux.dart';
import 'package:built_redux_sample/actions/actions.dart';
import 'package:built_redux_sample/data/todos_repository.dart';
import 'package:built_redux_sample/models/models.dart';

Middleware<AppState, AppStateBuilder, AppActions> createStoreTodosMiddlware([
  TodosRepository rerepository = const TodosRepository(),
]) {
  return (MiddlewareBuilder<AppState, AppStateBuilder, AppActions>().build());
}
