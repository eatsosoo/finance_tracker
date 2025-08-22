import 'package:finance_tracker/generated/l10n.dart';
import 'package:finance_tracker/providers/locale_provider.dart';
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

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String? themeSelected;
  String? languageSelected;

  @override
void initState() {
  super.initState();
  // Delay để đảm bảo context đã sẵn sàng
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    setState(() {
      themeSelected = themeProvider.themeText;
      languageSelected = localeProvider.lang;
    });
  });
}

  @override
  Widget build(BuildContext context) {
    final Color blockColor = Theme.of(context).colorScheme.surface;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    final s = S.of(context)!;
    final List<Map<String, String>> themeOptions = [
      {'title': s.setting_light_mode, 'value': 'light'},
      {'title': s.setting_dark_mode, 'value': 'dark'},
      {'title': s.setting_system_mode, 'value': 'system'},
    ];
    final List<Map<String, String>> languageOptions = [
      {'title': 'Việt Nam', 'value': 'vi'},
      {'title': 'English', 'value': 'en'},
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: LeadingCommon(),
        centerTitle: true,
        title: Text(
          s.setting_title,
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
                _buildSettingTile(
                  icon: LucideIcons.mail,
                  label: 'Email',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildSettingTile(
                  icon: LucideIcons.squareUser,
                  label: s.setting_profile,
                  onTap: () {},
                ),
                _buildDivider(),
                _buildSettingTile(
                  icon: LucideIcons.languages,
                  label: s.setting_language,
                  onTap: () => _selectLanguage(localeProvider, languageOptions),
                ),
                _buildDivider(),
                _buildSettingTile(
                  icon: LucideIcons.shieldCheck,
                  label: s.setting_privacy,
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
                  s.common_inactive,
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
                _buildSettingTile(
                  icon: LucideIcons.sun,
                  label: findTitleMapOptions(themeOptions, themeSelected ?? ''),
                  onTap: () => _selectTheme(themeProvider, themeOptions),
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

  Widget _buildSettingTile({
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

  void _selectTheme(ThemeProvider theme, List<Map<String, String>> options) {
    showBottomOptions(
      context: context,
      title: S.of(context)!.setting_theme,
      filterOptions: options,
      currentFilter: themeSelected!,
      onSelected: (value) {
        setState(() {
          themeSelected = value;
        });
        theme.toggleTheme(value);
      },
    );
  }

  void _selectLanguage(LocaleProvider provider, List<Map<String, String>> options) {
    showBottomOptions(
      context: context,
      title: S.of(context)!.setting_language,
      filterOptions: options,
      currentFilter: languageSelected!,
      onSelected: (value) {
        setState(() {
          languageSelected = value;
        });
        provider.toggleLanguage(value);
      },
    );
  }
}
