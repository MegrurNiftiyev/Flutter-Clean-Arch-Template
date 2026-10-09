import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Colors.green;
  static const Color secondary = Colors.amber;
  static const Color background = Color(0xFFF8F9FA);
  static const Color darkBackground = Color(0xFF121212);
  static const Color surface = Colors.white;
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color error = Colors.redAccent;
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFED6C02);

  // Text Colors
  static const Color textPrimary = Color(0xFF1D1B20);
  static const Color textSecondary = Color(0xFF79747E);
  static const Color textLight = Colors.white;

  // Border & State Colors
  static const Color border = Color(0xFFBDBDBD);
  static const Color borderFocused = Colors.green;
  static const Color disabled = Color(0xFFC4C4C4);
}
