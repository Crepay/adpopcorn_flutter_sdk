import 'package:flutter_test/flutter_test.dart';
import 'package:adpopcorn_flutter_sdk/adpopcorn_flutter_sdk.dart';
import 'package:adpopcorn_flutter_sdk/adpopcorn_flutter_sdk_platform_interface.dart';
import 'package:adpopcorn_flutter_sdk/adpopcorn_flutter_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAdpopcornFlutterSdkPlatform 
    with MockPlatformInterfaceMixin
    implements AdpopcornFlutterSdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AdpopcornFlutterSdkPlatform initialPlatform = AdpopcornFlutterSdkPlatform.instance;

  test('$MethodChannelAdpopcornFlutterSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAdpopcornFlutterSdk>());
  });

  test('getPlatformVersion', () async {
    AdpopcornFlutterSdk adpopcornFlutterSdkPlugin = AdpopcornFlutterSdk();
    MockAdpopcornFlutterSdkPlatform fakePlatform = MockAdpopcornFlutterSdkPlatform();
    AdpopcornFlutterSdkPlatform.instance = fakePlatform;
  
    expect(await adpopcornFlutterSdkPlugin.getPlatformVersion(), '42');
  });
}
