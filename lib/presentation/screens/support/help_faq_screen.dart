import 'package:flutter/material.dart';

class HelpFaqScreen extends StatelessWidget {
  const HelpFaqScreen({super.key});

  final List<Map<String, String>> faqs = const [
    {
      "question": "How do I reset my password?",
      "answer":
          "Go to Password & Security in the Settings screen and follow the instructions to reset your password.",
    },
    {
      "question": "How do I change my profile picture?",
      "answer":
          "Open your profile, tap on your profile picture, and select a new image from your gallery or camera.",
    },
    {
      "question": "How can I contact support?",
      "answer":
          "You can contact our support team via the 'Report a Problem' option in Settings or email support@chathub.com.",
    },
    {
      "question": "How do I enable notifications?",
      "answer":
          "Go to Notifications & Sounds in Settings, then enable Push Notifications and In-App Sounds as desired.",
    },
    {
      "question": "Can I switch accounts on this device?",
      "answer":
          "Yes! Go to App & Updates -> Switch Account to log in with a different account.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Help & FAQ", style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return Card(
            color: Theme.of(context).colorScheme.tertiary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            child: ExpansionTile(
              iconColor: Theme.of(context).primaryColor,
              collapsedIconColor: Theme.of(context).primaryColor,
              tilePadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              childrenPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              title: Text(
                faq['question']!,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              children: [
                Text(
                  faq['answer']!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
