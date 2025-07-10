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
  List<_ChartData> data = [
    _ChartData('Jan', 35),
    _ChartData('Feb', 28),
    _ChartData('Mar', 34),
    _ChartData('Apr', 32),
    _ChartData('May', 40),
  ];

  List<ChartSampleData> series = [
    ChartSampleData(x: 'Chlorine', y: 55, text: '55%', color: Colors.black),
    ChartSampleData(x: 'Sodium', y: 31, text: '31%', color: Colors.black12),
    ChartSampleData(x: 'Magnx', y: 7.7, text: '7.7%', color: Colors.black26),
    ChartSampleData(x: 'Sulfur', y: 3.7, text: '3.7%', color: Colors.black38),
    ChartSampleData(x: 'Calcium', y: 1.2, text: '1.2%', color: Colors.black45),
    ChartSampleData(x: 'Others', y: 1.4, text: '1.4%', color: Colors.black54),
  ];

  List<IncomItem> incomList = [
    IncomItem('Test 1', 'TAG', 10000, '2025-07-10'),
    IncomItem('Test 1', 'TAG', 10000, '2025-07-10'),
    IncomItem('Test 1', 'TAG', 10000, '2025-07-10'),
    IncomItem('Test 1', 'TAG', 10000, '2025-07-10'),
    IncomItem('Test 1', 'TAG', 10000, '2025-07-10'),
  ];

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
                borderRadius: BorderRadius.circular(12),
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
                            series: series,
                            baseColor: Colors.blue,
                          ),
                        ),
                        _listItems(context, incomList),
                      ],
                    ),
                  ),
                  DoughnutDefault(series: series, baseColor: Colors.purple),
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
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
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
                    Text(item.tag, style: const TextStyle(color: Colors.grey)),
                    Text(
                      '${item.amount}₫',
                      style: const TextStyle(fontWeight: FontWeight.w500),
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
