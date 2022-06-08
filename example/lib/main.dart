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
  String _platformVersion = 'Unknown';
  final _adpopcornFlutterSdkPlugin = AdpopcornFlutterSdk();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await AdpopcornFlutterSdk.getPlatformVersion() ?? 'Unknown platform version';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                  const userId = 'TEST_USER_ID';
                  var result = await AdpopcornFlutterSdk.setUserId(userId);
                  log('setUserId() id=$userId, result=$result');
                },
                child: const Text('setUserId()'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  var result = await AdpopcornFlutterSdk.openOfferWall();
                  log('openOfferWall() result=$result');
                },
                child: const Text('openOfferWall()'),
              ),
            ],
          )
        ),
      ),
    );
  }
}
