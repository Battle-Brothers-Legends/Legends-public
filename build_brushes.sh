BBDir="${1-"c:\\Steam\\steamapps\\common\\Battle Brothers\\data"}"
RepoDir="${2-"battlebrothers"}"

source "./buildscript/lib.sh"

current_dir=$(pwd)

function checkForError() {
if [[ $1 == *"ERROR"* ]]; then
    while read -r line; do
        echo "$line"
    done <<< "$1"
    echo "Failed to build Legends brush $2"
    exit 1;
fi
}

echo "Building helmets..."
rm -rf helmet_scripts
handleExit
mkdir -p "helmet_scripts"
handleExit
python "$current_dir\\buildscript\\python\\make_legend_helmets.py" "$current_dir"
handleExit
mkdir -p "$BBDir\\scripts\\items\\legend_helmets"
cp -R helmet_scripts/. "$BBDir\\scripts\\items\\legend_helmets"
handleExit

echo "Building armors..."
rm -rf legend_armor_scripts
handleExit
mkdir -p "legend_armor_scripts"
handleExit
python "$current_dir\\buildscript\\python\\make_legend_armor.py" "$current_dir"
handleExit
mkdir -p "$BBDir\scripts\\items\\legend_armor"
cp -R legend_armor_scripts/. "$BBDir\\scripts\\items\\legend_armor"
handleExit

echo "Building enemies..."
python "$current_dir\\buildscript\\python\\make_legend_enemies.py" "$current_dir"
handleExit

declare -a BRUSHES=(
"entity_blood"
"legend_characters"
"legend_enemies"
"legend_weapons"
"legend_world"
"world_tiles"
"legend_horses"
"legend_detail"
"terrain"
"ui"
"orientation"
"legend_objects"
"legend_helmets/0"
"legend_helmets/1"
"legend_helmets/2"
"legend_helmets/3"
"legend_helmets/4"
"legend_helmets/5"
"legend_helmets/6"
"legend_helmets/7"
"legend_helmets/8"
"legend_helmets/9"
"legend_helmets/10"
"legend_helmets/11"
"legend_helmets/12"
"legend_helmets/13"
"legend_helmets/14"
"legend_helmets/15"
"legend_helmets/16"
"legend_armor/0"
"legend_armor/1"
"legend_armor/2"
"legend_armor/3"
"legend_armor/4"
)

mkdir -p brushes

for i in "${BRUSHES[@]}"
do
    echo "Building $i brush..."
    cd ../bin
    brush=${i//[\/]/_}
    o=$(./bbrusher.exe pack --gfxPath "../$RepoDir/" ../$RepoDir/brushes/$brush.brush ../$RepoDir/unpacked/$i)
    cd ../"$RepoDir"
    checkForError "$o" "$i"
done

echo "Copying brushes to $BBDir\\brushes ..."
mkdir -p "$BBDir\\brushes"
cp -R brushes/. "$BBDir\\brushes"
handleExit
mkdir -p "$BBDir\\gfx"
cp -R gfx/*.png "$BBDir\\gfx"
handleExit