import 'package:finance_tracker/layouts/main_layout.dart';
import 'package:finance_tracker/screens/home_screen.dart';
import 'package:finance_tracker/screens/page/notification_screen.dart';
import 'package:finance_tracker/screens/page/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/auth/login_screen.dart';
// import 'screens/dashboard/dashboard_screen.dart'; // thêm sau

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) =>
              const HomeScreen(), // Sửa thành DashboardScreen sau
        ),
        GoRoute(
          path: '/second',
          builder: (context, state) => const SecondScreen(),
        ),
        GoRoute(
          path: '/notifications',
          builder: (context, state) => const NotificationScreen(),
        ),
      ],
    ),
  ],
);
