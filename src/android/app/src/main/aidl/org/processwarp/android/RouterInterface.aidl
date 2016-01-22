// RouterInterface.aidl
package org.processwarp.android;

// Declare any non-default types here with import statements
interface RouterInterface {
    void connectServer(String account, String password);
    void sendCommand(String pid, String dstNid, int module, String content);
}
