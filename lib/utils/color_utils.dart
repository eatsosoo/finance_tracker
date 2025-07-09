import 'package:flutter/material.dart';

List<Color> generateColors({
  required Color baseColor,
  int count = 10,
}) {
  final hsl = HSLColor.fromColor(baseColor);

  return List.generate(count, (i) {
    final lightness = 0.35 + (i / (count - 1)) * 0.5;

    return HSLColor.fromAHSL(
      1.0,
      hsl.hue,
      hsl.saturation == 0 ? 1.0 : hsl.saturation, // ép saturation nếu là 0
      lightness.clamp(0.0, 1.0),
    ).toColor();
  });
}
