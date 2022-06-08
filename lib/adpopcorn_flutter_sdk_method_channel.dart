import 'dart:developer';

import 'package:adpopcorn_flutter_sdk/adpopcorn_flutter_sdk.dart' as sdk;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'adpopcorn_flutter_sdk_platform_interface.dart';

/// An implementation of [AdpopcornFlutterSdkPlatform] that uses method channels.
class MethodChannelAdpopcornFlutterSdk extends AdpopcornFlutterSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final MethodChannel methodChannel;

  final listenerFunctions = <String, Function>{};

  MethodChannelAdpopcornFlutterSdk()
  : methodChannel = const MethodChannel(sdk.channelName)
  {
    methodChannel.setMethodCallHandler(_handleMethodCall);
  }

  Future<T?> _handleException<T>(String methodName, [dynamic arguments]) async {
    try {
      return await methodChannel.invokeMethod<T>(methodName, arguments);
    } catch (e, s) {
    // } on PlatformException catch (e, s) {
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
  Future<void> setOnAgreePrivacy(Function func) async {
    listenerFunctions['onAgreePrivacy'] = func;
  }

  @override
  Future<void> setOnDisagreePrivacy(Function func) async {
    listenerFunctions['onDisagreePrivacy'] = func;
  }

  @override
  Future<void> setOnClosedOfferWallPage(Function func) async {
    listenerFunctions['onClosedOfferWallPage'] = func;
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    listenerFunctions[call.method]?.call();
  }
}
