import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color mint = Color(0xFF2DD4BF);
  static const Color coral = Color(0xFFFF6B4A);
  static const Color ink = Color(0xFF0F1419);
}

ThemeData buildAppTheme() {
  final baseDark = ColorScheme.fromSeed(
    seedColor: AppColors.mint,
    brightness: Brightness.dark,
    primary: AppColors.mint,
    secondary: AppColors.coral,
    surface: const Color(0xFF1A222C),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: baseDark,
    scaffoldBackgroundColor: AppColors.ink,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      color: baseDark.surfaceContainerHighest.withValues(alpha: 0.65),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.ink.withValues(alpha: 0.92),
      indicatorColor: AppColors.mint.withValues(alpha: 0.22),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.mint,
          );
        }
        return TextStyle(
          fontSize: 12,
          color: Colors.white.withValues(alpha: 0.55),
        );
      }),
    ),
  );
}
