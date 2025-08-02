import 'package:finance_tracker/utils/color_utils.dart';
import 'package:finance_tracker/utils/number_utils.dart';
import 'package:finance_tracker/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:finance_tracker/widgets/cards_swiper.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _shouldPlayAnimation = false;
  final List<AccountCard> cards = [
    AccountCard(title: 'Vietinbank', amount: 500000),
    AccountCard(title: 'ACB Bank', amount: 5000000),
    AccountCard(title: 'Bonus', amount: 50000000),
    AccountCard(title: 'Bonus', amount: 50000000),
    AccountCard(title: 'Bonus', amount: 50000000),
    AccountCard(title: 'Bonus', amount: 50000000),
    AccountCard(title: 'Bonus', amount: 50000000),
  ];

  List _colors = [];

  @override
  void initState() {
    super.initState();
    _colors = blackToRedPalette(
      count: cards.length,
      leftColor: Colors.black,
      rightColor: Colors.blueGrey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Account'),
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
