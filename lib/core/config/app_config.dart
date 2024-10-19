import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../shared/local_storage.dart';

enum _AppMode { debug, production }

final appConfig = _AppConfig.value;

class _AppConfig {
  static _AppConfig get value => _AppConfig._();
  _AppConfig._();

  final appMode = kDebugMode ? _AppMode.debug : _AppMode.production;
  late Map<String, dynamic> config;

  init() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    config = _configs[appMode.name] ?? {};

    await Future.wait([
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]),
      localStorage.init(),
    ]);
  }

  final _configs = {
    "debug": {
      "base": {
        "app_id": "com.example.autoease",
      }
    },
    "production": {
      "base": {
        "app_id": "com.example.autoease",
      }
    }
  };
}
