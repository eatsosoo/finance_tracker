import 'package:finance_tracker/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:finance_tracker/utils/date_utils.dart';
import 'package:go_router/go_router.dart';

class ScrollableButtonBar extends StatefulWidget {
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
  State<ScrollableButtonBar> createState() => _ScrollableButtonBarState();
}

class _ScrollableButtonBarState extends State<ScrollableButtonBar> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedIndex = widget.labels.indexOf(widget.selected ?? '');
      if (selectedIndex != -1) {
        _scrollToCenter(selectedIndex);
      }
    });
  }

  // @override
  // void didUpdateWidget(covariant ScrollableButtonBar oldWidget) {
  //   super.didUpdateWidget(oldWidget);

  //   final selectedIndex = widget.labels.indexOf(widget.selected ?? '');
  //   if (selectedIndex != -1 && oldWidget.selected != widget.selected) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       _scrollToCenter(selectedIndex);
  //     });
  //   }
  // }

  void _scrollToCenter(int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    const buttonWidth = 90; // ⬅️ tùy chỉnh theo độ rộng nút
    final offset =
        (index * (buttonWidth + 8)) - (screenWidth / 2) + (buttonWidth / 2);

    _scrollController.animateTo(
      offset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48, // ⬅️ chiều cao nút + padding
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        itemCount: widget.labels.length,
        itemBuilder: (context, index) {
          final label = widget.labels[index];
          final isSelected = label == widget.selected;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  shadowCommon(),
                ],
              ),
              child: Material(
                elevation: isSelected ? 4 : 0,
                borderRadius: BorderRadius.circular(8),
                shadowColor: Colors.black26,
                color: isSelected ? Colors.black : Colors.white,
                child: InkWell(
                  onTap: () => widget.onPressed(label),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 90, // ⬅️ nên cố định để tính toán scroll
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
