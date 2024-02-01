import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:reper/config/theme/theme.dart';

class AppTheme {
  final bool isDarkMode;

  AppTheme({
    this.isDarkMode = true,
  });

  ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,

      //THEME COLORS
      canvasColor: isDarkMode ? backgroundDark : backgroundLight,
      scaffoldBackgroundColor: isDarkMode ? backgroundDark : backgroundLight,
      disabledColor: disabled,
      dividerColor: muted,
      cardColor: isDarkMode ? cardDark : cardLight,

      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryDark,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        background: isDarkMode ? backgroundDark : backgroundLight,
        error: error,
      ),

      //FONTS
      textTheme: GoogleFonts.urbanistTextTheme(
        isDarkMode ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
      ),

      //WIDGET STYLES
      //APP BAR
      appBarTheme: AppBarTheme(
        color: isDarkMode ? backgroundDark : backgroundLight,
        titleTextStyle: GoogleFonts.urbanist(),
      ),

      //DIVIDER
      dividerTheme: const DividerThemeData(
        color: muted,
      ),

      //CARD
      cardTheme: CardTheme(
        elevation: 0,
        color: isDarkMode ? cardDark : cardLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  AppTheme copyWith({bool? isDarkMode}) {
    return AppTheme(isDarkMode: isDarkMode ?? this.isDarkMode);
  }
}
