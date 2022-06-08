
import 'adpopcorn_flutter_sdk_platform_interface.dart';

class AdpopcornFlutterSdk {
  Future<String?> getPlatformVersion() {
    return AdpopcornFlutterSdkPlatform.instance.getPlatformVersion();
  }
}
