package org.processwarp.android;

import android.util.Log;

import junit.framework.Assert;

import org.json.JSONException;
import org.json.JSONObject;

import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import io.socket.client.IO;
import io.socket.client.Socket;
import io.socket.emitter.Emitter;

public class ServerConnector {
    /**
     * ServerConnector instance getter as singleton pattern.
     * @return The singleton instance of ServerConnector class.
     */
    public static ServerConnector getInstance() {
        return THIS;
    }

    /**
     * Initialize ServerConnector, setup Socket.IO instance with trust manager.
     * And relate Socket.IO event with receiver method.
     */
    public void initialize() {
        Log.v(this.getClass().getName(), "initialize()");
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
            socket = IO.socket("http://10.0.2.2/");

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

            socket.connect();
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
            if (!nid.isEmpty()) {
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
        // TODO
    }

    /** Singleton instance for ServerConnector. */
    private static final ServerConnector THIS = new ServerConnector();
    /** Socket.IO instance. */
    private Socket socket;

    /**
     * Constructor for singleton pattern.
     * This class is singleton.
     */
    private ServerConnector() {
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

    private void recvConnectNode(JSONObject data) {
        // TODO: 1/13/16
    }

    private void recvBindNode(JSONObject data) {
        // TODO: 1/13/16
    }

    private void recvRelayCommand(JSONObject data) {
        // TODO: 1/13/16
    }
}
