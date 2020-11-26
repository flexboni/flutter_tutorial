library built_redux_sample;

import 'package:built_redux/built_redux.dart';
import 'package:built_redux_sample/actions/actions.dart';
import 'package:built_redux_sample/localization.dart';
import 'package:built_redux_sample/middleware/store_todos_middleware.dart';
import 'package:built_redux_sample/models/app_state.dart';
import 'package:built_redux_sample/reducers/reducers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';
import 'package:todos_app_core/todos_app_core.dart';

void main() {
  runApp(BuiltReduxApp());
}

class BuiltReduxApp extends StatefulWidget {
  final store = Store<AppState, AppStateBuilder, AppActions>(
      reducerBuilder.build(), AppState.loading(), AppActions(),
      middleware: [
        createStoreTodosMiddlware(),
      ]);

  @override
  State<StatefulWidget> createState() {
    return BuiltReduxAppState();
  }
}

class BuiltReduxAppState extends State<BuiltReduxApp> {
  Store<AppState, AppStateBuilder, AppActions> store;

  @override
  void initState() {
    store = widget.store;
    store.actions.fetchTodosAction();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReduxProvider(
        store: store,
        child: MaterialApp(
          onGenerateTitle: (context) =>
              BuiltReduxLocalizations.of(context).appTitle,
              theme: ArchSampleTheme.theme,
              localizationsDelegates: [
                ArchSampleLocalizationsDelegate(),
                BuiltReduxLocalizationsDelegate(),
              ],
        ));
  }
}
