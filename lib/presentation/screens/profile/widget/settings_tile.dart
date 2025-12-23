import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final String? trailingText;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Theme.of(context).primaryColor,
        ),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing: trailingText != null
            ? Text(
                trailingText!,
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 14,
                ),
              )
            : Icon(
                CupertinoIcons.chevron_forward,
                size: 18,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                // color: Color(0xff692960),
              ),
      ),
    );
  }
}
