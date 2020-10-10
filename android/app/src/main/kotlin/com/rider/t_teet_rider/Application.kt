package com.rider.t_teet_rider

import io.flutter.app.FlutterApplication
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;


class Application : FlutterApplication(), PluginRegistrantCallback {
    @Override
    override fun onCreate() {
        super.onCreate()
        FlutterFirebaseMessagingService.setPluginRegistrant(this)
    }

    @Override
    override fun registerWith(registry: PluginRegistry?) {
//        GeneratedPluginRegistrant.registerWith(registry)
//        registry?.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin");
        io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin.registerWith(registry?.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));

    }
}