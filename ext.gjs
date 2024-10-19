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

const session = new Soup.Session();

function searchExtension(extension) {
    print(`Searching for ${extension}...`);

    let query = `${query_url}${extension}+filename:metadata.json+in:path`;

    let message = Soup.Message.new('GET', query);

    session.send_message(message);

    let result = message.response_body.data;

    let downloadUrlMatch = result.match(/https.*metadata.json/);
    if (downloadUrlMatch) {
        let download_url = downloadUrlMatch[0];

        message = Soup.Message.new('GET', download_url);
        session.send_message(message);

        let metadata = message.response_body.data;

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
}

for (let extension of current_extensions) {
    searchExtension(extension);
}