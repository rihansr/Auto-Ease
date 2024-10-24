import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/navigation_service.dart';
import '../shared/debug.dart';
import '../shared/enums.dart';
import '../shared/styles.dart';

T provider<T>([listen = false]) =>
    Provider.of<T>(navigator.context, listen: listen);

class BaseViewModel extends ChangeNotifier {
  final HashMap<String, bool> _loading = HashMap();
  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool status, {String? key, bool afterBinding = false}) {
    _busy = status;
    if (key != null) _loading[key] = status;
    afterBinding
        ? WidgetsBinding.instance
            .addPostFrameCallback((timeStamp) => notifyListeners())
        : notifyListeners();
    if (status == false && key != null && _loading.containsKey(key)) {
      _loading.remove(key);
    }
  }

  bool isLoading({String? key, bool? orElse}) =>
      (key != null && _loading.containsKey(key) ? _loading[key] : orElse) ??
      busy;

  Map<String, String> _errorLog = {};
  Map<String, String> get errorLog => _errorLog;
  get clearErrorLog => errorLog = {};
  set errorLog(Map<String, String> log) => this
    .._errorLog = log
    ..enabledAutoValidate = true
    ..notifyListeners();

  bool enabledAutoValidate = false;
  bool validate(GlobalKey<FormState> formKey,
      {autoValidate = true, orElse = true}) {
    bool validated =
        _errorLog.isNotEmpty || (formKey.currentState?.validate() ?? orElse);
    if (autoValidate) {
      this
        ..enabledAutoValidate = !validated
        ..notifyListeners();
    }
    return validated;
  }

  void showMessage(
    String? message, {
    String? tag,
    dynamic Function()? onAction,
    AlertType? type,
    bool logOnly = false,
  }) {
    if (message == null) return;

    debug.print(message, tag: tag, bounded: true);

    if (logOnly) {
      return;
    } else {
      ScaffoldMessenger.of(navigator.context).showSnackBar(
        style.snackbar(message, type: type, onAction: onAction),
      );
    }
  }

  void get notify => notifyListeners();

  @override
  void dispose() {
    _busy = false;
    _loading.clear();
    super.dispose();
  }
}
