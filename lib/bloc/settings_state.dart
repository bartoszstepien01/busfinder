import 'package:flutter/material.dart';

class SettingsState {
  final ThemeMode themeMode;
  final Locale? locale;

  const SettingsState({this.themeMode = ThemeMode.system, this.locale});

  SettingsState copyWith({ThemeMode? themeMode, Locale? locale}) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale,
    );
  }

  Map<String, dynamic> toJson() {
    return {'themeMode': themeMode.index, 'locale': locale?.languageCode};
  }

  factory SettingsState.fromJson(Map<String, dynamic> json) {
    return SettingsState(
      themeMode: ThemeMode.values[json['themeMode'] as int? ?? 0],
      locale: json['locale'] != null ? Locale(json['locale'] as String) : null,
    );
  }
}
