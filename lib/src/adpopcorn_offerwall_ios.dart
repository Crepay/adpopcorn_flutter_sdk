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
  Future<void> setAppKeyAndHashKey(String appKey, String hashKey) async {
    return await invokeMethodAndHandleException('setAppKeyAndHashKey', {
      'appKey': appKey,
      'hashKey': hashKey,
    });
  }

  @override
  Future<void> useIgaworksRewardServer(bool flag) async {
    return await invokeMethodAndHandleException(
        'useIgaworksRewardServer', {'flag': flag});
  }

  @override
  Future<void> setLogLevel(AdPopcornLogLevel level) async {
    return await invokeMethodAndHandleException(
        'setLogLevel', {'level': describeEnum(level)});
  }

  @override
  Future<void> setUserId(String userId) async {
    return await invokeMethodAndHandleException(
        'setUserId', {'userId': userId});
  }

  @override
  Future<void> openOfferWall() async {
    return await invokeMethodAndHandleException('openOfferWall');
  }

  @override
  Future<void> setOnWillOpenOfferWall(NoArgumentListener listener) async {
    noArgListeners['onWillOpenOfferWall'] = listener;
  }

  @override
  Future<void> setOnDidOpenOfferWall(NoArgumentListener listener) async {
    noArgListeners['onDidOpenOfferWall'] = listener;
  }

  @override
  Future<void> setOnWillCloseOfferWall(NoArgumentListener listener) async {
    noArgListeners['onWillCloseOfferWall'] = listener;
  }

  @override
  Future<void> setOnDidCloseOfferWall(NoArgumentListener listener) async {
    noArgListeners['onDidCloseOfferWall'] = listener;
  }

  @override
  Future<void> getEarnableTotalRewardInfo(
      OnGetEarnableTotalRewardInfo callback) async {
    onGetEarnableTotalRewardInfo = callback;
    return await invokeMethodAndHandleException('getEarnableTotalRewardInfo');
  }
}
