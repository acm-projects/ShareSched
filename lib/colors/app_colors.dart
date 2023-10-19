import 'package:flutter/material.dart';
import 'dart:math';

class AppColors {
  static Color getRandomColor() {
    final Random _random = Random();

    return Color.fromARGB(_random.nextInt(256), _random.nextInt(256),
        _random.nextInt(256), _random.nextInt(256));
  }

  // Background color
  static const Color backgroundColor = Colors.black;

  // Primary color
  static const Color primaryColor = Color(0xFF1264D1);

  // Secondary color
  static const Color secondaryColor = Color(0xFF34A853);

  // Button Colors
  static const Color buttonColor1 = Color(0xFF1264D1);
  static const Color buttonColor2 = Color.fromRGBO(53, 51, 205, 1);

  // Schedule colors
  static const Color gridColor = Color.fromRGBO(53, 51, 205, 1);
  static const Color courseColor = Color.fromRGBO(53, 51, 205, 1);
  // Subject colors
  static const Color mathColor = Color.fromRGBO(255, 0, 0, 1); // Red shade

  static const Color physicsColor =
      Color.fromRGBO(255, 87, 34, 1); // Orangish shade
  static const Color chemistryColor =
      Color.fromRGBO(0, 255, 0, 1); // Green shade
  static const Color biologyColor =
      Color.fromRGBO(33, 150, 243, 1); // Bluish shade
  static const Color literatureColor =
      Color.fromRGBO(233, 30, 99, 1); // Pinkish shade
  static const Color historyColor =
      Color.fromRGBO(156, 39, 176, 1); // Purple shade
  static const Color geographyColor =
      Color.fromRGBO(255, 152, 0, 1); // Orange shade
  static const Color computerScienceColor =
      Color.fromRGBO(0, 188, 212, 1); // Teal shade
  static const Color engineeringColor =
      Color.fromRGBO(255, 255, 0, 1); // Yellow shade
  static const Color psychologyColor =
      Color.fromRGBO(128, 128, 128, 1); // Grey shade
  static const Color economicsColor =
      Color.fromRGBO(0, 128, 0, 1); // Dark Green shade
  static const Color sociologyColor =
      Color.fromRGBO(255, 20, 147, 1); // Deep Pink shade
  static const Color philosophyColor =
      Color.fromRGBO(218, 165, 32, 1); // Golden shade
  static const Color artColor =
      Color.fromRGBO(148, 0, 211, 1); // Dark Violet shade
  static const Color musicColor =
      Color.fromRGBO(64, 224, 208, 1); // Turquoise shade
  static const Color politicalScienceColor =
      Color.fromRGBO(255, 0, 0, 1); // Red shade
  static const Color businessColor =
      Color.fromRGBO(34, 139, 34, 1); // Forest Green shade

  static const Color lawColor = Color.fromRGBO(0, 0, 0, 1); // Black shade

  // Text colors
  static const Color primaryTextColor = Colors.white;
  static const Color secondaryTextColor = Colors.black;

  // Error color
  static const Color errorColor = Color(0xFFEA4335);
}
