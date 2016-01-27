package org.processwarp.android;

import android.os.Build;
import android.util.Log;

import junit.framework.Assert;

import java.security.MessageDigest;

public class Router {
    /**
     * Delegate for implement by service.
     */
    public interface Delegate {
        void routerCreateVm(Router caller, String pid, long rootTid, long procAddr, String masterNid);
        void routerRelayControllerPacket(Router caller, CommandPacket packet);
        void routerRelayWorkerPacket(Router caller, CommandPacket packet);
    }

    private Delegate delegate;
    private ServerConnector server;

    /**
     * Initialize some module.
     * @param delegate Delegate for implement by service.
     * @param server ServerConnector instance for send data.
     */
    public void initialize(Delegate delegate, ServerConnector server) {
        this.delegate = delegate;
        this.server = server;

        try {
            myNid = "";
            schedulerInitialize(this);

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
            server.sendConnectNode(account, "[10sha256]" + hexString);

        } catch (Exception e) {
            Assert.fail("");
        }
    }

    /**
     * Get this node's node-id.
     * @return This node's node-id.
     */
    public String getMyNid() {
        return myNid;
    }

    /**
     * When connect is success, send bind_node packet with my-nid and node-name.
     * @param result Result code.
     */
    public void recvConnectNode(int result) {
        if (result == 0) {
            server.sendBindNode(myNid, Build.HOST);

        } else {
            // TODO
            Assert.fail();
        }
    }

    /**
     * When bind is success, store assigned nid as my-nid.
     * @param result Result code.
     * @param nid Assigned nid for this node.
     */
    public void recvBindNode(int result, String nid) {
        if (result == 0) {
            myNid = nid;
            schedulerSetMyNid(nid);

        } else {
            // TODO
            Assert.fail();
        }
    }

    /**
     * When passed a command from some module in this node,
     * set destination node-id and pass content to capable module in this node or
     * another node through the server.
     * @param packet Command packet.
     * @param isFromServer Set true if packet was passed by server.
     */
    public void relayCommand(CommandPacket packet, boolean isFromServer) {
        if (!isFromServer) {
            if (SpecialNid.NONE.equals(packet.dstNid))
                packet.dstNid = schedulerGetDstNid(packet.pid, packet.module);

            packet.srcNid = myNid;
        }

        if (packet.dstNid.equals(myNid) ||
                packet.dstNid.equals(SpecialNid.THIS) ||
                (packet.dstNid.equals(SpecialNid.BROADCAST) &&
                        !packet.srcNid.equals(myNid))) {
            switch (packet.module) {
                case Module.MEMORY:
                case Module.VM:
                    delegate.routerRelayWorkerPacket(this, packet);
                    return;

                case Module.SCHEDULER:
                    schedulerRecvCommand(
                            packet.pid, packet.srcNid, packet.srcNid,
                            packet.module, packet.content);
                    return;

                case Module.FRONTEND:
                    if (packet.pid.equals(SpecialPid.BROADCAST)) {
                        delegate.routerRelayControllerPacket(this, packet);
                    } else {
                        // TODO
                        Assert.fail();
                    }
                    return;

                default:
                    // TODO
                    Assert.fail();
                    return;
            }
        }

        if (!isFromServer) {
            server.sendRelayCommand(packet);
        } else {
            Assert.fail();
        }
    }

    public void schedulerCreateVm(String pid, long rootTid, long procAddr, String masterNid) {
        delegate.routerCreateVm(this, pid, rootTid, procAddr, masterNid);
    }

    public void schedulerCreateGui(String pid) {
        // TODO
        Assert.fail();
    }

    /**
     * When scheduler require send a command, relay command by command type.
     * @param pid Process-id bundled to packet.
     * @param dstNid Destination node-id.
     * @param srcNid Source node-id, should be my node-id, THIS, or NONE.
     * @param module Target module.
     * @param content Packet content string of JSON.
     */
    private void schedulerSendCommand(String pid, String dstNid, String srcNid,
                                      int module, String content) {
        CommandPacket packet = new CommandPacket();
        packet.pid = pid;
        packet.dstNid = dstNid;
        packet.srcNid = srcNid;
        packet.module = module;
        packet.content = content;
        relayCommand(packet, false);
    }

    private String myNid;

    private native void schedulerInitialize(Router router);
    private native String schedulerGetDstNid(String pid, int module);
    private native void schedulerRecvCommand(String pid, String dstNid, String srcNid,
                                             int module, String content);
    private native void schedulerSetMyNid(String nid);
    private native void schedulerActivate();
}
