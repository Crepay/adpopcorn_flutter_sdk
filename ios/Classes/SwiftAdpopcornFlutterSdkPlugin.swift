import Flutter
import UIKit
//import AdPopcornOfferwall

public class SwiftAdpopcornFlutterSdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "adpopcorn_flutter_sdk", binaryMessenger: registrar.messenger())
    let instance = SwiftAdpopcornFlutterSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    print("[iOS] handle: methodName=\(call.method)")
    
    let arguments = call.arguments as? [String: Any]
    switch call.method {
    case "setUserId":
      guard let userId = (arguments?["userId"] as? String) else {
        return result(FlutterError(code: "BAD_ARGUMENTS", message: "No user ID", details: nil))
      }
      print("[iOS] handle: userId=\(userId)")
//      AdPopcornOfferwall.setUserId(userId)
      return result(nil)
    case "openOfferWall":
//      AdPopcornOfferwall.setUserId(userId)
      return result(nil)
    default:
      return result(FlutterMethodNotImplemented)
    }
  }
}
