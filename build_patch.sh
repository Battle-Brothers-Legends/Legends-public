#!/bin/bash

source "./lib.sh"

latest_tag=$(getBaseVersion)

commit_hash=$(git rev-parse "$latest_tag")

Source="${1-"$commit_hash"}" # commit hash o branch if you wanna overwrite

zip_archive=$(artifactNameMod)

7z a -tzip "$zip_archive" mod_legends preload scripts ui
# Get a list of all files modified since that commit hash
modified_files=$(git diff --name-only "$Source" HEAD)
# Filter the files that are in 'gfx' or 'sounds' directories
filtered_files=$(echo "$modified_files" | grep -E '^(gfx|sounds)/')
# Add the filtered files into the existing zip archive
echo "$filtered_files" | while read -r file; do
    7z a "$zip_archive" "$file"
done
