import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'adpopcorn_flutter_sdk_platform_interface.dart';

const channelName = 'adpopcorn_flutter_sdk';

/// An implementation of [AdpopcornFlutterSdkPlatform] that uses method channels.
class MethodChannelAdpopcornFlutterSdk extends AdpopcornFlutterSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final MethodChannel methodChannel;

  final listenerFunctions = <String, Listener>{};
  OnGetEarnableTotalRewardInfo? onGetEarnableTotalRewardInfo;

  MethodChannelAdpopcornFlutterSdk()
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
  Future<String?> getPlatformVersion() async {
    return await _handleException('getPlatformVersion');
  }

  @override
  Future<void> setUserId(String userId) async {
    return await _handleException('setUserId', {userId: userId});
  }

  @override
  Future<void> openOfferWall() async {
    return await _handleException('openOfferWall');
  }

  @override
  Future<void> setOnAgreePrivacy(Listener listener) async {
    listenerFunctions['onAgreePrivacy'] = listener;
  }

  @override
  Future<void> setOnDisagreePrivacy(Listener listener) async {
    listenerFunctions['onDisagreePrivacy'] = listener;
  }

  @override
  Future<void> setOnClosedOfferWallPage(Listener listener) async {
    listenerFunctions['onClosedOfferWallPage'] = listener;
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    Listener? listener = listenerFunctions[call.method];
    if (listener != null) {
      return listener.call();
    }
    if (call.method == 'onGetEarnableTotalRewardInfo') {
      onGetEarnableTotalRewardInfo!(
        call.arguments['queryResult'],
        call.arguments['totalCount'],
        call.arguments['totalReward'],
      );
      return;
    }
  }

  @override
  Future<void> useFlagShowWhenLocked(bool flag) async {
    return await _handleException('useFlagShowWhenLocked', {flag: flag});
  }

  @override
  Future<void> openCSPage(String userId) async {
    return await _handleException('openCSPage', {userId: userId});
  }

  @override
  Future<void> getEarnableTotalRewardInfo(
      OnGetEarnableTotalRewardInfo callback) async {
    onGetEarnableTotalRewardInfo = callback;
    return await _handleException('getEarnableTotalRewardInfo');
  }
}
