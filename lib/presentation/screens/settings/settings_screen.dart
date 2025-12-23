import 'package:chat_hub/config/provider/theme_provider.dart';
import 'package:chat_hub/presentation/screens/app_and_updates/about_app_screen.dart';
import 'package:chat_hub/presentation/screens/app_and_updates/check_for_updates.dart';
import 'package:chat_hub/presentation/screens/auth/login_screen.dart';
import 'package:chat_hub/presentation/screens/delete_account/delete_account_screen.dart';
import 'package:chat_hub/presentation/screens/legal_policies/data_policy_screen.dart';
import 'package:chat_hub/presentation/screens/legal_policies/privacy_policy_screen.dart';
import 'package:chat_hub/presentation/screens/legal_policies/terms_of_service_screen.dart';
import 'package:chat_hub/presentation/screens/notifications/in_app_sound.dart';
import 'package:chat_hub/presentation/screens/notifications/push_notifications_screen.dart';
import 'package:chat_hub/presentation/screens/password_security/password_security_screen.dart';
import 'package:chat_hub/presentation/screens/photo_and_media/media_auto_download_screen.dart';
import 'package:chat_hub/presentation/screens/photo_and_media/upload_quality_screen.dart';
import 'package:chat_hub/presentation/screens/profile/profile_screen.dart';
import 'package:chat_hub/presentation/screens/support/help_faq_screen.dart';
import 'package:chat_hub/presentation/screens/support/reporta_problem_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final currentMode = themeProvider.themeMode;

    return Scaffold(
      backgroundColor: Theme.of(
        context,
      ).scaffoldBackgroundColor, // iOS grey background
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Colors.white,
        titleSpacing: 16,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.only(top: 60, bottom: 30),
        children: [
          // Appearance
          SettingsCard(
            title: "Appearance",
            child: Column(
              children: [
                SettingsRadioTile<ThemeMode>(
                  icon: CupertinoIcons.sun_max,
                  title: "Light",
                  value: ThemeMode.light,
                  groupValue: currentMode,
                  onChanged: (mode) {
                    if (mode != null) themeProvider.toggleTheme(false);
                  },
                ),
                const SizedBox(height: 8),
                SettingsRadioTile<ThemeMode>(
                  icon: CupertinoIcons.moon,
                  title: "Dark",
                  value: ThemeMode.dark,
                  groupValue: currentMode,
                  onChanged: (mode) {
                    if (mode != null) themeProvider.toggleTheme(true);
                  },
                ),
                const SizedBox(height: 8),
                SettingsRadioTile<ThemeMode>(
                  icon: CupertinoIcons.device_phone_portrait,
                  title: "System Default",
                  value: ThemeMode.system,
                  groupValue: currentMode,
                  onChanged: (mode) {
                    if (mode != null) themeProvider.setSystemMode();
                  },
                ),
              ],
            ),
          ),

          // Account
          SettingsCard(
            title: "Account",
            child: Column(
              children: [
                SettingsTile(
                  icon: CupertinoIcons.person,
                  iconColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  title: "Personal Details",
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (_) => const ProfileScreen()),
                    );
                  },
                ),
                const SizedBox(height: 8),
                SettingsTile(
                  icon: CupertinoIcons.lock,
                  iconColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  title: "Password & Security",
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const PasswordSecurityScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 8),
                SettingsTile(
                  icon: CupertinoIcons.delete,
                  title: "Delete Account",
                  iconColor: Colors.red,
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const DeleteAccountScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Notifications
          SettingsCard(
            title: "Notifications & Sounds",
            child: Column(
              children: [
                SettingsTile(
                  icon: CupertinoIcons.bell,
                  iconColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  title: "Push Notifications",
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const PushNotificationsScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                SettingsTile(
                  icon: CupertinoIcons.volume_up,
                  iconColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  title: "In-App Sounds",
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const NotificationSoundScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Media
          SettingsCard(
            title: "Photos & Media",
            child: Column(
              children: [
                SettingsTile(
                  icon: CupertinoIcons.photo,
                  iconColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  title: "Media Auto-Download",
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const MediaAutoDownloadScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                SettingsTile(
                  icon: CupertinoIcons.cloud_upload,
                  iconColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  title: "Upload Quality",
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const UploadQualityScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Updates
          SettingsCard(
            title: "App & Updates",
            child: Column(
              children: [
                SettingsTile(
                  icon: CupertinoIcons.info,
                  iconColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  title: "About app",
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const AboutAppScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                SettingsTile(
                  icon: CupertinoIcons.arrow_clockwise,
                  iconColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  title: "Check for Updates",
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const CheckForUpdatesScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                SettingsTile(
                  icon: CupertinoIcons.person_2,
                  iconColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  title: "Switch Account",
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                ),
              ],
            ),
          ),

          // Support
          SettingsCard(
            title: "Support",
            child: Column(
              children: [
                SettingsTile(
                  icon: CupertinoIcons.exclamationmark_bubble,
                  iconColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  title: "Report a Problem",
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const ReportProblemScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                SettingsTile(
                  icon: CupertinoIcons.question_circle,
                  iconColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  title: "Help & FAQ",
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (_) => const HelpFaqScreen()),
                    );
                  },
                ),
              ],
            ),
          ),

          // Legal
          SettingsCard(
            title: "Legal & Policies",
            child: Column(
              children: [
                SettingsTile(
                  icon: CupertinoIcons.doc_text,
                  iconColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  title: "Terms of Service",
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const TermsOfServiceScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                SettingsTile(
                  icon: CupertinoIcons.lock_shield,
                  iconColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  title: "Privacy Policy",
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const PrivacyPolicyScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                SettingsTile(
                  icon: CupertinoIcons.shield_lefthalf_fill,
                  iconColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  title: "Data Policy",
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const DataPolicyScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// iOS Styled Cards & Tiles
// ======================================================

class SettingsCard extends StatelessWidget {
  final String title;
  final Widget child;

  const SettingsCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withOpacity(0.7), // dynamic text color
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.shadow,
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final VoidCallback onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(12), // <-- circular corners
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor ?? Theme.of(context).primaryColor,
                size: 22,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
              const Spacer(),
              Icon(
                CupertinoIcons.chevron_forward,
                size: 18,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsRadioTile<T> extends StatelessWidget {
  final IconData icon;
  final String title;
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;

  const SettingsRadioTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => onChanged(value),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary, // secondary card color
          borderRadius: BorderRadius.circular(12), // <-- circular corners
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: Theme.of(
                context,
              ).colorScheme.primary, // dynamic primary color
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge, // dynamic text color
            ),
            const Spacer(),
            if (value == groupValue)
              Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: Theme.of(
                  context,
                ).colorScheme.primary, // dynamic primary color
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}
