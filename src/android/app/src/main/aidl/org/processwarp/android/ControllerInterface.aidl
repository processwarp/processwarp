// ControllerInterface.aidl
package org.processwarp.android;

// Declare any non-default types here with import statements
interface ControllerInterface {
    oneway void changeConnectStatus(boolean isConnect, String myNid);
    oneway void relayCommand(String pid, String dstNid, String srcNid, int module, String content);
}
