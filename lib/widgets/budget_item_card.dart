import 'package:finance_tracker/utils/color_utils.dart';
import 'package:finance_tracker/utils/number_utils.dart';
import 'package:finance_tracker/widgets/advanced_expandable.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
    final borderColor = over ? Colors.red : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: _buildBoxDecoration(isExpanded, over, borderColor),
        child: AdvancedExpandable(
          headerBuilder: (isExpanded) =>
              _buildHeaderContent(remain, item, isExpanded, over, percent),
          expandedContent: _buildExpandedContent(over),
          collapsedContent: over ? _buildCollapseContent() : null,
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration(bool open, bool over, Color borderColor) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border(
        top: BorderSide(color: borderColor, width: 1),
        left: BorderSide(color: borderColor, width: 1),
        right: BorderSide(color: borderColor, width: 1),
        bottom: BorderSide(color: borderColor, width: 1),
      ),
      boxShadow: [shadowCommon()],
    );
  }

  Widget _buildHeaderContent(
    double remain,
    BudgetItem item,
    bool isExpanded,
    bool over,
    double percent,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInformation(remain, item.tag, isExpanded),
          const SizedBox(height: 12),
          _buildSpent(over, item.spent, item.limit),
          const SizedBox(height: 6),
          _buildStack(percent, over),
        ],
      ),
    );
  }

  Widget _buildExpandedContent(bool over) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildExpandedDetails(over)],
      ),
    );
  }

  Widget _buildInformation(double remain, String tag, bool isExpanded) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // CachedNetworkImage(
        //   imageUrl: item.icon,
        //   width: 40,
        //   height: 40,
        //   imageBuilder: (context, imageProvider) => Container(
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       // border: Border.all(color: Colors.black12),
        //       color: Colors.white,
        //       image: DecorationImage(
        //         image: imageProvider,
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //   ),
        // ),
        // Icon(Iconsax.activity),
        // const SizedBox(width: 8),
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
                'Remain: ${remain < 0 ? '-' : ''}${formatCurrency(remain.abs())}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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

  Widget _buildSpent(bool over, double spent, double limit) {
    return Text.rich(
      TextSpan(
        text: 'Spent: ',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),

        children: [
          TextSpan(
            text: formatCurrency(spent),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: over ? Colors.red : Colors.black54,
            ),
          ),
          const TextSpan(text: ' / '),
          TextSpan(
            text: formatCurrency(limit),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
      style: const TextStyle(fontSize: 13),
    );
  }

  Widget _buildStack(double percent, bool over) {
    return Stack(
      children: [
        Container(
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey[200],
          ),
        ),
        FractionallySizedBox(
          widthFactor: percent,
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: over ? Colors.red.shade100 : Colors.black12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedDetails(bool over) {
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
                Icon(Icons.square, color: Colors.grey[200], size: 14),
                const SizedBox(width: 6),
                const Text('Amount assigned', style: TextStyle(fontSize: 12)),
              ],
            ),
            Row(
              children: [
                Icon(Icons.square, color: Colors.black12, size: 14),
                const SizedBox(width: 6),
                const Text('Amount spent', style: TextStyle(fontSize: 12)),
              ],
            ),
            if (over)
              Row(
                children: [
                  Icon(Icons.square, color: Colors.red.shade100, size: 14),
                  const SizedBox(width: 6),
                  const Text('Overspent', style: TextStyle(fontSize: 12)),
                ],
              ),
          ],
        ),
        const SizedBox(height: 4),
        Divider(height: 16, color: Colors.grey[200]),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildCollapseContent() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.shade700,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'You have one overspent',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Edit',
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
