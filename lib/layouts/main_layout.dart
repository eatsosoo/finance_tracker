import 'package:finance_tracker/screens/home_screen.dart';
import 'package:finance_tracker/screens/page/notification_screen.dart';
import 'package:finance_tracker/screens/page/add_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final uri = GoRouterState.of(
      context,
    ).uri.toString(); // ✅ Lấy từ GoRouterState

    int currentIndex = 0;
    if (uri.contains('budget')) {
      currentIndex = 1;
    } else if (uri.contains('new_transaction')) {
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
          Icon(
            LucideIcons.house,
            size: currentIndex == 0 ? 24 : 18,
            // color: Colors.black,
          ),
          Icon(
            LucideIcons.wallet,
            size: currentIndex == 1 ? 24 : 18,
            // color: Colors.black,
          ),
          Icon(
            LucideIcons.squarePlus,
            size: currentIndex == 2 ? 24 : 18,
            // color: Colors.black,
          ),
          Icon(
            LucideIcons.walletCards,
            size: currentIndex == 3 ? 24 : 18,
            // color: Colors.black,
          ),
          Icon(LucideIcons.chartPie, size: currentIndex == 4 ? 24 : 18),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
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
              context.go('/new_transaction');
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
