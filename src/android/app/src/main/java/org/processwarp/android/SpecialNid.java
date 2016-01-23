package org.processwarp.android;

/**
 *  Node-id is assigned for each node process run in any devices.
 */
public class SpecialNid {
    /** Set none if destination node-id isn't yet determined. */
    static final String NONE      = "";
    /** Send command to this(local) node. */
    static final String THIS      = ".";
    /** Send command to any node with the same account. */
    static final String BROADCAST = "*";
    /** Server is a special node. */
    static final String SERVER    = "server";
}
