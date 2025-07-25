import 'package:finance_tracker/layouts/main_layout.dart';
import 'package:finance_tracker/screens/auth/login_screen.dart';
import 'package:finance_tracker/screens/home_screen.dart';
import 'package:finance_tracker/screens/page/account_screen.dart';
import 'package:finance_tracker/screens/page/budget_screen.dart';
import 'package:finance_tracker/screens/page/new_page_screen.dart';
import 'package:finance_tracker/screens/page/notification_screen.dart';
import 'package:finance_tracker/screens/page/profile_screen.dart';
import 'package:finance_tracker/screens/page/reports_screen.dart';
import 'package:finance_tracker/screens/page/add_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/new', builder: (context, state) => const NewItemScreen()),
    GoRoute(
      path: '/new_transaction',
      builder: (context, state) => const AddTransactionScreen(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) =>
              const HomeScreen(), // Sửa thành DashboardScreen sau
        ),

        GoRoute(
          path: '/budget',
          builder: (context, state) => const BudgetScreen(),
        ),
        GoRoute(
          path: '/account',
          builder: (context, state) => const AccountScreen(),
        ),
        GoRoute(
          path: '/reports',
          builder: (context, state) => const ReportScreen(),
        ),
      ],
    ),
  ],
);
