BBDir="${1-"c:\\Steam\\steamapps\\common\\Battle Brothers\\data"}"
RepoDir="${2-"battlebrothers"}"

function checkForCompileError() {
code=0
while read -r line; do
    if [[ $line == *"error"* ]]; then
        echo "$line"
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

function checkForError() {
if [[ $1 == *"ERROR"* ]]; then
    while read -r line; do
        echo "$line"
    done <<< "$1"
    echo "Failed to build Legends brush $2"
    exit 1;
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

function copyBrushes() {
echo "Copying brushes to $BBDir\\brushes ..."
mkdir -p "$BBDir\\brushes"
cp -R brushes/. "$BBDir\\brushes"
handleExit
mkdir -p "$BBDir\\gfx"
cp -R gfx/*.png "$BBDir\\gfx"
handleExit
}


declare -a ArmorBrushes=(
"legend_armor/0"
"legend_armor/1"
)

declare -a HelmetBrushes=(
"legend_helmets"
"legend_helmets/0"
"legend_helmets/1"
"legend_helmets/2"
)

FILES=$(git status -s)
while read -r line; do
    #echo $line
    x=${line:0:1}
    if [ $x == "M" ] || [ $x == "A" ]; then
        if [ $x == "M" ]; then
            xpath=${line:2}
        else
            xpath=${line:3}
        fi

        if [[ "$xpath" == *.sh ]]; then
            :
            #echo "skipping $line"
        elif [[ "$xpath" == make_legend_helmets.py ]]; then
            rm -rf helmet_scripts
            mkdir -p "helmet_scripts"
            python make_legend_helmets.py
            handleExit
            mkdir -p "$BBDir\\scripts\items\legend_helmets"
            cp -R helmet_scripts/. "$BBDir\\scripts\items\legend_helmets"

            for i in "${HelmetBrushes[@]}"
            do
                echo "Building $i brush..."
                cd ../bin
                brush=${i//[\/]/_}
                o=$(./bbrusher.exe pack --gfxPath "../$RepoDir/" ../$RepoDir/brushes/$brush.brush ../$RepoDir/unpacked/$i)
                cd ../"$RepoDir"
                checkForError "$o" "$i"
            done
            copyBrushes

        elif [[ "$xpath" == make_legend_armor.py ]]; then
            rm -rf legend_armor_scripts
            mkdir -p "legend_armor_scripts"
            python make_legend_armor.py
            handleExit
            mkdir -p "$BBDir\\scripts\items\legend_armor"
            cp -R legend_armor_scripts/. "$BBDir\\scripts\items\legend_armor"
            for i in "${ArmorBrushes[@]}"
            do
                echo "Building $i brush..."
                cd ../bin
                brush=${i//[\/]/_}
                o=$(./bbrusher.exe pack --gfxPath "../$RepoDir/" ../$RepoDir/brushes/$brush.brush ../$RepoDir/unpacked/$i)
                cd ../"$RepoDir"
                checkForError "$o" "$i"
            done
            copyBrushes


        elif [[ "$xpath" == make_legend_enemies.py ]]; then
            python make_legend_enemies.py
            handleExit
            echo "Building legend_enemies brush..."
            cd ../bin
            o=$(./bbrusher.exe pack --gfxPath "../$RepoDir/" ../$RepoDir/brushes/legend_enemies.brush ../$RepoDir/unpacked/legend_enemies)
            cd ../"$RepoDir"
            checkForError "$o" "$i"
            copyBrushes

        elif [[ "$xpath" == unpacked/legend_weapons/metadata.xml ]]; then
            echo "Building legend_weapons brush..."
            cd ../bin
            o=$(./bbrusher.exe pack --gfxPath "../$RepoDir/" ../$RepoDir/brushes/legend_weapons.brush ../$RepoDir/unpacked/legend_weapons)
            cd ../"$RepoDir"
            checkForError "$o" "$i"
            copyBrushes

        elif [[ "$xpath" == unpacked/legend_characters/metadata.xml ]]; then
            echo "Building legend_characters brush..."
            cd ../bin
            o=$(./bbrusher.exe pack --gfxPath "../$RepoDir/" ../$RepoDir/brushes/legend_characters.brush ../$RepoDir/unpacked/legend_characters)
            cd ../"$RepoDir"
            checkForError "$o" "$i"
            copyBrushes

        elif [[ "$xpath" == unpacked/legend_objects/metadata.xml ]]; then
            echo "Building legend_objects brush..."
            cd ../bin
            o=$(./bbrusher.exe pack --gfxPath "../$RepoDir/" ../$RepoDir/brushes/legend_objects.brush ../$RepoDir/unpacked/legend_objects)
            cd ../"$RepoDir"
            checkForError "$o" "$i"
            copyBrushes

        elif [[ "$xpath" == unpacked/legends_ui/metadata.xml ]]; then
            echo "Building legends_ui brush..."
            cd ../bin
            o=$(./bbrusher.exe pack --gfxPath "../$RepoDir/" ../$RepoDir/brushes/legends_ui.brush ../$RepoDir/unpacked/legends_ui)
            cd ../"$RepoDir"
            checkForError "$o" "$i"
            copyBrushes

        elif [[ "$xpath" == unpacked/legend_world/metadata.xml ]]; then
            echo "Building legend_world brush..."
            cd ../bin
            o=$(./bbrusher.exe pack --gfxPath "../$RepoDir/" ../$RepoDir/brushes/legend_world.brush ../$RepoDir/unpacked/legend_world)
            cd ../"$RepoDir"
            checkForError "$o" "$i"
            copyBrushes

        elif [[ "$xpath" == unpacked/legend_runed/metadata.xml ]]; then
            echo "Building legend_runed brush..."
            cd ../bin
            o=$(./bbrusher.exe pack --gfxPath "../$RepoDir/" ../$RepoDir/brushes/legend_runed.brush ../$RepoDir/unpacked/legend_runed)
            cd ../"$RepoDir"
            checkForError "$o" "$i"
            copyBrushes

        elif [[ "$xpath" == *.py ]]; then
            :
            #echo "skipping $line"
        elif [[ "$xpath" == *.md ]]; then
            :
            #echo "skipping $line"
        elif [[ "$xpath" == unpacked* ]]; then
            :
            #echo "skipping $line"
        elif [[ "$xpath" == *.cnut ]]; then
            :
            #echo "skipping $line"

        else
            echo "$xpath"
            path=$( echo ${xpath%/*} )
            mkdir -p "$BBDir\\$path"
            cp "$xpath" "$BBDir\\$xpath"
        fi
    fi

done <<< "$FILES"

cd ../bin
o=$(./masscompile.bat "$BBDir\\scripts")
cd ../"$RepoDir"
checkForCompileError "$o"
if [ $? -ne "0" ]
then
    echo "Failed to build Legends!"
else
    echo "Success!"
fi

