import 'package:finance_tracker/generated/l10n.dart';
import 'package:finance_tracker/utils/color_utils.dart';
import 'package:finance_tracker/utils/number_utils.dart';
import 'package:finance_tracker/widgets/advanced_expandable.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BudgetItem {
  final String tag;
  final double spent;
  final double limit;
  final bool isExpanded;
  final String icon;

  BudgetItem({
    required this.tag,
    required this.spent,
    required this.limit,
    required this.icon,
    this.isExpanded = false,
  });
}

class BudgetItemCard extends StatelessWidget {
  final BudgetItem item;
  final bool isExpanded;
  final VoidCallback onTap;

  const BudgetItemCard({
    super.key,
    required this.item,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final over = item.spent > item.limit;
    final remain = item.limit - item.spent;
    final percent = (item.spent / item.limit).clamp(0.0, 1.0);
    final borderColor = over
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.surface;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(width: 1, color: borderColor),
        ),
        // surfaceTintColor: Colors.white,
        shadowColor: Colors.grey.shade100,
        elevation: 0,
        child: AdvancedExpandable(
          headerBuilder: (isExpanded) =>
              _buildHeaderContent(remain, item, isExpanded, over, percent, context),
          expandedContent: _buildExpandedContent(context, over),
          collapsedContent: over ? _buildCollapseContent(context) : null,
        ),
      ),
    );
  }

  Widget _buildHeaderContent(
    double remain,
    BudgetItem item,
    bool isExpanded,
    bool over,
    double percent,
    BuildContext context
  ) {
    final spentColor = over ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInformation(context, remain, item.tag, isExpanded),
          const SizedBox(height: 16),
          _buildSpent(context, spentColor, item.spent, item.limit),
          const SizedBox(height: 8),
          _buildStack(percent, over),
        ],
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context, bool over) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildExpandedDetails(context, over)],
      ),
    );
  }

  Widget _buildInformation(BuildContext context, double remain, String tag, bool isExpanded) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tag,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${S.of(context)!.budget_remain}: ${remain < 0 ? '-' : ''}${formatCurrency(remain.abs())}',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),

        AnimatedRotation(
          turns: isExpanded ? 0.5 : 0.0, // 0.5 vòng = 180 độ (arrow hướng lên)
          duration: const Duration(milliseconds: 300),
          child: Icon(Icons.arrow_drop_up_rounded, size: 30),
        ),
      ],
    );
  }

  Widget _buildSpent(BuildContext context, Color overColor, double spent, double limit) {
    return Text.rich(
      TextSpan(
        text: '${S.of(context)!.budget_spent}: ',

        children: [
          TextSpan(
            text: formatCurrency(spent),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: overColor,
            ),
          ),
          const TextSpan(text: ' / '),
          TextSpan(
            text: formatCurrency(limit),
          ),
        ],
      ),
      style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
    );
  }

  Widget _buildStack(double percent, bool over) {
    return Stack(
      children: [
        Container(
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade300,
          ),
        ),
        FractionallySizedBox(
          widthFactor: percent,
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: over ? Colors.red.shade200 : Colors.orangeAccent,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedDetails(BuildContext context, bool over) {
    return Column(
      key: const ValueKey(
        'expanded',
      ), // cần key để AnimatedSwitcher hoạt động đúng
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Row(
              children: [
                Icon(Icons.square, color: Colors.grey.shade300, size: 14),
                const SizedBox(width: 8),
                Text(S.of(context)!.budget_legend_1, style: TextStyle(fontSize: 12)),
              ],
            ),
            Row(
              children: [
                Icon(Icons.square, color: Colors.orangeAccent, size: 14),
                const SizedBox(width: 8),
                Text(S.of(context)!.budget_legend_2, style: TextStyle(fontSize: 12)),
              ],
            ),
            if (over)
              Row(
                children: [
                  Icon(Icons.square, color: Colors.red.shade100, size: 14),
                  const SizedBox(width: 8),
                  Text(S.of(context)!.budget_legend_3, style: TextStyle(fontSize: 12)),
                ],
              ),
          ],
        ),
        Divider(height: 16, color: Colors.grey[200]),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildCollapseContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.shade700,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context)!.budget_warning_text_2,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            S.of(context)!.common_edit,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
              decorationThickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
