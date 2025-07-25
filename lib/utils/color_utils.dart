import 'package:flutter/material.dart';

List<Color> generateColors({required Color baseColor, int count = 10}) {
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

Color hexToColor(String hex) {
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'FF$hex'; // Thêm alpha nếu chưa có
  }
  return Color(int.parse(hex, radix: 16));
}

BoxShadow shadowCommon({ Color? baseColor }) {
  return BoxShadow(
    color: baseColor ?? Colors.black.withOpacity(0.08), // ✅ dùng màu xám mờ
    blurRadius: 1, // ✅ bóng mượt
    spreadRadius: 0, // ✅ lan nhẹ ra
    offset: const Offset(0, 3), // ✅ bóng hướng xuống
  );
}
