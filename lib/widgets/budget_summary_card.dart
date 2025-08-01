import 'package:finance_tracker/utils/color_utils.dart';
import 'package:finance_tracker/utils/number_utils.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
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

class _BudgetSummaryCardState extends State<BudgetSummaryCard>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  String selected = 'Jul 2025';
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowCommon()],
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
      ),
      child: Column(
        children: [
          // 🔽 Row: arrow, month selector, edit
          _buildExpandedHeader(),

          // 🟦 Nội dung mở rộng
          SizeTransition(
            sizeFactor: _animation,
            child: _buildExpandedContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedHeader() {
    return Container(
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: AnimatedRotation(
              duration: const Duration(milliseconds: 200),
              turns: isExpanded ? 0.5 : 0,
              child: const Icon(LucideIcons.chevronUp),
            ),
            onPressed: () {
              _toggleExpanded();
            },
          ),
          OverlayMonthSelector(
            selectedMonth: selected,
            onChanged: (newMonth) {
              setState(() {
                selected = newMonth;
              });
            },
            options: [
              'Jan 2025',
              'Feb 2025',
              'Mar 2025',
              'Apr 2025',
              'May 2025',
              'Jun 2025',
              'Jul 2025',
              'Aug 2025',
              'Sep 2025',
              'Oct 2025',
              'Nov 2025',
            ],
          ),
          IconButton(
            icon: const Icon(LucideIcons.squarePen, size: 18),
            onPressed: widget.onEdit,
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: const EdgeInsets.only(bottom: 16, right: 16, left: 16, top: 0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'New budget',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
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
          const SizedBox(height: 8),
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
    );
  }
}
