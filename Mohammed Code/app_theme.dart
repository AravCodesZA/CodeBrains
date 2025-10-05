import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  static const navyBg = Color(0xFF0B1222);
  static const cardTop = Color(0xFF141B30);
  static const cardBottom = Color(0xFF1B2442);
  static const violet = Color(0xFF8B7DEB);
  static const lightBlue = Color(0xFF58B4FF);
  static const subtext = Color(0xFFB0B3C4);
  static const navInactive = Color(0xFF9A9AAF);
  static const logoPurple = Color(0xFF7C5CFC);
  static const logoBlue = Color(0xFF6E8CFF);
}

ThemeData buildDarkTheme() {
  final cs = const ColorScheme.dark(
    surface: AppColors.navyBg,
    primary: AppColors.violet,
    secondary: AppColors.lightBlue,
    onSurface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: cs,
    scaffoldBackgroundColor: AppColors.navyBg,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.navyBg,
      foregroundColor: Colors.white,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      centerTitle: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.06),
      labelStyle: const TextStyle(color: AppColors.subtext, fontSize: 16),
      hintStyle: const TextStyle(color: AppColors.subtext, fontSize: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.white24),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: AppColors.lightBlue, width: 1.6),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: cs.secondary,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16),
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: cs.secondary,
        textStyle: const TextStyle(fontSize: 15),
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.subtext, fontSize: 15),
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      headlineSmall: TextStyle(color: AppColors.violet, fontSize: 28, fontWeight: FontWeight.bold),
    ),
  );
}
