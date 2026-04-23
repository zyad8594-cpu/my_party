import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFFFFD700); // Royal Gold
  static const Color secondary = Color(0xFF8E44AD); // Deep Purple
  static const Color accent = Color(0xFFE74C3C); // Soft Red for urgency
  
  // Background colors
  static const Color background = Color(0xFF0F172A); // Deep Navy/Black
  static const Color surface = Color(0xFF1E293B); // Lighter Navy
  static const Color card = Color(0xFF334155); // Card background
  
  // Text colors
  static const Color textBody = Colors.white;
  static const Color textSubtitle = Color(0xFF94A3B8);
  
  // Gradients
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFFFD700), Color(0xFFF1C40F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [Colors.white10, Color(0x0DFFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
