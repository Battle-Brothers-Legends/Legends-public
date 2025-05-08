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
    exitCode=$?
    if [ $exitCode -ne 0 ]; then
        echo "Failed to build ${1:-"Legends"}!"
        exit 1
    fi
}

#Extracts current version of legends
extractVersion() {
    local file="scripts/!mods_preload/register_legends.nut"
    echo "$(grep -oP 'Version = "\K[0-9]+\.[0-9]+\.[0-9]+' "$file")"
}

getLegendsAssetsVersion() {
    local file="scripts/!mods_preload/register_legends.nut"
    grep -oE 'mod_legends_assets\(>=([0-9]+\.[0-9]+\.[0-9]+)\)' "$file" | \
        sed -E 's/.*\(>=([0-9]+\.[0-9]+\.[0-9]+)\).*/\1/'
}

# Builds asset mod script dynamically, according to versions of main mod
buildAssetsScript() {
    echo "::LegendsAssets <- {
    ID = \"mod_legends_assets\",
    Version = \"$(getLegendsAssetsVersion)\",
    Name = \"Legends assets\"
};
::mods_registerMod(::LegendsAssets.ID, ::LegendsAssets.Version, ::LegendsAssets.Name);"
}

artifactNameMod() {
  echo "mod_legends-$(extractVersion).zip"
}
artifactNameAssets() {
  echo "mod_legends-assets-$(getLegendsAssetsVersion).zip"
}