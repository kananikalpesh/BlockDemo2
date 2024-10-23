// theme_state.dart
import 'package:flutter/material.dart';
import 'package:movie_discovery_app/App/utils/app_colors.dart';

/// Abstract ThemeState
abstract class ThemeState {
  final ThemeData themeData;

  const ThemeState(this.themeData);
}

/// Light Theme State
class LightThemeState extends ThemeState {
  LightThemeState() : super(lightTheme);
}

/// Dark Theme State
class DarkThemeState extends ThemeState {
  DarkThemeState() : super(darkTheme);
}
