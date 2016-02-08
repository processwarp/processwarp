// RouterInterface.aidl
package org.processwarp.android;

import org.processwarp.android.ControllerInterface;
import org.processwarp.android.GuiInterface;
import org.processwarp.android.WorkerInterface;

// Declare any non-default types here with import statements
interface RouterInterface {
    void connectServer(String account, in String password);
    boolean isConnectServer();
    String getMyNid();
    void registerController(ControllerInterface controller);
    void registerGui(String pid, GuiInterface frontend);
    void registerWorker(String pid, WorkerInterface worker);
    void unregisterController();
    void unregisterGui(String pid);
    void unregisterWorker(String pid);
    void sendCommand(String pid, String dstNid, int module, String content);
}
