package module.com.netease.androidflutter;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.TextUtils;
import android.widget.TextView;
import android.widget.Toast;

public class FlutterActivity extends AppCompatActivity {
    private TextView text;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_flutter);
        text = findViewById(R.id.text);
        String params = getIntent().getStringExtra("test");
        if (!TextUtils.isEmpty(params)){
            Toast.makeText(this, "" + params, Toast.LENGTH_SHORT).show();

            text.setText("flutter 传参:" + params);

        }
    }
}
