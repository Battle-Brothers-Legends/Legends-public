
checkForCompileError() {
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

handleExit() {
    # Get exit code of the previous command, instead of echo
    exitCode=$?
    if [ $exitCode -ne "0" ]
    then
        echo "Failed to build Legends!"
        exit 1
    fi
}

#Extracts current version of legends
extractVersion() {
    local file="scripts/!mods_preload/register_legends.nut"
    echo "$(grep -oP 'Version = "\K[0-9]+\.[0-9]+\.[0-9]+' "$file")"
}

# Extract the major and minor versions, then append ".0" for the patch version
getBaseVersion() {
    local extractedVersion=$(extractVersion)
    echo "$(echo "$extractedVersion" | sed -E 's/^([0-9]+\.[0-9]+)\.[0-9]+$/\1.0/')"
}

# Builds asset mod script dynamically, according to versions of main mod
buildAssetsScript() {
    echo "::LegendsAssets <- {
    ID = \"mod_legends_assets\",
    Version = \"$(getBaseVersion)\",
    Name = \"Legends assets\"
};
::mods_registerMod(::LegendsAssets.ID, ::LegendsAssets.Version, ::LegendsAssets.Name);"
}

artifactNameMod() {
  echo "mod_legends-$(extractVersion).zip"
}
artifactNameAssets() {
  echo "mod_legends-assets-$(getBaseVersion).zip"
}