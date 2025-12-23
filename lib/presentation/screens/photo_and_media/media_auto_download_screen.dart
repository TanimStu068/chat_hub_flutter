import 'package:flutter/material.dart';

class MediaAutoDownloadScreen extends StatefulWidget {
  const MediaAutoDownloadScreen({super.key});

  @override
  State<MediaAutoDownloadScreen> createState() =>
      _MediaAutoDownloadScreenState();
}

class _MediaAutoDownloadScreenState extends State<MediaAutoDownloadScreen> {
  bool photos = true;
  bool videos = false;
  bool audio = true;
  bool documents = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Media Auto-Download",
          style: TextStyle(color: Colors.white),
        ),
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
                      Icons.download_for_offline_outlined,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      // color: Theme.of(context).colorScheme.primary,
                      size: 38,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Manage Auto-Download",
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Control which media files are automatically downloaded on Wi-Fi or Mobile Data.",
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
                    icon: Icons.photo_outlined,
                    title: "Photos",
                    description: "Automatically download photos.",
                    value: photos,
                    onChanged: (v) => setState(() => photos = v),
                  ),
                  const SizedBox(height: 16),
                  _ToggleCard(
                    icon: Icons.videocam_outlined,
                    title: "Videos",
                    description: "Automatically download videos.",
                    value: videos,
                    onChanged: (v) => setState(() => videos = v),
                  ),
                  const SizedBox(height: 16),
                  _ToggleCard(
                    icon: Icons.audiotrack_outlined,
                    title: "Audio",
                    description: "Automatically download audio files.",
                    value: audio,
                    onChanged: (v) => setState(() => audio = v),
                  ),
                  const SizedBox(height: 16),
                  _ToggleCard(
                    icon: Icons.insert_drive_file_outlined,
                    title: "Documents",
                    description: "Automatically download documents.",
                    value: documents,
                    onChanged: (v) => setState(() => documents = v),
                  ),
                  const SizedBox(height: 24),

                  // Info Section
                  Card(
                    color: Theme.of(context).colorScheme.tertiary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tip:",
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Disabling auto-download for videos or documents can help save mobile data.",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
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
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                // color: Theme.of(context).colorScheme.primary,
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
