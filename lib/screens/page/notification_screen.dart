import 'package:finance_tracker/utils/date_utils.dart';
import 'package:finance_tracker/widgets/app_bottom_sheet.dart';
import 'package:finance_tracker/widgets/leading_common.dart';
import 'package:finance_tracker/widgets/show_bottom_options.dart';
import 'package:flutter/material.dart';
import 'package:finance_tracker/widgets/drag_handle.dart';
import 'package:go_router/go_router.dart';
import 'package:finance_tracker/widgets/filter_option.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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
      dueDate: '11 Jun 2025 6:00 PM',
      date: DateTime(2025, 6, 11, 18),
      isRead: true,
    ),
  ];

  final List<Map<String, dynamic>> filterOptions = [
    {'icon': LucideIcons.mail, 'title': 'Unread and read', 'value': 'all'},
    {'icon': LucideIcons.mailWarning, 'title': 'Unread', 'value': 'unread'},
    {'icon': LucideIcons.mailCheck, 'title': 'Read', 'value': 'read'},
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = allNotifications.where((n) {
      if (filter == 'read') return n.isRead;
      if (filter == 'unread') return !n.isRead;
      return true;
    }).toList();

    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Inbox',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              LucideIcons.listFilter,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            onPressed: _showFilterOptions,
          ),
        ],
        elevation: 0,
        leading: LeadingCommon(),
      ),
      body: ListView.builder(
        itemCount: filtered.length,

        itemBuilder: (context, index) {
          final item = filtered[index];
          final daysAgo = timeAgo(item.date);
          return Container(
            margin: EdgeInsets.only(right: 16, left: 16, bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    child: CircleAvatar(
                      backgroundColor: Colors.red.shade700,
                      radius: 12,
                      child: Icon(
                        LucideIcons.alarmClock,
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
                              TextSpan(
                                text: item.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(item.dueDate, style: TextStyle(fontSize: 13)),
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
    showBottomOptions(
      context: context,
      title: 'Filters',
      filterOptions: filterOptions,
      currentFilter: filter,
      onSelected: (value) {
        setState(() => filter = value);
      },
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
