package org.processwarp.android;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.os.RemoteException;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.webkit.WebView;

import junit.framework.Assert;

import org.json.JSONException;
import org.json.JSONObject;

public class FrontendActivity extends AppCompatActivity implements ServiceConnection {
    /** AIDL Router interface to relay commands. */
    private RouterInterface router = null;
    /** Process-id for this frontend. */
    private String myPid = null;
    /** WebView reference for speed-up. */
    private WebView webView = null;

    /**
     * When create frontend, set default html to web view, get parameters from intent,
     * and connect to router service.
     * @param savedInstanceState Used to super class's method.
     */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_frontend);
        webView = (WebView)findViewById(R.id.web_view);
        webView.loadUrl("file:///android_asset/frame.html");

        Intent intent = getIntent();
        myPid = intent.getStringExtra("pid");

        bindService(new Intent(this, RouterService.class), this,
                Context.BIND_ABOVE_CLIENT | Context.BIND_AUTO_CREATE);
    }

    /**
     * When connect with router service, save reference, set to router,
     * register callback and send create_gui_done command to SCHEDULER.
     * @param name Not used.
     * @param service Router interface.
     */
    @Override
    public void onServiceConnected(ComponentName name, IBinder service) {
        router = RouterInterface.Stub.asInterface(service);
        try {
            router.registerFrontend(myPid, callback);

            sendCommand(myPid, SpecialNid.THIS, Module.SCHEDULER,
                    "create_gui_done", new JSONObject());

        } catch (RemoteException e) {
            // TODO
            e.printStackTrace();
            Assert.fail();
        }
    }

    /**
     * When disconnect from router service.
     * @param name Not used.
     */
    @Override
    public void onServiceDisconnected(ComponentName name) {
        router = null;
        // TODO
        Assert.fail();
    }

    /** Make a call back instance for AIDL. */
    private FrontendInterface callback = new FrontendInterface.Stub() {
        /**
         * Receiver for AIDL to relay command.
         * @param pid Process-id bundled for packet.
         * @param dstNid Destination node-id.
         * @param srcNid Source node-id.
         * @param module Target module.
         * @param content Packet content JSON formatted string.
         * @throws RemoteException
         */
        @Override
        public void relayCommand(String pid, String dstNid, String srcNid,
                                 int module, String content) throws RemoteException {
            Assert.assertEquals(myPid, pid);
            Assert.assertEquals(Module.FRONTEND, module);
            recvCommand(content);
        }
    };

    /**
     * When receive command from another module or node through router,
     * decode and call capable method.
     * @param content Packet content JSON formatted string.
     */
    private void recvCommand(String content) {
        try {
            JSONObject param = new JSONObject(content);
            String command = param.getString("command");

            if ("script".equals(command)) {
                recvCommandScript(param);

            } else if ("warpin".equals(command)) {
                recvCommandWarpin(param);

            } else {
                // TODO error
                Log.v(this.getClass().getName(), command);
                Assert.fail();
            }

        } catch (JSONException e) {
            // TODO error
            e.printStackTrace();
            Assert.fail();
        }
    }

    /**
     * When receive script command, evaluate script as javascript on web view.
     * @param param Command parameter containing script.
     * @throws JSONException
     */
    private void recvCommandScript(JSONObject param) throws JSONException {
        String script = param.getString("script");

        runOnUiThread(new Runnable() {
            private String script = null;

            public Runnable initialize(String script) {
                this.script = script;
                return this;
            }

            @Override
            public void run() {
                webView.loadUrl("javascript:" + script);
            }
        }.initialize(script));
    }

    /**
     * When receive warpin command, close activity.
     * @param param Not used.
     */
    private void recvCommandWarpin(JSONObject param) {
        finish();
    }

    /**
     * Send command packet through router.
     * @param pid Process-id bundled for packet.
     * @param dstNid Destination node-id.
     * @param module Target module.
     * @param command Command string.
     * @param param Parameters for command.
     */
    private void sendCommand(String pid, String dstNid, int module,
                             String command, JSONObject param) {
        Assert.assertFalse(param.has("command"));
        try {
            param.put("command", command);
            router.sendCommand(pid, dstNid, module, param.toString());

        } catch (Exception e) {
            // TODO error
            e.printStackTrace();
            Assert.fail();
        }
    }
}
