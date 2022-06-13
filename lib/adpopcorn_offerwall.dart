import 'src/adpopcorn_offerwall_platform.dart';

export 'src/adpopcorn_offerwall_platform.dart' show AdPopcornLogLevel;

class AdPopcornOfferwall {
  static Future<void> setAppKeyAndHashKey(String appKey, String hashKey) async {
    return AdPopcornOfferwallPlatform.instance
        .setAppKeyAndHashKey(appKey, hashKey);
  }

  static Future<void> useIgaworksRewardServer(bool flag) async {
    return AdPopcornOfferwallPlatform.instance.useIgaworksRewardServer(flag);
  }

  static Future<void> setLogLevel(AdPopcornLogLevel level) async {
    return AdPopcornOfferwallPlatform.instance.setLogLevel(level);
  }

  static Future<void> setUserId(String userId) async {
    return AdPopcornOfferwallPlatform.instance.setUserId(userId);
  }

  static Future<void> openOfferWall() async {
    return AdPopcornOfferwallPlatform.instance.openOfferWall();
  }

  static Future<void> setOnAgreePrivacy(NoArgumentListener listener) async {
    return AdPopcornOfferwallPlatform.instance.setOnAgreePrivacy(listener);
  }

  static Future<void> setOnDisagreePrivacy(NoArgumentListener listener) async {
    return AdPopcornOfferwallPlatform.instance.setOnDisagreePrivacy(listener);
  }

  static Future<void> setOnClosedOfferWallPage(
      NoArgumentListener listener) async {
    return AdPopcornOfferwallPlatform.instance
        .setOnClosedOfferWallPage(listener);
  }

  static Future<void> setOnWillOpenOfferWall(NoArgumentListener listener) {
    return AdPopcornOfferwallPlatform.instance.setOnWillOpenOfferWall(listener);
  }

  static Future<void> setOnDidOpenOfferWall(NoArgumentListener listener) {
    return AdPopcornOfferwallPlatform.instance.setOnDidOpenOfferWall(listener);
  }

  static Future<void> setOnWillCloseOfferWall(NoArgumentListener listener) {
    return AdPopcornOfferwallPlatform.instance
        .setOnWillCloseOfferWall(listener);
  }

  static Future<void> setOnDidCloseOfferWall(NoArgumentListener listener) {
    return AdPopcornOfferwallPlatform.instance.setOnDidCloseOfferWall(listener);
  }

  static Future<void> useFlagShowWhenLocked(bool flag) async {
    return AdPopcornOfferwallPlatform.instance.useFlagShowWhenLocked(flag);
  }

  static Future<void> openCSPage(String userId) async {
    return AdPopcornOfferwallPlatform.instance.openCSPage(userId);
  }

  static Future<void> getEarnableTotalRewardInfo(
      OnGetEarnableTotalRewardInfo callback) async {
    return AdPopcornOfferwallPlatform.instance
        .getEarnableTotalRewardInfo(callback);
  }

  static Future<void> loadPopupAd({
    NoArgumentListener? onLoadPopupAdSuccess,
    PopupAdErrorListener? onLoadPopupAdFailure,
    NoArgumentListener? onShowPopupAdSuccess,
    PopupAdErrorListener? onShowPopupAdFailure,
    NoArgumentListener? onPopupAdClose,
  }) async {
    return AdPopcornOfferwallPlatform.instance.loadPopupAd(
      onLoadPopupAdSuccess: onLoadPopupAdSuccess,
      onLoadPopupAdFailure: onLoadPopupAdFailure,
      onShowPopupAdSuccess: onShowPopupAdSuccess,
      onShowPopupAdFailure: onShowPopupAdFailure,
      onPopupAdClose: onPopupAdClose,
    );
  }

  static Future<void> showPopupAd() {
    return AdPopcornOfferwallPlatform.instance.showPopupAd();
  }
}
