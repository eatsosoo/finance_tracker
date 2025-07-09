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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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

          // ✅ TabBar bên dưới ScrollableButtonBar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: 'Income'),
                Tab(text: 'Outcome'),
              ],
            ),
          ),

          // ✅ Nội dung theo từng tab
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                DoughnutDefault(series: series, baseColor: Colors.blue),
                DoughnutDefault(series: series),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.year, this.sales);

  final String year;
  final double sales;
}
