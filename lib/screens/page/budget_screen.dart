// home_screen.dart
import 'package:finance_tracker/utils/number_utils.dart';
import 'package:finance_tracker/widgets/budget_summary_card.dart';
import 'package:finance_tracker/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:finance_tracker/widgets/budget_item_card.dart';
import 'package:finance_tracker/widgets/advanced_expandable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  List<BudgetItem> budgetList = [
    BudgetItem(
      tag: 'Food',
      spent: 1200000,
      limit: 2000000,
      isExpanded: false,
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWdrASvzMu1DZPSilrpKIRO1nU59KHD0VTlw&s',
    ),
    BudgetItem(
      tag: 'Transport',
      spent: 550000,
      limit: 500000,
      isExpanded: false,
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWdrASvzMu1DZPSilrpKIRO1nU59KHD0VTlw&s',
    ),
    BudgetItem(
      tag: 'Shopping',
      spent: 1600000,
      limit: 1500000,
      isExpanded: false,
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWdrASvzMu1DZPSilrpKIRO1nU59KHD0VTlw&s',
    ),
    BudgetItem(
      tag: 'Drink',
      spent: 300000,
      limit: 500000,
      isExpanded: false,
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWdrASvzMu1DZPSilrpKIRO1nU59KHD0VTlw&s',
    ),
    BudgetItem(
      tag: 'Healthcare',
      spent: 300000,
      limit: 500000,
      isExpanded: false,
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWdrASvzMu1DZPSilrpKIRO1nU59KHD0VTlw&s',
    ),
    BudgetItem(
      tag: 'Game',
      spent: 300000,
      limit: 500000,
      isExpanded: false,
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWdrASvzMu1DZPSilrpKIRO1nU59KHD0VTlw&s',
    ),
    BudgetItem(
      tag: 'Rent',
      spent: 300000,
      limit: 500000,
      isExpanded: false,
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWdrASvzMu1DZPSilrpKIRO1nU59KHD0VTlw&s',
    ),
    BudgetItem(
      tag: 'Drink',
      spent: 300000,
      limit: 500000,
      isExpanded: false,
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWdrASvzMu1DZPSilrpKIRO1nU59KHD0VTlw&s',
    ),
    BudgetItem(
      tag: 'Drink',
      spent: 300000,
      limit: 500000,
      isExpanded: false,
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWdrASvzMu1DZPSilrpKIRO1nU59KHD0VTlw&s',
    ),
    BudgetItem(
      tag: 'Drink',
      spent: 300000,
      limit: 500000,
      isExpanded: false,
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWdrASvzMu1DZPSilrpKIRO1nU59KHD0VTlw&s',
    ),
  ];

  String selectedMonth = 'Jan';
  int? expandedIndex;
  int _overspentCount = 0;

  @override
  void initState() {
    super.initState();
    _overspentCount = budgetList.where((budget) {
      return (budget.limit - budget.spent) < 0;
    }).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Budgets', backgroundColor: Colors.white),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BudgetSummaryCard(
              selectedMonth: 'Month 7 2025',
              onSelectMonth: () {
                // TODO: mở modal chọn tháng
              },
              onEdit: () {
                // TODO: xử lý sửa
              },
              totalAmount: 30000000,
              totalAllocated: 30000000,
            ),

            const SizedBox(height: 24),
            // Notify overspent
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xFFFEE4E2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/illustrations/undraw-warning.svg',
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'You have overspent $_overspentCount ${_overspentCount > 1 ? 'times' : 'time'}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$_overspentCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(LucideIcons.chevronRight, color: Colors.black, size: 18,),
                ],
              ),
            ),
            // 🔘 Danh sách ngân sách từng danh mục
            Expanded(
              child: ListView.builder(
                itemCount: budgetList.length,
                itemBuilder: (context, index) {
                  final item = budgetList[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    child: BudgetItemCard(
                      item: item,
                      isExpanded: expandedIndex == index,
                      onTap: () {
                        setState(() {
                          expandedIndex = expandedIndex == index ? null : index;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
