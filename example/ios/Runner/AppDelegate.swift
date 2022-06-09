import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    AdPopcornOfferwall.setAppKey("YOUR_APP_KEY", andHashKey: "YOUR_HASH_KEY")
    AdPopcornOfferwall.shared().useIgaworksRewardServer = false
    AdPopcornOfferwall.setLogLevel(AdPopcornOfferwallLogDebug)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
