#!/bin/zsh

# List of current_extension to search for
current_extensions=(
    
    the-circles-widget@xenlism.github.io
    flypie@schneegans.github.com
    upower-battery@codilia.com
    waylandorx11@injcristianrojas.github.com
    dash-to-dock@micxgx.gmail.com
    appindicatorsupport@rgcjonas.gmail.com
    floatingDock@sun.wxg@gmail.com
    desktop-cube@schneegans.github.com
    cairo@eexpss.gmail.com
    transparent-window-moving@noobsai.github.com
    compiz-windows-effect@hermes83.github.com
    cpufreq@konkor
    runcat@kolesnikov.se
    cpupower@mko-sl.de
    dock-from-dash@fthx
    minimizeall@scharlessantos.org
    ding@rastersoft.com
    ubuntu-appindicators@ubuntu.com
    ubuntu-dock@ubuntu.com
)

# GitHub API search query URL
query_url='https://api.github.com/search/repositories?q='

# Loop through the current_extension and search for each one
for extension in $current_extension; do
    echo "Searching for $extension..."

    # Build the search query URL for this extension
    query="$query_url$extension+filename:metadata.json+in:path"

    # Use curl to get the search results in JSON format
    result=$(curl -s "$query")

    # Extract the download URL for the metadata.json file
    download_url=$(echo "$result" | grep -o 'https.*metadata.json' | head -n 1)

    # Use curl again to get the metadata.json file
    metadata=$(curl -s "$download_url")

    # Extract the version field from the metadata
    version=$(echo "$metadata" | jq -r '.version')

    # Print the version
    echo "Version: $version"
done
