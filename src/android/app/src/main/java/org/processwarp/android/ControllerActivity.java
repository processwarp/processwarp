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
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import junit.framework.Assert;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class ControllerActivity extends AppCompatActivity implements ServiceConnection {
    /** Set true if router service has start. */
    private static boolean isServiceStart = false;
    /** AIDL interface for router. */
    private RouterInterface router = null;

    /**
     * When create application, show toolbar and start router service if needed.
     * @param savedInstanceState Used to super class's method.
     */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.v(this.getClass().getName(), "onCreate");
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_contoller);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        if (!isServiceStart) {
            startService(new Intent(this, RouterService.class));
            isServiceStart = true;
        }
    }

    /**
     * When resume main activity, (re)bind to router service.
     */
    @Override
    protected void onResume() {
        Log.v(this.getClass().getName(), "onResume");
        super.onResume();
        bindService(new Intent(this, RouterService.class), this,
                Context.BIND_ABOVE_CLIENT | Context.BIND_AUTO_CREATE);
    }

    /**
     * When pause main activity, unregister and unbind from router service.
     */
    @Override
    protected void onPause() {
        Log.v(this.getClass().getName(), "onPause");
        super.onPause();

        if (router != null) try {
            router.unregisterController();
            router = null;

        } catch (RemoteException e) {
            // TODO error
            Log.e(this.getClass().getName(), "onPause", e);
            Assert.fail();
        }
        unbindService(this);
    }

    /**
     * Fix toolbar menu that is the same to sample.
     * http://qiita.com/kobakei/items/f17019f8b0a88c8e57f4
     * @param menu Sorry, I don't know.
     * @return True.
     */
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_controller, menu);
        return true;
    }

    /**
     * When touched menu item, send activate command to scheduler on all nodes.
     * @param item Touched item instance.
     * @return Return value by super method.
     */
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.action_activate: {
                JSONObject param = new JSONObject();
                sendCommand(
                        SpecialPid.BROADCAST, SpecialNid.BROADCAST, Module.SCHEDULER,
                        "activate", param);
                return true;
            }
        }

        return super.onOptionsItemSelected(item);
    }

    /**
     * When connect with router service, save reference, set to router,
     * register callback and show connect dialog if needed.
     * Send require_processes_info command to get processes information for showing list.
     * @param name Not used.
     * @param service Router interface.
     */
    @Override
    public void onServiceConnected(ComponentName name, IBinder service) {
        Log.v(this.getClass().getName(), "onServiceConnected");
        router = RouterInterface.Stub.asInterface(service);
        try {
            router.registerController(callback);
            if (!router.isConnectServer()) {
                showConnectDialog();

            } else {
                sendCommand(
                        SpecialPid.BROADCAST, SpecialNid.THIS, Module.SCHEDULER,
                        "require_processes_info", new JSONObject());
            }

        } catch (RemoteException e) {
            // TODO error
            e.printStackTrace();
            Assert.fail();
        }
    }

    /**
     * When disconnect from router service.
     * @param name Not used.
     */
    @Override
    public void onServiceDisconnected(ComponentName name) {
        Log.v(this.getClass().getName(), "onServiceDisconnected");
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
     * Send a command through router and server if needed.
     * @param pid Process-id bundled to command.
     * @param dstNid Destination node-id.
     * @param module Target module.
     * @param command Command string.
     * @param param Parameter for a command.
     */
    private void sendCommand(String pid, String dstNid, int module, String command, JSONObject param) {
        Assert.assertNotNull(router);

        try {
            Assert.assertFalse(param.has("command"));
            param.put("command", command);

            router.sendCommand(pid, dstNid, module, param.toString());

        } catch (Exception e) {
            // TODO error
            Log.e(this.getClass().getName(), "sendCommand", e);
            Assert.fail();
        }
    }

    /**
     * When receive processes_info command, update processes list on controller.
     * @param param Parameter containing list of process-id and name.
     */
    private void recvCommandProcessesInfo(JSONObject param) {
        // TODO more smart implement?
        try {
            JSONArray processes = param.getJSONArray("processes");
            String[] members = new String[processes.length()];
            String[] pids    = new String[processes.length()];
            for (int idx = 0; idx < processes.length(); idx ++) {
                JSONObject info = processes.getJSONObject(idx);
                members[idx] = info.getString("name");
                pids[idx]    = info.getString("pid");
            }

            runOnUiThread(new Runnable() {
                private Context context;
                private String[] members;
                private String[] pids;

                public Runnable initialize(Context context, String[] members, String[] pids) {
                    this.context = context;
                    this.members = members;
                    this.pids    = pids;

                    return this;
                }

                @Override
                public void run() {
                    ListView processList = (ListView)findViewById(R.id.processList);
                    ArrayAdapter<String> adapter = new ArrayAdapter<String>(context,
                            android.R.layout.simple_expandable_list_item_1, members);
                    processList.setAdapter(adapter);
                    // If select item, foreground bind GUI activity.
                    processList.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                        @Override
                        public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                            String pid = pids[position];
                            try {
                                router.foregroundGui(pid);
                            } catch (RemoteException e) {
                                Log.e(this.getClass().getName(), "foregroundGui");
                            }
                        }
                    });

                }
            }.initialize(this, members, pids));

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
        public void relayCommand(
                String pid, String dstNid, String srcNid,
                int module, String content) throws RemoteException {
            try {
                JSONObject param = new JSONObject(content);
                String command = param.getString("command");

                if (command.equals("processes_info")) {
                    recvCommandProcessesInfo(param);

                } else {
                    Log.e(this.getClass().getName(), "unknown packet:" + content);
                }

            } catch (JSONException e) {
                // TODO
                e.printStackTrace();
                Assert.fail();
            }
        }
    };
}
