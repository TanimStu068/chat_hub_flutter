// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 2;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      uid: fields[0] as String,
      username: fields[1] as String,
      fullName: fields[2] as String,
      email: fields[3] as String,
      phoneNumber: fields[4] as String,
      isOnline: fields[5] as bool,
      lastSeen: fields[6] as DateTime?,
      createdAt: fields[7] as DateTime?,
      fcmToken: fields[8] as String?,
      blockedUsers: (fields[9] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.fullName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.isOnline)
      ..writeByte(6)
      ..write(obj.lastSeen)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.fcmToken)
      ..writeByte(9)
      ..write(obj.blockedUsers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
