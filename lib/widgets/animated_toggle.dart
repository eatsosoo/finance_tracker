import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
    setState(() {
      _selected = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = _selected == 'income';

    return Container(
      width: 220,
      height: 44,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: isIncome ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...widget.items.map((item) {
                return _buildToggleItem(
                  title: item.label,
                  icon: item.icon,
                  value: item.value,
                  selected: item.value == 'income',
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleItem({
    required String title,
    required IconData icon,
    required String value,
    required bool selected,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onTap(value),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: selected ? Colors.white : Colors.black,
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
