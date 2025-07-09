import 'package:flutter/material.dart';
import 'package:finance_tracker/utils/date_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class ScrollableButtonBar extends StatelessWidget {
  final List<String> labels;
  final void Function(String) onPressed;
  final String? selected;

  const ScrollableButtonBar({
    super.key,
    required this.labels,
    required this.onPressed,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: labels.map((label) {
          final isSelected = label == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ), // 👈 padding nhỏ
                  minimumSize: Size.zero, // 👈 bỏ hạn chế chiều cao/tối thiểu
                  backgroundColor: isSelected ? Colors.black : Colors.white,
                  foregroundColor: isSelected ? Colors.white : Colors.black,
                  side: BorderSide(color: isSelected ? Colors.black : Colors.white, width: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  textStyle: const TextStyle(fontSize: 12),
                ),
                onPressed: () => onPressed(label),
                child: Text(label),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
