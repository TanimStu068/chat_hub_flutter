import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart'; // required for Hive code generation

@HiveType(typeId: 2)
class UserModel extends HiveObject {
  @HiveField(0)
  final String uid;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String fullName;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String phoneNumber;

  @HiveField(5)
  final bool isOnline;

  @HiveField(6)
  final DateTime lastSeen;

  @HiveField(7)
  final DateTime createdAt;

  @HiveField(8)
  final String? fcmToken;

  @HiveField(9)
  final List<String> blockedUsers;

  UserModel({
    required this.uid,
    required this.username,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.isOnline = false,
    DateTime? lastSeen,
    DateTime? createdAt,
    this.fcmToken,
    this.blockedUsers = const [],
  }) : lastSeen = lastSeen ?? DateTime.now(),
       createdAt = createdAt ?? DateTime.now();

  UserModel copyWith({
    String? uid,
    String? username,
    String? fullName,
    String? email,
    String? phoneNumber,
    bool? isOnline,
    DateTime? lastSeen,
    DateTime? createdAt,
    String? fcmToken,
    List<String>? blockedUsers,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      createdAt: createdAt ?? this.createdAt,
      fcmToken: fcmToken ?? this.fcmToken,
      blockedUsers: blockedUsers ?? this.blockedUsers,
    );
  }

  // Firestore factory
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      username: data["username"] ?? "",
      fullName: data["fullName"] ?? "",
      email: data["email"] ?? "",
      phoneNumber: data["phoneNumber"] ?? "",
      fcmToken: data["fcmToken"],
      lastSeen: (data["lastSeen"] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdAt: (data["createdAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
      blockedUsers: List<String>.from(data["blockedUsers"] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'isOnline': isOnline,
      'lastSeen': Timestamp.fromDate(lastSeen),
      'createdAt': Timestamp.fromDate(createdAt),
      'blockedUsers': blockedUsers,
      'fcmToken': fcmToken,
    };
  }
}
