package org.processwarp.android;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.os.RemoteException;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import junit.framework.Assert;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class MainActivity extends AppCompatActivity implements ServiceConnection {
    private RouterInterface router = null;

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

        startService(new Intent(this, RouterService.class));
        bindService(new Intent(this, RouterService.class), this,
                Context.BIND_ABOVE_CLIENT | Context.BIND_AUTO_CREATE);
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
     * When connect with router service, save reference, set to router,
     * register callback and show connect dialog.
     * @param name Not used.
     * @param service Router interface.
     */
    @Override
    public void onServiceConnected(ComponentName name, IBinder service) {
        router = RouterInterface.Stub.asInterface(service);
        try {
            router.registerController(callback);
        } catch (RemoteException e) {
            // TODO
            e.printStackTrace();
            Assert.fail();
        }
        showConnectDialog();
    }

    /**
     * When disconnect from router service.
     * @param name Not used.
     */
    @Override
    public void onServiceDisconnected(ComponentName name) {
        router = null;
        // TODO error
        Assert.fail();
    }

    /**
     * Setup and show connect dialog.
     */
    private void showConnectDialog() {
        ConnectDialogFragment connectDialog = new ConnectDialogFragment();
        connectDialog.setRouter(router);
        connectDialog.show(getSupportFragmentManager(), "");
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

            router.sendCommand(pid, SpecialNid.THIS, module, param.toString());

        } catch (Exception e) {
            // TODO error
            Assert.fail();
        }
    }

    /**
     * When receive show_process_list command, update list of process to view.
     * @param param Parameter containing list of process-id and name.
     */
    private void recvCommandShowProcessList(JSONObject param) {
        // TODO more smart implement?
        try {
            JSONArray processes = param.getJSONArray("processes");
            String[] members = new String[processes.length()];
            for (int idx = 0; idx < processes.length(); idx ++) {
                JSONObject info = processes.getJSONObject(idx);
                members[idx] = info.getString("name");
            }

            runOnUiThread(new Runnable() {
                private Context context;
                private String[] members;

                public Runnable initialize(Context context, String[] members) {
                    this.context = context;
                    this.members = members;

                    return this;
                }

                @Override
                public void run() {
                    ListView processList = (ListView)findViewById(R.id.processList);
                    ArrayAdapter<String> adapter = new ArrayAdapter<String>(context,
                            android.R.layout.simple_expandable_list_item_1, members);
                    processList.setAdapter(adapter);

                }
            }.initialize(this, members));

        } catch (JSONException e) {
            // TODO error
            e.printStackTrace();
            Assert.fail();
        }
    }

    ControllerInterface callback = new ControllerInterface.Stub() {
        /**
         * When receive command from service process, pass it to capable method.
         * @param pid Process-id bundled to packet.
         * @param dstNid Destination node-id.
         * @param srcNid Source node-id.
         * @param module Target module.
         * @param content JSON string contain command and parameter.
         * @throws RemoteException
         */
        @Override
        public void recvCommand(
                String pid, String dstNid, String srcNid,
                int module, String content) throws RemoteException {
            try {
                JSONObject param = new JSONObject(content);
                String command = param.getString("command");

                if (command.equals("show_process_list")) {
                    recvCommandShowProcessList(param);
                }

            } catch (JSONException e) {
                // TODO
                e.printStackTrace();
                Assert.fail();
            }
        }
    };
}
