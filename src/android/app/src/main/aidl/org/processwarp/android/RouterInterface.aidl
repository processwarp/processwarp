// RouterInterface.aidl
package org.processwarp.android;

import org.processwarp.android.ControllerInterface;
import org.processwarp.android.GuiInterface;
import org.processwarp.android.WorkerInterface;

// Declare any non-default types here with import statements
interface RouterInterface {
    oneway void connectServer(String account, in String password);
    oneway void foregroundGui(String pid);
    boolean isConnectServer();
    String getMyNid();
    oneway void registerController(ControllerInterface controller);
    oneway void registerGui(String pid, GuiInterface frontend);
    oneway void registerWorker(String pid, WorkerInterface worker);
    oneway void unregisterController();
    oneway void unregisterGui(String pid);
    oneway void unregisterWorker(String pid);
    oneway void sendCommand(String pid, String dstNid, int module, String content);
}
