import 'package:flutter/material.dart';
import '../shared/constants.dart';

ThemeData theming(ThemeMode mode) {
  return ThemeData(
    fontFamily: kFontFamily,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: false,
  );
}
