import 'package:flutter/material.dart';

class UploadQualityScreen extends StatefulWidget {
  const UploadQualityScreen({super.key});

  @override
  State<UploadQualityScreen> createState() => _UploadQualityScreenState();
}

class _UploadQualityScreenState extends State<UploadQualityScreen> {
  String photoQuality = 'High';
  String videoQuality = 'High';
  String documentQuality = 'Standard';

  final List<String> qualityOptions = ['Low', 'Standard', 'High'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Upload Quality", style: TextStyle(color: Colors.white)),
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
                      Icons.cloud_upload_outlined,
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
                            "Control Upload Quality",
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Choose the quality of media files when uploading to save data or storage.",
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
                  _QualityCard(
                    icon: Icons.photo_outlined,
                    title: "Photos",
                    description: "Select the upload quality for photos.",
                    selectedValue: photoQuality,
                    options: qualityOptions,
                    onChanged: (val) => setState(() => photoQuality = val!),
                  ),
                  const SizedBox(height: 16),
                  _QualityCard(
                    icon: Icons.videocam_outlined,
                    title: "Videos",
                    description: "Select the upload quality for videos.",
                    selectedValue: videoQuality,
                    options: qualityOptions,
                    onChanged: (val) => setState(() => videoQuality = val!),
                  ),
                  const SizedBox(height: 16),
                  _QualityCard(
                    icon: Icons.insert_drive_file_outlined,
                    title: "Documents",
                    description: "Select the upload quality for documents.",
                    selectedValue: documentQuality,
                    options: qualityOptions,
                    onChanged: (val) => setState(() => documentQuality = val!),
                  ),
                  const SizedBox(height: 24),
                  // Info/Tips Card
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
                            "High quality consumes more data and storage. Choose wisely based on your network and device storage.",
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

class _QualityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String selectedValue;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  const _QualityCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.selectedValue,
    required this.options,
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
            DropdownButton<String>(
              value: selectedValue,
              items: options
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
              underline: const SizedBox(),
              dropdownColor: Theme.of(
                context,
              ).colorScheme.surface, // dynamic background
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
