
import 'adpopcorn_flutter_sdk_platform_interface.dart';

const channelName = 'adpopcorn_flutter_sdk';

class AdpopcornFlutterSdk {
  static Future<String?> getPlatformVersion() {
    return AdpopcornFlutterSdkPlatform.instance.getPlatformVersion();
  }

  static Future<void> setUserId(String userId) async {
    return AdpopcornFlutterSdkPlatform.instance.setUserId(userId);
  }

  static Future<void> openOfferWall() async {
    return AdpopcornFlutterSdkPlatform.instance.openOfferWall();
  }

  static Future<void> setOnAgreePrivacy(Function func) async {
    return AdpopcornFlutterSdkPlatform.instance.setOnAgreePrivacy(func);
  }

  static Future<void> setOnDisagreePrivacy(Function func) async {
    return AdpopcornFlutterSdkPlatform.instance.setOnDisagreePrivacy(func);
  }

  static Future<void> setOnClosedOfferWallPage(Function func) async {
    return AdpopcornFlutterSdkPlatform.instance.setOnClosedOfferWallPage(func);
  }

}
