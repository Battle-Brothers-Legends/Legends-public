#!/bin/bash

version="${1-"19.1.x"}"
release="mod_legends-${version}.zip"

src="/home/antoine/bb-ws/Legends-public"
tgt="/home/antoine/bb-sources/mod_legends-${version}"

cp -r $src/mod_legends $tgt/
cp -r $src/scripts $tgt/
cp -r $src/ui $tgt/

curr_dir=$(pwd)
cd $tgt
rm mod_legends-*.zip
zip -qr $release *
cd $curr_dir
