import 'package:flutter/material.dart';

import 'palette.dart';
export 'palette.dart';

class AppTheme {
  AppTheme._();

  static const bodyFont = 'PlusJakartaSans';
  static const headingFont = 'Fraunces';

  static ThemeData get light {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: Palette.accent,
          brightness: Brightness.light,
        ).copyWith(
          primary: Palette.accentDarkest,
          onPrimary: Colors.white,
          secondary: Palette.accent,
          onSecondary: Palette.text,
          surface: Palette.bg,
          onSurface: Palette.text,
          surfaceContainer: Palette.bgDark,
        );
    return ThemeData(
      useMaterial3: true,
      fontFamily: bodyFont,
      colorScheme: scheme,
      scaffoldBackgroundColor: Palette.bg,

      appBarTheme: AppBarThemeData(backgroundColor: scheme.surface),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Palette.accent,
        foregroundColor: Palette.text,
        shape: CircleBorder(),
      ),

      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStateProperty.fromMap({
            WidgetState.any: Palette.accentDarkest,
          }),
          backgroundColor: WidgetStateProperty.fromMap({
            WidgetState.pressed: Palette.accent,
            WidgetState.disabled: Colors.grey,
            WidgetState.any: Palette.bgDark,
          }),
          shape: WidgetStateProperty.fromMap({WidgetState.any: CircleBorder()}),
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Palette.bgDark,
        indicatorColor: Palette.accent,
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),

      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: bodyFont,
          fontSize: 40,
          color: Palette.text,
          fontVariations: [FontVariation('wght', 700)],
        ),
      ),
    );
  }
}
