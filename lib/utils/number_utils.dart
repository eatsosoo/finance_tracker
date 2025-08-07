import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatCurrency(num amount, {String suffix = '₫'}) {
  final formatter = NumberFormat('#,###', 'vi_VN');
  return '${formatter.format(amount)} $suffix';
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
