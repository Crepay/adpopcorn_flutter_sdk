import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'adpopcorn_offerwall_platform.dart';

class AdPopcornOfferwallIOS extends AdPopcornOfferwallPlatform {

  final noArgListeners = <String, NoArgumentListener?>{};
  OnGetEarnableTotalRewardInfo? onGetEarnableTotalRewardInfo;

  AdPopcornOfferwallIOS() {
    methodChannel.setMethodCallHandler(handleMethodCall);
  }

  Future<void> handleMethodCall(MethodCall call) async {
    NoArgumentListener? noArgListener = noArgListeners[call.method];
    if (noArgListener != null) {
      return noArgListener();
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
  Future<void> setAppKeyHashKey(String appKey, String hashKey) async {

  }

    @override
  Future<void> setUserId(String userId) async {
    return await invokeMethodAndHandleException('setUserId', {'userId': userId});
  }

  @override
  Future<void> openOfferWall() async {
    return await invokeMethodAndHandleException('openOfferWall');
  }


  @override
  Future<void> getEarnableTotalRewardInfo(
      OnGetEarnableTotalRewardInfo callback) async {
    onGetEarnableTotalRewardInfo = callback;
    return await invokeMethodAndHandleException('getEarnableTotalRewardInfo');
  }

}
