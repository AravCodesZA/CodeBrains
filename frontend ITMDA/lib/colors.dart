// lib/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color dark_navy = Color(0xFF1A1A2E); // background
  static const Color Yankees_Blue = Color(0xFF16213E); // Card background and background
  static const Color Cornflower_Blue = Color(0xFF667EEA); //button color 1
  static const Color Royal_Purple = Color(0xFF764BA2); //button color 2
  static const Color textPrimary = Colors.white; // White text
  static const Color textSecondary = Colors.white70; // Faded text
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

//Gradient for background
class AppGradients {
  static const LinearGradient mainBackground = LinearGradient(
    colors: [AppColors.dark_navy, AppColors.Yankees_Blue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
