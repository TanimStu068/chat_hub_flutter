import 'package:chat_hub/data/models/user_model.dart';
import 'package:chat_hub/data/services/service_locator.dart';
import 'package:chat_hub/logic/cubits/auth/auth_cubit.dart';
import 'package:chat_hub/presentation/screens/auth/login_screen.dart';
import 'package:chat_hub/presentation/screens/calls/calls_screen.dart';
import 'package:chat_hub/presentation/screens/home/home_screen.dart';
import 'package:chat_hub/presentation/screens/notifications/push_notifications_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_hub/presentation/screens/settings/settings_screen.dart';
import 'package:chat_hub/presentation/screens/profile/profile_screen.dart';
import 'package:chat_hub/data/services/zego_call_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainBottomNav extends StatefulWidget {
  const MainBottomNav({super.key});

  @override
  State<MainBottomNav> createState() => _MainBottomNavState();
}

class _MainBottomNavState extends State<MainBottomNav> {
  int _selectedIndex = 0;

  String userName = "John Doe";
  String userStatus = "Hey there! I am using ChatHub";
  String phoneNumber = "+880 1234 567890";

  void _logout(BuildContext context) async {
    ZegoCallService.uninit(); // 👈 ADD THIS

    final authCubit = getit<AuthCubit>();
    await authCubit.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      ZegoCallService.init(
        userId: user.uid,
        userName: user.displayName ?? "ChatHub User",
      );
    }
  }

  // Bottom nav pages
  final List<Widget> _pages = [
    const HomeScreen(),
    const Callscreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final box = Hive.box<UserModel>('userBox');
    UserModel? user = uid != null ? box.get(uid) : null;

    if (uid == null) {
      print("User not found");
    }
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Sidebar Header - tappable to open ProfileScreen
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              padding: EdgeInsets.zero,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context); // close drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                },
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
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
                                radius: 37,
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
                                      ).colorScheme.primary,

                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(6),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            user?.fullName ?? "Unknown User",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            userStatus,
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Sidebar options
            const SizedBox(height: 13),
            Container(
              color: Theme.of(context).colorScheme.tertiary, // dynamic card bg
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text("Profile"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Theme.of(context).colorScheme.tertiary, // dynamic card bg
              child: ListTile(
                leading: Icon(
                  Icons.chat,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text("Chats"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Theme.of(context).colorScheme.tertiary, // dynamic card bg
              child: ListTile(
                leading: Icon(
                  Icons.call,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text("Calls"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Callscreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Theme.of(context).colorScheme.tertiary, // dynamic card bg
              child: ListTile(
                leading: Icon(
                  Icons.notifications,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text("Notifications"),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => const PushNotificationsScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Theme.of(context).colorScheme.tertiary, // dynamic card bg
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Red for logout
                  foregroundColor: Theme.of(
                    context,
                  ).colorScheme.onPrimary, // text/icon color
                  minimumSize: const Size.fromHeight(50), // Full width button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _logout(context),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  "Logout",
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(
          context,
        ).colorScheme.onSurface.withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
