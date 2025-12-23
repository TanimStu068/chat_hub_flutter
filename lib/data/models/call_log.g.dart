// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CallLogAdapter extends TypeAdapter<CallLog> {
  @override
  final int typeId = 1;

  @override
  CallLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CallLog(
      userId: fields[0] as String,
      userName: fields[1] as String,
      isVideo: fields[2] as bool,
      isOutgoing: fields[3] as bool,
      time: fields[4] as DateTime,
      status: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CallLog obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.isVideo)
      ..writeByte(3)
      ..write(obj.isOutgoing)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CallLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
