import 'dart:async';
import 'dart:developer';

import 'package:adpopcorn_flutter_sdk/adpopcorn_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final textControllerUserId = TextEditingController();
  String userId = '';

  @override
  void initState() {
    super.initState();
    initEventListener();
  }

  @override
  void dispose() {
    textControllerUserId.dispose();
    super.dispose();
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
      duration: const Duration(milliseconds: 600),
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
                  const SizedBox(height: 32),
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
                      final result = await AdpopcornFlutterSdk.setUserId(userId);
                      showSnackBar('setUserId() $result');
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
                      final result = await AdpopcornFlutterSdk.useFlagShowWhenLocked(false);
                      showSnackBar('useFlagShowWhenLocked() $result');
                    },
                    child: const Text('useFlagShowWhenLocked()'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      log('openCSPage() userId=$userId');
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
          ),
                ),
              )),
        ),
      ),
    );
  }
}
