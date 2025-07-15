// home_screen.dart
import 'package:finance_tracker/utils/number_utils.dart';
import 'package:finance_tracker/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  List<BudgetItem> budgetList = [
    BudgetItem('Food', 1200000, 2000000),
    BudgetItem('Transport', 450000, 500000),
    BudgetItem('Shopping', 1600000, 1500000),
    BudgetItem('Drink', 300000, 500000),
  ];

  List<String> labels = ['Jan', 'Feb', 'Mar'];
  String selectedMonth = 'Jan';
  int? selectedIndex;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Budgets'),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔘 Tiêu đề & chọn tháng
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const Text(
                  //   'Monthly Budget',
                  //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  // ),
                  DropdownButton<String>(
                    value: selectedMonth,
                    items: labels.map((month) {
                      return DropdownMenuItem(value: month, child: Text(month));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMonth = value!;
                        // Gọi updateBudget()
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // 🔘 Danh sách ngân sách từng danh mục
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: budgetList.length,
                itemBuilder: (context, index) {
                  final item = budgetList[index];
                  final percent = item.spent / item.limit;
                  final over = percent > 1;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              item.tag,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${formatCurrency(item.spent)} / ${formatCurrency(item.limit)}',
                              style: TextStyle(
                                color: over ? Colors.red : Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: percent > 1 ? 1 : percent,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              over ? Colors.red : Colors.black12,
                            ),
                            minHeight: 8,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BudgetItem {
  final String tag;
  final int spent;
  final int limit;

  BudgetItem(this.tag, this.spent, this.limit);
}
