import 'dart:convert';
import 'package:flutter/material.dart';
import '../shared/enums.dart';

class Settings {
  final ThemeMode themeMode;
  final Language language;

  const Settings({
    this.themeMode = ThemeMode.system,
    this.language = Language.english,
  });

  Settings copyWith({
    ThemeMode? themeMode,
    Language? language,
  }) {
    return Settings(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
    );
  }

  factory Settings.fromMap(Map<String, dynamic> map) => Settings(
        themeMode: ThemeMode.values.byName(map["theme_mode"]),
        language: Language.values.byName(map["language"]),
      );

  Map<String, dynamic> toMap() => {
        "theme_mode": themeMode.name,
        "language": language.name,
      };

  String toJson() => jsonEncode(toMap());

  factory Settings.fromJson(String source) =>
      Settings.fromMap(jsonDecode(source));
}