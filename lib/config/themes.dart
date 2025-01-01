import "package:flutter/material.dart";

class AppThemes {
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: "Roboto",
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff4285F4),
      surface: const Color(0xFFFFFFFF),
      scrim: Colors.black,
      surfaceContainer: const Color(0xFFF0F3F8),
      surfaceContainerLow: const Color(0xFFCACCCB),
      surfaceContainerHigh: const Color(0xFFF9FAFE),
      primaryContainer: const Color(0xFFC3E7FF),
      onPrimaryContainer: const Color(0xFF011D35),
      secondaryContainer: const Color(0xFF0B57CF),
      onSecondaryContainer: const Color(0xFFFFFFFF),
    ),
  );

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    fontFamily: "Roboto",
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff4285F4),
      surface: const Color(0xff131313),
      scrim: Colors.white,
      surfaceContainer: const Color(0xff1E1F21),
      primaryContainer: const Color(0xff004A77),
      onPrimaryContainer: const Color(0xffC3E7FF),
      secondaryContainer: const Color(0xffA8C8FB),
      onSecondaryContainer: const Color(0xff062D6E),
      brightness: Brightness.dark,
    ),
  );
}
