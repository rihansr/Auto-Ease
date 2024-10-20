final utils = _Utils.value;

class _Utils {
  static _Utils get value => _Utils._();
  _Utils._();
}

extension StringExtension on String {
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';
  String get first => isEmpty ? '' : this[0];
}