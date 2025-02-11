import 'dart:ui';

import 'package:flutter/material.dart';

class HexColor {
  final String colorValue;

  const HexColor({required this.colorValue});

  Color parseHexColor() {
    if (colorValue == null || colorValue.isEmpty) {
      return Colors.grey; // Fallback color
    }

    try {
      // Remove the "#" if it exists and parse the color
      return Color(
          int.parse(colorValue.replaceFirst('#', ''), radix: 16) + 0xFF000000);
    } catch (e) {
      // If parsing fails, return a default color
      return Colors.grey;
    }
  }
}
