import 'package:finance_tracker/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.sort),
            onPressed: _showFilterOptions,
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      backgroundColor: Colors.white,
      body: ListView.separated(
        itemCount: filtered.length,
        separatorBuilder: (_, __) =>
            Divider(color: Colors.grey[100], height: 1),
        itemBuilder: (context, index) {
          final item = filtered[index];
          final daysAgo = timeAgo(item.date);
          return Padding(
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
                      Text('@${item.dueDate}', style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${daysAgo}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[100],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Tiêu đề "Filter"
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  'Filters',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.email_outlined),
                      title: const Text(
                        'Unread and read',
                        style: TextStyle(fontSize: 14),
                      ),
                      onTap: () {
                        setState(() => filter = 'all');
                        Navigator.pop(context);
                      },
                      trailing: filter == 'all' ? const Icon(Icons.check) : null,
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    ListTile(
                      leading: const Icon(Icons.mark_email_unread_outlined),
                      title: const Text(
                        'Unread',
                        style: TextStyle(fontSize: 14),
                      ),
                      onTap: () {
                        setState(() => filter = 'unread');
                        Navigator.pop(context);
                      },
                      trailing: filter == 'unread' ? const Icon(Icons.check) : null,
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    ListTile(
                      leading: const Icon(Icons.mark_email_read_outlined),
                      title: const Text('Read', style: TextStyle(fontSize: 14)),
                      onTap: () {
                        setState(() => filter = 'read');
                        Navigator.pop(context);
                      },
                      trailing: filter == 'read' ? const Icon(Icons.check) : null,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12,)
            ],
          ),
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
