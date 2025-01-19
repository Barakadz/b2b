package com.djezzy.b2b.internet;

import io.flutter.app.FlutterApplication;

public class AppDelegate extends FlutterApplication {

    @Override
    public void onCreate() {
        super.onCreate();
        instance = this;
    }

    /******************************** SINGLETON ********************************/

    private static AppDelegate instance;

    public static AppDelegate getInstance() { return instance; }
}
