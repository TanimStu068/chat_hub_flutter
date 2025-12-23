import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PushNotificationsScreen extends StatefulWidget {
  const PushNotificationsScreen({super.key});

  @override
  State<PushNotificationsScreen> createState() =>
      _PushNotificationsScreenState();
}

class _PushNotificationsScreenState extends State<PushNotificationsScreen> {
  bool messages = true;
  bool calls = true;
  bool groupMessages = true;
  bool mentions = true;
  bool sound = true;
  bool vibration = true;
  bool appUpdates = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Push Notifications",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header Card
            Card(
              color: Theme.of(context).colorScheme.tertiary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.notifications_active_outlined,
                      size: 40,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      // color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Stay Updated",
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Manage how and when you receive notifications.",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: ListView(
                children: [
                  _SectionTitle(title: "Messages"),
                  _SwitchTile(
                    title: "Direct Messages",
                    subtitle: "Get notified when someone messages you",
                    value: messages,
                    onChanged: (v) => setState(() => messages = v),
                  ),
                  _SwitchTile(
                    title: "Group Messages",
                    subtitle: "Notifications from group chats",
                    value: groupMessages,
                    onChanged: (v) => setState(() => groupMessages = v),
                  ),
                  _SwitchTile(
                    title: "Mentions",
                    subtitle: "When someone mentions you",
                    value: mentions,
                    onChanged: (v) => setState(() => mentions = v),
                  ),

                  const SizedBox(height: 24),

                  _SectionTitle(title: "Calls"),
                  _SwitchTile(
                    title: "Incoming Calls",
                    subtitle: "Voice & video call alerts",
                    value: calls,
                    onChanged: (v) => setState(() => calls = v),
                  ),

                  const SizedBox(height: 24),

                  _SectionTitle(title: "Sound & Vibration"),
                  _SwitchTile(
                    title: "Notification Sound",
                    subtitle: "Play sound for notifications",
                    value: sound,
                    onChanged: (v) => setState(() => sound = v),
                  ),
                  _SwitchTile(
                    title: "Vibration",
                    subtitle: "Vibrate on notification",
                    value: vibration,
                    onChanged: (v) => setState(() => vibration = v),
                  ),

                  const SizedBox(height: 24),

                  _SectionTitle(title: "System"),
                  _SwitchTile(
                    title: "App Updates",
                    subtitle: "New features and improvements",
                    value: appUpdates,
                    onChanged: (v) => setState(() => appUpdates = v),
                  ),

                  const SizedBox(height: 32),

                  // Footer info
                  Text(
                    "You can change notification permissions anytime from your device settings.",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* =======================
   Helper Widgets
======================= */

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            CupertinoSwitch(
              value: value,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
