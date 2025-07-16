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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isExpanded
              ? Border(
                  top: BorderSide(color: borderColor, width: 1),
                  left: BorderSide(color: borderColor, width: 1),
                  right: BorderSide(color: borderColor, width: 1),
                  bottom: BorderSide(color: borderColor, width: over ? 6 : 1),
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: isExpanded
                  ? (over
                        ? Colors.red.withOpacity(0.2)
                        : Colors.black.withOpacity(0.05))
                  : Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: item.icon,
                  width: 40,
                  height: 40,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(color: Colors.black12),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.tag,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Còn lại: ${remain < 0 ? '-' : ''}${formatCurrency(remain.abs())} đ',
                        style: TextStyle(
                          fontSize: 12,
                          color: remain < 0 ? Colors.red : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                Icon(
                  isExpanded
                      ? Icons.arrow_drop_up_rounded
                      : Icons.arrow_drop_down_rounded,
                  size: 30,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Spent
            Text.rich(
              TextSpan(
                text: 'Spent: ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),

                children: [
                  TextSpan(
                    text: '${formatCurrency(item.spent)}đ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: over ? Colors.red : Colors.black54,
                    ),
                  ),
                  const TextSpan(text: ' / '),
                  TextSpan(
                    text: '${formatCurrency(item.limit)}đ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              style: const TextStyle(fontSize: 13),
            ),

            const SizedBox(height: 6),

            // Progress bar
            Stack(
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
                      color: Colors.black12,
                    ),
                  ),
                ),
              ],
            ),

            // Expand content
            if (isExpanded) ...[
              const SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.square, color: Colors.grey[200], size: 14),
                      SizedBox(width: 6),
                      Text('Amount assigned', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  SizedBox(width: 12),
                  Row(
                    children: [
                      Icon(Icons.square, color: Colors.black12, size: 14),
                      SizedBox(width: 6),
                      Text('Amount spent', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Divider(height: 16, color: Colors.grey[200]),
            ],
          ],
        ),
      ),
    );
  }

  String formatCurrency(double amount) {
    return amount
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }
}
