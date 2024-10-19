import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../service/navigation_service.dart';

final string = _String.value;

class _String {
  static _String get value => _String._();
  _String._();

  AppLocalizations of([BuildContext? context]) =>
      AppLocalizations.of(context ?? navigator.context)!;
}
