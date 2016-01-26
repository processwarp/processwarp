// RouterInterface.aidl
package org.processwarp.android;

import org.processwarp.android.ControllerInterface;
import org.processwarp.android.WorkerInterface;

// Declare any non-default types here with import statements
interface RouterInterface {
    void registerController(ControllerInterface controller);
    void registerWorker(String pid, WorkerInterface worker);
    void connectServer(String account, in String password);
    void sendCommand(String pid, String dstNid, int module, String content);
}
