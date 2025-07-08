import 'package:flutter/material.dart';

Widget buildDragHandle() {
  return Center(
    child: Container(
      margin: const EdgeInsets.only(top: 0, bottom: 12),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  );
}