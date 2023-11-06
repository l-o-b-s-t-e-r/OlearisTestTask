import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  TextTheme get styles => Theme.of(this).textTheme;

  ColorScheme get colors => Theme.of(this).colorScheme;

  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  double get screenWidth => MediaQuery.of(this).size.width;
}

extension StringExt on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
