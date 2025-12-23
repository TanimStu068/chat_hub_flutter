import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'high_importance_channel',
      'Chat Notifications',
      channelDescription: 'Chat message notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );

const NotificationDetails notificationDetails = NotificationDetails(
  android: androidNotificationDetails,
);
