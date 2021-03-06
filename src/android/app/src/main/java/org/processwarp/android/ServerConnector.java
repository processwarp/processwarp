package org.processwarp.android;

import android.util.Log;

import junit.framework.Assert;

import org.json.JSONException;
import org.json.JSONObject;
import org.processwarp.android.constant.NID;

import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import io.socket.client.IO;
import io.socket.client.Socket;
import io.socket.emitter.Emitter;

public class ServerConnector {
    /** Socket.IO instance. */
    private Socket socket;
    /** Router instance for relay event. */
    private Router router;
    /** Instance for event listener. */
    private ServerConnector THIS = null;

    private boolean isConnected = false;

    // TODO check status

    /**
     * Initialize ServerConnector, setup Socket.IO instance with trust manager.
     * And relate Socket.IO event with receiver method.
     * @param router Router instance for relay event.
     */
    public void initialize(Router router) {
        Log.v(this.getClass().getName(), "initialize");

        // Save instance for event listener.
        Assert.assertNull(THIS);
        THIS = this;

        this.router = router;
        try {
            // Skip verification of certificate.
            final TrustManager[] manager = {new X509TrustManager() {

                @Override
                public X509Certificate[] getAcceptedIssuers() {
                    return new X509Certificate[0];
                }

                @Override
                public void checkServerTrusted(X509Certificate[] chain, String authType)
                        throws CertificateException {
                    // do nothing
                }

                @Override
                public void checkClientTrusted(X509Certificate[] chain, String authType)
                        throws CertificateException {
                    // do nothing
                }
            }};
            SSLContext sslContext = SSLContext.getInstance("TLS");
            sslContext.init(null, manager, null);

            // Setup Socket.IO
            IO.setDefaultSSLContext(sslContext);
            socket = IO.socket("https://prev.processwarp.org/");

        } catch (Exception e) {
            Log.e(this.getClass().getName(), "Wrong in configuration ?", e);
            Assert.fail("Wrong in configuration ?");
        }

        socket.on(Socket.EVENT_CONNECT_ERROR, onConnectError);
        socket.on(Socket.EVENT_CONNECT_TIMEOUT, onConnectError);
        socket.on(Socket.EVENT_ERROR, onConnectError);

        socket.on("sys_error", new Emitter.Listener() {
            @Override
            public void call(Object... args) {
                THIS.recvSystemError((JSONObject) args[0]);
            }
        });

        socket.on("app_error", new Emitter.Listener() {
            @Override
            public void call(Object... args) {
                THIS.recvApplicationError((JSONObject) args[0]);
            }
        });

        socket.on("connect_node", new Emitter.Listener() {
            @Override
            public void call(Object... args) {
                THIS.recvConnectNode((JSONObject) args[0]);
            }
        });

        socket.on("bind_node", new Emitter.Listener() {
            @Override
            public void call(Object... args) {
                THIS.recvBindNode((JSONObject) args[0]);
            }
        });

        socket.on("relay_command", new Emitter.Listener() {
            @Override
            public void call(Object... args) {
                THIS.recvRelayCommand((JSONObject) args[0]);
            }
        });
    }

    /**
     * Connect to server if not connected.
     */
    public void connect() {
        if (!socket.connected()) {
            socket.connect();
        }
    }

    /**
     * Check if has connection with the server be enabled.
     * @return True if connection with the server has be enabled.
     */
    public boolean isConnected() {
        return socket.connected() && isConnected;
    }

    /**
     * Send connect_node command.
     * @param account Account name.
     * @param password Password for account.
     */
    public void sendConnectNode(String account, String password) {
        Log.v(this.getClass().getName(),
                String.format("sendConnectNode(account = %s, password = *)", account));

        try {
            JSONObject data = new JSONObject();
            data.put("account", account);
            data.put("password", password);
            socket.emit("connect_node", data);

        } catch (JSONException e) {
            Log.e(this.getClass().getName(), "Exception", e);
        }
    }

    /**
     * Send bind_node command.
     * @param nid Node-id just using or empty if not assigned.
     * @param nodeName Node name.
     */
    public void sendBindNode(String nid, String nodeName) {
        Log.v(this.getClass().getName(),
                String.format("sendBindNode(nid = %s, node_name = %s)", nid, nodeName));

        try {
            JSONObject data = new JSONObject();
            if (nid != null) {
                data.put("nid", nid);
            }
            data.put("node_name", nodeName);

            socket.emit("bind_node", data);

        } catch (JSONException e) {
            Log.e(this.getClass().getName(), "Exception", e);
        }
    }

    /**
     * Relay command to another node by through by server.
     * @param packet Command packet.
     */
    public void sendRelayCommand(CommandPacket packet) {
        try {
            JSONObject data = new JSONObject();

            data.put("pid", packet.pid);
            data.put("dst_nid", packet.dstNid);
            data.put("module", Integer.toHexString(packet.module));
            data.put("content", packet.content);

            socket.emit("relay_command", data);

        } catch (JSONException e) {
            Log.e(this.getClass().getName(), "Exception", e);
        }
    }

    /**
     * When receive error event from Socket.IO, show log if debug mode.
     */
    private Emitter.Listener onConnectError = new Emitter.Listener() {
        @Override
        public void call(Object... args) {
            // TODO
            Log.d("####", "ConnectError");
        }
    };

    private void recvSystemError(JSONObject data) {
        // TODO
        Log.e(this.getClass().getName(), "recvSystemError");
    }

    private void recvApplicationError(JSONObject data) {
        // TODO
        Log.e(this.getClass().getName(), "recvApplicationError");
    }

    /**
     * When receive bind-node command reply, call Router's method.
     * Receive data having member 'result',0 means success, other means error code.
     * Receive data having member 'nid' is assigned node-id for this node.
     * @param data Receive data.
     */
    private void recvConnectNode(JSONObject data) {
        try {
            router.recvConnectNode(data.getInt("result"));

        } catch (JSONException e) {
            Log.e(this.getClass().getName(), "recvConnectNode");
        }
    }

    /**
     * When receive bind-node command reply, call Router's method.
     * Receive data having member 'result',0 means success, other means error code.
     * Receive data having member 'nid' is assigned node-id for this node.
     * @param data Receive data.
     */
    private void recvBindNode(JSONObject data) {
        try {
            int result = data.getInt("result");
            if (result == 0) {
                String nid = data.getString("nid");
                router.recvBindNode(result, nid);
                isConnected = true;

            } else {
                router.recvBindNode(result, "");
            }

        } catch (JSONException e) {
            Log.e(this.getClass().getName(), "recvBindNode");
        }
    }

    /**
     * When receive relay_command packet from server, check if me should receive it,
     * and relay to capable modules.
     * If connection was not established, drop any packets from the server.
     * @param data Received data.
     */
    private void recvRelayCommand(JSONObject data) {
        if (!isConnected) return;
        String myNid = router.getMyNid();

        try {
            CommandPacket packet = new CommandPacket();
            packet.dstNid = data.getString("dst_nid");
            packet.srcNid = data.getString("src_nid");

            if ((!myNid.equals(packet.dstNid) && !NID.BROADCAST.equals(packet.dstNid)) ||
                    myNid.equals(packet.srcNid)) {
                return;
            }

            packet.pid    = data.getString("pid");
            packet.module = Integer.parseInt(data.getString("module"), 16);
            packet.content = data.getString("content");

            router.relayCommand(packet, true);

        } catch (JSONException e) {
            Log.e(this.getClass().getName(), "recvRelayCommand");
        }
    }
}
