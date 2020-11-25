library built_redux_sample;

import 'package:flutter/material.dart';

void main() {
  runApp(BuilReduxApp());
}

class BuilReduxApp extends StatelessWidget {
  final store = Store<AppState, AppStateBuilder, AppActions>(
    
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
