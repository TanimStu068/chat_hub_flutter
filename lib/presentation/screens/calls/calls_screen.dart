import 'package:chat_hub/config/theme/app_theme.dart';
import 'package:chat_hub/data/models/call_log.dart';
import 'package:chat_hub/data/repositories/contact_repository.dart';
import 'package:chat_hub/data/services/call_log_service.dart';
import 'package:chat_hub/data/services/service_locator.dart';
import 'package:chat_hub/presentation/screens/chat/chat_message_screen.dart';
import 'package:chat_hub/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class Callscreen extends StatefulWidget {
  const Callscreen({super.key});

  @override
  State<Callscreen> createState() => _CallsScreenState();
}

Future<bool> requestPermissions({bool video = false}) async {
  final micStatus = await Permission.microphone.request();
  if (video) {
    final camStatus = await Permission.camera.request();
    return micStatus.isGranted && camStatus.isGranted;
  }
  return micStatus.isGranted;
}

class _CallsScreenState extends State<Callscreen> {
  late final ContactRepository _contactRepository;

  Icon _getCallTypeIcon(String type, String mode) {
    Color color;
    IconData iconData;

    switch (type) {
      case 'incoming':
        color = Colors.green;
        iconData = Icons.call_received;
        break;
      case 'outgoing':
        color = Colors.blue;
        iconData = Icons.call_made;
        break;
      case 'missed':
      default:
        color = Colors.red;
        iconData = Icons.call_missed;
    }

    return Icon(
      mode == 'video' ? Icons.videocam : iconData,
      color: color,
      size: 20,
    );
  }

  @override
  void initState() {
    _contactRepository = getit<ContactRepository>();
    super.initState();
  }

  void _showContactsList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                "Contacts",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _contactRepository.getRegisteredContacts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final contacts = snapshot.data!;
                    if (contacts.isEmpty) {
                      return const Center(child: Text("No contacts found"));
                    }
                    return ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        final contact = contacts[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xff692960).withOpacity(0.5),
                            child: Text(
                              (contact["name"]?.isNotEmpty ?? false)
                                  ? contact["name"][0].toUpperCase()
                                  : "?",
                            ),
                          ),
                          title: Text(contact["name"] ?? "Unknown"),
                          onTap: () {
                            final id = contact['id'];
                            final name = contact['name'] ?? "Unknown";

                            if (id == null) {
                              print("ERROR: Contact has no id → skipping");
                              return; // prevent crash
                            }
                            getit<AppRouter>().push(
                              ChatMessageScreen(
                                receiverId: id,
                                receiverName: name,
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: Text("Calls", style: TextStyle(color: Colors.white)),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<CallLog>('call_log').listenable(),
        builder: (context, Box<CallLog> box, _) {
          final calls = box.values.toList().reversed.toList();

          if (calls.isEmpty) {
            return const Center(child: Text("No call history"));
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: calls.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final call = calls[index];

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xff692960).withOpacity(0.5),

                  child: Text(
                    call.userName[0].toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(call.userName, style: theme.textTheme.titleLarge),
                subtitle: Row(
                  children: [
                    _getCallTypeIcon(
                      call.isOutgoing ? 'outgoing' : 'incoming',
                      call.isVideo ? 'video' : 'voice',
                    ),
                    const SizedBox(width: 6),
                    Text(
                      DateFormat('MMM d, h:mm a').format(call.time),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(
                    call.isVideo ? Icons.videocam : Icons.call,
                    color: AppTheme.primaryColor,
                  ),
                  onPressed: () async {
                    bool granted = await requestPermissions(
                      video: call.isVideo,
                    );
                    if (!granted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Microphone/Camera permission required",
                          ),
                        ),
                      );
                      return;
                    }

                    // Log outgoing call in Hive
                    getit<CallLogService>().addCall(
                      CallLog(
                        userId: call.userId,
                        userName: call.userName,
                        isVideo: call.isVideo,
                        isOutgoing: true,
                        time: DateTime.now(),
                        status: "calling",
                      ),
                    );

                    // Start the call
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ZegoUIKitPrebuiltCall(
                          appID: 496883871, // your Zego appID
                          appSign:
                              "c0c64f194502274fbffc950f1b2912ea38612fbbde462b40de6840113fc83f3f", // your Zego appSign
                          userID: FirebaseAuth.instance.currentUser!.uid,
                          userName:
                              FirebaseAuth.instance.currentUser!.displayName ??
                              "User",
                          callID:
                              "call_${call.userId}", // unique callID per call
                          config: call.isVideo
                              ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
                              : ZegoUIKitPrebuiltCallConfig.groupVoiceCall(),
                        ),
                      ),
                    );
                    // re-call / re-video-call
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showContactsList(context),
        backgroundColor: Theme.of(context).colorScheme.primary,

        child: Icon(Icons.add_call, color: Colors.white),
      ),
    );
  }
}
