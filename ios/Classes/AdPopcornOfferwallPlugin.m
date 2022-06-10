#import "AdPopcornOfferwallPlugin.h"
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdPopcornOfferwall/AdPopcornOfferwall.h>

@implementation AdPopcornOfferwallPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"adpopcorn_flutter_sdk"
            binaryMessenger:[registrar messenger]];
  AdPopcornOfferwallPlugin* instance = [[AdPopcornOfferwallPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"setUserId" isEqualToString:call.method]) {
    
  } else if ([@"openOfferWall" isEqualToString:call.method]) {
    UIViewController *viewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    [AdPopcornOfferwall openOfferWallWithViewController:viewController delegate:self userDataDictionaryForFilter:nil];
  } else {
    result(FlutterMethodNotImplemented);
  }

}

@end
