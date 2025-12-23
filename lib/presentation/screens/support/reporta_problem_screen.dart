import 'package:flutter/material.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  final _formKey = GlobalKey<FormState>();
  String problemType = "Bug";
  String description = "";
  bool attachLogs = false;

  final List<String> problemTypes = ["Bug", "Feature Request", "Other"];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Report a Problem", style: TextStyle(color: Colors.white)),
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
            Text(
              "We’re here to help!",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Please provide details about the issue you are facing, "
              "so we can resolve it quickly.",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 24),

            // Form
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Problem Type
                  Text(
                    "Problem Type",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: problemType,
                      items: problemTypes
                          .map(
                            (type) => DropdownMenuItem(
                              value: type,
                              child: Text(
                                type,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          problemType = value!;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Description
                  Text(
                    "Description",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextFormField(
                      maxLines: 6,
                      onChanged: (val) => description = val,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter a description";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Describe the problem in detail...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Attach logs toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Attach App Logs",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Switch(
                        value: attachLogs,
                        onChanged: (val) => setState(() => attachLogs = val),
                        activeColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Handle report submission
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Problem reported successfully!"),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Submit Report",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
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
