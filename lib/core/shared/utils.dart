import 'package:intl/intl.dart';

final utils = _Utils.value;

class _Utils {
  static _Utils get value => _Utils._();
  _Utils._();
}

extension StringExtension on String {
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';
  String get first => isEmpty ? '' : this[0];
}

extension DateTimeExtension on DateTime {
  String get Mdyyhhmma => DateFormat("M/d/yy hh:mm a").format(this);
}
