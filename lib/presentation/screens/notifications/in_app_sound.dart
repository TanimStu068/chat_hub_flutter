import 'package:flutter/material.dart';

class NotificationSoundScreen extends StatefulWidget {
  const NotificationSoundScreen({super.key});

  @override
  State<NotificationSoundScreen> createState() =>
      _NotificationSoundScreenState();
}

class _NotificationSoundScreenState extends State<NotificationSoundScreen> {
  bool messageNotif = true;
  bool callNotif = true;
  bool inAppSound = true;
  bool vibration = false;
  bool dnd = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Notifications & Sounds",
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
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      // color: Theme.of(context).primaryColor,
                      size: 38,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Stay Connected",
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Manage how you receive notifications and in-app sounds.",
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
                  _ToggleCard(
                    icon: Icons.chat_bubble_outline,
                    title: "Message Notifications",
                    description: "Get notified when you receive new messages.",
                    value: messageNotif,
                    onChanged: (v) => setState(() => messageNotif = v),
                  ),
                  SizedBox(height: 16),
                  _ToggleCard(
                    icon: Icons.call_outlined,
                    title: "Call Notifications",
                    description:
                        "Receive alerts for incoming voice and video calls.",
                    value: callNotif,
                    onChanged: (v) => setState(() => callNotif = v),
                  ),
                  SizedBox(height: 16),
                  _ToggleCard(
                    icon: Icons.volume_up_outlined,
                    title: "In-App Sounds",
                    description:
                        "Play sounds for messages, calls, and actions inside the app.",
                    value: inAppSound,
                    onChanged: (v) => setState(() => inAppSound = v),
                  ),
                  SizedBox(height: 16),
                  _ToggleCard(
                    icon: Icons.vibration_outlined,
                    title: "Vibration",
                    description:
                        "Use vibration feedback for notifications and calls.",
                    value: vibration,
                    onChanged: (v) => setState(() => vibration = v),
                  ),
                  SizedBox(height: 16),
                  _ToggleCard(
                    icon: Icons.notifications_off_outlined,
                    title: "Do Not Disturb",
                    description: "Silence notifications during selected times.",
                    value: dnd,
                    onChanged: (v) => setState(() => dnd = v),
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

class _ToggleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiary,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                // color: Theme.of(context).primaryColor,
                size: 26,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
