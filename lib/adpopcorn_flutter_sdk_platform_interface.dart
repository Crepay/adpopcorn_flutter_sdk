import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'adpopcorn_flutter_sdk_method_channel.dart';

abstract class AdpopcornFlutterSdkPlatform extends PlatformInterface {
  /// Constructs a AdpopcornFlutterSdkPlatform.
  AdpopcornFlutterSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static AdpopcornFlutterSdkPlatform _instance = MethodChannelAdpopcornFlutterSdk();

  /// The default instance of [AdpopcornFlutterSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelAdpopcornFlutterSdk].
  static AdpopcornFlutterSdkPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AdpopcornFlutterSdkPlatform] when
  /// they register themselves.
  static set instance(AdpopcornFlutterSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('getPlatformVersion() has not been implemented.');
  }

  Future<bool> setUserId(String userId) {
    throw UnimplementedError('setUserId() has not been implemented.');
  }

  Future<bool> openOfferWall() {
    throw UnimplementedError('openOfferWall() has not been implemented.');
  }
}
