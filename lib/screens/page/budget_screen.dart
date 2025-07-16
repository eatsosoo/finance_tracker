// home_screen.dart
import 'package:finance_tracker/utils/number_utils.dart';
import 'package:finance_tracker/widgets/budget_summary_card.dart';
import 'package:finance_tracker/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:finance_tracker/widgets/budget_item_card.dart';

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
      spent: 450000,
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

  List<String> labels = ['Jan', 'Feb', 'Mar'];
  String selectedMonth = 'Jan';
  int? expandedIndex;
  int overspentCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Budgets'),
      body: Center(
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

            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'You have overspent $overspentCount ${overspentCount > 1 ? 'times' : 'time'}',
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
                      '$overspentCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.keyboard_arrow_right, color: Colors.black),
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
