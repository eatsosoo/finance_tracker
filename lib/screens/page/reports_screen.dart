import 'package:finance_tracker/constants/colors.dart';
import 'package:finance_tracker/utils/color_utils.dart';
import 'package:finance_tracker/utils/number_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:finance_tracker/widgets/scroll_button_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:finance_tracker/widgets/doughnut_chart.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen>
    with TickerProviderStateMixin {
  String selected = '7/2025';
  late final TabController _tabController;

  List<IncomItem> incomList = [
    IncomItem('Lương tháng 7', 'Salary', 8000000, '2025-07-01'),
    IncomItem('Lương thưởng', 'Bonus', 2000000, '2025-07-05'),
  ];

  List<IncomItem> outcomList = [
    IncomItem('Ăn sáng', 'Food', 25000, '2025-07-08'),
    IncomItem('Xe buýt', 'Transport', 7000, '2025-07-08'),
    IncomItem('Mua áo thun', 'Shopping', 150000, '2025-07-08'),
    IncomItem('Trà sữa', 'Drink', 45000, '2025-07-08'),
    IncomItem('Ăn trưa', 'Food', 40000, '2025-07-08'),
    IncomItem('Grab', 'Transport', 30000, '2025-07-08'),
    IncomItem('Mua sách', 'Shopping', 120000, '2025-07-08'),
    IncomItem('Nước suối', 'Drink', 10000, '2025-07-08'),
    IncomItem('Ăn tối', 'Food', 60000, '2025-07-08'),
  ];

  List<ChartSampleData> generateChartData(List<IncomItem> list) {
    final Map<String, double> grouped = {};

    for (var item in list) {
      grouped[item.tag] = (grouped[item.tag] ?? 0) + item.amount.toDouble();
    }

    final total = grouped.values.fold(0.0, (sum, val) => sum + val);
  
    final result = grouped.entries.map((e) {
      final percent = (e.value / total) * 100;
      final tagHex = tagColors[e.key] ?? '#000000';
      final tagColor = hexToColor(tagHex);

      return ChartSampleData(
        tag: e.key,
        amount: double.parse(percent.toStringAsFixed(1)),
        text: '${percent.toStringAsFixed(1)}%',
        color: tagColor
      );
    }).toList();

    return result;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Income, Outcome
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Income and outcome report',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: const Icon(Iconsax.arrow_left_2),
        ),
      ),
      body: Column(
        children: [
          // ✅ Scrollable Button Bar
          ScrollableButtonBar(
            labels: [
              '1/2025',
              '2/2025',
              '3/2025',
              '4/2025',
              '5/2025',
              '6/2025',
              '7/2025',
              '8/2025',
              '9/2025',
              '10/2025',
              '11/2025',
              '12/2025',
            ],
            selected: selected,
            onPressed: (label) => setState(() => selected = label),
          ),

          // ✅ TabBar container
          Container(
            margin: const EdgeInsets.only(
              bottom: 0,
              top: 8,
              left: 16,
              right: 16,
            ),
            padding: const EdgeInsets.only(
              bottom: 8,
              top: 4,
              left: 4,
              right: 4,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              dividerHeight: 0,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              indicatorPadding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 6,
              ),
              tabs: const [
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('Income'),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('Outcome'),
                  ),
                ),
              ],
            ),
          ),

          // ✅ Nội dung theo từng tab
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                top: 0,
                right: 16,
                left: 16,
                bottom: 0,
              ),
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.only(
                //   bottomLeft: Radius.circular(8),
                //   bottomRight: Radius.circular(8),
                // ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TabBarView(
                controller: _tabController,
                children: [
                  // ✅ Tab 1 có scroll nếu content dài
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        // 🎯 Biểu đồ cố định chiều cao
                        SizedBox(
                          height: 300,
                          child: DoughnutDefault(
                            series: generateChartData(incomList),
                            baseColor: Colors.blue,
                          ),
                        ),
                        _listItems(context, incomList),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        // 🎯 Biểu đồ cố định chiều cao
                        SizedBox(
                          height: 300,
                          child: DoughnutDefault(
                            series: generateChartData(outcomList),
                          ),
                        ),
                        _listItems(context, outcomList),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listItems(BuildContext context, List<IncomItem> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        final tagHex = tagColors[item.tag] ?? '#000000';
        final tagColor = hexToColor(tagHex);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08), // ✅ dùng màu xám mờ
                  blurRadius: 12, // ✅ bóng mượt
                  spreadRadius: 1, // ✅ lan nhẹ ra
                  offset: const Offset(0, 4), // ✅ bóng hướng xuống
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: tagColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.tag,
                        style: TextStyle(
                          color: tagColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      formatCurrency(item.amount),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  item.date,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ChartData {
  _ChartData(this.year, this.sales);

  final String year;
  final double sales;
}

class IncomItem {
  final String title;
  final String tag;
  final double amount;
  final String date;

  IncomItem(this.title, this.tag, this.amount, this.date);
}
