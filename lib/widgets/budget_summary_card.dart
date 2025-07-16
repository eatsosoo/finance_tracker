import 'package:finance_tracker/utils/number_utils.dart';
import 'package:flutter/material.dart';
import 'month_selector.dart';

class BudgetSummaryCard extends StatefulWidget {
  final String selectedMonth;
  final VoidCallback onSelectMonth;
  final VoidCallback onEdit;
  final int totalAmount;
  final int totalAllocated;

  const BudgetSummaryCard({
    super.key,
    required this.selectedMonth,
    required this.onSelectMonth,
    required this.onEdit,
    required this.totalAmount,
    required this.totalAllocated,
  });

  @override
  State<BudgetSummaryCard> createState() => _BudgetSummaryCardState();
}

class _BudgetSummaryCardState extends State<BudgetSummaryCard> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // 🔽 Row: arrow, month selector, edit
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: isExpanded ? 0.5 : 0,
                  child: const Icon(Icons.keyboard_arrow_down_rounded),
                ),
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
              MonthSelector(
                selectedMonth: widget.selectedMonth,
                onTap: widget.onSelectMonth,
              ),
              IconButton(
                icon: const Icon(Icons.edit, size: 18),
                onPressed: widget.onEdit,
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 🟦 Ẩn/hiện phần chi tiết
          if (isExpanded)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'New budget',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Total amount',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  Text(
                    formatCurrency(widget.totalAmount),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Total allocated',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  Text(
                    formatCurrency(widget.totalAllocated),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
