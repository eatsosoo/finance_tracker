import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

Widget buildFilterOption(
  BuildContext context, {
  IconData? icon,
  required String title,
  required String value,
  required String currentFilter,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: icon != null
        ? Icon(icon, size: 18, color: Theme.of(context).colorScheme.onSurface)
        : null,
    title: Text(title, style: const TextStyle(fontSize: 14)),
    onTap: onTap,
    trailing: currentFilter == value
        ? Icon(
            LucideIcons.check,
            color: Theme.of(context).colorScheme.onSurface,
          )
        : null,
  );
}
