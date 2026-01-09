package com.example.cyberlog_app

import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "device_info_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            when (call.method) {
                "getDeviceModel" -> {
                    val model = Build.MANUFACTURER + " " + Build.MODEL +
                            " | Android " + Build.VERSION.RELEASE +
                            " (SDK " + Build.VERSION.SDK_INT + ")"
                    result.success(model)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
