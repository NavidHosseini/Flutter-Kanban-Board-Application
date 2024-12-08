import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppState extends Equatable {
  final ThemeData themeData;
  final Locale locale;
  final String themeName;

  const AppState({
    required this.themeData,
    required this.locale,
    required this.themeName,
  });

  @override
  List<Object> get props => [themeData, locale, themeName];
}
