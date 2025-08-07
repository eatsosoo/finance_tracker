import 'package:flutter/material.dart';

class ChartSampleData {
  final String tag;
  final double amount;
  final String text;
  final Color? color;

  ChartSampleData({
    required this.tag,
    required this.amount,
    required this.text,
    this.color,
  });
}