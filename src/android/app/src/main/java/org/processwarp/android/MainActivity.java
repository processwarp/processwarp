package org.processwarp.android;

import android.support.v4.app.DialogFragment;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;

import junit.framework.Assert;

import org.json.JSONException;
import org.json.JSONObject;

public class MainActivity extends AppCompatActivity {
    /**
     * When create application, call initialize and show toolbar and connect dialog.
     * @param savedInstanceState Used to super class's method.
     */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        Router router = Router.getInstance();
        router.initialize();

        DialogFragment connectDialog = new ConnectDialogFragment();
        connectDialog.show(getSupportFragmentManager(), "");
    }

    /**
     * Fix toolbar menu that is the same to sample.
     * http://qiita.com/kobakei/items/f17019f8b0a88c8e57f4
     * @param menu Sorry, I don't know.
     * @return True.
     */
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    /**
     * When touched menu item, call
     * @param item Touched item instance.
     * @return Return value by super method.
     */
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.action_activate: {
                JSONObject param = new JSONObject();
                sendCommand(SpecialPid.BROADCAST, Module.SCHEDULER, "activate", param);
                return true;
            }
        }

        return super.onOptionsItemSelected(item);
    }

    /**
     * Send a command to another module in this node.
     * @param pid Process-id bundled to command.
     * @param module Target module.
     * @param command Command string.
     * @param param Parameter for a command.
     */
    private void sendCommand(String pid, int module, String command, JSONObject param) {
        try {
            Assert.assertFalse(param.has("command"));
            param.put("command", command);
        } catch (JSONException e) {
            // TODO error
            Assert.fail();
        }

        CommandPacket packet = new CommandPacket();
        packet.pid = pid;
        packet.dstNid = SpecialNid.THIS;
        packet.srcNid = SpecialNid.NONE;
        packet.module = module;
        packet.content = param.toString();

        Router router = Router.getInstance();
        router.relayCommand(packet);
    }

    static {
        System.loadLibrary("processwarp_jni");
    }
}
