import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? prefixIcon;
  final double? height;
  final bool disableEmoji;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Color fillColor;
  final double borderRadius;

  const CustomInput({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.prefixIcon,
    this.height = 46,
    this.disableEmoji = true,
    this.keyboardType,
    this.inputFormatters,
    this.fillColor = const Color(0xFFF5F5F5),
    this.borderRadius = 50,
  });

  @override
  Widget build(BuildContext context) {
    // Kết hợp inputFormatters truyền vào + chặn emoji nếu cần
    final formatters = <TextInputFormatter>[
      if (disableEmoji)
        FilteringTextInputFormatter.deny(
          RegExp(
            r'[\u{1F600}-\u{1F64F}]|'
            r'[\u{1F300}-\u{1F5FF}]|'
            r'[\u{1F680}-\u{1F6FF}]|'
            r'[\u{2600}-\u{26FF}]|'
            r'[\u{2700}-\u{27BF}]',
            unicode: true,
          ),
        ),
      if (inputFormatters != null) ...inputFormatters!,
    ];

    final input = TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: formatters,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14),
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );

    // Nếu có height thì wrap vào SizedBox
    return height != null
        ? SizedBox(height: height, child: input)
        : input;
  }
}
