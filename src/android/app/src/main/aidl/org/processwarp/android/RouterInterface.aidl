// RouterInterface.aidl
package org.processwarp.android;

import org.processwarp.android.ControllerInterface;

// Declare any non-default types here with import statements
oneway interface RouterInterface {
    void registerController(ControllerInterface controller);
    void connectServer(String account, in String password);
    void sendCommand(String pid, String dstNid, int module, String content);
}
