import 'dart:async';
import 'dart:developer';

import 'package:adpopcorn_flutter_sdk/adpopcorn_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

const userId = 'TEST_USER_ID';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initEventListener();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await AdpopcornFlutterSdk.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  void initEventListener() {
    AdpopcornFlutterSdk.setOnAgreePrivacy(
        () => showSnackBar('onAgreePrivacy!'));
    AdpopcornFlutterSdk.setOnDisagreePrivacy(
        () => showSnackBar('onDisagreePrivacy!'));
    AdpopcornFlutterSdk.setOnClosedOfferWallPage(
        () => showSnackBar('onClosedOfferWallPage!'));
  }

  void showSnackBar(String text) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          children: [
            const SizedBox(height: 32),
            Text('Running on: $_platformVersion'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                log('setUserId() id=$userId');
                await AdpopcornFlutterSdk.setUserId(userId);
              },
              child: const Text('setUserId()'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                log('openOfferWall()');
                await AdpopcornFlutterSdk.openOfferWall();
              },
              child: const Text('openOfferWall()'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                log('useFlagShowWhenLocked()');
                await AdpopcornFlutterSdk.useFlagShowWhenLocked(false);
              },
              child: const Text('useFlagShowWhenLocked()'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                log('openCSPage()');
                await AdpopcornFlutterSdk.openCSPage(userId);
              },
              child: const Text('openCSPage()'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                log('getEarnableTotalRewardInfo()');
                await AdpopcornFlutterSdk.getEarnableTotalRewardInfo(
                    (queryResult, totalCount, totalReward) {
                  showSnackBar(
                      'queryResult=$queryResult, totalCount=$totalCount, totalReward=$totalReward');
                });
              },
              child: const Text('getEarnableTotalRewardInfo()'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                log('loadPopupAd()');
                await AdpopcornFlutterSdk.loadPopupAd(
                  onLoadPopupAdSuccess: () =>
                      showSnackBar('onLoadPopupAdSuccess'),
                  onLoadPopupAdFailure: (errorCode, errorMessage) => showSnackBar(
                      'onLoadPopupAdFailure: errorCode=$errorCode, errorMessage=$errorMessage'),
                  onShowPopupAdSuccess: () =>
                      showSnackBar('onShowPopupAdSuccess'),
                  onShowPopupAdFailure: (errorCode, errorMessage) => showSnackBar(
                      'onShowPopupAdFailure: errorCode=$errorCode, errorMessage=$errorMessage'),
                  onPopupAdClose: () => showSnackBar('onPopupAdClose'),
                );
              },
              child: const Text('loadPopupAd()'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                log('showPopupAd()');
                await AdpopcornFlutterSdk.showPopupAd();
              },
              child: const Text('showPopupAd()'),
            ),
          ],
        )),
      ),
    );
  }
}
