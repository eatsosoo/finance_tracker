import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:finance_tracker/widgets/custom_app_bar.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final List<String> images = [
    '/images/abstract-bg-1.jpg',
    '/images/abstract-bg-2.jpg',
    '/images/abstract-bg-3.jpg',
    '/images/abstract-bg-1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Account'),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: CardSwiper(
              cardsCount: images.length,
              numberOfCardsDisplayed: 3,
              scale: 0.9,
              duration: const Duration(milliseconds: 300),
              maxAngle: 20,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              allowedSwipeDirection: const AllowedSwipeDirection.only(
                left: true,
                right: true,
              ),
              cardBuilder:
                  (context, index, percentThresholdX, percentThresholdY) {
                    return RepaintBoundary(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                          gaplessPlayback: true,
                          cacheWidth: 400, // tuỳ chỉnh phù hợp với thiết bị
                          cacheHeight: 225,
                        ),
                      ),
                    );
                  },
              onSwipe: (prevIndex, currentIndex, direction) {
                debugPrint("Swiped: $direction, now at $currentIndex");
                return true; // Cho phép swipe
              },
              onEnd: () {
                debugPrint("Finished all cards");
              },
            ),
          ),
        ],
      ),
    );
  }
}
