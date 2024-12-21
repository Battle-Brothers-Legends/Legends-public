#!/bin/bash

BBDir="${1-"c:\\Steam\\steamapps\\common\\Battle Brothers\\data"}"
RepoDir="${2-"battlebrothers"}"
BuildDir="${3-".\\build"}"

source "./lib.sh"

rm "$BuildDir" -r

cp unpacked/dead_arrows.png unpacked/legend_characters/entity/bodies
cp unpacked/dead_javelin.png unpacked/legend_characters/entity/bodies

./build_brushes.sh "$BuildDir" "$RepoDir"
handleExit

echo "Copying sounds to $BuildDir\\sounds ..."
cp -R sounds/. "$BuildDir\\sounds"
handleExit
echo "Copying gfx to $BuildDir\\gfx ..."
cp -R gfx/. "$BuildDir\\gfx"
echo "Copying mod_legends to $BuildDir\\mod_legends ..."
cp -R mod_legends/. "$BuildDir\\mod_legends"
handleExit
echo "Copying mod script files to $BuildDir\\scripts ..."
cp -R scripts/. "$BuildDir\\scripts"
handleExit
echo "Copying mod ui files to $BuildDir\\ui ..."
cp -R ui/. "$BuildDir\\ui"
handleExit
echo "Copying mod preload files to $BuildDir\\preload ..."
cp -R ui/. "$BuildDir\\preload"
handleExit

# zip the content of build dir and move file to bb's /data dir
cd "$BuildDir"
zipNameAssets=$(artifactNameAssets)
zipNameMod=$(artifactNameMod)
7z a -tzip $zipNameAssets brushes gfx sounds preload
7z a -tzip $zipNameMod mod_legends scripts ui

buildAssetsScript > mod_legends_assets.nut
rm "scripts" -r
mkdir "scripts"
mkdir "scripts\\!mods_preload"
mv mod_legends_assets.nut "scripts\\!mods_preload"
7z a $zipNameAssets scripts

mv $zipNameAssets "$BBDir"
mv $zipNameMod "$BBDir"
