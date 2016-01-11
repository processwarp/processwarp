package org.processwarp.android;

import android.app.Dialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.v4.app.DialogFragment;
import android.support.v7.app.AlertDialog;
import android.view.LayoutInflater;

public class ConnectDialogFragment extends DialogFragment {
    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
        // Get the layout inflater
        LayoutInflater inflater = getActivity().getLayoutInflater();

        // Inflate and set the layout for the dialog
        // Pass null as the parent view because its going in the dialog layout
        builder.setView(inflater.inflate(R.layout.dialog_connect, null))
                .setPositiveButton(R.string.connect_connect, new DialogInterface.OnClickListener() {
                    /**
                     * When choose CONNECT, connect to server by account and password.
                     * @param dialog Not used.
                     * @param id Not used.
                     */
                    @Override
                    public void onClick(DialogInterface dialog, int id) {
                        // Connect to the server.
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
