package org.processwarp.android;

import android.app.Service;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.os.RemoteException;
import android.support.annotation.Nullable;
import android.util.Log;

import junit.framework.Assert;

public class WorkerService extends Service implements Worker.Delegate, ServiceConnection {
    private Worker worker = null;
    private RouterInterface router = null;

    /**
     * When service is created explicit, make vm and connect to router service.
     * @param intent Not used.
     * @param flags Not used.
     * @param startId Not used.
     * @return START_NOT_STICKY value.
     */
    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Assert.assertNull(worker);
        worker = new Worker();

        worker.initialize(
                this,
                intent.getStringExtra("nid"),
                intent.getStringExtra("pid"),
                intent.getLongExtra("root_tid", -1),
                intent.getLongExtra("proc_addr", -1),
                intent.getStringExtra("master_nid")
        );

        bindService(new Intent(this, RouterService.class), this,
                Context.BIND_ABOVE_CLIENT | Context.BIND_AUTO_CREATE);

        return START_NOT_STICKY;
    }

    /**
     * When destroy service, stop vm and unregister this worker from the router service.
     */
    @Override
    public void onDestroy() {
        Log.v(this.getClass().getName(), "onDestroy");

        try {
            worker.stop();
            router.unregisterWorker(worker.getPid());
            router = null;

        } catch (RemoteException e) {
            Log.e(this.getClass().getName(), "onDestroy", e);
            // TODO error
            Assert.fail();
        }
        super.onDestroy();
    }

    /**
     * Default implement for block bind by another process.
     * @param intent Not used.
     * @return null.
     */
    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    /**
     * When connect to router service had success, get AIDL reference and
     * register this worker to router service.
     * @param name Not used.
     * @param service Binder containing AIDL reference.
     */
    @Override
    public void onServiceConnected(ComponentName name, IBinder service) {
        router = RouterInterface.Stub.asInterface(service);
        try {
            router.registerWorker(worker.getPid(), callback);
            worker.run();

        } catch (RemoteException e) {
            // TODO
            e.printStackTrace();
            Assert.fail();
        }
    }

    /**
     * When disconnect from router service, release AIDL reference.
     * This method shouldn't be called.
     * @param name Not used.
     */
    @Override
    public void onServiceDisconnected(ComponentName name) {
        router = null;
        // TODO
        Assert.fail();
    }

    private WorkerInterface callback = new WorkerInterface.Stub() {
        @Override
        public void relayCommand(String pid, String dstNid, String srcNid,
                                 int module, String content) {
            worker.relayWorkerCommand(pid, dstNid, srcNid, module, content);
        }
    };

    /**
     * When relay packet to controller is required, do it by AIDL.
     * @param caller Caller instance, not used.
     * @param packet Command packet.
     */
    @Override
    public void workerRelayCommand(Worker caller, CommandPacket packet) {
        try {
            router.sendCommand(packet.pid, packet.dstNid, packet.module, packet.content);

        } catch (RemoteException e) {
            // TODO error
            e.printStackTrace();
            Assert.fail();
        }
    }

    static {
        System.loadLibrary("processwarp_jni");
    }
}
