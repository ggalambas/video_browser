import 'package:flutter/material.dart';
import 'package:video_browser/config/constants.dart';

const ColorScheme _colorScheme = ColorScheme.dark(
  primary: Color(0xFFFFAE6C),
  onPrimary: Colors.white,
  background: Color(0xFF00111C),
);

ThemeData get theme => ThemeData(
      brightness: Brightness.dark,
      colorScheme: _colorScheme,
      primaryColor: _colorScheme.primary,
      scaffoldBackgroundColor: Colors.transparent,
      canvasColor: Colors.transparent,
      appBarTheme: _appBarTheme,
      dividerTheme: _dividerTheme,
      inputDecorationTheme: _inputDecorationTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
    );

AppBarTheme get _appBarTheme => const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );

DividerThemeData get _dividerTheme => const DividerThemeData(
      thickness: kDividerThickness,
      color: Colors.white24,
    );

InputDecorationTheme get _inputDecorationTheme => const InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.white54),
      iconColor: Colors.white54,
      border: OutlineInputBorder(borderSide: BorderSide.none),
      contentPadding: EdgeInsets.symmetric(horizontal: kInputPadding),
    );

ElevatedButtonThemeData get _elevatedButtonTheme => ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(kBottomNavigationBarHeight),
        shape: const RoundedRectangleBorder(),
      ),
    );
