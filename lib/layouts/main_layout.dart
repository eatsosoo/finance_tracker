import 'package:finance_tracker/screens/home_screen.dart';
import 'package:finance_tracker/screens/page/notification_screen.dart';
import 'package:finance_tracker/screens/page/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final uri = GoRouterState.of(context).uri.toString(); // ✅ Lấy từ GoRouterState

    int currentIndex = 0;
    if (uri.contains('second')) {
      currentIndex = 1;
    } else if (uri.contains('notifications')) {
      currentIndex = 2;
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        height: 65.0,
        items: <Widget>[
          Icon(Iconsax.home_25, size: currentIndex == 0 ? 26 : 18, color: Colors.white),
          Icon(Iconsax.document_favorite5, size: currentIndex == 1 ? 26 : 18, color: Colors.white),
          Icon(Iconsax.notification5, size: currentIndex == 2 ? 26 : 18, color: Colors.white),
        ],
        color: Colors.black,
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/second');
              break;
            case 2:
              context.go('/notifications');
              break;
          }
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}


