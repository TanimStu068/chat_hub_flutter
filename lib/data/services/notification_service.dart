import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  Future<void> saveFcmToken(String userId, String? token) async {
    if (token != null) {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'fcmToken': token,
      });
    }
  }
}
