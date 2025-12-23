import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Privacy Policy", style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Privacy Policy",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Effective Date
            Text(
              "Effective Date: December 20, 2025",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),

            // Section 1
            Text(
              "1. Information We Collect",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                // color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "We collect information you provide directly, such as your account details, messages, and media. We may also collect technical data such as device type, IP address, and usage analytics to improve the app.",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                color: theme.colorScheme.onSurface, // dynamic main text color
              ),
            ),
            const SizedBox(height: 16),

            // Section 2
            Text(
              "2. How We Use Information",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                // color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Your information is used to provide, maintain, and improve Chat Hub. This includes delivering messages, notifications, personalizing content, and analyzing app usage.",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                color: theme.colorScheme.onSurface, // dynamic main text color
              ),
            ),
            const SizedBox(height: 16),

            // Section 3
            Text(
              "3. Sharing of Information",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                // color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "We do not sell your personal information. We may share information with trusted partners or law enforcement as required by law or to protect rights and safety.",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                color: theme.colorScheme.onSurface, // dynamic main text color
              ),
            ),
            const SizedBox(height: 16),

            // Section 4
            Text(
              "4. Data Security",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                // color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "We implement reasonable security measures to protect your information. However, no method of transmission or storage is completely secure.",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                color: theme.colorScheme.onSurface, // dynamic main text color
              ),
            ),
            const SizedBox(height: 16),

            // Section 5
            Text(
              "5. Your Choices",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                // color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "You can manage your account settings, including notification preferences and data sharing options. You may also request deletion of your account at any time.",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                color: theme.colorScheme.onSurface, // dynamic main text color
              ),
            ),
            const SizedBox(height: 16),

            // Section 6
            Text(
              "6. Changes to This Policy",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                // color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "We may update this Privacy Policy from time to time. Continued use of Chat Hub indicates your acceptance of any changes.",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                color: theme.colorScheme.onSurface, // dynamic main text color
              ),
            ),
            const SizedBox(height: 24),

            // Footer / Contact
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
                      Icons.email_outlined,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      // color: Theme.of(context).primaryColor,
                      size: 28,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Need Help?",
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Contact support@chathub.com",
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

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
