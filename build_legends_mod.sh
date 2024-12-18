BBDir="${1-"c:\\Steam\\steamapps\\common\\Battle Brothers\\data"}"
RepoDir="${2-"battlebrothers"}"
BuildDir="${3-".\\build"}"

function checkForCompileError() {
code=0
while read -r line; do
    if [[ $line == *" error"* ]]; then
        #echo "$line"
        code=1
    fi
done <<< "$1"
if [ $code == 1 ]
then
    return 1
else
    return 0
fi
}

function handleExit() {
    # Get exit code of the previous command, instead of echo
    exitCode=$?
    if [ $exitCode -ne "0" ]
    then
        echo "Failed to build Legends!"
        exit 1
    fi
}

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
7z a -tzip mod_legends_assets.zip brushes gfx sounds
7z a -tzip mod_legends_build.zip mod_legends preload scripts ui

mv mod_legends_assets.zip "$BBDir"
mv mod_legends_build.zip "$BBDir"
