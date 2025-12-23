import 'package:chat_hub/data/models/user_model.dart';
import 'package:chat_hub/data/services/base_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactRepository extends BaseRepository {
  String get currentUserId => FirebaseAuth.instance.currentUser?.uid ?? '';

  /// Request contacts permission
  Future<bool> requestContactsPermission() async {
    return await FlutterContacts.requestPermission();
  }

  /// Normalize phone numbers: remove non-digit characters and take last 11 digits
  String normalizePhone(String phone) {
    phone = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (phone.length > 11) {
      phone = phone.substring(phone.length - 11);
    }
    return phone;
  }

  /// Get registered contacts that are also in Firebase
  Future<List<Map<String, dynamic>>> getRegisteredContacts() async {
    try {
      final hasPermission = await requestContactsPermission();
      if (!hasPermission) {
        print('Contacts permission denied');
        return [];
      }

      // Get all device contacts
      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );

      // Filter contacts with phone numbers
      final phoneContacts = contacts.where((c) => c.phones.isNotEmpty).toList();

      // Fetch all users from Firestore
      final usersSnapshot = await firestore.collection('users').get();
      final registeredUsers = usersSnapshot.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList();

      final List<Map<String, dynamic>> matchedContacts = [];

      for (final contact in phoneContacts) {
        final contactPhone = normalizePhone(contact.phones.first.number);

        // Find matching user in Firebase safely
        try {
          final matchedUser = registeredUsers.firstWhere(
            (user) =>
                normalizePhone(user.phoneNumber) == contactPhone &&
                user.uid != currentUserId,
          );

          matchedContacts.add({
            'id': matchedUser.uid,
            'name': contact.displayName,
            'phoneNumber': contact.phones.first.number,
            'photo': contact.photo,
          });
        } catch (e) {
          // No match found, skip this contact
          continue;
        }
      }

      return matchedContacts;
    } catch (e) {
      print('Error getting registered contacts: $e');
      return [];
    }
  }
}
