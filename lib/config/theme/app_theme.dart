import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:reper/config/theme/theme.dart';

class AppTheme {
  final bool isDarkMode;

  AppTheme({
    this.isDarkMode = true,
  });

  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,

      //THEME COLORS
      canvasColor: canvasDark,
      scaffoldBackgroundColor: backgroundDark,
      disabledColor: disabled,
      dividerColor: muted,
      cardColor: cardDark,

      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryDark,
        brightness: Brightness.dark,
        background: backgroundDark,
        error: error,
      ),

      //FONTS
      textTheme: GoogleFonts.urbanistTextTheme(
        ThemeData.dark().textTheme,
      ),

      //WIDGET STYLES
      //APP BAR
      appBarTheme: AppBarTheme(
        shadowColor: primaryDark,
        color: backgroundDark,
        titleSpacing: 25,
        titleTextStyle: GoogleFonts.urbanist(
          color: backgroundLight,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),

      //DIVIDER
      dividerTheme: const DividerThemeData(
        color: muted,
      ),

      //CARD
      cardTheme: CardTheme(
        elevation: 0,
        color: cardDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      //THEME COLORS
      canvasColor: canvasLight,
      scaffoldBackgroundColor: backgroundLight,
      disabledColor: disabled,
      dividerColor: muted,
      cardColor: cardLight,

      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryDark,
        brightness: Brightness.light,
        background: backgroundLight,
        error: error,
      ),

      //FONTS
      textTheme: GoogleFonts.urbanistTextTheme(
        ThemeData.light().textTheme,
      ),

      //WIDGET STYLES
      //APP BAR
      appBarTheme: AppBarTheme(
        shadowColor: primaryDark,
        color: backgroundLight,
        titleSpacing: 25,
        titleTextStyle: GoogleFonts.urbanist(
          color: backgroundDark,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),

      //DIVIDER
      dividerTheme: const DividerThemeData(
        color: muted,
      ),

      //CARD
      cardTheme: CardTheme(
        elevation: 0,
        color: cardLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  ThemeData getTheme() => isDarkMode ? darkTheme : lightTheme;

  AppTheme copyWith({bool? isDarkMode}) {
    return AppTheme(isDarkMode: isDarkMode ?? this.isDarkMode);
  }
}
