import 'package:flutter/material.dart';
import '../model/settings_model.dart';
import '../shared/enums.dart';
import '../shared/local_storage.dart';

final AppSettings appSettings = AppSettings.value;

class AppSettings {
  static AppSettings get value => AppSettings._();
  AppSettings._();

  ValueNotifier<Settings> settings = ValueNotifier(localStorage.settings);

  set _settings(Settings settings) {
    this.settings.value = settings;
    localStorage.settings = settings;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    this.settings.notifyListeners();
  }

  // Theme
  set theme(ThemeMode mode) =>
      _settings = settings.value.copyWith(themeMode: mode);

  ThemeMode get theme => settings.value.themeMode;

  // Locale
  set language(Language language) =>
      _settings = settings.value.copyWith(language: language);

  Language get language => settings.value.language;
}
