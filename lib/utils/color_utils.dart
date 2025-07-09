import 'package:flutter/material.dart';

List<String> generateHexColors({
  required Color baseColor,
  int count = 10,
}) {
  final hsl = HSLColor.fromColor(baseColor);
  final List<String> hexColors = [];

  for (int i = 0; i < count; i++) {
    // Create lightness from 0.35 to 0.85 
    final lightness = 0.35 + (i / (count - 1)) * 0.5;
    final modified = hsl.withLightness(lightness.clamp(0.0, 1.0));
    final color = modified.toColor();

    // Convert to HEX
    final hex = '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
    hexColors.add(hex);
  }

  return hexColors;
}
