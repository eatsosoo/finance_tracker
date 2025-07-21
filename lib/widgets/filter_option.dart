import 'package:flutter/material.dart';

Widget buildFilterOption(
    BuildContext context, {
    IconData? icon,
    required String title,
    required String value,
    required String currentFilter,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: icon != null ? Icon(icon, size: 18) : null,
      title: Text(title, style: const TextStyle(fontSize: 14)),
      onTap: onTap,
      trailing: currentFilter == value ? const Icon(Icons.check) : null,
    );
  }