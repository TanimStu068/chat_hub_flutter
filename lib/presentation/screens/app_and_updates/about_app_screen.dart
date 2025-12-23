import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("About App", style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // App Logo
              CircleAvatar(
                radius: 60,
                backgroundColor: Theme.of(
                  context,
                ).primaryColor.withOpacity(0.1),
                child: Icon(
                  Icons.chat_bubble_outline,
                  size: 60,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  // color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(height: 24),

              // App Name
              Text(
                "Chat Hub",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // Version
              Text(
                "Version 1.0.0",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 24),

              // Short Description
              Text(
                "Chat Hub helps you stay connected with friends, family, "
                "and colleagues. Experience seamless messaging, calls, "
                "and media sharing in one app.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface,
                ),
              ),

              // Developer Info / Support
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
                        Icons.person_outline,
                        size: 28,
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
                              "Developer",
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Chat Hub Inc.",
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

              const SizedBox(height: 16),

              // Contact / Email
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
                        size: 28,
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
                              "Contact",
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "support@chathub.com",
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
      ),
    );
  }
}
