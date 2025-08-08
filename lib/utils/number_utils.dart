import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatCurrency(num amount, {String suffix = '₫'}) {
  final formatter = NumberFormat('#,###', 'vi_VN');
  return '${formatter.format(amount)} $suffix';
}

String formatNumberShort(num number) {
  if (number >= 1e9) {
    return (number / 1e9).toStringAsFixed(number % 1e9 == 0 ? 0 : 1) + 'B';
  } else if (number >= 1e6) {
    return (number / 1e6).toStringAsFixed(number % 1e6 == 0 ? 0 : 1) + 'M';
  } else if (number >= 1e3) {
    return (number / 1e3).toStringAsFixed(number % 1e3 == 0 ? 0 : 1) + 'K';
  } else {
    return number.toString();
  }
}

Future<Map<String, dynamic>> loadMockData(
  BuildContext context,
  String path,
) async {
  try {
    final response = await DefaultAssetBundle.of(context).loadString(path);
    final data = jsonDecode(response);
    if (data is Map<String, dynamic>) {
      return data;
    } else {
      throw Exception('JSON root is not a Map<String, dynamic>');
    }
  } catch (e, stack) {
    debugPrint('Error loading mock data from $path: $e');
    debugPrintStack(stackTrace: stack);
    rethrow;
  }
}
