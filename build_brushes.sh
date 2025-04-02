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
)

for dir in "$current_dir/unpacked/legend_helmets/"*/; do
    # Check if directory name is numeric
    dir_name=$(basename "$dir")
    if [[ "$dir_name" =~ ^[0-9]+$ ]]; then
        BRUSHES+=("legend_helmets/$dir_name")
    fi
done

for dir in "$current_dir/unpacked/legend_armor/"*/; do
    dir_name=$(basename "$dir")
    if [[ "$dir_name" =~ ^[0-9]+$ ]]; then
        BRUSHES+=("legend_armor/$dir_name")
    fi
done


rm -rf brushes
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