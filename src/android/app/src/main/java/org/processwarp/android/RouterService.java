package org.processwarp.android;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.os.RemoteException;
import android.support.annotation.Nullable;

import junit.framework.Assert;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RouterService extends Service implements Router.Delegate {
    /** Max worker number. */
    private static final int MAX_WORKERS = 3;
    /** Classes for start worker service. */
    private static final Class<?> WORKER_CLASSES[] = {
            WorkerService0.class,
            WorkerService1.class,
            WorkerService2.class
    };

    /** The router having native interface. */
    private Router router = null;
    /** The server for relay packet. */
    private ServerConnector server = null;
    /** The controller callback for relay CONTROLLER command. */
    private static ControllerInterface controller = null;
    /** Map of Process-id and worker callback for relay VM and VMEMORY command. */
    private static Map<String, WorkerInterface> workers = new HashMap<String, WorkerInterface>();
    private static Map<String, List<CommandPacket>> sendWait =
            new HashMap<String, List<CommandPacket>>();
    /** Process-id bind for worker. Array index is equal to worker index. */
    private String[] workerPid = new String[MAX_WORKERS];


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
         * When method is called by worker, save worker callback with process-id.
         * If packets are waiting to send in buffer, send packet and remove buffer.
         * @param pid Worker's process-id.
         * @param worker Worker callback instance.
         */
        @Override
        public void registerWorker(String pid, WorkerInterface worker) {
            RouterService.workers.put(pid, worker);

            for (CommandPacket packet : sendWait.get(pid)) {
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
                    Assert.fail();
                }
            }
            sendWait.remove(pid);
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

        sendWait.put(pid, new ArrayList<CommandPacket>());

        intent.putExtra("nid", router.getMyNid());
        intent.putExtra("pid", pid);
        intent.putExtra("root_tid", rootTid);
        intent.putExtra("proc_addr", procAddr);
        intent.putExtra("master_nid", masterNid);

        startService(intent);
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
            controller.recvCommand(
                    packet.pid, packet.dstNid, packet.srcNid,
                    packet.module, packet.content);

        } catch (RemoteException e) {
            Assert.fail();
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
                Assert.fail();
            }

        } else if (sendWait.containsKey(packet.pid)) {
            sendWait.get(packet.pid).add(packet);

        } else {
            // TODO error
            Assert.fail();
        }
    }

    static {
        System.loadLibrary("processwarp_jni");
    }
}
