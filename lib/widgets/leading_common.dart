import 'package:finance_tracker/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';

class LeadingCommon extends StatelessWidget {
  const LeadingCommon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [shadowCommon()],
        ),
        child: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.black),
          onPressed: () {
            context.canPop() ? context.pop() : context.go('/home');
          },
          padding: EdgeInsets.zero, // ✅ Xoá padding mặc định
          constraints: const BoxConstraints(), // ✅ Gỡ giới hạn mặc định
        ),
      ),
    );
  }
}
