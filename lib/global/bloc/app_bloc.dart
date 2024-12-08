import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban/global/theme/dark_theme.dart';
import 'package:kanban/global/theme/green_theme.dart';
import 'package:kanban/global/theme/light_theme.dart';
import 'package:kanban/global/theme/red_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(AppState(
          themeData: lightTheme,
          themeName: 'light',
          locale: const Locale('en', ''),
        )) {
    _loadPreferences();

    on<ThemeChanged>((event, emit) async {
      ThemeData newTheme;
      switch (event.themeName) {
        case 'dark':
          newTheme = darkTheme;
          break;
        case 'red':
          newTheme = redTheme;
          break;
        case 'green':
          newTheme = greenTheme;
          break;
        case 'light':
        default:
          newTheme = lightTheme;
          break;
      }
      emit(AppState(themeData: newTheme, locale: state.locale, themeName: event.themeName));
      await _saveTheme(event.themeName);
    });

    on<LanguageChanged>((event, emit) async {
      Locale newLocale = Locale(event.languageCode, '');
      emit(AppState(themeData: state.themeData, locale: newLocale, themeName: state.themeName));
      await _saveLanguage(event.languageCode);
    });
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString('theme') ?? 'light';
    final languageCode = prefs.getString('language') ?? 'en';
    add(ThemeChanged(themeName));
    add(LanguageChanged(languageCode));
  }

  Future<void> _saveTheme(String themeName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', themeName);
  }

  Future<void> _saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language', languageCode);
  }
}
