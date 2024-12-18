#!/bin/bash
# Save the most recent tag in current branch, that ends with .0
latest_tag=$(git tag --list | grep -E '^\d+(\.\d+)*\.0$' | sort -V | tail -n 1)

# If no such tag exists, fall back to the most recent tag (for safety)
if [ -z "$latest_tag" ]; then
    latest_tag=$(git tag --sort=-creatordate | head -n 1)
fi
echo "using tag $latest_tag"

# Get the commit hash associated with the latest tag
commit_hash=$(git rev-list -n 1 "$latest_tag")

Source="${1-"$commit_hash"}" # commit hash o branch if you wanna overwrite

zip_archive="mod_legends_build-$(git tag --sort=-creatordate | head -n 1).zip"
# Remove the existing zip archive if it exists
if [ -f "$zip_archive" ]; then
    rm "$zip_archive"
fi

7z a -tzip "$zip_archive" mod_legends preload scripts ui

# Get a list of all files modified since that commit hash
modified_files=$(git diff --name-only "$Source" HEAD)
# Filter the files that are in 'gfx' or 'sounds' directories
filtered_files=$(echo "$modified_files" | grep -E '^(gfx|sounds)/')
# Add the filtered files into the existing zip archive
echo "$filtered_files" | while read -r file; do
    7z a "$zip_archive" "$file"
done
