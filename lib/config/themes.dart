import "package:flutter/material.dart";

class AppThemes {
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: "Roboto",
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff4285F4),
    ),
  );

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    fontFamily: "Roboto",
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff4285F4),
      brightness: Brightness.dark,
    ),
  );
}
