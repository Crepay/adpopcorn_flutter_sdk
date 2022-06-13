#import "AdPopcornOfferwallPlugin.h"
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

@implementation AdPopcornOfferwallPlugin {
  FlutterMethodChannel* channel;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  AdPopcornOfferwallPlugin* instance = [[AdPopcornOfferwallPlugin alloc] init];
  instance->channel = [FlutterMethodChannel
      methodChannelWithName:@"adpopcorn_flutter_sdk"
            binaryMessenger:[registrar messenger]];
  [registrar addMethodCallDelegate:instance channel:instance->channel];
  
  [AdPopcornOfferwall shared].delegate = instance;
  [AdPopcornOfferwall getEarnableTotalRewardInfo:instance];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
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
                                        message:[NSString stringWithFormat:@"'%@' is not supported for log level.", level]
                                        details:nil]);
    }
  } else if ([@"setUserId" isEqualToString:call.method]) {
    NSString* userId = arguments[@"userId"];
    NSLog(@"[iOS] AdPopcornOfferwallPlugin: setUserId: userId=%@", userId);
    [AdPopcornOfferwall setUserId: userId];
  } else if ([@"openOfferWall" isEqualToString:call.method]) {
    UIViewController *viewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    [AdPopcornOfferwall openOfferWallWithViewController:viewController delegate:self userDataDictionaryForFilter:nil];
  } else if ([@"getEarnableTotalRewardInfo" isEqualToString:call.method]) {
    [AdPopcornOfferwall getEarnableTotalRewardInfo:self];
  } else {
    NSLog(@"[iOS] AdPopcornOfferwallPlugin: method=%@", call.method);
    return result(FlutterMethodNotImplemented);
  }
  return result(nil);
}

-(void)willOpenOfferWall { //Offerwall will be opened
  [self->channel invokeMethod:@"onWillOpenOfferWall" arguments:nil];
}

-(void)didOpenOfferWall { //Offerwall did opened
  [self->channel invokeMethod:@"onDidOpenOfferWall" arguments:nil];
}

-(void)willCloseOfferWall { //Offerwall will bel closed
  [self->channel invokeMethod:@"onWillCloseOfferWall" arguments:nil];
}

-(void)didCloseOfferWall { //Offerwall did closed
  [self->channel invokeMethod:@"onDidCloseOfferWall" arguments:nil];
}

- (void)offerwallTotalRewardInfo:(BOOL)queryResult totalCount:(NSInteger)totalCount totalReward:(NSString *)totalReward {
  [self->channel invokeMethod:@"onGetEarnableTotalRewardInfo"
                    arguments:@{
    @"queryResult": @(queryResult),
    @"totalCount": @(totalCount),
    @"totalReward": totalReward,
  }];
}

@end
