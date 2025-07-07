// home_screen.dart
import 'package:finance_tracker/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Welcome',
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/second'),
          child: const Text('Đi đến màn hình thứ hai'),
        ),
      ),
    );
  }
}
