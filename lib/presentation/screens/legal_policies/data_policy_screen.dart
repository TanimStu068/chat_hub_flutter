import 'package:flutter/material.dart';

class DataPolicyScreen extends StatelessWidget {
  const DataPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Data Policy", style: TextStyle(color: Colors.white)),
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
              "Data Policy",
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
              "1. Data We Collect",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "We collect data to provide and improve Chat Hub. This includes user-generated content, device information, usage data, and analytics. We ensure that only necessary data is collected.",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                color: theme.colorScheme.onSurface, // dynamic main text color
              ),
            ),
            const SizedBox(height: 16),

            // Section 2
            Text(
              "2. How We Use Data",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Collected data helps us deliver and enhance our services, personalize content, analyze trends, detect issues, and maintain security. It may also be used for research and development purposes.",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                color: theme.colorScheme.onSurface, // dynamic main text color
              ),
            ),
            const SizedBox(height: 16),

            // Section 3
            Text(
              "3. Data Sharing",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "We do not sell personal data. Data may be shared with trusted partners or law enforcement only when legally required or to protect rights and safety. Aggregate or anonymized data may be shared for analysis.",
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
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "We implement strong security measures to protect your data. However, no method is completely secure. Users are encouraged to follow best practices to secure their accounts.",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                color: theme.colorScheme.onSurface, // dynamic main text color
              ),
            ),
            const SizedBox(height: 16),

            // Section 5
            Text(
              "5. Your Rights",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "You have the right to access, update, or request deletion of your personal data. You can also manage your preferences for data collection, storage, and sharing within the app settings.",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                color: theme.colorScheme.onSurface, // dynamic main text color
              ),
            ),
            const SizedBox(height: 16),

            // Section 6
            Text(
              "6. Changes to Data Policy",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "We may update this Data Policy periodically. Continued use of Chat Hub indicates your acceptance of any updates.",
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
