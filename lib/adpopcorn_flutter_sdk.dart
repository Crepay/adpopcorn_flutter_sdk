
import 'src/adpopcorn_flutter_sdk_platform_interface.dart';

class AdpopcornFlutterSdk {

  static Future<bool> setUserId(String userId) async {
    return AdpopcornFlutterSdkPlatform.instance.setUserId(userId);
  }

  static Future<void> openOfferWall() async {
    return AdpopcornFlutterSdkPlatform.instance.openOfferWall();
  }

  static Future<void> setOnAgreePrivacy(NoArgumentListener listener) async {
    return AdpopcornFlutterSdkPlatform.instance.setOnAgreePrivacy(listener);
  }

  static Future<void> setOnDisagreePrivacy(NoArgumentListener listener) async {
    return AdpopcornFlutterSdkPlatform.instance.setOnDisagreePrivacy(listener);
  }

  static Future<void> setOnClosedOfferWallPage(NoArgumentListener listener) async {
    return AdpopcornFlutterSdkPlatform.instance.setOnClosedOfferWallPage(listener);
  }

  static Future<bool> useFlagShowWhenLocked(bool flag) async {
    return AdpopcornFlutterSdkPlatform.instance.useFlagShowWhenLocked(flag);
  }

  static Future<void> openCSPage(String userId) async {
    return AdpopcornFlutterSdkPlatform.instance.openCSPage(userId);
  }

  static Future<void> getEarnableTotalRewardInfo(OnGetEarnableTotalRewardInfo callback) async {
    return AdpopcornFlutterSdkPlatform.instance.getEarnableTotalRewardInfo(callback);
  }

  static Future<void> loadPopupAd({
    NoArgumentListener? onLoadPopupAdSuccess,
    PopupAdErrorListener? onLoadPopupAdFailure,
    NoArgumentListener? onShowPopupAdSuccess,
    PopupAdErrorListener? onShowPopupAdFailure,
    NoArgumentListener? onPopupAdClose,
  } ) async {
    return AdpopcornFlutterSdkPlatform.instance.loadPopupAd(
      onLoadPopupAdSuccess: onLoadPopupAdSuccess,
      onLoadPopupAdFailure: onLoadPopupAdFailure,
      onShowPopupAdSuccess: onShowPopupAdSuccess,
      onShowPopupAdFailure: onShowPopupAdFailure,
      onPopupAdClose: onPopupAdClose,
    );
  }

  static Future<void> showPopupAd() {
    return AdpopcornFlutterSdkPlatform.instance.showPopupAd();
  }

}
