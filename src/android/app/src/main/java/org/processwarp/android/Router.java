package org.processwarp.android;

import android.os.Build;
import android.util.Log;

import junit.framework.Assert;

import java.security.MessageDigest;

public class Router {
    public static Router getInstance() {
        return THIS;
    }

    /**
     * Initialize some module.
     */
    public void initialize() {
        try {
            myNid = "";
            schedulerInitialize();

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

    public void recvConnectNode(int result) {
        if (result == 0) {
            ServerConnector server = ServerConnector.getInstance();
            server.sendBindNode(myNid, Build.HOST);

        } else {
            // TODO
            Assert.fail();
        }
    }

    public void recvBindNode(int result, String nid) {
        if (result == 0) {
            myNid = nid;
            schedulerSetMyNid(nid);

        } else {
            // TODO
            Assert.fail();
        }
    }

    private static final Router THIS = new Router();
    private String myNid;

    private Router() {
    }

    private native void schedulerInitialize();
    private native String schedulerGetDstNid(String pid, int module);
    private native void schedulerRecvCommand(String pid, String dstNid, String srcNid,
                                             int module, String content);
    private native void schedulerSetMyNid(String nid);
    private native void schedulerActivate();
}
