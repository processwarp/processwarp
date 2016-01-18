package org.processwarp.android;

import android.support.v4.app.DialogFragment;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

public class MainActivity extends AppCompatActivity {
    /**
     * When create application, call initialize and show connect dialog.
     * @param savedInstanceState Used to super class's method.
     */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Router router = Router.getInstance();
        router.initialize();

        DialogFragment connectDialog = new ConnectDialogFragment();
        connectDialog.show(getSupportFragmentManager(), "");
    }

    static {
        System.loadLibrary("processwarp_jni");
    }
}
