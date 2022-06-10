import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'adpopcorn_offerwall_platform.dart';

const channelName = 'adpopcorn_flutter_sdk';

class AdPopcornOfferwallIOS extends AdPopcornOfferwallPlatform {
  @visibleForTesting
  final MethodChannel methodChannel;

  final noArgListeners = <String, NoArgumentListener?>{};
  final popupAdErrorListeners = <String, PopupAdErrorListener?>{};
  OnGetEarnableTotalRewardInfo? onGetEarnableTotalRewardInfo;

  AdPopcornOfferwallIOS()
      : methodChannel = const MethodChannel(channelName) {
    methodChannel.setMethodCallHandler(_handleMethodCall);
  }

  Future<T?> _handleException<T>(String methodName, [dynamic arguments]) async {
    try {
      return await methodChannel.invokeMethod<T>(methodName, arguments);
    } catch (e, s) {
      log('Exception during invoking \'$methodName\'', error: e, stackTrace: s);
      return Future<T?>(() => null);
    }
  }

  @override
  Future<void> setAppKeyHashKey(String appKey, String hashKey) async {

  }

    @override
  Future<void> setUserId(String userId) async {
    return await _handleException('setUserId', {'userId': userId});
  }

  @override
  Future<void> openOfferWall() async {
    return await _handleException('openOfferWall');
  }

  @override
  Future<void> setOnAgreePrivacy(NoArgumentListener listener) async {
    noArgListeners['onAgreePrivacy'] = listener;
  }

  @override
  Future<void> setOnDisagreePrivacy(NoArgumentListener listener) async {
    noArgListeners['onDisagreePrivacy'] = listener;
  }

  @override
  Future<void> setOnClosedOfferWallPage(NoArgumentListener listener) async {
    noArgListeners['onClosedOfferWallPage'] = listener;
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    NoArgumentListener? noArgListener = noArgListeners[call.method];
    if (noArgListener != null) {
      return noArgListener();
    }

    PopupAdErrorListener? popupAdErrorListener =
        popupAdErrorListeners[call.method];
    if (popupAdErrorListener != null) {
      return popupAdErrorListener(
        call.arguments['errorCode'],
        call.arguments['errorMessage'],
      );
    }

    if (call.method == 'onGetEarnableTotalRewardInfo') {
      return onGetEarnableTotalRewardInfo!(
        call.arguments['queryResult'],
        call.arguments['totalCount'],
        call.arguments['totalReward'],
      );
    }
  }

  @override
  Future<void> useFlagShowWhenLocked(bool flag) async {
    return await _handleException('useFlagShowWhenLocked', {'flag': flag});
  }

  @override
  Future<void> openCSPage(String userId) async {
    return await _handleException('openCSPage', {'userId': userId});
  }

  @override
  Future<void> getEarnableTotalRewardInfo(
      OnGetEarnableTotalRewardInfo callback) async {
    onGetEarnableTotalRewardInfo = callback;
    return await _handleException('getEarnableTotalRewardInfo');
  }

  @override
  Future<void> loadPopupAd({
    NoArgumentListener? onLoadPopupAdSuccess,
    PopupAdErrorListener? onLoadPopupAdFailure,
    NoArgumentListener? onShowPopupAdSuccess,
    PopupAdErrorListener? onShowPopupAdFailure,
    NoArgumentListener? onPopupAdClose,
  }) async {
    noArgListeners['onLoadPopupAdSuccess'] = onLoadPopupAdSuccess;
    noArgListeners['onShowPopupAdSuccess'] = onShowPopupAdSuccess;
    noArgListeners['onPopupAdClose'] = onPopupAdClose;
    popupAdErrorListeners['onLoadPopupAdFailure'] = onLoadPopupAdFailure;
    popupAdErrorListeners['onShowPopupAdFailure'] = onShowPopupAdFailure;
    return await _handleException('loadPopupAd');
  }

  @override
  Future<void> showPopupAd() async {
    return await _handleException('showPopupAd');
  }

}
