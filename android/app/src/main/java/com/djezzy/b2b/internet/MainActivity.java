package com.djezzy.b2b.internet;

import android.util.Log;

import androidx.annotation.NonNull;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {

    private final String CHANNEL = "com.djezzy.b2b.internet/native";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((methodCall, result) -> {

                    if("F94027e6f".equals(methodCall.method))
                        result.success(Constants.getInstance().F94027e6f());
                    else if("F624ec337".equals(methodCall.method))
                        result.success(Constants.getInstance().F624ec337());
                    else if("F0ca8c48e".equals(methodCall.method))
                        result.success(Constants.getInstance().F0ca8c48e());
                    else if("F49c4f779".equals(methodCall.method))
                        result.success(Constants.getInstance().F49c4f779());
                    else if("Ff07c6783".equals(methodCall.method))
                        result.success(Constants.getInstance().Ff07c6783());
                    else if("Fe8ed80d7".equals(methodCall.method))
                        result.success(Constants.getInstance().Fe8ed80d7());

                    //Base URL
                    else if("Ffa442cd3".equals(methodCall.method))
                        result.success(Constants.getInstance().Ffa442cd3());
                    //Registration URL
                    else if("F48628b49".equals(methodCall.method))
                        result.success(Constants.getInstance().F48628b49());
                    //Token URL
                    else if("Fe54a2fc7".equals(methodCall.method))
                        result.success(Constants.getInstance().Fe54a2fc7());
                    //Information URL
                    else if("Fe0c2ae9e".equals(methodCall.method))
                        result.success(Constants.getInstance().Fe0c2ae9e());
                        //Care URL
                    else if("Fccd83952".equals(methodCall.method))
                        result.success(Constants.getInstance().Fccd83952());
                        //Epayment
                    else if("Fee12c08d".equals(methodCall.method))
                        result.success(Constants.getInstance().Fee12c08d());

                    //Shared preferences getter
                    else if("Fb8c0bb40".equals(methodCall.method))
                        result.success(Constants.getInstance().Fb8c0bb40());
                    else if("Fb8c0bb42".equals(methodCall.method))
                        result.success(Constants.getInstance().Fb8c0bb42());
                    else if("Fb8c0bb44".equals(methodCall.method))
                        result.success(Constants.getInstance().Fb8c0bb44());
                    else if("Fb8c0bb46".equals(methodCall.method))
                        result.success(Constants.getInstance().Fb8c0bb46());
                    else if("Fb8c0bb48".equals(methodCall.method))
                        result.success(Constants.getInstance().Fb8c0bb48());

                    //Shared preferences setter
                    else if("Fb8c0bb41".equals(methodCall.method))
                        result.success(Constants.getInstance().Fb8c0bb41(methodCall.argument("msisdn")));
                    else if("Fb8c0bb43".equals(methodCall.method))
                        result.success(Constants.getInstance().Fb8c0bb43(methodCall.argument("token")));
                    else if("Fb8c0bb45".equals(methodCall.method))
                        result.success(Constants.getInstance().Fb8c0bb45(methodCall.argument("token")));
                    else if("Fb8c0bb47".equals(methodCall.method))
                        result.success(Constants.getInstance().Fb8c0bb47(methodCall.argument("type")));
                    else if("Fb8c0bb49".equals(methodCall.method))
                        result.success(Constants.getInstance().Fb8c0bb49(methodCall.argument("locale")));

                    else if("get".equals(methodCall.method))
                        result.success(Constants.getInstance().Fb8c0bb50(methodCall.argument("key")));
                    else if("set".equals(methodCall.method))
                        result.success(Constants.getInstance().Fb8c0bb51(
                                methodCall.argument("key"), methodCall.argument("value")));

                    else
                        result.notImplemented();
                });
    }
}