import 'package:chat_hub/data/models/call_log.dart';
import 'package:chat_hub/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AccountDeletionService {
  Future<void> deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;
    // if (user == null) return;

    if (user == null) {
      throw Exception("No authenticated user");
    }

    final uid = user.uid;

    // 1. Delete Firestore data
    await FirebaseFirestore.instance.collection('users').doc(uid).delete();

    // (Optional) delete call logs, messages, etc.
    // 2️⃣ Clear Hive local data
    await _clearLocalHiveData();

    // 2. Delete Auth user
    await user.delete();
  }

  Future<void> _clearLocalHiveData() async {
    // User data
    if (Hive.isBoxOpen('userBox')) {
      await Hive.box<UserModel>('userBox').clear();
    }

    // Call history
    if (Hive.isBoxOpen('call_log')) {
      await Hive.box<CallLog>('call_log').clear();
    }
  }
}
