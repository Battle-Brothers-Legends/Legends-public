#!/bin/bash

version="${1-"19.1.x"}"
release="mod_legends-assets-${version}.zip"

src="/home/antoine/bb-ws/Legends-public"
tgt="/home/antoine/bb-sources/mod_legends-assets-${version}"

cp -r $src/brushes/legend_enemies.brush $tgt/brushes/
cp -r $src/brushes/orientation.brush $tgt/brushes/
cp -r $src/brushes/ui.brush $tgt/brushes/

cp -r $src/gfx/legend_enemies.png $tgt/gfx/
cp -r $src/gfx/ui.png $tgt/gfx/

cp -r $src/gfx/skills $tgt/gfx/
cp -r $src/gfx/ui $tgt/gfx/

curr_dir=$(pwd)
cd $tgt
rm mod_legends-assets-*.zip
zip -qr $release *
cd $curr_dir
