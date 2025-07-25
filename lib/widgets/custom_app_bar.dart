import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finance_tracker/utils/date_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final Widget? rightWidget;
  final String? avatarUrl;
  final Color? backgroundColor;

  CustomAppBar({
    super.key,
    required this.title,
    String? subtitle,
    this.rightWidget,
    this.avatarUrl,
    this.backgroundColor = Colors.transparent,
  }) : subtitle = subtitle ?? getFormattedDate();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: backgroundColor,
      flexibleSpace: Container(
        color: backgroundColor,
        child: SafeArea(
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

                // Right-side widget (notification button + avatar)
                if (rightWidget != null) rightWidget!,

                // Notification button (circle)
                // Notification button (with badge)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      context.push('/notifications');
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Nút hình tròn nền xám
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Iconsax.notification5,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),

                        // Badge đỏ ở góc phải
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              // border: Border.all(color: Colors.white, width: 1.5),
                            ),
                            child: const Center(
                              child: Text(
                                '3', // <-- Số thông báo chưa đọc
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Avatar
                GestureDetector(
                  onTap: () {
                    context.push('/profile');
                  },
                  child: Container(
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
                    child: avatarUrl != null
                        ? CircleAvatar(
                            radius: 22,
                            backgroundImage: AssetImage(
                              avatarUrl!, // bạn có thể sửa logic để load SVG ở đây nếu muốn
                            ),
                          )
                        : SvgPicture.asset(
                            'assets/illustrations/cool-girl-avatar.svg',
                            width: 40,
                            height: 40,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
