package org.processwarp.android;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

public class GuiReceiver extends BroadcastReceiver {
    /** Classes for starting frontend activity. */
    private static final Class<?> GUI_CLASSES[] = {
            GuiActivity0.class,
            GuiActivity1.class,
            GuiActivity2.class
    };

    /**
     * Launch frontend activity required by router service.
     * @param context Passed context.
     * @param intent Intent containing pid and frontend-id.
     */
    @Override
    public void onReceive(Context context, Intent intent) {
        // Select a activity class by frontend-id.
        int id = intent.getIntExtra("id", GUI_CLASSES.length);
        Intent lunch = new Intent(context, GUI_CLASSES[id]);
        // Set flag and parameter to a intent.
        lunch.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        lunch.putExtra("pid", intent.getStringExtra("pid"));
        // Start activity.
        context.startActivity(lunch);
    }
}
