// lib/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color dark_navy = Color(0xFF1A1A2E); // background
  static const Color Yankees_Blue = Color(0xFF16213E); // Card background and background
  static const Color Cornflower_Blue = Color(0xFF667EEA); //button color 1
  static const Color Royal_Purple = Color(0xFF764BA2); //button color 2
  static const Color textPrimary = Colors.white; // White text
  static const Color textSecondary = Colors.white70; // Faded text
}

//Gradient for background
class AppGradients {
  static const LinearGradient mainBackground = LinearGradient(
    colors: [AppColors.dark_navy, AppColors.Yankees_Blue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
