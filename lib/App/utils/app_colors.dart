import 'package:flutter/material.dart';

ColorScheme defaultLightColorScheme = const ColorScheme(
  brightness: Brightness.light,
  primary: Colors.green,
  onPrimary: Color(0xFFA3A3B2),
  primaryContainer: Color(0xFFD9E2FF),
  onPrimaryContainer: Color(0xFF424263),
  secondary: Colors.blue,
  onSecondary: Color(0xFFffffff),
  secondaryContainer: Color(0xFFdce2f9),
  onSecondaryContainer: Color(0xFF141b2c),
  tertiary: Colors.black54,
  onTertiary: Color(0xFF424242),
  tertiaryContainer: Color(0xFFE6BEB4),
  onTertiaryContainer: Color(0xFFEDE0D1),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFF9F4EF),
  onBackground: Color(0xFFFFFFFF),
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFFFFFFFF),
  surfaceVariant: Color(0xFFE1E2EC),
  onSurfaceVariant: Color(0xFF44464F),
  outline: Color(0xFF757780),
  onInverseSurface: Color(0xFFF4EEFF),
  inverseSurface: Color(0xFF302175),
  inversePrimary: Color(0xFFB0C6FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF365CA9),
  outlineVariant: Color(0xFFFFFFFF),
  scrim: Color(0xFF000000),
);

ColorScheme defaultDarkColorScheme = const ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.green,
  onPrimary: Color(0xFFA3A3B2),
  primaryContainer: Color(0xFFD9E2FF),
  onPrimaryContainer: Color(0xFFE6BEB4),
  secondary: Colors.blue,
  onSecondary: Color(0xFFEDE0D1),
  secondaryContainer: Color(0xFF404659),
  onSecondaryContainer: Color(0xFFdce2f9),
  tertiary: Color(0xFFdce2f9),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFE6BEB4),
  onTertiaryContainer: Color(0xFFEDE0D1),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFFF9F4EF),
  onBackground: Color(0xFFF9F4EF),
  surface: Color(0xFF1B1B1C),
  onSurface: Color(0xFFFFFFFF),
  surfaceVariant: Color(0xFF44464F),
  onSurfaceVariant: Color(0xFFC5C6D0),
  outline: Color(0xFF8F9099),
  onInverseSurface: Color(0xFF1B0261),
  inverseSurface: Color(0xFFE5DEFF),
  inversePrimary: Color(0xFF365CA9),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFB0C6FF),
  outlineVariant: Color.fromARGB(255, 79, 79, 79),
  scrim: Color(0xFFFFFFFF),
);

ColorScheme lightColorScheme = defaultLightColorScheme;
ColorScheme darkColorScheme = defaultDarkColorScheme;

ThemeData lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.onPrimary,
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.primary,
    foregroundColor: darkColorScheme.onPrimary,
  ),
);
