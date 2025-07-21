import 'package:flutter/material.dart';

class AppBottomSheet extends StatelessWidget {
  final String? title;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const AppBottomSheet({
    super.key,
    this.title,
    required this.child,
    this.padding,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    required Widget child,
    EdgeInsetsGeometry? padding,
    bool isScrollControlled = true,
    bool useRootNavigator = true,
    Color? backgroundColor,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      backgroundColor: backgroundColor ?? Colors.grey[100],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: AppBottomSheet(
          title: title,
          child: child,
          padding: padding,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildDragHandle(),
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                title!,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          child,
        ],
      ),
    );
  }
}

Widget buildDragHandle() => Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(2),
      ),
    );