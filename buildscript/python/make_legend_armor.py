from string import Template
from shutil import copyfile
from buildscript.python.armor import Templates, Defs, cleanupDirs
import re, os, argparse
from pathlib import Path


def checkForIcon(path, iconpath, variants):
    dirpath = os.path.join(path, "gfx", "ui", "items")
    parts = iconpath.split("/")
    if parts[0] == "armor":
        return False
    for p in parts:
        dirpath = os.path.join(dirpath, p)

    if len(variants) == 0:
        if not os.path.exists(dirpath + ".png"):
            print("Missing " + iconpath)
            return True
        return False

    has_missing = False
    for v in variants:
        variant = str(v)
        if v < 10:
            variant = "0" + variant
        if not os.path.exists(dirpath + "_" + variant + ".png"):
            print("Missing " + iconpath + "_" + variant)
            has_missing = True

    return has_missing


def makeSheet(path, num):
    dirpath = os.path.join(path, "unpacked", "legend_armor", "" + str(num))
    if not os.path.exists(dirpath):
        os.makedirs(dirpath)

    filepath = os.path.join(dirpath, "metadata.xml")
    F = open(filepath, "w")
    F.write('<brush name="gfx/legend_armor_' + str(num) + '.png" version="17">\n')
    return F


def generate_legend_armor(base_path):
    path = str(base_path)  # Convert Path to string for compatibility

    cleanupDirs(os.path.join(path, "unpacked", "legend_armor"))
    # Build Brushes
    fileCount = 0
    imageCount = 0
    Brush = makeSheet(path, fileCount)
    L = Templates.Layer
    LBase = Templates.LBase

    IC = 4280560954

    # Build Nuts
    has_missing = False
    for d in Defs.layers:

        inherit = ""
        if "inherit" in d:
            inherit = d["inherit"]
        layer = d["layer"]

        temp = Templates.UpgradeNut
        if layer == "cloth":
            temp = Templates.BaseNut
            if "named" in d:
                temp = Templates.BaseNamedNut
            elif inherit != "":
                temp = Templates.BaseNutInherit
        elif layer == "cloak":
            temp = Templates.CloakNut
        elif layer == "tabard":
            temp = Templates.TabardNut
        elif "named" in d:
            temp = Templates.NamedUpgradeNut

        fname = d["name"]
        dirpath = os.path.join(path, "legend_armor_scripts", layer)
        if not os.path.exists(dirpath):
            os.makedirs(dirpath)

        filepath = os.path.join(dirpath, fname + ".nut")
        F = open(filepath, "w")
        variants = []
        if "variants" in d:
            variants = d["variants"]
        else:
            for x in range(d["min"], d["max"] + 1):
                variants.append(x)

        impactsound = "::Const.Sound.ArmorLeatherImpact"
        invsound = "::Const.Sound.ArmorLeatherImpact"
        if d["invSound"] == "cloth":
            invsound = "::Const.Sound.ClothEquip"
        elif d["invSound"] == "chain":
            invsound = "::Const.Sound.ArmorChainmailImpact"

        if d["impactSound"] == "chain":
            impactsound = "::Const.Sound.ArmorChainmailImpact"
        elif d["impactSound"] == "plate":
            impactsound = "::Const.Sound.ArmorHalfplateImpact"
        elif d["impactSound"] == "bone":
            impactsound = "::Const.Sound.ArmorBoneImpact"

        brushName = d["name"].replace("legend_armor", "legend")
        if "brush" in d:
            brushName = d["brush"]

        brush = "bust_" + brushName
        overlayLarge = "legend_armor/inventory_" + brushName
        overlay = "legend_armor/icon_" + brushName
        icon = "legend_armor/icon_" + brushName

        if "vanilla" in d:
            brush = "bust_" + d["vanilla"]
            overlayLarge = "armor/inventory_" + d["vanilla"] + "_armor"
            overlay = "armor/icon_" + d["vanilla"] + "_armor"
            icon = "armor/icon_" + d["vanilla"] + "_armor"

        if inherit != "":
            if inherit == "legend_padded_surcoat":
                has_missing = has_missing or checkForIcon(
                    path, "legend_armor/inventory_" + "legend_gambeson", variants
                )
                has_missing = has_missing or checkForIcon(
                    path, "legend_armor/icon_" + "legend_gambeson", variants
                )
            else:
                has_missing = has_missing or checkForIcon(
                    path, "legend_armor/inventory_" + inherit, variants
                )
                has_missing = has_missing or checkForIcon(
                    path, "legend_armor/icon_" + inherit, variants
                )
        else:
            has_missing = has_missing or checkForIcon(path, overlayLarge, variants)
            has_missing = has_missing or checkForIcon(path, icon, variants)

        namesL = []
        if "names" in d:
            namesL = "["
            for n in d["names"]:
                namesL += '"' + n + '", '
            namesL += "]"

        bravery = 0
        if "bravery" in d:
            bravery = d["bravery"]

        itemType = "this.m.ItemType"
        if "itemType" in d:
            itemType += " | " + d["itemType"]

        opts = dict(
            test="true",
            inherit=inherit,
            name=fname,
            title=d["title"],
            desc=d["desc"],
            adesc=d["adesc"],
            condition=d["con"],
            value=d["value"],
            stamina=d["stam"],
            id="legend_armor.body." + fname,
            variants=variants,
            layer=layer,
            type=d["layer"].capitalize(),
            brush=brush,
            overlayLarge=overlayLarge,
            overlay=overlay,
            icon=icon,
            impactSound=impactsound,
            invSound=invsound,
            names=namesL,
            rminStam=d["rminStam"] if "rminStam" in d else 0,
            rmaxStam=d["rmaxStam"] if "rmaxStam" in d else 0,
            rminCond=d["rminCond"] if "rminCond" in d else 0,
            rmaxCond=d["rmaxCond"] if "rmaxCond" in d else 0,
            bravery=bravery,
            itemType=itemType,
        )
        s = Template(temp)
        text = s.substitute(opts)
        F.write(text)
        F.close()

        # print('[1, "' + layer + '/' + fname + '"],' + "// " + str(d["con"]))
        # print('"' + layer + '/' + fname +'",')

        if "inherit" in d:
            continue

        if "vanilla" in d:
            continue

        R = L
        if d["layer"] == "cloth":
            R = LBase

        names = []
        for i in variants:
            ind = "0" + str(i) if i < 10 else str(i)
            names.append(brushName + "_" + ind)

        for t in R:
            for name in names:
                name = "bust_" + name
                IC += 1
                opts = dict(
                    ic=hex(IC).upper().lstrip("0X"),
                    name=name,
                    damaged=name + "_damaged",
                    dead=name + "_dead",
                    arrow=name + "_dead_arrows",
                    javelin=name + "_dead_javelin",
                    name_path=os.path.join("..", "entity", "legend_armor", name + ".png"),
                    damaged_path=os.path.join(
                        "..", "entity", "legend_armor", name + "_damaged.png"
                    ),
                    dead_path=os.path.join("..", "entity", "legend_armor", name + "_dead.png"),
                    arrow_path=os.path.join("..", "..", "dead_arrows.png"),
                    javelin_path=os.path.join("..", "..", "dead_javelin.png"),
                )
                s = Template(t)
                text = s.substitute(opts)
                # Only replace forward slashes in img paths, not in "/>" endings
                text = re.sub(
                    r'img="([^"]*)"', lambda m: f'img="{m.group(1).replace("/", chr(92))}"', text
                )
                Brush.write(text)
                imageCount += 1
                if imageCount > 700:
                    Brush.write("</brush>\n")
                    Brush.close()
                    imageCount = 0
                    fileCount += 1
                    Brush = makeSheet(path, fileCount)

    for d in Defs.brush_only_layers:
        R = L
        if d["layer"] == "cloth":
            R = LBase

        brushName = d["name"].replace("legend_armor", "legend")
        if "brush" in d:
            brushName = d["brush"]

        variants = []
        names = [brushName]
        if "variants" in d:
            variants = d["variants"]
        elif "min" in d:
            names = []
            for x in range(d["min"], d["max"] + 1):
                variants.append(x)

        for i in variants:
            ind = "0" + str(i) if i < 10 else str(i)
            names.append(brushName + "_" + ind)

        for t in R:
            for name in names:
                name = "bust_" + name
                IC += 1
                opts = dict(
                    ic=hex(IC).upper().lstrip("0X"),
                    name=name,
                    damaged=name + "_damaged",
                    dead=name + "_dead",
                    arrow=name + "_dead_arrows",
                    javelin=name + "_dead_javelin",
                    name_path=os.path.join("..", "entity", "legend_armor", name + ".png"),
                    damaged_path=os.path.join(
                        "..", "entity", "legend_armor", name + "_damaged.png"
                    ),
                    dead_path=os.path.join("..", "entity", "legend_armor", name + "_dead.png"),
                    arrow_path=os.path.join("..", "..", "dead_arrows.png"),
                    javelin_path=os.path.join("..", "..", "dead_javelin.png"),
                )
                s = Template(t)
                text = s.substitute(opts)
                # Only replace forward slashes in img paths, not in "/>" endings
                text = re.sub(
                    r'img="([^"]*)"', lambda m: f'img="{m.group(1).replace("/", chr(92))}"', text
                )
                Brush.write(text)
                imageCount += 1
                if imageCount > 700:
                    Brush.write("</brush>\n")
                    Brush.close()
                    imageCount = 0
                    fileCount += 1
                    Brush = makeSheet(path, fileCount)

    Brush.write("</brush>\n")
    Brush.close()

    if has_missing:
        raise ValueError("Missing gfx icons")


def main():
    parser = argparse.ArgumentParser(description="Legends armor brushes generator.")
    parser.add_argument("path", type=str, help="The base directory path")
    args = parser.parse_args()

    base_path = Path(args.path)
    generate_legend_armor(base_path)


if __name__ == "__main__":
    main()
