import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FancyBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const FancyBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<FancyBottomNavBar> createState() => _FancyBottomNavBarState();
}

class _FancyBottomNavBarState extends State<FancyBottomNavBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutQuad,
            alignment: widget.currentIndex == 0
                ? Alignment(-1.0, 0)
                : widget.currentIndex == 1
                    ? Alignment(0, -2.3) // Icon giữa nổi lên
                    : Alignment(1.0, 0),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(icon: Icons.home, index: 0),
              _buildNavItem(icon: Icons.local_fire_department, index: 1, isCenter: true),
              _buildNavItem(icon: Icons.settings, index: 2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    bool isCenter = false,
  }) {
    final isSelected = widget.currentIndex == index;

    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(12),
        decoration: isCenter
            ? BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              )
            : null,
        child: Icon(
          icon,
          color: isSelected ? Colors.orange : Colors.white,
          size: isCenter ? 32 : 24,
        ),
      ),
    );
  }
}
