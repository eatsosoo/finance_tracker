import 'package:flutter/material.dart';
import 'package:finance_tracker/widgets/app_bottom_sheet.dart';
import 'package:finance_tracker/widgets/filter_option.dart';

Future<void> showBottomOptions({
  required BuildContext context,
  required String title,
  required List<Map<String, dynamic>> filterOptions,
  required String currentFilter,
  required ValueChanged<String> onSelected,
  Color? backgroundColor,
  Color? surfaceColor,
}) {
  return AppBottomSheet.show(
    backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.background,
    context: context,
    title: title,
    child: Container(
      decoration: BoxDecoration(
        color: surfaceColor ?? Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ...filterOptions.map((option) {
            final index = filterOptions.indexOf(option);
            return Column(
              children: [
                buildFilterOption(
                  context,
                  icon: option['icon'],
                  title: option['title'],
                  value: option['value'],
                  currentFilter: currentFilter,
                  onTap: () {
                    onSelected(option['value']);
                    Navigator.pop(context);
                  },
                ),
                if (index != filterOptions.length - 1)
                  Divider(
                    height: 1,
                  ),
              ],
            );
          }).toList(),
        ],
      ),
    ),
  );
}