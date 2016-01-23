package org.processwarp.android;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.os.RemoteException;
import android.support.annotation.Nullable;

import junit.framework.Assert;

public class RouterService extends Service implements Router.Delegate {
    private Router router = null;
    private ServerConnector server = null;
    private static ControllerInterface controller = null;

    /**
     * When create service, setup Router and Server Connector instances.
     */
    @Override
    public void onCreate() {
        router = new Router();
        server = new ServerConnector();

        router.initialize(this, server);
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
         * When method is called by frontend, save passed controller callback.
         * @param controller Controller callback instance.
         */
        @Override
        public void registerController(ControllerInterface controller) {
            Assert.assertNull(RouterService.controller);
            RouterService.controller = controller;
        }

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

    /**
     * When relay controller is required, relay packet to controller by AIDL.
     * @param packet Command packet.
     */
    @Override
    public void relayControllerPacket(CommandPacket packet) {
        if (controller == null) return;

        try {
            controller.recvCommand(
                    packet.pid, packet.dstNid, packet.srcNid,
                    packet.module, packet.content);

        } catch (RemoteException e) {
            Assert.fail();
        }
    }

    static {
        System.loadLibrary("processwarp_jni");
    }
}
