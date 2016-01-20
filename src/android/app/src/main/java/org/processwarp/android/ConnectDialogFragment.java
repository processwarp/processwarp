package org.processwarp.android;

import android.app.Dialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.app.DialogFragment;
import android.support.v7.app.AlertDialog;
import android.support.v7.widget.Toolbar;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.EditText;

public class ConnectDialogFragment extends DialogFragment {
    /**
     * When create dialog, set toolbar and event receiver to buttons.
     * @param savedInstanceState Not used.
     * @return Dialog instance.
     */
    @Override
    @NonNull
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
        LayoutInflater inflater = getActivity().getLayoutInflater();
        final View view = inflater.inflate(R.layout.dialog_connect, null, false);

        Toolbar toolbar = (Toolbar)view.findViewById(R.id.connect_toolbar);
        toolbar.setTitle(R.string.app_name);

        builder.setView(view)
                .setPositiveButton(R.string.connect_connect, new DialogInterface.OnClickListener() {
                    /**
                     * When choose CONNECT, connect to server by account and password.
                     * @param dialog Not used.te
                     * @param id Not used.
                     */
                    @Override
                    public void onClick(DialogInterface dialog, int id) {
                        EditText connect_account =
                                (EditText)view.findViewById(R.id.connect_account);
                        EditText connect_password =
                                (EditText)view.findViewById(R.id.connect_password);

                        Router router = Router.getInstance();
                        router.connectServer(
                                connect_account.getText().toString(),
                                connect_password.getText().toString()
                        );
                    }
                })
                .setNegativeButton(R.string.connect_quit, new DialogInterface.OnClickListener() {
                    /**
                     * When choose QUIT, move activity to back.
                     * @param dialog Not used.
                     * @param id Not used.
                     */
                    @Override
                    public void onClick(DialogInterface dialog, int id) {
                        getActivity().moveTaskToBack(true);
                    }
                });

        setCancelable(false);

        return builder.create();
    }
}
