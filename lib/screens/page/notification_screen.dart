import 'package:finance_tracker/utils/date_utils.dart';
import 'package:finance_tracker/widgets/app_bottom_sheet.dart';
import 'package:finance_tracker/widgets/leading_common.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:finance_tracker/widgets/drag_handle.dart';
import 'package:go_router/go_router.dart';
import 'package:finance_tracker/widgets/filter_option.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String filter = 'all'; // all, read, unread

  final List<NotificationItem> allNotifications = [
    NotificationItem(
      title: '🍕 Pizza',
      dueDate: '14 Jun 2025 7:00 PM',
      date: DateTime(2025, 6, 14, 19),
      isRead: true,
    ),
    NotificationItem(
      title: '🛒 Mua dầu gội Clear',
      dueDate: '12 Jun 2025 5:00 PM',
      date: DateTime(2025, 6, 12, 17),
      isRead: false,
    ),
    NotificationItem(
      title: '🍿 Xem phim Lilo & stitch với con em',
      dueDate: '11 Jun 2025 7:00 PM',
      date: DateTime(2025, 6, 11, 19),
      isRead: false,
    ),
    NotificationItem(
      title: '🌕 Chiêm ngưỡng Trăng Dâu (Strawberry Moon)',
      dueDate: '11 Jun 2025 6:00 PM–7:00 PM',
      date: DateTime(2025, 6, 11, 18),
      isRead: true,
    ),
  ];

  final List<Map<String, dynamic>> filterOptions = [
    {'icon': Icons.email_outlined, 'title': 'Unread and read', 'value': 'all'},
    {
      'icon': Icons.mark_email_unread_outlined,
      'title': 'Unread',
      'value': 'unread',
    },
    {'icon': Icons.mark_email_read_outlined, 'title': 'Read', 'value': 'read'},
  ];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final filtered = allNotifications.where((n) {
      if (filter == 'read') return n.isRead;
      if (filter == 'unread') return !n.isRead;
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inbox',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.sort),
            onPressed: _showFilterOptions,
          ),
        ],
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        leadingWidth: 70,
        leading: LeadingCommon(),
      ),
      body: ListView.separated(
        itemCount: filtered.length,
        separatorBuilder: (_, __) =>
            Divider(color: Colors.grey[100], height: 1),
        itemBuilder: (context, index) {
          final item = filtered[index];
          final daysAgo = timeAgo(item.date);
          return Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 6),
                    child: CircleAvatar(
                      backgroundColor: Colors.red.shade700,
                      radius: 12,
                      child: Icon(
                        Icons.access_alarm,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(text: 'You have a reminder in '),
                              TextSpan(
                                text: item.title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Due date',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          '@${item.dueDate}',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    daysAgo,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showFilterOptions() {
    AppBottomSheet.show(
      context: context,
      title: 'Filters',
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            ...filterOptions.map((option) {
              final index = filterOptions.indexOf(option);
              return Column(
                children: [
                  buildFilterOption(
                    context,
                    icon: option['icon'],
                    title: option['title'],
                    value: option['value'],
                    currentFilter: filter,
                    onTap: () {
                      setState(() => filter = option['value']);
                      Navigator.pop(context);
                    },
                  ),
                  if (index !=
                      filterOptions.length -
                          1) // Không thêm Divider sau option cuối
                    Divider(height: 1, color: Colors.grey[100]),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String dueDate;
  final DateTime date;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.dueDate,
    required this.date,
    this.isRead = false,
  });
}
