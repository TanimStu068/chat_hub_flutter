import 'package:chat_hub/data/models/user_model.dart';
import 'package:chat_hub/data/services/service_locator.dart';
import 'package:chat_hub/logic/cubits/auth/auth_cubit.dart';
import 'package:chat_hub/presentation/screens/auth/login_screen.dart';
import 'package:chat_hub/presentation/screens/password_security/password_security_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_hub/presentation/screens/profile/widget/settings_card.dart';
import 'package:chat_hub/presentation/screens/profile/widget/settings_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userStatus = "Hey there! I am using ChatHub";

  void _logout(BuildContext context) async {
    final authCubit = getit<AuthCubit>();
    await authCubit.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final theme = Theme.of(context);
    final box = Hive.box<UserModel>('userBox');
    UserModel? user = uid != null ? box.get(uid) : null;

    if (uid == null) {
      print("User not found");
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        children: [
          // =========================
          // Header: Avatar + Name + Status
          // =========================
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/150?img=3", // Placeholder avatar
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: GestureDetector(
                        onTap: () {
                          // Handle avatar change
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).primaryColor, // dynamic primary color
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            Icons.edit,
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimary, // dynamic contrast color
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  user?.fullName ?? "Unknown User",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userStatus,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // =========================
          // Account Information
          // =========================
          SettingsCard(
            title: "Account",
            child: Column(
              children: [
                SettingsTile(
                  icon: CupertinoIcons.phone,
                  iconColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  title: "Phone Number",
                  trailingText: user?.phoneNumber ?? "No phone",
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                SettingsTile(
                  icon: CupertinoIcons.mail,
                  iconColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  title: "Email",
                  trailingText: user?.email ?? "No email",
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                SettingsTile(
                  icon: CupertinoIcons.lock,
                  iconColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  title: "Password & Security",
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const PasswordSecurityScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // =========================
          // Actions: Logout / Delete
          // =========================
          SettingsCard(
            title: "Actions",
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Red for logout
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(
                        50,
                      ), // Full width button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _logout(context),
                    icon: const Icon(Icons.logout),
                    label: const Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
