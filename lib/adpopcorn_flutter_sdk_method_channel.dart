import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'adpopcorn_flutter_sdk_platform_interface.dart';

/// An implementation of [AdpopcornFlutterSdkPlatform] that uses method channels.
class MethodChannelAdpopcornFlutterSdk extends AdpopcornFlutterSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('adpopcorn_flutter_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    return await methodChannel.invokeMethod<String>('getPlatformVersion');
  }

  @override
  Future<bool> setUserId(String userId) async {
    return await methodChannel.invokeMethod<bool>('setUserId', { userId: userId }) ?? false;
  }

  @override
  Future<bool> openOfferWall() async {
    return await methodChannel.invokeMethod<bool>('openOfferWall') ?? false;
  }
}
