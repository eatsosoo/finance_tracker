import 'package:finance_tracker/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color blockColor = Colors.white;
    final Color bgColor = const Color(0xFFF6F6F6);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.black),
          onPressed: () {
            context.canPop() ? context.pop() : context.go('/home');
          },
        ),
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Block 1: Account
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: blockColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [shadowCommon()]
            ),
            child: Column(
              children: [
                _buildProfileTile(
                  icon: Iconsax.sms,
                  label: 'Email',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildProfileTile(
                  icon: Iconsax.profile_circle,
                  label: 'Username',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildProfileTile(
                  icon: Iconsax.activity,
                  label: 'Step data source',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildProfileTile(
                  icon: Iconsax.language_square,
                  label: 'Language',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildProfileTile(
                  icon: Iconsax.shield_tick,
                  label: 'Privacy',
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Block 2: Premium status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: blockColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Iconsax.crown, color: Color(0xFF3D5AFE)),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Premium Status',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  'Inactive',
                  style: TextStyle(
                    color: Colors.orange.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Iconsax.arrow_right_3, color: Colors.orange, size: 18),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Block 3: Refer a friend (custom orange card)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFF8A34), // Orange
              borderRadius: BorderRadius.circular(16),
              boxShadow: [shadowCommon()]
            ),
            child: Row(
              children: [
                // Left: Text & badge
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Refer a friend',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Iconsax.gift, size: 16, color: Colors.white),
                            SizedBox(width: 4),
                            Text(
                              '50 /referral',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Right: (Pandas or suitable placeholder)
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Image.asset(
                    'assets/images/panda_friends.png', // Bạn cần chuẩn bị hình này cho đúng, hoặc dùng placeholder
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Block 4: App Icon & Widget
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: blockColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [shadowCommon()]
            ),
            child: Column(
              children: [
                _buildProfileTile(
                  icon: Iconsax.d_cube_scan,
                  label: 'App Icon',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildProfileTile(
                  icon: Iconsax.element_3,
                  label: 'Widget',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() => Divider(
        color: Colors.grey[100],
        height: 1,
        thickness: 1,
        indent: 16,
        endIndent: 16,
      );

  Widget _buildProfileTile({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black, size: 22),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
      trailing: const Icon(Iconsax.arrow_right_3, color: Colors.grey, size: 18),
      onTap: onTap,
      tileColor: Colors.transparent,
      contentPadding: const EdgeInsets.only(left: 16, right: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    );
  }
}