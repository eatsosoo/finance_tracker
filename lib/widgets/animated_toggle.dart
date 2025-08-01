import 'package:finance_tracker/utils/color_utils.dart';
import 'package:flutter/material.dart';

class ToggleItem {
  final String label;
  final String value;
  final IconData icon;

  ToggleItem({required this.label, required this.value, required this.icon});
}

class AnimatedToggle extends StatefulWidget {
  final String selected;
  final Function(String) onChanged;
  final List<ToggleItem> items;

  const AnimatedToggle({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.items,
  });

  @override
  State<AnimatedToggle> createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  void _onTap(String value) {
    if (_selected != value) {
      setState(() {
        _selected = value;
      });
      widget.onChanged(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = widget.items.indexWhere((item) => item.value == _selected);

    return Container(
      width: 220,
      height: 44,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(30),
        boxShadow: [shadowCommon()]
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double itemWidth = (constraints.maxWidth - 10) / widget.items.length;

          return Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: Alignment(-1.0 + (2.0 * selectedIndex) / (widget.items.length - 1), 0),
                // Trả về -1.0 (trái) ... 0 (giữa) ... 1.0 (phải)
                child: Container(
                  width: itemWidth,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [shadowCommon()],
                  ),
                ),
              ),
              Row(
                children: widget.items.map((item) {
                  bool isSelected = item.value == _selected;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => _onTap(item.value),
                      behavior: HitTestBehavior.translucent,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              item.icon,
                              size: 16,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item.label,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}