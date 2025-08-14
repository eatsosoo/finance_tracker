import 'package:finance_tracker/types/chart.dart';
import 'package:finance_tracker/utils/color_utils.dart';
import 'package:finance_tracker/utils/number_utils.dart';
import 'package:finance_tracker/widgets/custom_app_bar.dart';
import 'package:finance_tracker/widgets/month_selector.dart';
import 'package:finance_tracker/widgets/spline_chart.dart';
import 'package:finance_tracker/widgets/cards_swiper.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _shouldPlayAnimation = false;
  late Map<String, dynamic> mockData = {};
  List<Color> _colors = [];
  String selected = '6 months';

  final List<AccountCard> cards = [
    AccountCard(title: 'Vietinbank', amount: 500000),
    AccountCard(title: 'ACB Bank', amount: 5000000),
    AccountCard(title: 'Bonus', amount: 50000000),
    AccountCard(title: 'Bonus', amount: 50000000),
    AccountCard(title: 'Bonus', amount: 50000000),
    AccountCard(title: 'Bonus', amount: 50000000),
    AccountCard(title: 'Bonus', amount: 50000000),
  ];

  final data1 = [
    ChartData('Jan', 30000000),
    ChartData('Feb', 42000000),
    ChartData('Mar', 20000000),
    ChartData('Apr', 50000000),
    ChartData('May', 50000000),
    ChartData('Jun', 50000000),
    ChartData('Jul', 50000000),
    ChartData('Aug', 10000000),
    ChartData('Sep', 60000000),
    ChartData('Oct', 80000000),
    ChartData('Nov', 10000000),
  ];

  final data2 = [
    ChartData('Jan', 30000000),
    ChartData('Feb', 52000000),
    ChartData('Mar', 20000000),
    ChartData('Apr', 50000000),
    ChartData('May', 50000000),
    ChartData('Jun', 100000000),
    ChartData('Jul', 50000000),
    ChartData('Aug', 10000000),
    ChartData('Sep', 50000000),
    ChartData('Oct', 50000000),
    ChartData('Nov', 50000000),
  ];

  final averageIncome = AverageCard(
    title: 'Average Income',
    amount: 50000000,
    rate: 50,
  );
  final averageExpense = AverageCard(
    title: 'Average Expense',
    amount: 1000000,
    rate: -10.5,
  );

  List<ChartSampleData> generateChartData(Map<String, dynamic> jsonData) {
    final List<ChartSampleData> result = [];

    jsonData.forEach((tag, months) {
      (months as Map<String, dynamic>).forEach((month, amount) {
        result.add(ChartSampleData(tag: tag, amount: amount, text: month));
      });
    });

    return result;
  }

  Future<void> loadMockData(BuildContext context) async {
    final String response = await DefaultAssetBundle.of(
      context,
    ).loadString('mocks/accounts.json');
    mockData = jsonDecode(response);
  }

  @override
  void initState() {
    super.initState();
    _colors = blackToRedPalette(
      count: cards.length,
      leftColor: Colors.black,
      rightColor: Colors.grey,
    );
    loadMockData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Accounts'),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       _shouldPlayAnimation = !_shouldPlayAnimation;
      //     });
      //   },
      //   child: Icon(_shouldPlayAnimation ? Icons.pause : Icons.play_arrow),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardsSwiperWidget(
                  onCardCollectionAnimationComplete: (value) {
                    setState(() {
                      _shouldPlayAnimation = value;
                    });
                  },
                  shouldStartCardCollectionAnimation: _shouldPlayAnimation,
                  cardData: cards,
                  animationDuration: const Duration(milliseconds: 600),
                  downDragDuration: const Duration(milliseconds: 200),
                  onCardChange: (index) {},
                  cardBuilder: (context, index, visibleIndex) {
                    if (index < 0 || index >= cards.length) {
                      return const SizedBox.shrink();
                    }
                    final card = cards[index];
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                            final bool isIncoming =
                                child.key == ValueKey<int>(visibleIndex);

                            if (isIncoming) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            } else {
                              return child;
                            }
                          },
                      child: Container(
                        key: ValueKey<int>(visibleIndex),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: buildGradient(_colors[index]),
                          boxShadow: [boxShadowCommon()],
                        ),
                        width: 350,
                        height: 200,
                        // alignment: Alignment.center,
                        child: _buildCard(card),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildMetricBlock(context),
                  const SizedBox(height: 16),
                  _buildSavingBlock(context),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildCard(AccountCard item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          item.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            shadows: [shadowCommon()],
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 8),
        Text(
          formatCurrency(item.amount),
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [shadowCommon(baseColor: Colors.black38)],
          ),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  Widget _buildAverage(AverageCard item, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatNumberShort(item.amount),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Icon(
                    item.rate < 0 ? LucideIcons.moveDown : LucideIcons.moveUp,
                    size: 14,
                    color: item.rate < 0 ? Colors.red : Colors.green,
                  ),
                  Text(
                    '${item.rate < 0 ? '' : '+'}${item.rate}%',
                    style: TextStyle(
                      fontSize: 12,
                      color: item.rate < 0 ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricBlock(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // boxShadow: [boxShadowCommon()],
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Data Metrics',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Income-Expense Insight Analyzer',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                OverlayMonthSelector(
                  selectedMonth: selected,
                  onChanged: (newMonth) {
                    setState(() {
                      selected = newMonth;
                    });
                  },
                  options: ['6 months', '12 months'],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: SplineChart(
              series: [data1, data2],
              palettes: [Colors.greenAccent, Colors.redAccent],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, bottom: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 8,
              children: [
                Expanded(child: _buildAverage(averageIncome, context)),
                Expanded(child: _buildAverage(averageExpense, context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavingBlock(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        // boxShadow: [boxShadowCommon()],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your saving',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                formatCurrency(100000000),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          Wrap(
            children: [
              Center(
                child: CircularPercentIndicator(
                  radius: 25, // bán kính vòng tròn
                  lineWidth: 5, // độ dày đường
                  percent: 0.75, // 75%
                  center: Icon(LucideIcons.gamepad),
                  progressColor: Theme.of(context).colorScheme.secondary,
                  backgroundColor: Colors.grey.shade300,
                  circularStrokeCap: CircularStrokeCap.round, // bo tròn đầu nét
                  animation: true, // bật animation
                  animationDuration: 800,
                ),
              ),
              const SizedBox(width: 8),
              Center(
                child: CircularPercentIndicator(
                  radius: 25, // bán kính vòng tròn
                  lineWidth: 5, // độ dày đường
                  percent: 0.5, // 75%
                  center: Icon(LucideIcons.car),
                  progressColor: Theme.of(context).colorScheme.secondary,
                  backgroundColor: Colors.grey.shade300,
                  circularStrokeCap: CircularStrokeCap.round, // bo tròn đầu nét
                  animation: true, // bật animation
                  animationDuration: 800,
                ),
              ),
              const SizedBox(width: 8),
              Center(
                child: CircularPercentIndicator(
                  radius: 25, // bán kính vòng tròn
                  lineWidth: 5, // độ dày đường
                  percent: 0.25, // 75%
                  center: Icon(LucideIcons.heartHandshake),
                  progressColor: Theme.of(context).colorScheme.secondary,
                  backgroundColor: Colors.grey.shade300,
                  circularStrokeCap: CircularStrokeCap.round, // bo tròn đầu nét
                  animation: true, // bật animation
                  animationDuration: 800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AccountCard {
  final String title;
  final double amount;

  AccountCard({required this.title, required this.amount});
}

class AverageCard {
  final String title;
  final double amount;
  final double rate;

  AverageCard({required this.title, required this.amount, required this.rate});
}
