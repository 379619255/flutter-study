package com.example.flutter_app;

import android.app.Activity;

import android.os.Bundle;
import android.text.TextUtils;
import android.widget.TextView;
import android.widget.Toast;
//R文件在此找不到，但是项目又可以正常运行
public class Main2Activity extends Activity {
    private TextView text;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);
        text = findViewById(R.id.text);
        String params = getIntent().getStringExtra("test");
        if (!TextUtils.isEmpty(params)){
            Toast.makeText(this, "" + params, Toast.LENGTH_SHORT).show();

            text.setText("flutter 传参:" + params);

        }
    }
}
