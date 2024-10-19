#!/usr/bin/env gjs

const Soup = imports.gi.Soup;
const GLib = imports.gi.GLib;
const Gio = imports.gi.Gio;

const current_extensions = [
    "the-circles-widget@xenlism.github.io",
    "flypie@schneegans.github.com",
    "upower-battery@codilia.com",
    "waylandorx11@injcristianrojas.github.com",
    "dash-to-dock@micxgx.gmail.com",
    "appindicatorsupport@rgcjonas.gmail.com",
    "floatingDock@sun.wxg@gmail.com",
    "desktop-cube@schneegans.github.com",
    "cairo@eexpss.gmail.com",
    "transparent-window-moving@noobsai.github.com",
    "compiz-windows-effect@hermes83.github.com",
    "cpufreq@konkor",
    "runcat@kolesnikov.se",
    "cpupower@mko-sl.de",
    "dock-from-dash@fthx",
    "minimizeall@scharlessantos.org",
    "ding@rastersoft.com",
    "ubuntu-appindicators@ubuntu.com",
    "ubuntu-dock@ubuntu.com"
];

const query_url = 'https://api.github.com/search/repositories?q=';
const session = new Soup.SessionAsync();

async function fetchAsync(url) {
    return new Promise((resolve, reject) => {
        let message = Soup.Message.new('GET', url);
        session.queue_message(message, (session, response) => {
            if (response.status_code === Soup.Status.OK) {
                resolve(response.response_body.data);
            } else {
                reject(`Error: ${response.status_code}`);
            }
        });
    });
}

async function searchExtension(extension) {
    try {
        print(`Searching for ${extension}...`);

        let query = `${query_url}${extension}+filename:metadata.json+in:path`;
        let result = await fetchAsync(query);

        let downloadUrlMatch = result.match(/https.*metadata.json/);
        if (downloadUrlMatch) {
            let download_url = downloadUrlMatch[0];
            let metadata = await fetchAsync(download_url);

            let versionMatch = metadata.match(/"version":\s*"([^"]+)"/);
            if (versionMatch) {
                let version = versionMatch[1];
                print(`Version: ${version}`);
            } else {
                print("Version not found");
            }
        } else {
            print("Download URL not found");
        }
    } catch (error) {
        print(`Error searching for ${extension}: ${error}`);
    }
}

async function main() {
    for (let extension of current_extensions) {
        await searchExtension(extension);
    }
}

main();