package module.com.xxx.androidflutter;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.widget.FrameLayout;
import android.widget.TextView;

import io.flutter.facade.Flutter;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;

/**
 * @author chenyouyou
 */
public class MainActivity extends AppCompatActivity {
    private TextView textView;
    /***
     * Flutter提供了两种方式让Android工程来引用组件，一种是View，一种是Fragment，
     * 这里我们用两种方式来引入FLutter，本质是还是是作为一个view引入布局还是将FlutterView作为Activity的根View。
     */
    private FrameLayout frameLayout;
    private FlutterView flutterView;
    public static final String FlutterToAndroidCHANNEL  = "module.com.xxx.androidflutter.toandroid/plugin";
    public static final String  AndroidToFlutterCHANNEL= "module.com.xxx.androidflutter.toflutter/plugin";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_native);
        textView = findViewById(R.id.params);

        frameLayout = findViewById(R.id.rl_flutter);

        /***
         * 通过上面很简单的一个方法，我们就能通过Flutter创建出一个view，这个方法提供三个参数，第一个是Activity，
         * 第二个参数是一个Lifecycle对象，我们之间取Activity的lifecycle即可，第三个参数是告诉Flutter我们要创建一个什么样的view，这个字符串参数可以在Flutter工程中获取得到。
         * 创建出这个FlutterView之后就可以按常规的操作来将它加入到任何你想要的布局中去了。
         */
        // route2 flutter_modlule lib 文件夹下 main.dart 中 所对应 希望加载 哪个页面 就填写相应的 route2 名称.
        flutterView = Flutter.createView(this,getLifecycle(),"route2");
        //flutterview增加到frameLayout
        FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.MATCH_PARENT);
        frameLayout.addView(flutterView, layoutParams);
        /*String params = getIntent().getStringExtra("test");
        if (!TextUtils.isEmpty(params)){
            Toast.makeText(this, "" + params, Toast.LENGTH_SHORT).show();

            textView.setText("flutter 传参:" + params);

        }*/
        //android端 发送信息到flutter端
        new EventChannel(flutterView,AndroidToFlutterCHANNEL)
                .setStreamHandler(new EventChannel.StreamHandler() {
                    @Override
                    public void onListen(Object o, EventChannel.EventSink eventSink) {
                        String androidParmas = "来自android原生的参数";
                        eventSink.success(androidParmas);
                    }

                    @Override
                    public void onCancel(Object o) {

                    }
                });

        //flutter调用android
        new MethodChannel(flutterView,FlutterToAndroidCHANNEL)
                .setMethodCallHandler(new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        //接收来自flutter的指令withoutParams
                        if ("withoutParams".equals(methodCall.method)){
                            Log.d("chenyouyou","_jumpToNative不带参数");
                            //跳转到指定Activity
                            Intent intent = new Intent(MainActivity.this, FlutterActivity.class);
                            startActivity(intent);

                            //返回给flutter的参数
                            result.success("success");
                        }
                        //接收来自flutter的指令withParams
                        else if ("withParams".equals(methodCall.method)) {
                            Log.d("chenyouyou","_jumpToNativeWithParams带了参数");
                            //解析参数
                            String text = methodCall.argument("flutter");

                            //带参数跳转到指定Activity
                            Intent intent = new Intent(MainActivity.this, FlutterActivity.class);
                            intent.putExtra("test", text);
                            startActivity(intent);

                            //返回给flutter的参数
                            result.success("success");
                        } else {
                            result.notImplemented();
                        }

                    }
                });

    }
}
