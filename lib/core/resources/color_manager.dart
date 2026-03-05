import 'package:flutter/material.dart';

class ColorManager {
  // Primary
  static const Color primary = Color(0xFF743698);
  static const Color primaryAccent = Color(0xFFF5E5FF);

  // Secondary
  static const Color secondary = Color(0xFF898DDF);
  static const Color secondaryAccent = Color(0xFFE5E6FF);

  // Alert / Red
  static const Color alert = Color(0xFFF0506D);
  static const Color alertAccent = Color(0xFFFFDBE1);

  // Text
  static const Color darkText = Color(0xFF272727);
  static const Color hint = Color(0xFF9B9B9B);

  // Background
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray1 = Color(0xFFF2F2F2);
  static const Color lightGray2 = Color(0xFFF9F9F9);

  // Border / Line
  static const Color border = Color(0xFFE6E6E6);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
  );

  static const LinearGradient g2Gradient = LinearGradient(
    colors: [Color(0xFF00C2CB), Color(0xFF51AFB3)],
  );
}
