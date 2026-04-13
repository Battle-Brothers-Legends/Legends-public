from string import Template
from buildscript.python.helmet import Templates, Defs, cleanupDirs
from PIL import Image
from buildscript.python.crop import CropTool
import re, os, argparse
from pathlib import Path
import itertools


def checkForIcon(path, iconpath, variants):
    dirpath = path / "gfx/ui/items/legend_helmets" / iconpath

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


def makeSheet(helmetsPath, num):
    dirpath = helmetsPath / str(num)
    dirpath.mkdir(parents=True, exist_ok=True)

    metadataPath = dirpath / "metadata.xml"
    F = open(metadataPath, "w")
    F.write(f'<brush name="gfx/legend_helmets_{num}.png" version="17">\n')
    return F


def makeBrushes(path):
    helmetsPath = Path(path) / "unpacked/legend_helmets"
    cleanupDirs(helmetsPath)
    helmetDir = helmetsPath / "entity"
    fileCount = 0
    imageCount = 0
    F = makeSheet(helmetsPath, fileCount)

    templates = [Template(t) for t in Templates.BLayer]
    cardinals = Templates.Cardinals

    for d in itertools.chain(Defs.layers, Defs.brush_only_layers):
        # ratio = 0
        # if d["stam"] < -1 and d["layer"] == "helm":
        #     ratio = (d["con"] * 1.0) / (-1.0 * d["stam"])
        #     print("{} {} : {}".format(d["name"], d["con"], ratio))
        if "min" in d:
            names = [f"{d['name']}_{i:02d}" for i in range(d["min"], d["max"] + 1)]
        else: # unused by now?
            names = [d["name"]]

        for name in names:
            name_path, damaged_path, dead_path, _dir = Templates.get_sprites(name)
            c_name_path, c_damaged_path, c_dead_path, c_dir = Templates.get_cropped_sprites(name)

            def fixPathsAndGetCardinals(rel_path, crop_rel_path, cardinal_index):            
                CropTool.crop(helmetDir / rel_path, helmetDir / crop_rel_path)
                return crop_rel_path.replace("/", "\\"), Templates.calculate_cardinals(cardinals[cardinal_index], CropTool.getBounds(helmetDir / rel_path))

            fin_name_path, name_cardinals = fixPathsAndGetCardinals(name_path, c_name_path, 0)
            fin_damaged_path, damaged_cardinals   = fixPathsAndGetCardinals(damaged_path, c_damaged_path, 1)
            fin_dead_path, dead_cardinals = fixPathsAndGetCardinals(dead_path, c_dead_path, 2)

            opts = {
                "name": f"legendhelms_{name}",
                "damaged": f"legendhelms_{name}_damaged",
                "dead": f"legendhelms_{name}_dead",
                "name_path": fin_name_path,
                "damaged_path": fin_damaged_path,
                "dead_path": fin_dead_path,
                "name_cardinals": name_cardinals,
                "damaged_cardinals": damaged_cardinals,
                "dead_cardinals": dead_cardinals,
            }
            #print(calculateCropArea(os.path.abspath(os.path.join(helmetDir, name + ".png"))))

            for s in templates:
                F.write(s.substitute(opts))

                imageCount += 1  
                if imageCount > 1600:           
                    F.write("</brush>\n")
                    F.close()
                    imageCount = 0
                    fileCount += 1
                    F = makeSheet(helmetsPath, fileCount)

    F.write("</brush>\n")
    F.close()


def generate_legend_helmets(base_path):
    has_missing = False
    for d in Defs.layers:

        layer = d["layer"]
        fname = f"legend_helmet_{d['name']}"

        # print('"' + layer + '/' + fname + '",')
        # continue

        if layer == "hood":
            temp = Templates.BaseNamedLayer if "named" in d else Templates.BaseLayer
        else:
            temp = Templates.NamedLayer if "named" in d else Templates.Layer

        sounds = {
            "cloth": "::Const.Sound.ClothEquip",
            "leather": "::Const.Sound.ArmorLeatherImpact",
            "chain": "::Const.Sound.ArmorChainmailImpact",
            "plate": "::Const.Sound.ArmorHalfplateImpact",
            "bone":  "::Const.Sound.ArmorBoneImpact",
        }
        invsound = sounds.get(d.get("invSound"), sounds["leather"])
        impactsound = sounds.get(d.get("impactSound"), sounds["leather"])

        variants = list(range(1, d["max"] + 1))
        has_missing = has_missing or checkForIcon(base_path, f"inventory_{d['name']}", variants)

        opts = {
            "test": "true",
            "name": fname,
            "title": d["title"],
            "desc": d["desc"],
            "adesc": d["adesc"],
            "condition": d["con"],
            "value": d["value"],
            "stamina": d["stam"],
            "vision": d["vis"],
            "id": f"armor.head.{fname}",
            "variants": variants,
            "layer": layer,
            "type": layer.capitalize(),
            "brush": f"legendhelms_{d['name']}",
            "icon": f"inventory_{d['name']}",
            "impactSound": impactsound,
            "invSound": invsound,
            "lower": "true" if "lower" in d else "false",
            "hair": d["hair"],
            "beard": d["beard"],
            "itemType": f"this.m.ItemType | {d['itemType']}" if "itemType" in d else "this.m.ItemType",
        }
        if "named" in d:
            opts.update({
                "names":    d["named"].get("names", []),
                "rminViz":  d["named"].get("vis", {}).get("min", 0),
                "rmaxViz":  d["named"].get("vis", {}).get("max", 0),
                "rminStam": d["named"].get("fat", {}).get("min", 0),
                "rmaxStam": d["named"].get("fat", {}).get("max", 0),
                "rminCond": d["named"].get("con", {}).get("min", 0),
                "rmaxCond": d["named"].get("con", {}).get("max", 0)
            })

        dirpath = base_path / "helmet_scripts" / layer
        dirpath.mkdir(parents=True, exist_ok=True)
        filepath = dirpath / f"{fname}.nut"
        text = Template(temp).substitute(opts)
        filepath.write_text(text.strip())

    makeBrushes(base_path)

    if has_missing:
        raise ValueError("Missing gfx icons")


def main():
    parser = argparse.ArgumentParser(description="Legends helmet brushes generator.")
    parser.add_argument("path", type=str, help="The base directory path")
    args = parser.parse_args()

    base_path = Path(args.path)
    generate_legend_helmets(base_path)


if __name__ == "__main__":
    main()