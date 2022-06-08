import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'adpopcorn_flutter_sdk_platform_interface.dart';

/// An implementation of [AdpopcornFlutterSdkPlatform] that uses method channels.
class MethodChannelAdpopcornFlutterSdk extends AdpopcornFlutterSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('adpopcorn_flutter_sdk');

  Future<T?> _handleException<T>(String methodName, [dynamic arguments]) {
    try {
      return methodChannel.invokeMethod<T>(methodName, arguments);
    } on PlatformException catch (e, s) {
      log('Exception during invoking \'$methodName\'', error: e, stackTrace: s);
      return Future<T?>(() => null);
    }
  }

  @override
  Future<String?> getPlatformVersion() async {
    return await _handleException('getPlatformVersion');
  }

  @override
  Future<bool> setUserId(String userId) async {
    return await _handleException<bool>('setUserId', {userId: userId}) ?? false;
  }

  @override
  Future<bool> openOfferWall() async {
    return await _handleException<bool>('openOfferWall') ?? false;
  }
}
