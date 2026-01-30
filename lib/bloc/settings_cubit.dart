import 'package:busfinder/bloc/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void updateTheme(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }

  void updateLocale(Locale? locale) {
    emit(SettingsState(themeMode: state.themeMode, locale: locale));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return state.toJson();
  }
}
