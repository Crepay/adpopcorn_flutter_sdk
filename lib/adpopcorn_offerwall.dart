import 'src/adpopcorn_offerwall_platform.dart';

class AdPopcornOfferwall {
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
