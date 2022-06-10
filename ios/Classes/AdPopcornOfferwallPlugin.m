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
  
  NSLog(@"[iOS] AdPopcornOfferwallPlugin: method=%@", call.method);
  NSDictionary* arguments = call.arguments;
  
  if ([@"setAppKeyHashKey" isEqualToString:call.method]) {
    NSString* appKey = arguments[@"appKey"];
    NSString* hashKey = arguments[@"hashKey"];
    NSLog(@"[iOS] AdPopcornOfferwallPlugin: setAppKeyHashKey: appKey=%@, hashKey=%@", appKey, hashKey);
    [AdPopcornOfferwall setAppKey:appKey andHashKey:hashKey];
  } else if ([@"useIgaworksRewardServer" isEqualToString:call.method]) {
    BOOL flag = [arguments[@"flag"] boolValue];
    NSLog(@"[iOS] AdPopcornOfferwallPlugin: useIgaworksRewardServer: flag=%s", flag ? "YES" : "NO");
    [AdPopcornOfferwall shared].useIgaworksRewardServer = flag;
  } else if ([@"setLogLevel" isEqualToString:call.method]) {
    NSString* level = arguments[@"level"];
    NSLog(@"[iOS] AdPopcornOfferwallPlugin: setLogLevel: level=%@", level);
    if ([level isEqualToString:@"info"]) {
      [AdPopcornOfferwall setLogLevel:AdPopcornOfferwallLogInfo];
    } else if ([level isEqualToString:@"debug"]) {
      [AdPopcornOfferwall setLogLevel:AdPopcornOfferwallLogDebug];
    } else if ([level isEqualToString:@"trace"]) {
      [AdPopcornOfferwall setLogLevel:AdPopcornOfferwallLogTrace];
    } else {
      return result([FlutterError errorWithCode:@"BAD_ARGUMENT"
                                        message:[NSString stringWithFormat:@"'%@' is not supported", level]
                                        details:nil]);
    }
  } else if ([@"setUserId" isEqualToString:call.method]) {
    
  } else if ([@"openOfferWall" isEqualToString:call.method]) {
    UIViewController *viewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    [AdPopcornOfferwall openOfferWallWithViewController:viewController delegate:self userDataDictionaryForFilter:nil];
  } else {
    return result(FlutterMethodNotImplemented);
  }
  return result(nil);
}

@end
