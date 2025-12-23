import 'package:chat_hub/data/models/call_log.dart';
import 'package:hive/hive.dart';

class CallLogService {
  final Box<CallLog> _box = Hive.box<CallLog>('call_log');

  void addCall(CallLog log) {
    _box.add(log);
  }

  List<CallLog> getCalls() {
    return _box.values.toList().reversed.toList();
  }
}
