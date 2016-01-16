package org.processwarp.android;

import android.support.v4.app.DialogFragment;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;

import junit.framework.Assert;

import java.security.MessageDigest;

public class MainActivity extends AppCompatActivity {
    /**
     * When create application, call initialize and show connect dialog.
     * @param savedInstanceState Used to super class's method.
     */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        initialize();

        DialogFragment connectDialog = new ConnectDialogFragment();
        connectDialog.show(getSupportFragmentManager(), "");
    }

    /**
     * Initialize some module.
     */
    public void initialize() {
        try {
            ServerConnector server = ServerConnector.getInstance();
            server.initialize();

        } catch (Exception e) {
            Log.e(this.getClass().getName(), "", e);
        }
    }

    /**
     * Connect server, make password SHA256 digest and send to server to check account.
     * @param account Target account name.
     * @param password Target password.
     */
    public void connectServer(String account, String password) {
        try {
            String hexString = null;
            // apply digest 10 times by SHA256
            byte[] digest = password.getBytes("UTF-8");
            for (int i = 0; i < 10; i ++) {
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                md.update(digest);
                digest = md.digest();

                // Convert to hex string.
                StringBuilder hex = new StringBuilder();
                for (byte b : digest) {
                    if ((b & 0xFF) <= 0x0F) hex.append("0");
                    hex.append(Integer.toHexString(b & 0xFF));
                }
                hexString = hex.toString();
                digest = hexString.getBytes("UTF-8");
            }

            // Send to server
            ServerConnector server = ServerConnector.getInstance();
            server.sendConnectNode(account, "[10sha256]" + hexString);

        } catch (Exception e) {
            Assert.fail("");
        }
    }
}
