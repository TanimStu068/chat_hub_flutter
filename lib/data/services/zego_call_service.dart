import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class ZegoCallService {
  static bool _initialized = false;

  static void init({required String userId, required String userName}) {
    if (_initialized) return;

    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: 496883871, // int (NO quotes)
      appSign:
          "c0c64f194502274fbffc950f1b2912ea38612fbbde462b40de6840113fc83f3f", // String (YES quotes)
      userID: userId,
      userName: userName,
      plugins: [ZegoUIKitSignalingPlugin()],
    );

    _initialized = true;
  }

  static void uninit() {
    ZegoUIKitPrebuiltCallInvitationService().uninit();
    _initialized = false;
  }
}
