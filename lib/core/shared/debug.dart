import 'dart:developer';

import 'package:flutter/foundation.dart';

final debug = _Debug.value;

class _Debug {
  static _Debug get value => _Debug._();

  _Debug._();

  var enabled = !kReleaseMode;
  
  print(dynamic message, {bool bounded = true, String? tag}) =>
      {if (enabled) _log(message, bounded, tag)};

  _log(dynamic message, bool bounded, String? boundedText) {
    log(
      '${bounded || boundedText != null ? '\n========${boundedText ?? ''}========\n' : ''}'
      '$message'
      '${bounded || boundedText != null ? '\n========${boundedText ?? ''}========\n' : ''}',
    );
  }
}
