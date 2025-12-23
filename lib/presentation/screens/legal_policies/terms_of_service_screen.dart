import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Terms of Service", style: TextStyle(color: Colors.white)),
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
              "Terms of Service",
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
              "1. Acceptance of Terms",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                // color: theme.colorScheme.primary, // dynamic primary color
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "By accessing or using Chat Hub, you agree to be bound by these Terms of Service and all applicable laws and regulations. If you do not agree, you may not use the app.",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                color: theme.colorScheme.onSurface, // dynamic main text color
              ),
            ),
            const SizedBox(height: 16),

            // Section 2
            Text(
              "2. User Responsibilities",
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
              "You are responsible for maintaining the confidentiality of your account and password and for all activities that occur under your account. You agree to use the app in compliance with all applicable laws.",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                color: theme.colorScheme.onSurface, // dynamic main text color
              ),
            ),
            const SizedBox(height: 16),

            // Section 3
            Text(
              "3. Prohibited Activities",
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
              "You may not use Chat Hub for any unlawful purpose or in any way that could damage, disable, overburden, or impair the app’s functionality. Harassment, spamming, or distribution of harmful content is strictly prohibited.",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                color: theme.colorScheme.onSurface, // dynamic main text color
              ),
            ),
            const SizedBox(height: 16),

            // Section 4
            Text(
              "4. Intellectual Property",
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
              "All content, logos, and materials in Chat Hub are owned by Chat Hub Inc. or its licensors. You may not reproduce, distribute, or create derivative works without prior written permission.",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                color: theme.colorScheme.onSurface, // dynamic main text color
              ),
            ),
            const SizedBox(height: 16),

            // Section 5
            Text(
              "5. Termination",
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
              "We reserve the right to terminate or suspend your access to Chat Hub at any time, without notice, for violation of these Terms or other policies.",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                color: theme.colorScheme.onSurface, // dynamic main text color
              ),
            ),
            const SizedBox(height: 16),

            // Section 6
            Text(
              "6. Changes to Terms",
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
              "We may modify these Terms at any time. Continued use of the app after changes indicates your acceptance of the updated Terms.",
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
