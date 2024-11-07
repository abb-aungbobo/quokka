import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    appBarTheme: _appBarTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.tealAccent,
      primary: Colors.teal,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    appBarTheme: _appBarTheme,
    colorScheme: ColorScheme.dark(
      primary: Colors.teal,
    ),
  );

  static const _appBarTheme = AppBarTheme(
    centerTitle: true,
  );
}
