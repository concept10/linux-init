const GLib = imports.gi.GLib;
const requiredExtensions = new Map();



function asyncExec(command) {
    return new Promise((resolve, reject) => {
        GLib.spawn_async(null, command, null, GLib.SpawnFlags.SEARCH_PATH, null, null, (success, stdout, stderr) => {
            if (!success) {
                reject(stderr.toString());
            } else {
                resolve(stdout.toString());
            }
        });
    });
}
// TODO: define extension download directory dev or ~/.local/share/gnome-shell/extensions

async function downloadAndInstallExtension(extensionURL) {
    const downloadDirectory = GLib.get_tmp_dir();
    const extensionName = extensionURL.split('/').pop().replace('.zip', '');

    const wgetCommand = `wget -P ${downloadDirectory} ${extensionURL}`;
    const unzipCommand = `unzip ${downloadDirectory}/${extensionName}.zip -d ${downloadDirectory}`;
    const installCommand = `gnome-extensions install --file ${downloadDirectory}/${extensionName}`;

    try {
        await asyncExec(wgetCommand);
        print('Extension downloaded successfully.');

        await asyncExec(unzipCommand);
        print('Extension unzipped successfully.');

        const installResult = await asyncExec(installCommand);
        print(`Extension ${extensionName} installed successfully!\n${installResult}`);
    } catch (error) {
        print(`Error: ${error}`);
    }
}


const extensionURL = 'https://github.com/username/repo/archive/master.zip';

downloadAndInstallExtension(extensionURL);