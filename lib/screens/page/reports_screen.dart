import 'package:finance_tracker/constants/colors.dart';
import 'package:finance_tracker/utils/color_utils.dart';
import 'package:finance_tracker/utils/date_utils.dart';
import 'package:finance_tracker/utils/number_utils.dart';
import 'package:finance_tracker/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:finance_tracker/widgets/scroll_button_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:finance_tracker/widgets/doughnut_chart.dart';
import 'dart:convert';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen>
    with TickerProviderStateMixin {
  String selected = '2025-07';
  late final TabController _tabController;
  late Map<String, dynamic> mockData;
  List<IncomItem> incomeList = [];
  List<IncomItem> outcomeList = [];
  List<String> labels = [];

  Future<void> loadMockData(BuildContext context) async {
    final String response = await DefaultAssetBundle.of(
      context,
    ).loadString('mocks/reports.json');
    mockData = jsonDecode(response);
    labels = mockData.keys.toList(); // ví dụ: ['1/2025', '2/2025', ...]
  }

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
        color: tagColor,
      );
    }).toList();

    return result;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Income, Outcome
    loadMockData(context).then((_) {
      setState(() {
        updateListsForMonth('2025-07'); // hoặc tháng hiện tại
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void updateListsForMonth(String selectedMonth) {
    final incomeJson = mockData[selectedMonth]['income'] as List<dynamic>;
    final outcomeJson = mockData[selectedMonth]['outcome'] as List<dynamic>;

    incomeList = incomeJson.map((e) => IncomItem.fromJson(e)).toList();
    outcomeList = outcomeJson.map((e) => IncomItem.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Reports'),
      body: Column(
        children: [
          // ✅ Scrollable Button Bar
          ScrollableButtonBar(
            labels: [
              '2025-01',
              '2025-02',
              '2025-03',
              '2025-04',
              '2025-05',
              '2025-06',
              '2025-07',
              '2025-08',
              '2025-09',
              '2025-10',
              '2025-11',
              '2025-12',
            ],
            selected: selected,
            onPressed: (label) => setState(() {
              selected = label;
              updateListsForMonth(selected);
            }),
          ),

          // ✅ TabBar container
          Container(
            margin: const EdgeInsets.only(top: 8, right: 16, left: 16),
            // padding: const EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(14)),
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
                boxShadow: [boxShadowCommon()],
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
                    child: Text('Expenses'),
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
                bottom: 16,
              ),
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(color: Colors.grey[100]),
              child: TabBarView(
                controller: _tabController,
                children: [
                  // ✅ Tab 1 có scroll nếu content dài
                  Column(
                    children: [
                      // 🎯 Biểu đồ cố định chiều cao
                      SizedBox(
                        height: 300,
                        child: DoughnutChart(
                          series: generateChartData(incomeList),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 8),
                          const Text(
                            'History',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: SingleChildScrollView(
                          child: _listItems(context, incomeList),
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      // 🎯 Biểu đồ cố định chiều cao
                      SizedBox(
                        height: 300,
                        child: DoughnutChart(
                          series: generateChartData(outcomeList),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 8),
                          const Text(
                            'History',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: SingleChildScrollView(
                          child: _listItems(context, outcomeList),
                        ),
                      ),
                    ],
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            margin: const EdgeInsets.only(top: 0, bottom: 8, right: 2, left: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [boxShadowCommon()],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item.tag,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          formatCurrency(item.amount),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          formatDateToMonthDay(item.date),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class IncomItem {
  final String title;
  final String tag;
  final double amount;
  final String date;

  IncomItem(this.title, this.tag, this.amount, this.date);

  factory IncomItem.fromJson(Map<String, dynamic> json) {
    return IncomItem(
      json['title'] as String,
      json['tag'] as String,
      json['amount'] as double,
      json['date'] as String,
    );
  }
}
