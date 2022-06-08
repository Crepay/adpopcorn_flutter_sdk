package com.crepay.thirdparty.adpopcorn_flutter_sdk

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
import com.igaworks.adpopcorn.Adpopcorn
import com.igaworks.adpopcorn.interfaces.IAdPOPcornEventListener
import io.flutter.Log

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

private const val CHANNEL_NAME = "adpopcorn_flutter_sdk"
private const val TAG: String = "AdpopcornFlutterSdkPlugin";

/** AdpopcornFlutterSdkPlugin */
class AdpopcornFlutterSdkPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {

  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private lateinit var activity: Activity

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL_NAME)
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "setUserId") {
      Adpopcorn.setUserId(activity, call.argument<String>("userId"));
      result.success(true)
    } else if (call.method == "openOfferWall") {
      Adpopcorn.openOfferWall(activity);
      result.success(true)
    } else {
      result.notImplemented()
    }
  }

  private fun initEventListener() {
    val resultHandler = object: MethodChannel.Result {
      override fun success(result: Any?) {
        Log.d(TAG, "success: '$result'")
      }
      override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
        Log.e(TAG, "error: $errorCode, $errorMessage, $errorDetails")
      }
      override fun notImplemented() {
        Log.d(TAG, "notImplemented:")
      }
    }

    Adpopcorn.setEventListener(activity, object : IAdPOPcornEventListener {
      // 오퍼월 진입 후, 개인 정보 수집 동의 시 이벤트 발생
      override fun OnAgreePrivacy() {
        channel.invokeMethod("onAgreePrivacy", null, resultHandler)
      }

      override fun OnDisagreePrivacy() {
        channel.invokeMethod("onDisagreePrivacy", null, resultHandler)
      }

      // 오퍼월이 종료될 때 이벤트 발생
      override fun OnClosedOfferWallPage() {
        channel.invokeMethod("onClosedOfferWallPage", null, resultHandler)
      }
    })
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity;
    initEventListener();
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }
}
