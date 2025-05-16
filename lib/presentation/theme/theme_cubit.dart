import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/shared_preferences_service.dart';
import '../common/app_constants.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(
    super.initialState, {
    required this.preferencesService,
  });

  final SharedPreferencesService preferencesService;

  Future<void> initialize () async {
    final result = await _getStoredThemeMode();
    emit(result);
  }

  Future<void> setTheme(ThemeMode theme) async {
    await _saveThemeMode(theme);
    emit(theme);
  }

  Future<void> _saveThemeMode(ThemeMode theme) async {
    await preferencesService.saveString(
      AppConstants.themeModeKey,
      theme.name,
    );
  }

  Future<ThemeMode> _getStoredThemeMode() async {
    final themeName = preferencesService.getString(AppConstants.themeModeKey);
    switch (themeName) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
