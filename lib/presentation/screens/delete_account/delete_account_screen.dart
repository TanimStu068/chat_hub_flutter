import 'package:chat_hub/data/services/account_deletion_service.dart';
import 'package:chat_hub/presentation/screens/intro/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_hub/config/theme/app_theme.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  void _showDeleteDialog(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Account"),
        content: const Text(
          "Are you sure you want to delete your account? This action cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              try {
                await AccountDeletionService().deleteAccount();

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const IntroScreen()),
                  (_) => false,
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Failed to delete account: $e")),
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Account deleted (mock)")));
      Navigator.pop(context); // Go back after deletion
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Delete Account", style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header Info Card
            Card(
              color: Theme.of(
                context,
              ).colorScheme.tertiary, // dynamic background
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.red,
                      size: 40,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Important Information",
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Deleting your account is permanent and will remove all your data.",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.7),
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

            // Delete Info Section
            Expanded(
              child: ListView(
                children: [
                  _InfoCard(
                    title: "Data Loss",
                    info:
                        "All your messages, calls, and profile data will be permanently deleted.",
                    icon: Icons.delete_forever,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  _InfoCard(
                    title: "Subscriptions",
                    info:
                        "Any active subscriptions will be canceled and cannot be recovered.",
                    icon: Icons.subscriptions,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 16),
                  _InfoCard(
                    title: "Shared Content",
                    info:
                        "Shared content with others may still be visible to them.",
                    icon: Icons.people,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  _InfoCard(
                    title: "Final Step",
                    info:
                        "Press the delete button below to permanently remove your account.",
                    icon: Icons.info_outline,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(height: 32),

                  // Delete Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _showDeleteDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Delete Account",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
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

class _InfoCard extends StatelessWidget {
  final String title;
  final String info;
  final IconData icon;
  final Color color;

  const _InfoCard({
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
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.7),
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
