import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finance_tracker/utils/date_utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final Widget? rightWidget;
  final String? avatarUrl;

  CustomAppBar({
    super.key,
    required this.title,
    String? subtitle,
    this.rightWidget,
    this.avatarUrl,
  }): subtitle = subtitle ?? getFormattedDate();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Column: Title + Subtitle
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Right-side widget (avatar, notification, etc.)
              if (rightWidget != null) rightWidget!,
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage('assets/illustrations/cool-girl-avatar.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
