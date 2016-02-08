package org.processwarp.android;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.os.RemoteException;
import android.support.annotation.Nullable;
import android.util.Log;

import junit.framework.Assert;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RouterService extends Service implements Router.Delegate {
    /** Max gui number. */
    private static final int MAX_GUIS = 3;
    /** Max worker number. */
    private static final int MAX_WORKERS = 3;
    /** Classes for start worker service. */
    private static final Class<?> WORKER_CLASSES[] = {
            WorkerService0.class,
            WorkerService1.class,
            WorkerService2.class
    };

    /** The router having native interface. */
    private static Router router = null;
    /** The server for relay packet. */
    private static ServerConnector server = null;
    /** The controller callback for relay CONTROLLER command. */
    private static ControllerInterface controller = null;

    /** Map of Process-id and worker callback for relay VM and VMEMORY command. */
    private static Map<String, WorkerInterface> workers = new HashMap<String, WorkerInterface>();
    private static Map<String, List<CommandPacket>> workerSendWait =
            new HashMap<String, List<CommandPacket>>();
    /** Process-id bind for worker. Array index is equal to worker index. */
    private String[] workerPid = new String[MAX_WORKERS];

    private static Map<String, GuiInterface> guis =
            new HashMap<String, GuiInterface>();
    private static Map<String, List<CommandPacket>> guiSendWait =
            new HashMap<String, List<CommandPacket>>();
    private String[] guiPid = new String[MAX_GUIS];


    /**
     * When create service, setup Router and Server Connector instances.
     */
    @Override
    public void onCreate() {
        Log.v(this.getClass().getName(), "onCreate");
        router = new Router();
        server = new ServerConnector();

        router.initialize(this, server);
        server.initialize(router);
    }

    /**
     * When service is created explicit, return START_NOT_STICKY to continue as explicit as possible.
     * @param intent Not used.
     * @param flags Not used.
     * @param startId Not used.
     * @return START_NOT_STICKY value.
     */
    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.v(this.getClass().getName(), "onStartCommand");

        return START_NOT_STICKY;
    }

    /**
     * When service is bundled by another process, pass binder.
     * @param intent Not used.
     * @return Binder.
     */
    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        Log.v(this.getClass().getName(), "onBind");
        return binder;
    }

    private RouterInterface.Stub binder = new RouterInterface.Stub() {
        /**
         * When method is called by controller, pass it to router.
         * @param account Account string.
         * @param password Password string.
         * @throws RemoteException
         */
        @Override
        public void connectServer(String account, String password) throws RemoteException {
            server.connect();
            router.connectServer(account, password);
        }

        /**
         * It check if has connection with server is created.
         * @return True if connection with server has be created.
         * @throws RemoteException
         */
        @Override
        public boolean isConnectServer() throws RemoteException {
            return server.isConnected();
        }

        /**
         * Get this node's node-id.
         * @return This node's node-id.
         * @throws RemoteException
         */
        @Override
        public String getMyNid() throws RemoteException {
            return router.getMyNid();
        }

        /**
         * When method is called by controller, save passed controller callback.
         * @param controller Controller callback instance.
         */
        @Override
        public void registerController(ControllerInterface controller) {
            Assert.assertNull(RouterService.controller);
            RouterService.controller = controller;
        }

        /**
         * When method is called by gui, save gui callback with process-id.
         * If packets are waiting to send in buffer, send packet and remove buffer.
         * @param pid GUI process-id.
         * @param gui GUI callback instance.
         * @throws RemoteException
         */
        @Override
        public void registerGui(String pid, GuiInterface gui) throws RemoteException {
            RouterService.guis.put(pid, gui);

            for (CommandPacket packet : guiSendWait.get(pid)) {
                try {
                    gui.relayCommand(
                            packet.pid,
                            packet.dstNid,
                            packet.srcNid,
                            packet.module,
                            packet.content
                    );
                } catch (RemoteException e) {
                    // TODO error
                    Log.e(this.getClass().getName(), "registerGui", e);
                    Assert.fail();
                }
            }
            guiSendWait.remove(pid);
        }

        /**
         * When method is called by worker, save worker callback with process-id.
         * If packets are waiting to send in buffer, send packet and remove buffer.
         * @param pid Worker's process-id.
         * @param worker Worker callback instance.
         */
        @Override
        public void registerWorker(String pid, WorkerInterface worker) {
            RouterService.workers.put(pid, worker);

            for (CommandPacket packet : workerSendWait.get(pid)) {
                try {
                    worker.relayCommand(
                            packet.pid,
                            packet.dstNid,
                            packet.srcNid,
                            packet.module,
                            packet.content
                    );
                } catch (RemoteException e) {
                    // TODO error
                    Log.e(this.getClass().getName(), "registerWorker", e);
                    Assert.fail();
                }
            }
            workerSendWait.remove(pid);
        }

        /**
         * Unregister controller if require from the controller activity.
         * @throws RemoteException
         */
        @Override
        public void unregisterController() throws RemoteException {
            RouterService.controller = null;
        }

        /**
         * Unregister GUI if require from a GUI activity.
         * @param pid Process-id bundled to GUI activity.
         * @throws RemoteException
         */
        @Override
        public void unregisterGui(String pid) throws RemoteException {
            Assert.assertTrue(guis.containsKey(pid) || guiSendWait.containsKey(pid));

            guis.remove(pid);
            guiSendWait.remove(pid);
            for (int i = 0; i < guiPid.length; i ++) {
                if (pid.equals(guiPid[i])) guiPid[i] = null;
            }
        }

        /**
         * Unregister worker if require from a worker service.
         * @param pid Process-id bundled to worker service.
         * @throws RemoteException
         */
        @Override
        public void unregisterWorker(String pid) throws RemoteException {
            Assert.assertTrue(workers.containsKey(pid) || workerSendWait.containsKey(pid));

            workers.remove(pid);
            workerSendWait.remove(pid);
            for (int i = 0; i < workerPid.length; i ++) {
                if (pid.equals(workerPid[i])) workerPid[i] = null;
            }
        }

        /**
         * When send command is called by another activity or services,
         * make packet and relay to router.
         * @param pid Process-id bundled to packet.
         * @param dstNid Destination node-id.
         * @param module Target module.
         * @param content JSON string contain command and parameter.
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

            router.relayCommand(packet, false);
        }
    };

    /**
     * When scheduler require create vm, call Worker's method to do it.
     * @param caller Caller instance.
     * @param pid Process-id for new vm.
     * @param rootTid Root thread-id for new vm.
     * @param procAddr Address of process information for new vm.
     * @param masterNid Node-id of master node for new vm.
     */
    @Override
    public void routerCreateVm(Router caller, String pid, long rootTid, long procAddr, String masterNid) {
        Log.v(this.getClass().getName(), "routerCreateVm");

        // Ignore if worker is assigned.
        // This situation is possible by timing.
        if (workers.containsKey(pid) || workerSendWait.containsKey(pid)) {
            Log.w(this.getClass().getName(), "duplicate vm");
            return;
        }

        Intent intent = null;
        for (int id = 0; id < MAX_WORKERS; id++) {
            if (workerPid[id] == null) {
                workerPid[id] = pid;
                intent = new Intent(this, WORKER_CLASSES[id]);
                break;
            }
        }

        if (intent == null) {
            // TODO
            Assert.fail();
        }

        workerSendWait.put(pid, new ArrayList<CommandPacket>());

        intent.putExtra("nid", router.getMyNid());
        intent.putExtra("pid", pid);
        intent.putExtra("root_tid", rootTid);
        intent.putExtra("proc_addr", procAddr);
        intent.putExtra("master_nid", masterNid);

        startService(intent);
    }

    /**
     * When scheduler require create gui, create a new GUI to do it.
     * To create a GUI activity, broadcast intent to receiver.
     * @param caller Caller instance, not used.
     * @param pid New gui's process-id.
     */
    @Override
    public void routerCreateGui(Router caller, String pid) {
        Log.v(this.getClass().getName(), "routerCreateGui");

        // Ignore if gui is assigned.
        // This situation is possible by timing.
        if (guis.containsKey(pid) || guiSendWait.containsKey(pid)) {
            Log.w(this.getClass().getName(), "duplicate gui");
            return;
        }

        // Search empty id.
        Intent intent = null;
        for (int id = 0; id < MAX_GUIS; id++) {
            if (guiPid[id] == null) {
                guiPid[id] = pid;
                guiSendWait.put(pid, new ArrayList<CommandPacket>());
                intent = new Intent();
                intent.setAction("create_gui");
                intent.putExtra("pid", pid);
                intent.putExtra("id", id);
                break;
            }
        }

        if (intent == null) {
            // TODO resource full
            Assert.fail();
        }

        sendBroadcast(intent);
    }

    /**
     * When relay packet to controller is required, do it by AIDL.
     * @param caller Caller instance, not used.
     * @param packet Command packet.
     */
    @Override
    public void routerRelayControllerPacket(Router caller, CommandPacket packet) {
        if (controller == null) return;

        try {
            controller.relayCommand(
                    packet.pid, packet.dstNid, packet.srcNid,
                    packet.module, packet.content);

        } catch (RemoteException e) {
            // TODO error
            Log.e(this.getClass().getName(), "routerRelayControllerPacket", e);
            Assert.fail();
        }
    }

    /**
     * When relay packet to GUI is required, do it by AIDL.
     * If connection was not made yet and buffer was made, store packet to buffer.
     * @param caller Caller instance, not used.
     * @param packet Command packet.
     */
    @Override
    public void routerRelayGuiPacket(Router caller, CommandPacket packet) {
        if (guis.containsKey(packet.pid)) {
            try {
                guis.get(packet.pid).relayCommand(
                        packet.pid,
                        packet.dstNid,
                        packet.srcNid,
                        packet.module,
                        packet.content
                );
            } catch (RemoteException e) {
                // TODO error
                Log.e(this.getClass().getName(), "routerRelayGuiPacket", e);
                Assert.fail();
            }

        } else if (guiSendWait.containsKey(packet.pid)) {
            guiSendWait.get(packet.pid).add(packet);

        }
    }

    /**
     * When relay packet to worker is required, do it by AIDL.
     * Store packet to buffer if connection isn't open yet.
     * @param caller Caller instance, not used.
     * @param packet Command packet.
     */
    @Override
    public void routerRelayWorkerPacket(Router caller, CommandPacket packet) {
        if (workers.containsKey(packet.pid)) {
            try {
                workers.get(packet.pid).relayCommand(
                        packet.pid,
                        packet.dstNid,
                        packet.srcNid,
                        packet.module,
                        packet.content
                );
            } catch (RemoteException e) {
                // TODO error
                Log.e(this.getClass().getName(), "routerRelayWorkerPacket", e);
                Assert.fail();
            }

        } else if (workerSendWait.containsKey(packet.pid)) {
            workerSendWait.get(packet.pid).add(packet);

        } else {
            Log.w(this.getClass().getName(), "routerRelayWorkerPacket, drop packet");
        }
    }

    static {
        System.loadLibrary("processwarp_jni");
    }
}
