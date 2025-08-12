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

List<Color> blackToRedPalette({
  int count = 10,
  Color leftColor = Colors.black,
  Color rightColor = Colors.red,
}) {
  return List.generate(
    count,
    (i) => Color.lerp(leftColor, rightColor, i / (count - 1))!,
  );
}

Color hexToColor(String hex) {
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'FF$hex'; // Thêm alpha nếu chưa có
  }
  return Color(int.parse(hex, radix: 16));
}

BoxShadow boxShadowCommon({Color? baseColor}) {
  return BoxShadow(
    color: baseColor ?? Colors.black.withOpacity(0.08), // ✅ dùng màu xám mờ
    blurRadius: 1, // ✅ bóng mượt
    spreadRadius: 0, // ✅ lan nhẹ ra
    offset: const Offset(0, 3), // ✅ bóng hướng xuống
  );
}

Shadow shadowCommon({Color? baseColor}) {
  return Shadow(
    offset: Offset(2, 2), // độ lệch bóng (x, y)
    blurRadius: 4, // độ mờ của bóng
    color: baseColor ?? Colors.black, // màu bóng
  );
}

LinearGradient buildGradient(Color baseColor) {
  // Tạo 2 màu gradient: màu sáng hơn và màu tối hơn dựa trên baseColor
  final Color lighter = Color.lerp(baseColor, Colors.white, 0.5)!;
  final Color darker = Color.lerp(baseColor, Colors.black, 0.4)!;

  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [lighter, baseColor, darker],
  );
}

LinearGradient backgroundGradient() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE9E4EF),
      Color(0xFFF1F4F6),
      Color(0xFFEEF5FA),
      Color(0xFFF3F8FD),
    ],
    stops: [0.0, 0.3, 0.65, 1.0], // Màu 2
  );
}
