
import 'src/adpopcorn_flutter_sdk_platform_interface.dart';

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

  static Future<void> setOnAgreePrivacy(Listener listener) async {
    return AdpopcornFlutterSdkPlatform.instance.setOnAgreePrivacy(listener);
  }

  static Future<void> setOnDisagreePrivacy(Listener listener) async {
    return AdpopcornFlutterSdkPlatform.instance.setOnDisagreePrivacy(listener);
  }

  static Future<void> setOnClosedOfferWallPage(Listener listener) async {
    return AdpopcornFlutterSdkPlatform.instance.setOnClosedOfferWallPage(listener);
  }

  static Future<void> useFlagShowWhenLocked(bool flag) async {
    return AdpopcornFlutterSdkPlatform.instance.useFlagShowWhenLocked(flag);
  }

  static Future<void> openCSPage(String userId) async {
    return AdpopcornFlutterSdkPlatform.instance.openCSPage(userId);
  }

  static Future<void> getEarnableTotalRewardInfo(OnGetEarnableTotalRewardInfo callback) async {
    return AdpopcornFlutterSdkPlatform.instance.getEarnableTotalRewardInfo(callback);
  }

}
