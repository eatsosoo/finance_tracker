import 'package:finance_tracker/types/chart.dart';
import 'package:finance_tracker/utils/color_utils.dart';
import 'package:finance_tracker/utils/number_utils.dart';
import 'package:finance_tracker/widgets/custom_app_bar.dart';
import 'package:finance_tracker/widgets/spline_chart.dart';
import 'package:finance_tracker/widgets/cards_swiper.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'dart:convert';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _shouldPlayAnimation = false;
  late Map<String, dynamic> mockData = {};
  List _colors = [];

  final List<AccountCard> cards = [
    AccountCard(title: 'Vietinbank', amount: 500000),
    AccountCard(title: 'ACB Bank', amount: 5000000),
    AccountCard(title: 'Bonus', amount: 50000000),
    AccountCard(title: 'Bonus', amount: 50000000),
    AccountCard(title: 'Bonus', amount: 50000000),
    AccountCard(title: 'Bonus', amount: 50000000),
    AccountCard(title: 'Bonus', amount: 50000000),
  ];

  final data = [
    ChartData('Jan', 30),
    ChartData('Feb', 42),
    ChartData('Mar', 20),
    ChartData('Apr', 50),
    ChartData('May', 50),
    ChartData('Jun', 50),
    ChartData('Jul', 50),
    ChartData('Aug', 10),
    ChartData('Sep', 60),
    ChartData('Oct', 80),
    ChartData('Nov', 100),
  ];

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
      rightColor: Colors.blueGrey,
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
          const SizedBox(height: 48),
          Row(
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
          Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [boxShadowCommon()],
              color: Colors.white
            ),
            child: SplineChart(data: data, title: 'Chi tiêu theo tháng'),
          )
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
          ),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}

class AccountCard {
  final String title;
  final double amount;

  AccountCard({required this.title, required this.amount});
}
