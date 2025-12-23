import 'package:flutter/material.dart';

class PasswordSecurityScreen extends StatelessWidget {
  const PasswordSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Password & Security",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header Info Card
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
                      Icons.lock_outline,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      // color: Theme.of(context).primaryColor,
                      size: 40,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Secure your account",
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Your password is strong and your account is protected",
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

            // Password & Security Info Section
            Expanded(
              child: ListView(
                children: [
                  _SecurityInfoCard(
                    title: "Password Strength",
                    info: "Strong (12 characters, mix of letters & symbols)",
                    icon: Icons.security,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  _SecurityInfoCard(
                    title: "Last Password Change",
                    info: "Changed on: 12 Dec, 2025",
                    icon: Icons.calendar_today_outlined,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    // color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 16),
                  _SecurityInfoCard(
                    title: "Two-Factor Authentication",
                    info: "Enabled: Authenticator App",
                    icon: Icons.verified_user_outlined,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    // color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 16),
                  _SecurityInfoCard(
                    title: "Login Alerts",
                    info: "Notifications enabled for new device login",
                    icon: Icons.notifications_active_outlined,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    // color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 16),
                  _SecurityInfoCard(
                    title: "Biometric Lock",
                    info: "Enabled: Fingerprint & Face ID",
                    icon: Icons.fingerprint,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    // color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 16),
                  _SecurityInfoCard(
                    title: "Active Sessions",
                    info: "2 devices currently logged in",
                    icon: Icons.devices,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    // color: Theme.of(context).primaryColor,
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

class _SecurityInfoCard extends StatelessWidget {
  final String title;
  final String info;
  final IconData icon;
  final Color color;

  const _SecurityInfoCard({
    required this.title,
    required this.info,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
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
                    info,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
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
