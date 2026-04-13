from string import Template
from shutil import copyfile
from buildscript.python.armor import Templates, Defs, cleanupDirs
import re, os, argparse
from pathlib import Path
import itertools


def checkForIcon(path, iconpath, variants):
    if iconpath.startswith("armor/"):
        return False

    dirpath = path / "gfx/ui/items" / iconpath

    if len(variants) == 0: # unused by now?
        if not dirpath.with_suffix(".png").exists():
            print(f"Missing {dirpath}")
            return True
        return False

    has_missing = False
    for v in variants:
        variant_path = dirpath.with_name(f"{dirpath.name}_{v:02d}.png")
        if not variant_path.exists():
            print(f"Missing {variant_path}")
            has_missing = True

    return has_missing


def makeSheet(armorPath, num):
    dirpath = armorPath / str(num)
    dirpath.mkdir(parents=True, exist_ok=True)

    metadataPath = dirpath / "metadata.xml"
    F = open(metadataPath, "w")
    F.write(f'<brush name="gfx/legend_armor_{num}.png" version="17">\n')
    return F


def makeBrushes(path):
    armorPath = Path(path) / "unpacked/legend_armor"
    cleanupDirs(armorPath)
    fileCount = 0
    imageCount = 0
    F = makeSheet(armorPath, fileCount)
    IC = 4280560954
    
    L = [Template(t) for t in Templates.Layer]
    LBase = [Template(t) for t in Templates.LBase]
    LFrontBack = [Template(t) for t in Templates.LFrontBack]

    for d in itertools.chain(Defs.layers, Defs.brush_only_layers):
        if "inherit" in d or "vanilla" in d:
                continue

        layer = d["layer"]
        R = LFrontBack if "front_back" in d else LBase if layer == "cloth" else L

        brushName = d.get("brush", d["name"])    
        if d in Defs.brush_only_layers:
            if "variants" in d:
                names = [brushName] + [f"{brushName}_{i:02d}" for i in d["variants"]]
            elif "min" in d: # d["min"] is always present
                names = [f"{brushName}_{i:02d}" for i in range(d["min"], d["max"] + 1)]
            else:
                names = [brushName]
        else:
            names = [f"{brushName}_{i:02d}" for i in d.get("variants", range(d.get("min", 1), d.get("max", 0) + 1))]

        for t in R:
            for name in names:
                IC += 1
                opts = {
                        "ic": f"{IC:X}",
                        "name": name,
                        "damaged": f"{name}_damaged",
                        "dead": f"{name}_dead",
                        "arrow": f"{name}_dead_arrows",
                        "javelin": f"{name}_dead_javelin",
                        "name_path": f"..\\entity\\legend_armor\\{name}.png",
                        "damaged_path": f"..\\entity\\legend_armor\\{name}_damaged.png",
                        "dead_path": f"..\\entity\\legend_armor\\{name}_dead.png",
                        "arrow_path": "..\\..\\dead_arrows.png",
                        "javelin_path": "..\\..\\dead_javelin.png",
                }
                if "front_back" in d:
                    fbo = d["front_back"]
                    opts.update({
                        "front_name": f"{name}_front",
                        "front_damaged": f"{name}_front_damaged",
                        "front_dead": f"{name}_front_dead",
                        "back_name": f"{name}_back",
                        "back_damaged": f"{name}_back_damaged",
                        "back_dead": f"{name}_back_dead",
                        "front_name_path": f"..\\entity\\legend_armor\\front_back\\{name}_front.png",
                        "front_damaged_path": f"..\\entity\\legend_armor\\front_back\\{name}_front_damaged.png",
                        "front_dead_path": f"..\\entity\\legend_armor\\front_back\\{name}_front_dead.png",
                        "back_name_path": f"..\\entity\\legend_armor\\front_back\\{name}_back.png",
                        "back_damaged_path": f"..\\entity\\legend_armor\\front_back\\{name}_back_damaged.png",
                        "back_dead_path": f"..\\entity\\legend_armor\\front_back\\{name}_back_dead.png",
                        "fl": fbo["front"][0], "fr": fbo["front"][1], "ft": fbo["front"][2], "fb": fbo["front"][3],
                        "fld": fbo["front_dead"][0], "frd": fbo["front_dead"][1], "ftd": fbo["front_dead"][2], "fbd": fbo["front_dead"][3],
                        "bl": fbo["back"][0], "br": fbo["back"][1], "bt": fbo["back"][2], "bb": fbo["back"][3],
                        "bld": fbo["back_dead"][0], "brd": fbo["back_dead"][1], "btd": fbo["back_dead"][2], "bbd": fbo["back_dead"][3],
                    })
                F.write(t.substitute(opts))

                imageCount += 1
                if imageCount > 700:
                    F.write("</brush>\n")
                    F.close()
                    imageCount = 0
                    fileCount += 1
                    F = makeSheet(armorPath, fileCount)

    F.write("</brush>\n")
    F.close()


def generate_legend_armor(base_path):
    has_missing = False
    for d in Defs.layers:
        
        inherit = d.get("inherit", "") # d["inherit"] isn't used anymore
        layer = d["layer"]
        fname = f"legend_armor_{d['name']}"

        if layer == "cloth":
            temp = Templates.BaseNamedNut if "named" in d else (Templates.BaseNutInherit if inherit else Templates.BaseNut)
        elif layer == "cloak":
            temp = Templates.CloakNut
        elif layer == "tabard":
            temp = Templates.TabardNut
        else:
            temp = Templates.NamedUpgradeNut if "named" in d else Templates.UpgradeNut

        sounds = {
            "cloth": "::Const.Sound.ClothEquip",
            "leather": "::Const.Sound.ArmorLeatherImpact",
            "chain": "::Const.Sound.ArmorChainmailImpact",
            "plate": "::Const.Sound.ArmorHalfplateImpact",
            "bone":  "::Const.Sound.ArmorBoneImpact",
        }
        invsound = sounds.get(d.get("invSound"), sounds["leather"])
        impactsound = sounds.get(d.get("impactSound"), sounds["leather"])

        variants = d.get("variants", list(range(d.get("min", 1), d.get("max", 0) + 1))) # d["variants"] isn't used anymore
        brushName = d.get("brush", d["name"])

        if "vanilla" in d:
            brush = f"bust_{d['vanilla']}"
            overlayLarge = f"armor/inventory_{d['vanilla']}_armor"
            overlay = icon = f"armor/icon_{d['vanilla']}_armor"
        else:
            brush = brushName
            overlayLarge = f"legend_armor/inventory_{brushName}"
            overlay = icon = f"legend_armor/icon_{brushName}"

        if inherit:
            has_missing = has_missing or checkForIcon(base_path, f"legend_armor/inventory_{inherit}", variants)
            has_missing = has_missing or checkForIcon(base_path, f"legend_armor/icon_{inherit}", variants)
        else:
            has_missing = has_missing or checkForIcon(base_path, overlayLarge, variants)
            has_missing = has_missing or checkForIcon(base_path, icon, variants)

        opts = {
            "test": "true",
            "inherit": inherit,
            "name": fname,
            "title": d["title"],
            "desc": d["desc"],
            "adesc": d["adesc"],
            "condition": d["con"],
            "value": d["value"],
            "stamina": d["stam"],
            "id": f"legend_armor.body.{fname}",
            "variants": variants,
            "layer": layer,
            "type": layer.capitalize(),
            "brush": brush,
            "overlayLarge": overlayLarge,
            "overlay": overlay,
            "icon": icon,
            "impactSound": impactsound,
            "invSound": invsound,
            "names": "[" + ", ".join(f'"{n}"' for n in d["names"]) + "]" if "names" in d else "[]",
            "bravery": d.get("bravery", 0),
            "itemType": f"this.m.ItemType | {d['itemType']}" if "itemType" in d else "this.m.ItemType",
        }
        if "named" in d:
            opts.update({
                "names":    "[" + ", ".join(f'"{n}"' for n in d["named"].get("names", [])) + "]",
                "rminStam": d["named"].get("fat", {}).get("min", 0),
                "rmaxStam": d["named"].get("fat", {}).get("max", 0),
                "rminCond": d["named"].get("con", {}).get("min", 0),
                "rmaxCond": d["named"].get("con", {}).get("max", 0)
            })
        # print('[1, "' + layer + '/' + fname + '"],' + "// " + str(d["con"]))
        # print('"' + layer + '/' + fname +'",')
        dirpath = base_path / "legend_armor_scripts" / layer
        dirpath.mkdir(parents=True, exist_ok=True)
        filepath = dirpath / f"{fname}.nut"
        text = Template(temp).substitute(opts)
        filepath.write_text(text.strip())

    makeBrushes(base_path)

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