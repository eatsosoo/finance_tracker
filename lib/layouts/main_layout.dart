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
    if (uri.contains('budget')) {
      currentIndex = 1;
    } else if (uri.contains('second')) {
      currentIndex = 2;
    } else if (uri.contains('account')) {
      currentIndex = 3;
    } else if (uri.contains('reports')) {
      currentIndex = 4;
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        height: 60.0,
        items: <Widget>[
          Icon(Iconsax.home_25, size: currentIndex == 0 ? 26 : 18, color: Colors.white),
          Icon(Iconsax.wallet_1, size: currentIndex == 1 ? 26 : 18, color: Colors.white),
          Icon(Iconsax.add5, size: currentIndex == 2 ? 26 : 18, color: Colors.white),
          Icon(Iconsax.card, size: currentIndex == 3 ? 26 : 18, color: Colors.white),
          Icon(Iconsax.document_favorite5, size: currentIndex == 4 ? 26 : 18, color: Colors.white),
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
              context.go('/budget');
              break;
            case 2:
              context.go('/second');
              break;
            case 3:
              context.go('/account');
              break;
            case 4:
              context.go('/reports');
              break;
          }
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}


