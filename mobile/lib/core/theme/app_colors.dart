import 'package:flutter/material.dart';

/// Design tokens matching Figma designs
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF2563EB); // blue-600
  static const Color primaryDark = Color(0xFF1E40AF); // blue-700
  static const Color primaryLight = Color(0xFF3B82F6); // blue-500

  // Secondary Colors  
  static const Color secondary = Color(0xFF10B981); // green-500
  static const Color secondaryDark = Color(0xFF059669); // green-600
  static const Color secondaryLight = Color(0xFF34D399); // green-400

  // Success, Warning, Error
  static const Color success = Color(0xFF16A34A); // green-600
  static const Color warning = Color(0xFFEAB308); // yellow-500
  static const Color error = Color(0xFFDC2626); // red-600
  static const Color info = Color(0xFF0EA5E9); // sky-500

  // Neutral Colors
  static const Color neutral900 = Color(0xFF111827); // gray-900
  static const Color neutral800 = Color(0xFF1F2937); // gray-800
  static const Color neutral700 = Color(0xFF374151); // gray-700
  static const Color neutral600 = Color(0xFF4B5563); // gray-600
  static const Color neutral500 = Color(0xFF6B7280); // gray-500
  static const Color neutral400 = Color(0xFF9CA3AF); // gray-400
  static const Color neutral300 = Color(0xFFD1D5DB); // gray-300
  static const Color neutral200 = Color(0xFFE5E7EB); // gray-200
  static const Color neutral100 = Color(0xFFF3F4F6); // gray-100
  static const Color neutral50 = Color(0xFFF9FAFB); // gray-50

  // Background
  static const Color background = Color(0xFFFFFFFF); // white
  static const Color backgroundGray = neutral50;
  static const Color surface = Color(0xFFFFFFFF);
  
  // Text Colors
  static const Color textPrimary = neutral900;
  static const Color textSecondary = neutral600;
  static const Color textDisabled = neutral400;
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Border
  static const Color border = neutral200;
  static const Color borderLight = neutral100;

  // Overlay
  static const Color overlay = Color(0x80000000); // black with 50% opacity
  static const Color overlayLight = Color(0x40000000); // black with 25% opacity
}
