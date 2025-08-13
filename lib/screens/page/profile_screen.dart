import 'package:finance_tracker/providers/theme_provider.dart';
import 'package:finance_tracker/utils/color_utils.dart';
import 'package:finance_tracker/utils/number_utils.dart';
import 'package:finance_tracker/widgets/leading_common.dart';
import 'package:finance_tracker/widgets/show_bottom_options.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String themeSelected = '0';
  final List<Map<String, String>> themeOptions = [
    {'title': 'Light', 'value': '0'},
    {'title': 'Dark', 'value': '1'},
    {'title': 'System', 'value': '2'},
  ];



  @override
  Widget build(BuildContext context) {
    final Color blockColor = Theme.of(context).colorScheme.surface;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: LeadingCommon(),
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
              // boxShadow: [boxShadowCommon()],
            ),
            child: Column(
              children: [
                _buildProfileTile(
                  icon: LucideIcons.mail,
                  label: 'Email',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildProfileTile(
                  icon: LucideIcons.squareUser,
                  label: 'Username',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildProfileTile(
                  icon: LucideIcons.activity,
                  label: 'Step data source',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildProfileTile(
                  icon: LucideIcons.languages,
                  label: 'Language',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildProfileTile(
                  icon: LucideIcons.shieldCheck,
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
              // boxShadow: [boxShadowCommon()],
            ),
            child: Row(
              children: [
                const Icon(LucideIcons.crown, color: Color(0xFF3D5AFE)),
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
                const Icon(
                  LucideIcons.chevronRight,
                  color: Colors.orange,
                  size: 18,
                ),
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
              // boxShadow: [boxShadowCommon()],
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              LucideIcons.gift,
                              size: 16,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '50 /referral',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Right: (Pandas or suitable placeholder)
                SvgPicture.asset(
                  'assets/illustrations/undraw_pizza-sharing.svg',
                  width: 70,
                  height: 70,
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
              // boxShadow: [boxShadowCommon()],
            ),
            child: Column(
              children: [
                _buildProfileTile(
                  icon: LucideIcons.box,
                  label: 'App Icon',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildProfileTile(
                  icon: LucideIcons.layoutGrid,
                  label: 'Widget',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildProfileTile(
                  icon: LucideIcons.sun,
                  label: '${findTitleMapOptions(themeOptions, themeSelected)} Mode',
                  onTap: () => _selectTheme(themeProvider),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() => Divider(
    height: 1,
    thickness: 1,
    // indent: 16,
    // endIndent: 16,
  );

  Widget _buildProfileTile({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 18),
      title: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
      ),
      trailing: const Icon(LucideIcons.chevronRight, size: 18),
      onTap: onTap,
      contentPadding: const EdgeInsets.only(left: 16, right: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    );
  }

  void _selectTheme(ThemeProvider theme) {
    showBottomOptions(
      context: context,
      title: 'Theme select',
      filterOptions: themeOptions,
      currentFilter: themeSelected,
      onSelected: (value) {
        setState(() {
          themeSelected = value;
        });
        theme.toggleTheme(value);
      },
    );
  }
}
