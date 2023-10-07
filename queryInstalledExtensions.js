#!/usr/bin/gjs

const GLib = imports.gi.GLib;

function queryInstalledExtensions() {
    // Use GLib.spawn_command_line_sync to run the gnome-extensions list command
    let [success, stdout, stderr] = GLib.spawn_command_line_sync('gnome-extensions list');

    if (success) {
        // Split the stdout into lines
        let extensionList = stdout.toString().split('\n');

        // Remove the last empty line
        extensionList.pop();

        // Print the list of installed extensions
        print('Installed Extensions:');
        for (let extension of extensionList) {
            print(extension);
        }
    } else {
        // Handle any errors
        print('Error:', stderr.toString());
    }
}

// Call the function to query installed extensions
queryInstalledExtensions();