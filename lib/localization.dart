import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class BuiltReduxLocalizations {
  static BuiltReduxLocalizations of(BuildContext context) {
    return Localizations.of<BuiltReduxLocalizations>(
        context, BuiltReduxLocalizations);
  }

  String get appTitle => 'Built Redux Example';
}
