import 'package:chat_hub/config/theme/app_theme.dart';
import 'package:chat_hub/data/models/call_log.dart';
import 'package:chat_hub/data/models/user_model.dart';
import 'package:chat_hub/data/repositories/chat_repository.dart';
import 'package:chat_hub/data/services/call_log_service.dart';
import 'package:chat_hub/data/services/notification_service.dart';
import 'package:chat_hub/data/services/service_locator.dart';
import 'package:chat_hub/firebase_options.dart';
import 'package:chat_hub/logic/cubits/auth/auth_cubit.dart';
import 'package:chat_hub/logic/cubits/auth/auth_state.dart';
import 'package:chat_hub/logic/observer/app_life_cycle_observer.dart';
import 'package:chat_hub/presentation/screens/bottom_nav_bar/mian_bottom_nav.dart';
import 'package:chat_hub/presentation/screens/home/home_screen.dart';
import 'package:chat_hub/presentation/screens/intro/intro_screen.dart';
import 'package:chat_hub/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:chat_hub/config/provider/theme_provider.dart';
import 'package:chat_hub/config/notification_config/notification_config.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initLocalNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (details) {
      print("Notification clicked: ${details.payload}");
    },
  );
}

final FirebaseMessaging _fcm = FirebaseMessaging.instance;

Future<void> initFCM() async {
  // Request permission (iOS only, harmless on Android)
  await _fcm.requestPermission();

  // Get the device token for push notifications
  final token = await _fcm.getToken();
  print("FCM Token: $token");

  // Optional: handle background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await flutterLocalNotificationsPlugin.show(
    message.hashCode,
    message.data['title'] ?? 'New message',
    message.data['body'] ?? 'You have a new message',
    notificationDetails,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await setupServiceLocator();

  await initLocalNotifications();

  // ✅ CREATE ANDROID NOTIFICATION CHANNEL (HERE 👇)
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'Chat Notifications',
    description: 'Chat message notifications',
    importance: Importance.max,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  await Hive.initFlutter();
  // Register adapter
  Hive.registerAdapter(UserModelAdapter());

  // Open a Hive box for user data
  await Hive.openBox<UserModel>('userBox');
  Hive.registerAdapter(CallLogAdapter());
  await Hive.openBox<CallLog>('call_log');

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLifeCycleObserver _lifeCycleObserver;
  final GlobalKey<NavigatorState> _navigatorKey =
      getit<AppRouter>().navigatorKey;

  @override
  void initState() {
    super.initState();

    // --- Foreground notifications ---
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // final notification = message.notification;

      // if (notification != null) {
      //   flutterLocalNotificationsPlugin.show(
      //     message.hashCode,
      //     notification.title,
      //     notification.body,
      //     notificationDetails, // ✅ reuse global config
      //   );
      // }

      final title = message.data['title'];
      final body = message.data['body'];

      flutterLocalNotificationsPlugin.show(
        message.hashCode,
        title,
        body,
        notificationDetails,
      );
    });

    getit<AuthCubit>().stream.listen((state) async {
      if (state.status == AuthStatus.authenticated && state.user != null) {
        final user = state.user!;

        // Save FCM token for this user
        final token = await FirebaseMessaging.instance.getToken();
        NotificationService().saveFcmToken(user.uid, token);

        _lifeCycleObserver = AppLifeCycleObserver(
          userId: state.user!.uid,
          chatRepository: getit<ChatRepository>(),
        );

        WidgetsBinding.instance.addObserver(_lifeCycleObserver);
        // Initialize Zego call invitation service
        ZegoUIKitPrebuiltCallInvitationService().init(
          appID: 496883871,
          appSign:
              "c0c64f194502274fbffc950f1b2912ea38612fbbde462b40de6840113fc83f3f",
          userID: state.user!.uid,
          userName: state.user!.username,
          plugins: [
            ZegoUIKitSignalingPlugin(), // required for invitations
          ],
          invitationEvents: ZegoUIKitPrebuiltCallInvitationEvents(
            onIncomingCallReceived: (callID, caller, callType, callees, customData) {
              // ✅ Show Accept / Decline dialog
              showDialog(
                context: _navigatorKey.currentContext!,
                barrierDismissible: false,
                builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.surfaceVariant, // adapts to light/dark
                          child: Text(
                            caller.name[0].toUpperCase(),
                            style: TextStyle(
                              fontSize: 32,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant, // dynamic text color
                            ),
                          ),
                        ),
                        Text(
                          caller.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          callType == ZegoCallInvitationType.videoCall
                              ? "Video Call"
                              : "Voice Call",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant, // adapts to light/dark
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Decline button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(20),
                              ),
                              onPressed: () {
                                Navigator.pop(context);

                                getit<CallLogService>().addCall(
                                  CallLog(
                                    userId: caller.id,
                                    userName: caller.name,
                                    isVideo:
                                        callType ==
                                        ZegoCallInvitationType.videoCall,
                                    isOutgoing: false,
                                    time: DateTime.now(),
                                    status: "declined",
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.call_end,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            // Accept button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(20),
                              ),
                              onPressed: () {
                                Navigator.pop(context);

                                // ✅ STORE ACCEPTED CALL
                                getit<CallLogService>().addCall(
                                  CallLog(
                                    userId: caller.id,
                                    userName: caller.name,
                                    isVideo:
                                        callType ==
                                        ZegoCallInvitationType.videoCall,
                                    isOutgoing: false,
                                    time: DateTime.now(),
                                    status: "accepted",
                                  ),
                                );

                                _navigatorKey.currentState?.push(
                                  MaterialPageRoute(
                                    builder: (_) => ZegoUIKitPrebuiltCall(
                                      appID: 496883871,
                                      appSign:
                                          "c0c64f194502274fbffc950f1b2912ea38612fbbde462b40de6840113fc83f3f",
                                      userID: state.user!.uid,
                                      userName: state.user!.username,
                                      callID: callID,
                                      config:
                                          callType ==
                                              ZegoCallInvitationType.videoCall
                                          ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
                                          : ZegoUIKitPrebuiltCallConfig.groupVoiceCall(),
                                    ),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.call,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },

            onIncomingCallCanceled:
                (String callID, ZegoCallUser caller, String customData) {
                  getit<CallLogService>().addCall(
                    CallLog(
                      userId: caller.id,
                      userName: caller.name,
                      isVideo: false,
                      isOutgoing: false,
                      time: DateTime.now(),
                      status: "missed",
                    ),
                  );
                  // Called when caller cancels before answer
                  print("Call cancelled by: ${caller.name}");
                },
            onIncomingCallTimeout: (String callID, ZegoCallUser caller) {
              getit<CallLogService>().addCall(
                CallLog(
                  userId: caller.id,
                  userName: caller.name,
                  isVideo: false, // or store from customData
                  isOutgoing: false,
                  time: DateTime.now(),
                  status: "missed",
                ),
              );
              // Called when callee didn’t answer
              print("Call timed out from: ${caller.name}");
            },
            onIncomingCallDeclineButtonPressed: () {
              print("Call declined by callee");
            },
          ),
        );
      }
    });

    // 2. Firebase Messaging: handle when the user taps a notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final chatRoomId = message.data['chatRoomId'];
      if (chatRoomId != null) {
        _navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: 'Chat Hub',
        navigatorKey: getit<AppRouter>().navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: Provider.of<ThemeProvider>(context).themeMode,
        home: BlocBuilder<AuthCubit, AuthState>(
          bloc: getit<AuthCubit>(),
          builder: (context, state) {
            if (state.status == AuthStatus.initial) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (state.status == AuthStatus.authenticated &&
                state.user != null) {
              return const MainBottomNav();
            }
            return const IntroScreen();
          },
        ),
      ),
    );
  }
}
