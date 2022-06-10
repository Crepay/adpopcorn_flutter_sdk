import 'dart:io';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'adpopcorn_offerwall_android.dart';

typedef OnGetEarnableTotalRewardInfo = void Function(
    bool queryResult, int totalCount, String totalReward);
typedef NoArgumentListener = void Function();
typedef PopupAdErrorListener = void Function(
    int errorCode, String errorMessage);

abstract class AdPopcornOfferwallPlatform extends PlatformInterface {
  AdPopcornOfferwallPlatform() : super(token: _token);

  static final Object _token = Object();

  static final AdPopcornOfferwallPlatform instance =
      _instanceByPlatform();

  static AdPopcornOfferwallPlatform _instanceByPlatform() {
    AdPopcornOfferwallPlatform? instance;
    if (Platform.isAndroid) {
      instance = AdPopcornOfferwallAndroid();
    } else if (Platform.isIOS) {
      instance = AdPopcornOfferwallAndroid();
    } else {
      throw UnsupportedError(
          '\'${Platform.operatingSystem}\' is not supported.');
    }
    PlatformInterface.verify(instance, _token);
    return instance;
  }

  Future<void> setUserId(String userId) {
    throw UnimplementedError('setUserId() has not been implemented.');
  }

  Future<void> openOfferWall() {
    throw UnimplementedError('openOfferWall() has not been implemented.');
  }

  Future<void> setOnAgreePrivacy(NoArgumentListener listener) {
    throw UnimplementedError('setOnAgreePrivacy() has not been implemented.');
  }

  Future<void> setOnDisagreePrivacy(NoArgumentListener listener) {
    throw UnimplementedError(
        'setOnDisagreePrivacy() has not been implemented.');
  }

  Future<void> setOnClosedOfferWallPage(NoArgumentListener listener) {
    throw UnimplementedError(
        'setOnClosedOfferWallPage() has not been implemented.');
  }

  Future<void> useFlagShowWhenLocked(bool flag) {
    throw UnimplementedError(
        'useFlagShowWhenLocked() has not been implemented.');
  }

  Future<void> openCSPage(String userId) {
    throw UnimplementedError('openCSPage() has not been implemented.');
  }

  Future<void> getEarnableTotalRewardInfo(
      OnGetEarnableTotalRewardInfo callback) {
    throw UnimplementedError(
        'getEarnableTotalRewardInfo() has not been implemented.');
  }

  Future<void> loadPopupAd({
    NoArgumentListener? onLoadPopupAdSuccess,
    PopupAdErrorListener? onLoadPopupAdFailure,
    NoArgumentListener? onShowPopupAdSuccess,
    PopupAdErrorListener? onShowPopupAdFailure,
    NoArgumentListener? onPopupAdClose,
  }) {
    throw UnimplementedError('loadPopupAd() has not been implemented.');
  }

  Future<void> showPopupAd() {
    throw UnimplementedError('showPopupAd() has not been implemented.');
  }
}
