package org.processwarp.android;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Build;
import android.os.Handler;
import android.os.IBinder;
import android.os.RemoteException;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.webkit.WebView;

import junit.framework.Assert;

import org.json.JSONException;
import org.json.JSONObject;

public class GuiActivity extends AppCompatActivity implements ServiceConnection {
    /** Heartbeat interval.(sec) */
    private final int HEARTBEAT_INTERVAL = 3;
    /** GUI status. */
    enum Status { NORMAL, WAIT_WARP }

    /** AIDL Router interface to relay commands. */
    private RouterInterface router = null;
    /** Process-id for this GUI module. */
    private String myPid = null;
    /** Node-id for this node. */
    private String myNid = null;
    /** WebView reference for speed-up. */
    private WebView webView = null;
    /** GUI status. */
    private Status status = Status.NORMAL;
    /** Node-id to warp(this id is enable when status is WAIT_WARP). */
    private String warp_target_nid = null;
    /** Handler to heartbeat. */
    private Handler handler = new Handler();

    /**
     * When create gui, set default html to web view, get parameters from intent,
     * and connect to router service.
     * @param savedInstanceState Used to super class's method.
     */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_gui);
        webView = (WebView)findViewById(R.id.web_view);
        webView.getSettings().setJavaScriptEnabled(true);
        webView.loadUrl("file:///android_asset/frame.html");

        Intent intent = getIntent();
        myPid = intent.getStringExtra("pid");
    }

    /**
     * When resume gui activity, (re)bind to router service.
     */
    @Override
    protected void onResume() {
        Log.v(this.getClass().getName(), "onResume");

        super.onResume();
        bindService(new Intent(this, RouterService.class), this,
                Context.BIND_ABOVE_CLIENT | Context.BIND_AUTO_CREATE);
    }

    /**
     * When pause gui activity, unregister and unbind from router service.
     */
    @Override
    protected void onPause() {
        Log.v(this.getClass().getName(), "onPause");

        if (router != null) try {
            router.unregisterGui(myPid);
            router = null;

        } catch (RemoteException e) {
            // TODO error
            Log.e(this.getClass().getName(), "onPause", e);
            Assert.fail();
        }
        unbindService(this);
        super.onPause();
    }

    /**
     * When connect with router service, save reference, set to router,
     * register callback and get node-id for this node, start heartbeat.
     * @param name Not used.
     * @param service Router interface.
     */
    @Override
    public void onServiceConnected(ComponentName name, IBinder service) {
        router = RouterInterface.Stub.asInterface(service);
        try {
            router.registerGui(myPid, callback);
            myNid = router.getMyNid();

        } catch (RemoteException e) {
            // TODO
            Log.e(this.getClass().getName(), "onServiceConnected", e);
            Assert.fail();
        }

        // Start heartbeat.
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                switch (status) {
                    case NORMAL:
                        sendCommandHeartbeatGui();
                        break;

                    case WAIT_WARP:
                        sendCommandWarpGui();
                        break;

                    default:
                        // TODO error
                        Log.e(this.getClass().getName(), "onCreate");
                        Assert.fail();
                }
                // Set next heartbeat if connection is enable.
                if (router != null) handler.postDelayed(this, HEARTBEAT_INTERVAL * 1000);
            }
        }, HEARTBEAT_INTERVAL * 1000);
    }

    /**
     * When disconnect from router service.
     * @param name Not used.
     */
    @Override
    public void onServiceDisconnected(ComponentName name) {
        Log.e(this.getClass().getName(), "onServiceDisconnected");
        router = null;
        // TODO error
        Assert.fail();
    }

    /** Make a call back instance for AIDL. */
    private GuiInterface callback = new GuiInterface.Stub() {
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
            Assert.assertTrue(pid.equals(myPid) || pid.equals(SpecialPid.BROADCAST));
            Assert.assertEquals(Module.GUI, module);

            CommandPacket packet = new CommandPacket();
            packet.pid = pid;
            packet.dstNid = dstNid;
            packet.srcNid = srcNid;
            packet.module = module;
            packet.content = content;
            recvCommand(packet);
        }
    };

    /**
     * When receive command from another module or node through router,
     * decode and call capable method.
     * @param packet Packet content.
     */
    private void recvCommand(CommandPacket packet) {
        try {
            JSONObject param = new JSONObject(packet.content);
            String command = param.getString("command");

            if ("heartbeat_gui".equals(command)) {
                recvCommandHeartbeatGui(packet, param);

            } else if ("script".equals(command)) {
                recvCommandScript(packet, param);

            } else if ("require_warp_gui".equals(command)) {
                recvCommandRequireWarpGui(packet, param);

            } else {
                // TODO error
                Log.v(this.getClass().getName(), command);
                Assert.fail();
            }

        } catch (JSONException e) {
            // TODO error
            Log.e(this.getClass().getName(), "recvCommand", e);
            Assert.fail();
        }
    }

    /**
     * When receive heartbeat_gui command from another node, close GUI if on warp sequence.
     * @param packet Command packet.
     * @param param Parameter for command content.
     */
    private void recvCommandHeartbeatGui(CommandPacket packet, JSONObject param) {
        Log.v(this.getClass().getName(), "recvCommandHeartbeatGui");

        if (packet.srcNid.equals(myNid)) return;
        Assert.assertTrue(status != Status.NORMAL);

        if (status == Status.WAIT_WARP) {
            Intent intent = new Intent(getApplicationContext(), ControllerActivity.class);
            startActivity(intent);
        }
    }

    /**
     * When receive require_warp_gui command, save target node-id and send warp_gui command.
     * Ignore if GUI status isn't NORMAL (ex. On warp sequence to another node).
     * Ignore if target node is this node.
     * @param packet Command packet.
     * @param param Not used.
     */
    private void recvCommandRequireWarpGui(CommandPacket packet, JSONObject param) {
        Log.v(this.getClass().getName(), "recvCommandRequireWarpGui");

        if (status != Status.NORMAL) return;
        try {
            String target_nid = param.getString("target_nid");
            if (target_nid.equals(myNid)) return;
            warp_target_nid = target_nid;
        } catch (JSONException e) {
            // TODO error
            Log.e(this.getClass().getName(), "recvCommandRequireWarpGui", e);
        }
        status = Status.WAIT_WARP;
        sendCommandWarpGui();
    }

    /**
     * When receive script command, evaluate script as javascript on web view.
     * @param packet Command packet.
     * @param param Command parameter containing script.
     */
    private void recvCommandScript(CommandPacket packet, JSONObject param) {
        String script = null;
        try {
            script = param.getString("script");
        } catch (JSONException e) {
            // TODO error
            Log.e(this.getClass().getName(), "recvCommandScript", e);
        }

        // Scripts must be evaluated in UI thread.
        runOnUiThread(new Runnable() {
            private String script = null;

            public Runnable initialize(String script) {
                this.script = script;
                return this;
            }

            @Override
            public void run() {
                if (Build.VERSION.SDK_INT >= 19) {
                    webView.evaluateJavascript(script, null);
                } else {
                    webView.loadUrl("javascript:" + script);
                }
            }
        }.initialize(script));
    }

    /**
     * Send command packet through router.
     * Drop packets if connection is disabled.
     * @param pid Process-id bundled for packet.
     * @param dstNid Destination node-id.
     * @param module Target module.
     * @param command Command string.
     * @param param Parameters for command.
     */
    private void sendCommand(String pid, String dstNid, int module,
                             String command, JSONObject param) {
        Assert.assertFalse(param.has("command"));
        if (router == null) {
            Log.w(this.getClass().getName(), "Couldn't send command.");
            return;
        }
        try {
            param.put("command", command);
            router.sendCommand(pid, dstNid, module, param.toString());

        } catch (Exception e) {
            // TODO error
            Log.e(this.getClass().getName(), "sendCommand", e);
            Assert.fail();
        }
    }

    /**
     * Send heartbeat_gui command to scheduler and GUI module on all nodes.
     */
    private void sendCommandHeartbeatGui() {
        sendCommand(myPid, SpecialNid.BROADCAST, Module.SCHEDULER,
                "heartbeat_gui", new JSONObject());
        sendCommand(myPid, SpecialNid.BROADCAST, Module.GUI,
                "heartbeat_gui", new JSONObject());
    }

    /**
     * Send warp_gui command to scheduler on the target node.
     */
    private void sendCommandWarpGui() {
        sendCommand(myPid, warp_target_nid, Module.SCHEDULER, "warp_gui", new JSONObject());
    }
}
