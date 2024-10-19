import 'package:flutter/material.dart';

import '../service/navigation_service.dart';

final dimen = Dimen.value;

class Dimen {
  static Dimen get value => Dimen._();
  Dimen._();

  final Size size = MediaQuery.sizeOf(navigator.context);
  final double height = MediaQuery.sizeOf(navigator.context).height;
  final double width = MediaQuery.sizeOf(navigator.context).width;
  final EdgeInsets padding = MediaQuery.of(navigator.context).padding;

  double bottom(double value, [bool merge = true]) =>
      padding.bottom == 0 ? value : padding.bottom + (merge ? value : 0);
}
