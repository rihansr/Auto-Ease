import 'package:flutter/material.dart';

import '../service/navigation_service.dart';

final dimen = _Dimen.value;

class _Dimen {
  static _Dimen get value => _Dimen._();
  _Dimen._();

  final Size size = MediaQuery.sizeOf(navigator.context);
  final double height = MediaQuery.sizeOf(navigator.context).height;
  final double width = MediaQuery.sizeOf(navigator.context).width;
  final EdgeInsets padding = MediaQuery.of(navigator.context).padding;

  final toolBarHeight = 88.0;
  final navBarHeight = 72.0;

  double bottom(double value, [bool merge = true]) =>
      padding.bottom == 0 ? value : padding.bottom + (merge ? value : 0);
}
