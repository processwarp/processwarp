// WorkerInterface.aidl
package org.processwarp.android;

// Declare any non-default types here with import statements
interface WorkerInterface {
    oneway void relayCommand(String pid, String dstNid, String srcNid, int module, String content);
}
