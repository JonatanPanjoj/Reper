import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:reper/config/theme/theme.dart';


final isDarkModeProvider = StateProvider<bool>((ref) => true);

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier(),
);

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme());

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }
}

//GRADIENT

final gradientNotifierProvider = StateNotifierProvider <GradientNotifier,LinearGradient> ((ref) {
  return GradientNotifier();
});

class GradientNotifier extends StateNotifier<LinearGradient>{
  GradientNotifier(): super (gradients.first);

  void changeGradient(LinearGradient gradient){
    state = gradient;
  }
  
}