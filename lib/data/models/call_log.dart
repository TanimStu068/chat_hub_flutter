import 'package:hive/hive.dart';

part 'call_log.g.dart';

@HiveType(typeId: 1)
class CallLog extends HiveObject {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String userName;

  @HiveField(2)
  final bool isVideo;

  @HiveField(3)
  final bool isOutgoing;

  @HiveField(4)
  final DateTime time;

  @HiveField(5)
  final String status; // missed | accepted | declined

  CallLog({
    required this.userId,
    required this.userName,
    required this.isVideo,
    required this.isOutgoing,
    required this.time,
    required this.status,
  });
}
