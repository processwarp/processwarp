package org.processwarp.android;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.os.RemoteException;
import android.support.annotation.Nullable;

public class RouterService extends Service {
    private Router router = null;
    private ServerConnector server = null;

    /**
     * When create service, setup Router and Server Connector instances.
     */
    @Override
    public void onCreate() {
        router = new Router();
        server = new ServerConnector();

        router.initialize(server);
        server.initialize(router);
    }

    /**
     * When service is created explicit, connect with server by Socket.IO if needed.
     * @param intent Not used.
     * @param flags Not used.
     * @param startId Not used.
     * @return START_STICKY value.
     */
    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        server.connect();

        return START_STICKY;
    }

    /**
     * When service is bundled by another process, pass binder.
     * @param intent Not used.
     * @return Binder.
     */
    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return binder;
    }

    private RouterInterface.Stub binder = new RouterInterface.Stub() {
        /**
         * When method is called by frontend, pass it to router.
         * @param account Account string.
         * @param password Password string.
         * @throws RemoteException
         */
        @Override
        public void connectServer(String account, String password) throws RemoteException {
            router.connectServer(account, password);
        }

        /**
         * When send command is called by another activity or services,
         * make packet and relay to router.
         * @param pid
         * @param dstNid
         * @param module
         * @param content
         * @throws RemoteException
         */
        @Override
        public void sendCommand(String pid, String dstNid, int module, String content)
                throws RemoteException {

            CommandPacket packet = new CommandPacket();
            packet.pid = pid;
            packet.dstNid = dstNid;
            packet.srcNid = SpecialNid.NONE;
            packet.module = module;
            packet.content = content;

            router.relayCommand(packet);
        }
    };

    static {
        System.loadLibrary("processwarp_jni");
    }
}
