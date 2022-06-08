
import 'adpopcorn_flutter_sdk_platform_interface.dart';

class AdpopcornFlutterSdk {
  static Future<String?> getPlatformVersion() {
    return AdpopcornFlutterSdkPlatform.instance.getPlatformVersion();
  }

  static Future<bool> setUserId(String userId) async {
    return AdpopcornFlutterSdkPlatform.instance.setUserId(userId);
  }

  static Future<bool> openOfferWall() async {
    return AdpopcornFlutterSdkPlatform.instance.openOfferWall();
  }
}
