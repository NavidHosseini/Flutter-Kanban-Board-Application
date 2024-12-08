import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class ThemeChanged extends AppEvent {
  final String themeName;

  const ThemeChanged(this.themeName);

  @override
  List<Object> get props => [themeName];
}

class LanguageChanged extends AppEvent {
  final String languageCode;

  const LanguageChanged(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}
