import 'package:flutter/material.dart';

abstract class AppColors {
  AppColors._();

  // Couleurs principales
  static const Color primary = Color(0xFFF2B609);
  static const Color secondary = Color(0xFF00FFFF);
  static const Color tertiary = Color(0xFFFF00FF);

  // Couleurs de fond
  static const Color background = Color(0xFF113256);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color surfaceVariant = Color(0xFF2A2A2A);

  // Couleurs de texte
  static const Color textPrimary = Color(0xFF00FF00);
  static const Color textSecondary = Color(0xFF00FFFF);
  static const Color textSelectGameButton = Color(0xFFF6DBBD);
  static const Color textDisabled = Color(0xFF666666);

  // Couleurs de jeu
  static const Color playerX = Color(0xFFFF0000);
  static const Color playerO = Color(0xFF0000FF);
  static const Color gridLine = Color(0xFF00FF00);

  // États
  static const Color success = Color(0xFF00FF00);
  static const Color error = Color(0xFFFF0000);
  static const Color warning = Color(0xFFFFFF00);
  static const Color info = Color(0xFF00FFFF);
}
