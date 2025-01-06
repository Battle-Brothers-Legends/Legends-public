#!/bin/bash

source "./lib.sh"

current_dir=$(pwd)
log_file="$current_dir\\log.txt"

latest_tag=$(getBaseVersion)

commit_hash=$(git rev-parse "$latest_tag" 2>$log_file)
if [ $? -ne 0 ]; then
    commit_hash=""
fi

Source="${1-"$commit_hash"}" # commit hash or branch if you wanna overwrite
BuildDir="${2-".\\build"}"

zip_archive=$(artifactNameMod)

rm "$BuildDir" -r
# build helmets, armors and enemies, then add them to zip
echo "Building helmets..."
rm -rf helmet_scripts
handleExit
mkdir -p "helmet_scripts"
handleExit
python make_legend_helmets.py
handleExit
mkdir -p "$BuildDir\\scripts\\items\\legend_helmets"
cp -R helmet_scripts/. "$BuildDir\\scripts\\items\\legend_helmets"
handleExit

echo "Building armors..."
rm -rf legend_armor_scripts
handleExit
mkdir -p "legend_armor_scripts"
handleExit
python make_legend_armor.py
handleExit
mkdir -p "$BuildDir\scripts\\items\\legend_armor"
cp -R legend_armor_scripts/. "$BuildDir\\scripts\\items\\legend_armor"
handleExit

echo "Building enemies..."
python make_legend_enemies.py
handleExit

7z a -tzip "$zip_archive" mod_legends scripts ui >> $log_file
mv "$zip_archive" "$BuildDir"
cd "$BuildDir"
7z a -tzip "$zip_archive" scripts >> $log_file
mv "$zip_archive" "$current_dir"
cd "$current_dir"

# Get a list of all files modified since that commit hash
if [ -n "$commit_hash" ]; then
  modified_files=$(git diff --name-only "$Source" HEAD)
  # Filter the files that are in 'gfx' or 'sounds' directories
  filtered_files=$(echo "$modified_files" | grep -E '^(gfx|sounds)/')
  # Add the filtered files into the existing zip archive
  echo "$filtered_files" | while read -r file; do
      7z a "$zip_archive" "$file" >> $log_file
  done
fi

handleExit
rm $log_file
echo "Done"