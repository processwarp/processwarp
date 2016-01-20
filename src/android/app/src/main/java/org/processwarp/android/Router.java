package org.processwarp.android;

import android.os.Build;
import android.util.Log;

import junit.framework.Assert;

import java.security.MessageDigest;

public class Router {
    /**
     * Router instance getter as singleton pattern.
     * @return The singleton instance of Router class.
     */
    public static Router getInstance() {
        return THIS;
    }

    /**
     * Initialize some module.
     */
    public void initialize() {
        try {
            myNid = "";
            schedulerInitialize(this);

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
            ServerConnector server = ServerConnector.getInstance();
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
     */
    public void relayCommand(CommandPacket packet) {
        String realNid = (
                !SpecialNid.NONE.equals(packet.dstNid) ?
                packet.dstNid :
                schedulerGetDstNid(packet.pid, packet.module));

        CommandPacket realPacket = new CommandPacket();
        realPacket.pid     = packet.pid;
        realPacket.dstNid  = realNid;
        realPacket.srcNid  = myNid;
        realPacket.module  = packet.module;
        realPacket.content = packet.content;

        if (realPacket.dstNid.equals(myNid) || realPacket.dstNid.equals(SpecialNid.THIS)) {
            switch (realPacket.module) {
                case Module.MEMORY:
                case Module.VM:
                    // TODO
                    Assert.fail();
                    break;

                case Module.SCHEDULER:
                    schedulerRecvCommand(
                            realPacket.pid, realPacket.srcNid, realPacket.srcNid,
                            realPacket.module, realPacket.content);
                    break;

                case Module.FRONTEND:
                    // TODO
                    Assert.fail();
                    break;

                default:
                    // TODO
                    Assert.fail();
                    break;
            }
        }

        ServerConnector server = ServerConnector.getInstance();
        server.sendRelayCommand(realPacket);
    }

    /**
     * When receive packet from server to scheduler, relay it to scheduler.
     * @param packet Command packet.
     */
    public void relaySchedulerCommand(CommandPacket packet) {
        schedulerRecvCommand(
                packet.pid, packet.dstNid, packet.srcNid,
                packet.module, packet.content);
    }

    public void schedulerCreateVm(String pid, long rootTid, long procAddr, String masterNid) {
        // TODO
        Assert.fail();
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
        relayCommand(packet);
    }

    private static final Router THIS = new Router();
    private String myNid;

    /**
     * Constructor for singleton pattern.
     * This class is singleton.
     * This method is private.
     */
    private Router() {
    }

    private native void schedulerInitialize(Router router);
    private native String schedulerGetDstNid(String pid, int module);
    private native void schedulerRecvCommand(String pid, String dstNid, String srcNid,
                                             int module, String content);
    private native void schedulerSetMyNid(String nid);
    private native void schedulerActivate();
}
