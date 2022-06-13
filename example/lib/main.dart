import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:adpopcorn_flutter_sdk/adpopcorn_offerwall.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final random = math.Random();
  final textControllerAppKey = TextEditingController();
  final textControllerHashKey = TextEditingController();
  final textControllerUserId = TextEditingController();
  String userId = '';

  List<Widget>? widgetsByPlatform;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      initAndroid();
    } else if (Platform.isIOS) {
      initIOS();
    }
  }

  @override
  void dispose() {
    textControllerAppKey.dispose();
    textControllerHashKey.dispose();
    textControllerUserId.dispose();
    super.dispose();
  }

  void initAndroid() {
    widgetsByPlatform = [
      buildSetUserId(),
      buildOpenOfferwall(),
      buildGetEarnableTotalRewardInfo(),
      buildUseFlagShowWhenLocked(),
      buildOpenCSPage(),
      buildLoadPopupAd(),
      buildShowPopupAd(),
    ];
    AdPopcornOfferwall.setOnAgreePrivacy(
        () => showSnackBar('onAgreePrivacy()'));
    AdPopcornOfferwall.setOnDisagreePrivacy(
        () => showSnackBar('onDisagreePrivacy()'));
    AdPopcornOfferwall.setOnClosedOfferWallPage(
        () => showSnackBar('onClosedOfferWallPage()'));
  }

  void initIOS() {
    widgetsByPlatform = [
      buildSetAppKeyHashKey(),
      buildUseIgaworksRewardServer(),
      buildSetLogLevel(),
      buildSetUserId(),
      buildOpenOfferwall(),
      buildGetEarnableTotalRewardInfo(),
    ];
    AdPopcornOfferwall.setOnWillOpenOfferWall(
        () => showSnackBar('setOnWillOpenOfferWall()'));
    AdPopcornOfferwall.setOnDidOpenOfferWall(
        () => showSnackBar('setOnDidOpenOfferWall()'));
    AdPopcornOfferwall.setOnWillCloseOfferWall(
        () => showSnackBar('setOnWillCloseOfferWall()'));
    AdPopcornOfferwall.setOnDidCloseOfferWall(
        () => showSnackBar('setOnDidCloseOfferWall()'));
  }

  void showSnackBar(String text) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(milliseconds: 600),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];
    for (Widget widget in widgetsByPlatform!) {
      children.add(const SizedBox(height: 8));
      children.add(widget);
    }
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Center(
              child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 24),
                  for(final child in children) child,
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }

  Widget buildSetAppKeyHashKey() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: TextFormField(
                controller: textControllerAppKey,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'App key',
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 100,
              child: TextFormField(
                controller: textControllerHashKey,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Hash key',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            final appKey = textControllerAppKey.text;
            final hashKey = textControllerHashKey.text;
            log('setAppKeyAndHashKey() appKey=$appKey, hashKey=$hashKey');
            await AdPopcornOfferwall.setAppKeyAndHashKey(appKey, hashKey);
            showSnackBar('setAppKeyAndHashKey()');
          },
          child: const Text('setAppKeyAndHashKey()'),
        ),
      ],
    );
  }

  Widget buildUseIgaworksRewardServer() {
    return ElevatedButton(
      onPressed: () async {
        final flag = random.nextBool();
        log('useIgaworksRewardServer() flag=$flag');
        await AdPopcornOfferwall.useIgaworksRewardServer(flag);
        showSnackBar('useIgaworksRewardServer($flag)');
      },
      child: const Text('useIgaworksRewardServer()'),
    );
  }

  Widget buildSetLogLevel() {
    return ElevatedButton(
      onPressed: () async {
        final index = random.nextInt(AdPopcornLogLevel.values.length);
        final level = AdPopcornLogLevel.values[index];
        log('setLogLevel() level=$level');
        await AdPopcornOfferwall.setLogLevel(level);
        showSnackBar('setLogLevel(${describeEnum(level)})');
      },
      child: const Text('setLogLevel()'),
    );
  }

  Widget buildSetUserId() {
    return Column(
      children: [
        SizedBox(
          width: 200,
          child: TextFormField(
            controller: textControllerUserId,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'User ID',
            ),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            userId = textControllerUserId.text;
            log('setUserId() id=$userId');
            await AdPopcornOfferwall.setUserId(userId);
            showSnackBar('setUserId()');
          },
          child: const Text('setUserId()'),
        ),
      ],
    );
  }

  Widget buildOpenOfferwall() {
    return ElevatedButton(
      onPressed: () async {
        log('openOfferWall()');
        await AdPopcornOfferwall.openOfferWall();
      },
      child: const Text('openOfferWall()'),
    );
  }

  Widget buildUseFlagShowWhenLocked() {
    return ElevatedButton(
      onPressed: () async {
        final flag = random.nextBool();
        log('useFlagShowWhenLocked() flag=$flag');
        await AdPopcornOfferwall.useFlagShowWhenLocked(flag);
        showSnackBar('useFlagShowWhenLocked($flag)');
      },
      child: const Text('useFlagShowWhenLocked()'),
    );
  }

  Widget buildOpenCSPage() {
    return ElevatedButton(
      onPressed: () async {
        log('openCSPage() userId=$userId');
        await AdPopcornOfferwall.openCSPage(userId);
      },
      child: const Text('openCSPage()'),
    );
  }

  Widget buildGetEarnableTotalRewardInfo() {
    return ElevatedButton(
      onPressed: () async {
        log('getEarnableTotalRewardInfo()');
        await AdPopcornOfferwall.getEarnableTotalRewardInfo(
            (queryResult, totalCount, totalReward) {
          showSnackBar(
              'onGetEarnableTotalRewardInfo() queryResult=$queryResult, totalCount=$totalCount, totalReward=$totalReward');
        });
      },
      child: const Text('getEarnableTotalRewardInfo()'),
    );
  }

  Widget buildLoadPopupAd() {
    return ElevatedButton(
      onPressed: () async {
        log('loadPopupAd()');
        await AdPopcornOfferwall.loadPopupAd(
          onLoadPopupAdSuccess: () => showSnackBar('onLoadPopupAdSuccess()'),
          onLoadPopupAdFailure: (errorCode, errorMessage) => showSnackBar(
              'onLoadPopupAdFailure() errorCode=$errorCode, errorMessage=$errorMessage'),
          onShowPopupAdSuccess: () => showSnackBar('onShowPopupAdSuccess()'),
          onShowPopupAdFailure: (errorCode, errorMessage) => showSnackBar(
              'onShowPopupAdFailure()) errorCode=$errorCode, errorMessage=$errorMessage'),
          onPopupAdClose: () => showSnackBar('onPopupAdClose()'),
        );
      },
      child: const Text('loadPopupAd()'),
    );
  }

  Widget buildShowPopupAd() {
    return ElevatedButton(
      onPressed: () async {
        log('showPopupAd()');
        await AdPopcornOfferwall.showPopupAd();
      },
      child: const Text('showPopupAd()'),
    );
  }
}
