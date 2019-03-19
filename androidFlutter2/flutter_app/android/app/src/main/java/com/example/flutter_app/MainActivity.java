package com.example.flutter_app;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    //通道标识，名称相同的通道会干扰彼此的通信
    private static final String CHANNEL = "samples.flutter.io/battery";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //    setMethodCallHandler在此通道上接收方法调用的回调  flutter调用android
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        Log.d("test","---------methodCall.method="+methodCall.method);
//                通过methodCall可以获取参数和方法名  执行对应的平台业务逻辑即可
                        if (methodCall.method.equals("getBatteryLevel")) {
                            Log.d("test","---------getBatteryLevel");
                            int batteryLevel = getBatteryLevel();
                            if (batteryLevel != -1) {
                                result.success(batteryLevel);
                            } else {
                                result.error("UNAVAILABLE", "Battery level not available.", null);
                            }
                        } else if (methodCall.method.equals("withNOData")){
                            //跳转不传入参数
                            //跳转到指定Activity
                            Log.d("test","---------no data");
                            Intent intent = new Intent(MainActivity.this, Main2Activity.class);
                            startActivity(intent);

                            //返回给flutter的参数
                            result.success("success");

                        }else if (methodCall.method.equals("withData")){
                            //跳转传入参数
                            //解析参数
                            String text = methodCall.argument("flutter");
                            Log.d("test","---------no data"+text);
                            //带参数跳转到指定Activity
                            Intent intent = new Intent(MainActivity.this, Main2Activity.class);
                            intent.putExtra("test", text);
                            startActivity(intent);

                            //返回给flutter的参数
                            result.success("success");
                        }
                        else {
                            result.notImplemented();
                        }
                    }
                }
        );
    }

    /**
     * 获取电池电量
     *
     * @return
     */
    private int getBatteryLevel() {

        int batteryLevel = -1;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(getApplicationContext()).
                    registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }
        return batteryLevel;
    }
}
