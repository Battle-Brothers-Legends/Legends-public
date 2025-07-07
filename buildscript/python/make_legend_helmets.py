from string import Template
from buildscript.python.helmet import Templates, Defs, cleanupDirs
from PIL import Image
from buildscript.python.crop import CropTool
import re, os, argparse
from pathlib import Path


def checkForIcon(path, iconpath, variants):
    dirpath = os.path.join(path, "gfx", "ui", "items", "legend_helmets")
    parts = iconpath.split("/")

    for p in parts:
        dirpath = os.path.join(dirpath, p)

    if len(variants) == 0:
        if not os.path.exists(dirpath + ".png"):
            print("Missing " + dirpath)
            return True
        return False

    has_missing = False
    for v in variants:
        variant = str(v)
        if v < 10:
            variant = "0" + variant
        if not os.path.exists(dirpath + "_" + variant + ".png"):
            print("Missing " + dirpath + "_" + variant)
            has_missing = True

    return has_missing


def makeSheet(path, num):
    dirpath = os.path.join(path, "unpacked", "legend_helmets", "" + str(num))
    if not os.path.exists(dirpath):
        os.makedirs(dirpath)

    filepath = os.path.join(dirpath, "metadata.xml")
    F = open(filepath, "w")
    F.write('<brush name="gfx/legend_helmets_' + str(num) + '.png" version="17">\n')
    return F


def makeBrushes(path):
    cleanupDirs(os.path.join(path, "unpacked", "legend_helmets"))
    helmetDir = os.path.join(path, "unpacked", "legend_helmets", "entity")
    fileCount = 0
    imageCount = 0
    F = makeSheet(path, fileCount)

    L = Templates.BLayer
    for d in Defs.layers:
        # ratio = 0
        # if d["stam"] < -1 and d["layer"] == "helm":
        #     ratio = (d["con"] * 1.0) / (-1.0 * d["stam"])
        #     print("{} {} : {}".format(d["name"], d["con"], ratio))
        R = L
        names = [d["name"]]
        if "min" in d:
            names = []
            for i in range(d["min"], d["max"] + 1):
                ind = "0" + str(i) if i < 10 else str(i)
                names.append(d["name"] + "_" + ind)

        layer = d["layer"]

        if "lowervanity" in d:
            layer += "_lower"

        for t in R:
            for name in names:
                name_path, damaged_path, dead_path, _dir = Templates.get_sprites(name)
                c_name_path, c_damaged_path, c_dead_path, c_dir = Templates.get_cropped_sprites(
                    name
                )

                CropTool.crop(
                    os.path.abspath(os.path.join(helmetDir, name_path)),
                    os.path.abspath(os.path.join(helmetDir, c_name_path)),
                )
                CropTool.crop(
                    os.path.abspath(os.path.join(helmetDir, damaged_path)),
                    os.path.abspath(os.path.join(helmetDir, c_damaged_path)),
                )
                CropTool.crop(
                    os.path.abspath(os.path.join(helmetDir, dead_path)),
                    os.path.abspath(os.path.join(helmetDir, c_dead_path)),
                )
                cardinals = Templates.Cardinals

                opts = dict(
                    name="legendhelms_" + name,
                    damaged="legendhelms_" + name + "_damaged",
                    dead="legendhelms_" + name + "_dead",
                    name_path=c_name_path,
                    damaged_path=c_damaged_path,
                    dead_path=c_dead_path,
                    name_cardinals=Templates.calculate_cardinals(
                        cardinals[0],
                        CropTool.getBounds(os.path.abspath(os.path.join(helmetDir, name_path))),
                    ),
                    damaged_cardinals=Templates.calculate_cardinals(
                        cardinals[1],
                        CropTool.getBounds(os.path.abspath(os.path.join(helmetDir, damaged_path))),
                    ),
                    dead_cardinals=Templates.calculate_cardinals(
                        cardinals[2],
                        CropTool.getBounds(os.path.abspath(os.path.join(helmetDir, dead_path))),
                    ),
                )
                #                 print(calculateCropArea(os.path.abspath(os.path.join(helmetDir, name + ".png"))))

                s = Template(t)
                text = s.substitute(opts)
                # Only replace forward slashes in img paths, not in "/>" endings
                text = re.sub(
                    r'img="([^"]*)"', lambda m: f'img="{m.group(1).replace("/", chr(92))}"', text
                )
                F.write(text)
                imageCount += 1
                if imageCount > 1600:
                    F.write("</brush>\n")
                    F.close()
                    imageCount = 0
                    fileCount += 1
                    F = makeSheet(path, fileCount)

    for d in Defs.brush_only_layers:
        R = L
        names = [d["name"]]
        if "min" in d:
            names = []
            for i in range(d["min"], d["max"] + 1):
                ind = "0" + str(i) if i < 10 else str(i)
                names.append(d["name"] + "_" + ind)

        layer = d["layer"]

        if "lowervanity" in d:
            layer += "_lower"

        for t in R:
            for name in names:
                name_path, damaged_path, dead_path, _dir = Templates.get_sprites(name)
                c_name_path, c_damaged_path, c_dead_path, c_dir = Templates.get_cropped_sprites(
                    name
                )

                CropTool.crop(
                    os.path.abspath(os.path.join(helmetDir, name_path)),
                    os.path.abspath(os.path.join(helmetDir, c_name_path)),
                )
                CropTool.crop(
                    os.path.abspath(os.path.join(helmetDir, damaged_path)),
                    os.path.abspath(os.path.join(helmetDir, c_damaged_path)),
                )
                CropTool.crop(
                    os.path.abspath(os.path.join(helmetDir, dead_path)),
                    os.path.abspath(os.path.join(helmetDir, c_dead_path)),
                )
                cardinals = Templates.Cardinals

                opts = dict(
                    name="legendhelms_" + name,
                    name_path=c_name_path,
                    damaged_path=c_damaged_path,
                    dead_path=c_dead_path,
                    name_cardinals=Templates.calculate_cardinals(
                        cardinals[0],
                        CropTool.getBounds(os.path.abspath(os.path.join(helmetDir, name_path))),
                    ),
                    damaged_cardinals=Templates.calculate_cardinals(
                        cardinals[1],
                        CropTool.getBounds(os.path.abspath(os.path.join(helmetDir, damaged_path))),
                    ),
                    dead_cardinals=Templates.calculate_cardinals(
                        cardinals[2],
                        CropTool.getBounds(os.path.abspath(os.path.join(helmetDir, dead_path))),
                    ),
                )
                s = Template(t)
                text = s.substitute(opts)
                # Only replace forward slashes in img paths, not in "/>" endings
                text = re.sub(
                    r'img="([^"]*)"', lambda m: f'img="{m.group(1).replace("/", chr(92))}"', text
                )
                F.write(text)
                imageCount += 1
                if imageCount > 1600:
                    F.write("</brush>\n")
                    F.close()
                    imageCount = 0
                    fileCount += 1
                    F = makeSheet(path, fileCount)

    F.write("</brush>\n")
    F.close()


def generate_legend_helmets(base_path):
    path = str(base_path)  # Convert Path to string for compatibility

    has_missing = False
    for d in Defs.layers:

        layer = d["layer"]

        lower = "false"

        temp = Templates.Layer
        if "base" in d:
            temp = Templates.BaseLayer
        if "named" in d:
            temp = Templates.NamedLayer

        if "lowervanity" in d:
            layer += "_lower"
            lower = "true"

        fname = "legend_helmet_" + d["name"]

        # print('"' + layer + '/' + fname + '",')
        # continue

        dirpath = os.path.join(path, "helmet_scripts", layer)
        if not os.path.exists(dirpath):
            os.makedirs(dirpath)

        filepath = os.path.join(dirpath, fname + ".nut")
        F = open(filepath, "w")
        variants = []
        for x in range(d["max"]):
            variants.append(x + 1)

        title = d["title"]
        desc = d["desc"]

        has_missing = has_missing or checkForIcon(path, "inventory_" + d["name"], variants)

        itemType = "this.m.ItemType"
        if "itemType" in d:
            itemType += " | " + d["itemType"]

        opts = dict(
            test="true",
            name=fname,
            title=title,
            desc=desc,
            condition=d["con"],
            value=d["value"],
            stamina=d["stam"],
            vision=d["vis"],
            id="armor.head." + fname,
            variants=variants,
            layer=layer,
            type=d["layer"].capitalize(),
            brush="legendhelms_" + d["name"],
            icon="inventory_" + d["name"],
            lower=lower,
            hair=d["hair"],
            beard=d["beard"],
            names=d["names"] if "names" in d else [],
            rminViz=d["rminViz"] if "rminViz" in d else 0,
            rmaxViz=d["rmaxViz"] if "rmaxViz" in d else 0,
            rminStam=d["rminStam"] if "rminStam" in d else 0,
            rmaxStam=d["rmaxStam"] if "rmaxStam" in d else 0,
            rminCond=d["rminCond"] if "rminCond" in d else 0,
            rmaxCond=d["rmaxCond"] if "rmaxCond" in d else 0,
            itemType=itemType,
        )
        s = Template(temp)
        text = s.substitute(opts)
        F.write(text.strip())
        F.close()

    makeBrushes(path)

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

"""

"helm/legend_helmet_southern_leather_helm",
"helm/legend_helmet_southern_studded_leather_helm",
"helm/legend_helmet_carthaginian",
"helm/legend_helmet_bronze_helm",
"helm/legend_helmet_southern_conic_helm",
"helm/legend_helmet_dentist_helmet",
"helm/legend_helmet_legend_armet_01_named",
"helm/legend_helmet_stag_helm",
"helm/legend_helmet_swan_helm",
"helm/legend_helmet_skin_helm",


"top/legend_helmet_goblin_leather_mask",
"top/legend_helmet_vampire_crown",
"top/legend_helmet_nose_plate",
"top/legend_helmet_faceplate_curved",
"top/legend_helmet_faceplate_short",
"top/legend_helmet_faceplate_long",
"top/legend_helmet_faceplate_winged",
"top/legend_helmet_faceplate_pointed",
"top/legend_helmet_faceplate_pointed_slit",
"top/legend_helmet_faceplate_full",
"top/legend_helmet_faceplate_full_breaths",
"top/legend_helmet_faceplate_full_gold",
"top/legend_helmet_faceplate_full_01_named",
"top/legend_helmet_southern_faceplate_bearded",
"top/legend_helmet_faceplate_gold",
"top/legend_helmet_golden_helm",
"top/legend_helmet_golden_mask",


"vanity/legend_helmet_crown",
"vanity/legend_helmet_impaled_head",
"vanity/legend_helmet_noble_buckle",
"vanity/legend_helmet_noble_feather",
"vanity/legend_helmet_noble_floppy_hat",
"vanity/legend_helmet_noble_hat",
"vanity/legend_helmet_noble_hood",
"vanity/legend_helmet_wreath",
"vanity/legend_helmet_royal_hood",


"vanity_lower/legend_helmet_back_feathers",

Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_goblin_scarf"], //5
        [1, "hood/legend_helmet_barb_chain_scarf"], //55
        [1, "hood/legend_helmet_rotten_chain_scarf"], //60
        [1, "hood/legend_helmet_cloth_scarf"], //10
        [1, "hood/legend_helmet_cloth_bandana"], //15
        [1, "hood/legend_helmet_patched_hood"], //25
        [1, "hood/legend_helmet_simple_hood"], //30
        [1, "hood/legend_helmet_hood_cloth_round"], //30
        [1, "hood/legend_helmet_hood_cloth_wide"], //30
        [1, "hood/legend_helmet_hood_cloth_long"], //30
        [1, "hood/legend_helmet_leather_cap"], //35
        [1, "hood/legend_helmet_padded_cap"], //40
        [1, "hood/legend_helmet_leather_hood"], //45
        [1, "hood/legend_helmet_padded_hood"], //50
        [1, "hood/legend_helmet_open_chain_hood"], //65
        [1, "hood/legend_helmet_chain_scarf"], //70
        [1, "hood/legend_helmet_chain_hood"], //80
        [1, "hood/legend_helmet_chain_hood_full"], //90
        [1, "hood/legend_helmet_bronze_chain"], //100
    ],
    Helms = [
        [1, "helm/legend_helmet_ancient_conic_helm"], //15
        [1, "helm/legend_helmet_ancient_kettle"], //15
        [1, "helm/legend_helmet_ancient_dome"], //15
        [1, "helm/legend_helmet_ancient_dome_tailed"], //15
        [1, "helm/legend_helmet_ancient_face_plate"], //50
        [1, "helm/legend_helmet_ancient_legionaire"], //50
        [1, "helm/legend_helmet_ancient_side_hawk"], //50
        [1, "helm/legend_helmet_ancient_tailed_conic_helm"], //50
        [1, "helm/legend_helmet_ancient_crested"], //100
        [1, "helm/legend_helmet_ancient_face_helm"], //100
        [1, "helm/legend_helmet_orc_strapped_helm"], //160
        [1, "helm/legend_helmet_orc_double_helm"], //220
        [1, "helm/legend_helmet_orc_great_helm"], //420
        [1, "helm/legend_helmet_crude_metal_helm"], //65
        [1, "helm/legend_helmet_crude_cylinder_helm"], //110
        [1, "helm/legend_helmet_heavy_plate_helm"], //170
        [1, "helm/legend_helmet_heavy_plate_helm_named"], //170
        [1, "helm/legend_helmet_crude_skull_helm"], //130
        [1, "helm/legend_helmet_heavy_spiked_helm"], //150
        [1, "helm/legend_helmet_viking_helm"], //45
        [1, "helm/legend_helmet_norman_helm"], //50
        [1, "helm/legend_helmet_flat_top_helm"], //70
        [1, "helm/legend_helmet_barbute"], //110
        [1, "helm/legend_helmet_horsetail"], //120
        [1, "helm/legend_helmet_basinet"], //130
        [1, "helm/legend_helmet_kettle_helm"], //130
        [1, "helm/legend_helmet_flat_top_face_plate"], //130
        [1, "helm/legend_helmet_carthaginian"], //160
        [1, "helm/legend_helmet_conic_helm"], //170
        [1, "helm/legend_helmet_sallet"], //185
        [1, "helm/legend_helmet_nordic_helm"], //185
        [1, "helm/legend_helmet_bronze_helm"], //190
        [1, "helm/legend_helmet_great_helm"], //220
        [1, "helm/legend_helmet_legend_armet"], //260
        [1, "helm/legend_helmet_legend_frogmouth"], //265
        [1, "helm/legend_helmet_legend_ancient_gladiator"], //115
        [1, "helm/legend_helmet_legend_ancient_legionaire_restored"], //60
        [1, "helm/legend_helmet_dentist_helmet"], //160
        [1, "helm/legend_helmet_tailed_conic"], //185
        [1, "helm/legend_helmet_legend_armet_01_named"], //260
        [1, "helm/legend_helmet_stag_helm"], //230
        [1, "helm/legend_helmet_swan_helm"], //230
        [1, "helm/legend_helmet_skin_helm"], //190
        [1, "helm/legend_helmet_rotten_flat_top_face_mask"], //150
        [1, "helm/legend_helmet_rotten_great_helm"], //160
    ],
    Tops = [
        [1, "top/legend_helmet_orc_leather_mask"], //35
        [1, "top/legend_helmet_orc_horn_mask"], //60
        [1, "top/legend_helmet_orc_metal_mask"], //120
        [1, "top/legend_helmet_goblin_leaves"], //5
        [1, "top/legend_helmet_goblin_leaf_helm"], //10
        [1, "top/legend_helmet_goblin_gillie"], //25
        [1, "top/legend_helmet_goblin_leather_mask"], //40
        [1, "top/legend_helmet_goblin_leather_helm"], //45
        [1, "top/legend_helmet_goblin_chain_helm"], //70
        [1, "top/legend_helmet_goblin_spiked_helm"], //90
        [1, "top/legend_helmet_vampire_crown"], //30
        [1, "top/legend_helmet_ancient_crown"], //80
        [1, "helm/legend_helmet_ancient_lion_mask"], //100
        [1, "helm/legend_helmet_ancient_mask"], //100
        [1, "helm/legend_helmet_ancient_beard_mask"], //100
        [1, "top/legend_helmet_leather_hood_barb"], //105
        [1, "top/legend_helmet_nose_plate"], //15
        [1, "top/legend_helmet_headband_side"], //20
        [1, "top/legend_helmet_headband_nose"], //30
        [1, "top/legend_helmet_eyemask"], //35
        [1, "top/legend_helmet_chain_attachment"], //40
        [1, "top/legend_helmet_faceplate_flat"], //45
        [1, "top/legend_helmet_faceplate_curved"], //50
        [1, "top/legend_helmet_faceplate_short"], //60
        [1, "top/legend_helmet_cult_hood"], //65
        [1, "top/legend_helmet_faceplate_long"], //65
        [1, "top/legend_helmet_faceplate_winged"], //70
        [1, "top/legend_helmet_faceplate_snub_nose"], //75
        [1, "top/legend_helmet_faceplate_snub_slit"], //80
        [1, "top/legend_helmet_faceplate_sharp"], //85
        [1, "top/legend_helmet_facemask"], //90
        [1, "top/legend_helmet_faceplate_pointed"], //95
        [1, "top/legend_helmet_faceplate_pointed_slit"], //100
        [1, "top/legend_helmet_faceplate_full"], //110
        [1, "top/legend_helmet_faceplate_gold"], //105
        [1, "top/legend_helmet_faceplate_full_gold"], //115
        [1, "top/legend_helmet_golden_helm"], //80
        [1, "top/legend_helmet_faceplate_raised"], //55
        [1, "top/legend_helmet_faceplate_full_01_named"], //110
        [1, "top/legend_helmet_golden_mask"], //100
        [1, "top/legend_helmet_warlock_skull"], //90
    ],
    Vanity = [
        [1, "vanity/legend_helmet_hood_cloth_square"], //30
        [1, "vanity/legend_helmet_sack"], //80
        [1, "vanity/legend_helmet_antler"], //10
        [1, "vanity/legend_helmet_bear_head"], //10
        [1, "vanity/legend_helmet_beret"], //10
        [1, "vanity/legend_helmet_bull_horns"], //10
        [1, "vanity/legend_helmet_crown"], //10
        [1, "vanity/legend_helmet_faction_helmet"], //10
        [1, "vanity/legend_helmet_faction_helmet_2"], //10
        [1, "vanity/legend_helmet_feather_band"], //10
        [1, "vanity/legend_helmet_feathered_hat"], //10
        [1, "vanity/legend_helmet_fencer_hat"], //10
        [1, "vanity/legend_helmet_goat_horns"], //10
        [1, "vanity/legend_helmet_headband"], //10
        [1, "vanity/legend_helmet_horn_decorations"], //10
        [1, "vanity/legend_helmet_hunter_cap"], //10
        [1, "vanity/legend_helmet_impaled_head"], //10
        [1, "vanity/legend_helmet_jester_hat"], //10
        [1, "vanity/legend_helmet_metal_bird"], //10
        [1, "vanity/legend_helmet_noble_buckle"], //10
        [1, "vanity/legend_helmet_noble_feather"], //10
        [1, "vanity/legend_helmet_noble_floppy_hat"], //10
        [1, "vanity/legend_helmet_noble_hat"], //10
        [1, "vanity/legend_helmet_noble_hood"], //10
        [1, "vanity/legend_helmet_wreath"], //10
        [1, "vanity/legend_helmet_orc_bones"], //10
        [1, "vanity/legend_helmet_plait"], //10
        [1, "vanity/legend_helmet_ponytail"], //10
        [1, "vanity/legend_helmet_ram_horns"], //10
        [1, "vanity/legend_helmet_side_feather"], //10
        [1, "vanity/legend_helmet_straw_hat"], //10
        [1, "vanity/legend_helmet_top_feather"], //10
        [1, "vanity/legend_helmet_witchhunter_helm"], //10
        [1, "vanity/legend_helmet_wizard_cowl"], //10
        [1, "vanity/legend_helmet_wolf_helm"], //10
        [1, "vanity/legend_helmet_white_wolf_helm"], //10
        [1, "vanity/legend_helmet_royal_hood"], //10
        [1, "vanity/legend_helmet_lindwurm_helm"], //10
        [1, "vanity/legend_helmet_redback_helm"], //10
        [1, "vanity/legend_helmet_nun_habit"], //10
        [1, "vanity/legend_helmet_nach_helm"], //10
        [1, "vanity/legend_helmet_mountain_helm"], //10
        [1, "vanity/legend_helmet_demon_alp_helm"], //10
        [1, "vanity/legend_helmet_warlock_hood"], //10
        [1, "vanity_lower/legend_helmet_back_crest"], //10
        [1, "vanity_lower/legend_helmet_back_feathers"], //10
        [1, "vanity_lower/legend_helmet_feather_crest"], //10
        [1, "vanity_lower/legend_helmet_knotted_tail"], //10
        [1, "vanity_lower/legend_helmet_orc_tail"], //10
        [1, "vanity_lower/legend_helmet_top_plume"], //10
        [1, "vanity_lower/legend_helmet_wings"], //10
    ]
}]
"""
