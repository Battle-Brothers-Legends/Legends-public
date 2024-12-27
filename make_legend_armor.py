
from string import Template
from shutil import copyfile
import os

Names = [
"Beast",
"Berserker",
"Wolf",
"Predator",
"Hunter\'s Mask",
"Hag Bane",
"Witch\'s Doom",
"Hag\'s End",
"Curse Lifter",
"Jinx Helm",
"Decorated",
"Ribboned",
"Splinted",
"Blazing Dome",
"Nomad\'s Crown",
"Clan Helmet",
"Highland Helm",
"Faceguard",
"Owl",
"Ward",
"Headguard",
"Protector",
"Sea Raider",
"Chieftain",
"Engraved",
"Face of the North",
"Metal Skull",
"Tribal Visage",
"Pillager Gaze",
"Bladed",
"Horned",
"Protector",
"Steel Countenance",
"Lizard",
"Dragon\'s Dome",
"Ward",
"Dead Man\'s Head",
"Seance\'s Skull",
"Faith",
"Redemption",
"Pennance",
"Rapture",
"Guardian",
"Hope",
"Bullwark",
"Bastion",
"Breakers End",
"The Summit",
"The Wall",
"The Halo",
"The Swan Toad",
"Bufo Bufo",
"Treefrog",
"Spadefoot",
"Stechhelm",
"Newt",
"Triturust",
"Ranid",
"The Play",
"Folly\'s Friend",
"Fool\'s crown",
"Jolly Folly",
"Knightly",
"Golden Crest",
"Vizier\'s Pride",
"Sun Veil",
"Gilder\'s Pride",
"Gilder\'s Visage",
"The Masque",
"Harlequin\'s Visage",
"The Silent Shroud",
"Reaper\'s Mirth",
"The Dawning Hope",
"Shattered Mirage",
"Maker\'s Mark",
"Gluttonous",
"King\'s Bane",
"Purifier\'s",
"Long Grasp",
"The Settling",
"The Quickening",
"Mother\'s Loss",
"Noble\'s Demise",
"Kingslayer",
"Deathmark",
"Fearblocker",
"Deathgrip",
"Fecund",
"Sanctified",
"Witch Hammer",
"Lumbering",
"Proctor\'s Gaze",
"All Seeing",
"Watchful",
"The Rising",
"Trinity",
"Diabolica",
"Warthirst",
"Marshall\'s Cry",
"Hopeless",
"Struggling",
"Umbra",
"Optimist\'s Demise",
"Death\'s Clutch",
"Purified",
"Hardpoint",
"Shattering",
"Begger\'s",
"Gothic",
"Noble\'s Burden",
"Dark Veil",
"Insurmountable",
"Afflicted",
"Lucem",
"Martyr\'s Call",
"Builder\'s",
"Gambler\'s Pride",
"Shieldmaiden\'s",
"Godbane",
"Madman\'s Unitatis",
"Stalwart",
"Mistwalker\'s",
"Stalker\'s",
"Mithering Doom",
"Stonewall",
"The Setting",
"Crypt Keeper\'s",
"Last Gasp",
"Calor",
"Putrid",
"Doloris Capere",
"The Falling",
"Solemn Vow",
"Deacon\'s Lament",
"Agile",
"Curse Bringer",
"Plague Bringer",
"Tamer\'s",
"Chalice",
"Handmaiden\'s",
"Slayer\'s",
"Deathmarch",
"Bountiful",
"Mindfire",
"Swatter",
"Ancient",
"Wanderer\'s",
"Riposte",
"Profiteer\'s",
"Bane",
"Stonewatcher\'s",
"The Shattering",
"Dishonoured",
"Martial",
"Cataclysmic",
"Mind\'s Cloister",
"Bloated",
"Beacon",
"Temple",
"Chant",
"Chanter\'s",
"Pessimist\'s Blight",
"Crusader\'s Redoubt"
]

layers = [
{"name": "legend_ancient_cloth",                          "layer": "cloth", "min": 1, "max": 4, "value" : 20, "con" : 30, "stam" : -5, "impactSound" : "leather", "invSound" : "cloth", "brush" : "ancient_cloth", \
    "title" :  "Ancient Cloth", \
    "desc" :  "An ancient cloth wrap, heavy and offering little protection", \
    "adesc" :""
},
{"name": "legend_ancient_cloth_restored",                 "layer": "cloth", "min": 1, "max": 5, "value" : 40, "con" : 35, "stam" : -4, "impactSound" : "leather", "invSound" : "cloth", "brush" : "ancient_cloth_restored", \
    "title" :  "Ancient Cloth", \
    "desc" :  "A cloth wrap, heavy and offering small protection", \
    "adesc" :""
},
{"name": "legend_apron_butcher",                          "layer": "cloth", "min": 7, "max": 10, "value" : 50, "con" : 30, "stam" : -3, "impactSound" : "leather", "invSound" : "leather", "brush" : "legend_apron", \
    "title" :  "Butcher\'s Apron", \
    "desc" :  "A rugged apron worn by butchers to protect against accidental cuts.", \
    "adesc" :""
},
{"name": "legend_apron",                                  "layer": "cloth", "min": 1, "max": 6, "value" : 60, "con" : 35, "stam" : -4, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Blacksmith Apron", \
    "desc" :  "A leather apron usually worn by a blacksmith", \
    "adesc" :""
},
{"name": "legend_gladiator_harness",                       "layer": "cloth", "min": 11, "max": 11, "value" : 150, "con" : 40, "stam" : -4, "impactSound" : "leather", "invSound" : "cloth", "vanilla" : "body_southern",  \
    "title" :  "Gladiator Harness", \
    "desc" :  "A leather harness commonly worn by pit fighters in arenas of the southern city states.", \
    "adesc" :""
},
{"name": "legend_gambeson",                               "layer": "cloth", "min": 0, "max": 39, "value" : 250, "con" : 65, "stam" : -8, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Gambeson", \
    "desc" :  "A sturdy and heavy padded tunic that offers decent protection.", \
    "adesc" :""
},
{"name": "legend_gambeson_plain",                         "layer": "cloth", "min": 0, "max": 0, "value" : 250, "con" : 65, "stam" : -8, "impactSound" : "leather", "invSound" : "leather", "inherit" : "legend_gambeson", "variants" : [0,1,8], \
    "title" :  "Gambeson", \
    "desc" :  "A sturdy and heavy padded tunic that offers decent protection.", \
    "adesc" :""
},
# {"name": "legend_gambeson_common_color",                  "layer": "cloth", "min": 0, "max": 39, "value" : 250, "con" : 65, "stam" : -8, "impactSound" : "leather", "invSound" : "cloth", "inherit" : "legend_gambeson", \
#     "title" :  "Gambeson", \
#     "desc" :  "A sturdy and heavy padded tunic that offers decent protection.", \
#     "adesc" :""
# },
# {"name": "legend_gambeson_rare_color",                    "layer": "cloth", "min": 4, "max": 12, "value" : 400, "con" : 65, "stam" : -7, "impactSound" : "leather", "invSound" : "cloth", "inherit" : "legend_gambeson",\
#     "title" :  "Gambeson", \
#     "desc" :  "A sturdy and heavy padded tunic that offers decent protection.", \
#     "adesc" :""
# },
{"name": "legend_gambeson_wolf",                          "layer": "cloth", "min": 1, "max": 1, "value" : 300, "con" : 70, "stam" : -9, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Wolf Gambeson", \
    "desc" :  "A sturdy and heavy padded tunic that offers decent protection.", \
    "adesc" :""
},
{"name": "legend_gambeson_named",                         "layer": "cloth", "min": 1, "max": 12, "value" : 1500, "con" : 70, "stam" : -7, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "", \
    "desc" :  "A master crafted heavy padded tunic that offers excellent protection.", \
    "adesc" :"", \
    "named" : True, "rminStam" : 4, "rmaxStam": 6, "rminCond" : 75, "rmaxCond" : 90,  "names" : Names + ["Heraldic Gambeson", "Splendor", "Grandiosity", "Pageantry", "Swank", "Noble Surcoat", "Duty", "Honor"]
},
{"name": "legend_padded_surcoat",                         "layer": "cloth", "min": 40, "max": 70, "value" : 150, "con" : 55, "stam" : -6, "impactSound" : "leather", "invSound" : "cloth", "brush" : "legend_gambeson", \
    "title" :  "Padded Surcoat", \
    "desc" :  "A sturdy and heavy padded coat that offers decent protection.", \
    "adesc" :""
},
{"name": "legend_padded_surcoat_plain",                   "layer": "cloth", "min": 0, "max": 0, "value" : 150, "con" : 55, "stam" : -6, "impactSound" : "leather", "invSound" : "cloth", "inherit" : "legend_padded_surcoat", "variants" : [40,65,66,67,68,69,70], \
    "title" :  "Padded Surcoat", \
    "desc" :  "A sturdy and heavy padded coat that offers decent protection.", \
    "adesc" :""
},
{"name": "legend_peasant_dress",                          "layer": "cloth", "min": 1, "max": 22, "value" : 25, "con" : 25, "stam" : -2, "impactSound" : "leather", "invSound" : "cloth", "brush" : "peasant_dress", \
    "title" :  "Peasant\'s Dress", \
    "desc" :  "A simple dress of rough fabric and common dye", \
    "adesc" :""
},
{"name": "legend_robes",                                  "layer": "cloth", "min": 0, "max": 0, "value" : 25, "con" : 25, "stam" : -2, "impactSound" : "leather", "invSound" : "cloth", "variants" : [1,2,11,12,13,14,15,16,17,18], \
    "title" :  "Monk\'s Robe", \
    "desc" :  "A rugged, large robe made of simple cloth usually worn by monks and similar individuals who don\'t care for fashion.", \
    "adesc" :""
},
{"name": "legend_robes_magic",                            "layer": "cloth", "min": 1, "max": 6, "value" : 100, "con" : 5, "stam" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "magic_robe", \
    "title" :  "Magician\'s Robe", \
    "desc" :  "A soft shiny robe worn by practictioners of the arcane arts", \
    "adesc" :""
},
{"name": "legend_robes_wizard",                            "layer": "cloth", "min": 1, "max": 12, "value" : 50, "con" : 5, "stam" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "wizard_robe", \
    "title" :  "Beautiful Robe", \
    "desc" :  "A soft shiny robe worn by practictioners of the arts", \
    "adesc" :""
},
{"name": "anatomist_robe",                            "layer": "cloth", "min": 1, "max": 1, "value" : 350, "con" : 70, "stam" : -7, "impactSound" : "leather", "invSound" : "cloth", "brush" : "anatomist_robe", \
    "title" :  "Anatomist\'s Robe", \
    "desc" :  "A dark robe and gloves worn by those who tinker with flesh and filth", \
    "adesc" :"A dark robe"
},
{"name": "wanderers_coat",                            "layer": "cloth", "min": 1, "max": 1, "value" : 120, "con" : 45, "stam" : -4, "impactSound" : "leather", "invSound" : "cloth", "brush" : "wanderers_coat", \
    "title" :  "Wanderer\'s Coat", \
    "desc" :  "A coat well suited to wandering the lands", \
    "adesc" :""
},
{"name": "legend_robes_nun",                              "layer": "cloth", "min": 1, "max": 2, "value" : 25, "con" : 22, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth", "brush" : "legend_robes", "variants" : [6,7], \
    "title" :  "Nun\'s Robe", \
    "desc" :  "A rugged, large robe made of simple cloth usually worn by young nuns.", \
    "adesc" :""
},
{"name": "legend_sackcloth_tattered",                     "layer": "cloth", "min": 12, "max": 18, "value" : 5, "con" : 5, "stam" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush": "legend_sackcloth", "variants" : [2,13,14,15,16,17,18], \
    "title" :  "Tattered Sackcloth", \
    "desc" :  "Barely better than running naked.", \
    "adesc" :""
},
{"name": "legend_sackcloth",                              "layer": "cloth", "min": 3, "max": 12, "value" : 15, "con" : 10, "stam" : 0, "impactSound" : "leather", "invSound" : "cloth", "variants" : [1,4,5,6,7,8,9,10,11,12], \
    "title" :  "Sackcloth", \
    "desc" :  "Better than running naked.", \
    "adesc" :""
},
{"name": "legend_bandages",                              "layer": "cloth", "min": 1, "max": 2, "value" : 1, "con" : 5, "stam" : 0, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Bandages", \
    "desc" :  "More for dressing wounds than protection", \
    "adesc" :""
},
{"name": "legend_sackcloth_patched",                      "layer": "cloth", "min": 1, "max": 8, "value" : 25, "con" : 15, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth", "brush": "legend_sackcloth", "variants" : [3,19,20,21,22,23,24,25], \
    "title" :  "Leather Wraps", \
    "desc" :  "Various patches of rough leather sewn together.", \
    "adesc" :""
},
{"name": "legend_thick_tunic",                            "layer": "cloth", "min": 1, "max": 24, "value" : 40, "con" : 30, "stam" : -3, "impactSound" : "leather", "invSound" : "cloth", "brush" : "thick_tunic", \
    "title" :  "Thick Tunic", \
    "desc" :  "A heavy cloth tunic, bulky but offering some protection.", \
    "adesc" :""
},
{"name": "legend_tunic",                                  "layer": "cloth", "min": 1, "max": 12, "value" : 25, "con" : 20, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Linen Tunic", \
    "desc" :  "A simple cloth tunic. Fashionable but offering little in protection.", \
    "adesc" :""
},
{"name": "legend_tunic_wrap",                                  "layer": "cloth", "min": 1, "max": 11, "value" : 25, "con" : 20, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Linen Tunic Wrap", \
    "desc" :  "A simple cloth tunic. Fashionable but offering little in protection.", \
    "adesc" :""
},
{"name": "legend_tunic_collar_thin",                                  "layer": "cloth", "min": 1, "max": 5, "value" : 25, "con" : 20, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Thin Collar Linen Tunic", \
    "desc" :  "A simple cloth tunic. Fashionable but offering little in protection.", \
    "adesc" :""
},
{"name": "legend_tunic_collar_deep",                                  "layer": "cloth", "min": 1, "max": 1, "value" : 25, "con" : 20, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Deep Collar Linen Tunic", \
    "desc" :  "A simple cloth tunic. Fashionable but offering little in protection.", \
    "adesc" :""
},
{"name": "legend_dark_tunic",                             "layer": "cloth", "min": 1, "max": 2, "value" : 50, "con" : 35, "stam" : -4, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Dark Tunic", \
    "desc" :  "A heavy cloth tunic. bulky but offering some protection.", \
    "adesc" :""
},
{"name": "legend_tunic_noble",                            "layer": "cloth", "min": 1, "max": 10, "value" : 500, "con" : 10, "stam" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "legend_tunic_collar_wide", \
    "title" :  "Noble Tunic", \
    "desc" :  "A fine linen tunic of exquisite material, embroided with pleasing patterns. Fashionable but offering little in protection.", \
    "adesc" :""
},
{"name": "legend_tunic_noble_named",                      "layer": "cloth", "min": 1, "max": 1, "value" : 1500, "con" : 40, "stam" : -2, "impactSound" : "leather", "invSound" : "cloth", "brush" : "legend_tunic_collar_gold", \
    "title" :  "Noble Tunic", \
    "desc" :  "A fine linen tunic of exquisite material, embroided with pleasing patterns. Fashionable but offering little in protection.", \
    "adesc" :"",
    "named" : True, "rminStam" : 0, "rmaxStam": 2, "rminCond" : 46, "rmaxCond" : 56,  "names" : Names + ['Heraldic Tunic', "Splendor", "Grandiosity", "Pageantry", "Swank", "Duty", "Honor", "Noble"]
},

{"name": "legend_southern_robe",                 "layer": "cloth", "min": 1, "max": 6, "value" : 35, "con" : 25, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth", "brush" : "southern_robe", \
    "title" : "Southern Wool Robe", \
    "desc" :  "A dense wool wrap to protect against blunt hits.", \
    "adesc" : ""
},
{"name": "legend_knightly_robe",                 "layer": "cloth", "min": 1, "max": 8, "value" : 200, "con" : 60, "stam" : -2, "impactSound" : "leather", "invSound" : "cloth", "brush" : "legend_knightly_robe", \
    "title" : "Knight\'s Robe", \
    "desc" :  "A padded robe designed to go under armor and absorb blows", \
    "adesc" : ""
},
{"name": "legend_southern_gambeson",           "layer": "cloth", "min": 1, "max": 7, "value" : 250, "con" : 65, "stam" : -8, "impactSound" : "leather", "invSound" : "cloth", "brush" : "southern_gambeson", \
    "title" :  "Southern Gambeson", \
    "desc" :  "A sturdy and heavy padded tunic of southern origin that offers decent protection.", \
    "adesc" : ""
},
{"name": "legend_southern_split_gambeson",           "layer": "cloth", "min": 1, "max": 1, "value" : 250, "con" : 65, "stam" : -8, "impactSound" : "leather", "invSound" : "cloth", "brush" : "southern_split_gambeson", \
    "title" :  "Southern Split Gambeson", \
    "desc" :  "A sturdy and heavy padded tunic of southern origin that offers decent protection.", \
    "adesc" : ""
},
{"name": "legend_southern_tunic",           "layer": "cloth", "min": 1, "max": 6, "value" : 50, "con" : 25, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth", "brush" : "southern_checked", \
    "title" :  "Southern Tunic", \
    "desc" :  "A light and well made checkered tunic southern origin.", \
    "adesc" : ""
},
{"name": "legend_southern_noble_surcoat",           "layer": "cloth", "min": 1, "max": 9, "value" : 350, "con" : 55, "stam" : -6, "impactSound" : "leather", "invSound" : "cloth", "brush" : "southern_noble_cloth", \
    "title" :  "Southern Noble Surcoat", \
    "desc" :  "A studded and heavy padded coat that offers decent protection.", \
    "adesc" : ""
},

# {"name": "legend_southern_cloth_sash",           "layer": "cloth", "min": 0, "max": 0, "value" : 30, "con" : 20, "stam" : 0, "impactSound" : "leather", "invSound" : "cloth", "vanilla" : "body_southern", "variants" : [12,18,19], \
#     "title" :  "Cloth Sash", \
#     "desc" :  "A double sash made from thick cloth that is worn across the body.", \
#     "adesc" : ""
# },
# {"name": "legend_southern_robe_nomad",           "layer": "cloth", "min": 0, "max": 0, "value" : 50, "con" : 35, "stam" : -2, "impactSound" : "leather", "invSound" : "cloth", "vanilla" : "body_southern", "variants" : [16], \
#     "title" :  "Nomad Robe", \
#     "desc" :  "A nomad cloth robe worn to protect against both the heat and against cuts and bruises.", \
#     "adesc" : ""
# },
# {"name": "legend_southern_robe_nomad_thick",     "layer": "cloth", "min": 0, "max": 0, "value" : 80, "con" : 50, "stam" : -5, "impactSound" : "leather", "invSound" : "cloth", "vanilla" : "body_southern", "variants" : [17], \
#     "title" :  "Thick Nomad Robe", \
#     "desc" :  "A double layered robe fashioned from thick cloth.", \
#     "adesc" : ""
# }



{"name": "legend_armor_ancient_double_mail",              "layer": "chain", "min": 1, "max": 5, "value" : 750, "con" : 80, "stam" : -14, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Ancient Double Layer Mail", \
    "desc" :  "Includes A heavy and rotten double-layered mail of ancient design.", \
    "adesc" :""
},
{"name": "legend_armor_ancient_mail",                     "layer": "chain", "min": 1, "max": 1, "value" : 300, "con" : 35, "stam" : -6, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Ancient Mail", \
    "desc" :  "Includes an old and crusted heavy mail of ancient design.", \
    "adesc" :""
},
{"name": "legend_armor_basic_mail",                       "layer": "chain", "min": 1, "max": 1, "value" : 800, "con" : 85, "stam" : -12, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Basic Mail", \
    "desc" :  "A long and heavy chainmail that offers good protection but is very fatiguing to wear.", \
    "adesc" : "Includes a long and heavy chainmail that offers good protection but is very fatiguing to wear."
},
{"name": "legend_armor_hauberk",                          "layer": "chain", "min": 1, "max": 1, "value" : 1750, "con" : 95, "stam" : -11, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Hauberk", \
    "desc" :  "A long and heavy chainmail that offers good protection but is very fatiguing to wear.", \
    "adesc" : "Includes a long and heavy chainmail that offers good protection but is very fatiguing to wear."
},
{"name": "legend_armor_hauberk_full",                     "layer": "chain", "min": 1, "max": 1, "value" : 2500, "con" : 115, "stam" : -14, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Full Hauberk", \
    "desc" :  "A long and heavy chainmail that offers good protection but is very fatiguing to wear.", \
    "adesc" : "Includes a long and heavy chainmail that offers good protection but is very fatiguing to wear."
},
{"name": "legend_armor_hauberk_full_named",               "layer": "chain", "min": 1, "max": 1, "value" : 5000, "con" : 120, "stam" : -15, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "", \
    "desc" :  "Truly fit for a knight, this mail hauberk is made from the highest quality materials and boasts precious decorations and ornaments.", \
    "adesc" : "Includes a mail hauberk made from the highest quality materials and boasts precious decorations and ornaments.", \
    "named" : True, "rminStam" : 9, "rmaxStam": 13, "rminCond" : 125, "rmaxCond" : 150,  "names" : Names + ['Heraldic Mail', "Splendor", "Grandiosity", "Pageantry", "Swank", "Full Mail", "Mail Hauberk", "Chainmail", "Surcoat", "Duty", "Honor", "Noble Mail"]
},
{"name": "legend_armor_hauberk_sleevless",                "layer": "chain", "min": 1, "max": 1, "value" : 1250, "con" : 65, "stam" : -7, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Sleeveless Hauberk", \
    "desc" :  "A long and heavy chainmail that offers good protection but is very fatiguing to wear.", \
    "adesc" : "Includes a long and heavy chainmail that offers good protection but is very fatiguing to wear."
},
{"name": "legend_armor_mail_shirt",                       "layer": "chain", "min": 1, "max": 1, "value" : 375, "con" : 50, "stam" : -6, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Basic Mail Shirt", \
    "desc" :  "A basic mail shirt. Offers decent and affordable protection against slashing and piercing attacks.", \
    "adesc" : "Includes a basic mail shirt that offers good protection against slashing and piercing attacks."
},
{"name": "wild_scale",                              "layer": "chain", "min": 1, "max": 1, "value" : 2000, "con" : 60, "stam" : -6, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Wild Scale", \
    "desc" :  "A well crafted scale mail shirt", \
    "adesc" : "Includes a basic mail shirt that offers good protection against slashing and piercing attacks."
},
{"name": "legend_armor_mail_shirt_simple",                "layer": "chain", "min": 1, "max": 1, "value" : 250, "con" : 25, "stam" : -3, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Simple Mail Shirt", \
    "desc" :  "A simple mail shirt. Offers decent and affordable protection against slashing and piercing attacks.", \
    "adesc" : "Includes a simple mail shirt that offers good protection against slashing and piercing attacks."
},
{"name": "legend_armor_reinforced_mail",                  "layer": "chain", "min": 1, "max": 1, "value" : 1750, "con" : 110, "stam" : -15, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Reinforced Mail", \
    "desc" :  "A long and heavy reinforced chainmail that offers good protection but is very fatiguing to wear.", \
    "adesc" : "Includes a long and heavy reinforced chainmail that offers good protection but is very fatiguing to wear."
},
{"name": "legend_armor_reinforced_mail_shirt",            "layer": "chain", "min": 1, "max": 1, "value" : 1000, "con" : 80, "stam" : -10, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Reinforced Mail Shirt", \
    "desc" :  "A reinforced mail shirt with shoulder guards providing excellent protection against most weapons.", \
    "adesc" : "Includes a reinforced mail shirt in excellent condition."
},
{"name": "legend_armor_reinforced_rotten_mail_shirt",     "layer": "chain", "min": 1, "max": 4, "value" : 200, "con" : 45, "stam" : -7, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Rotten Reinforced Mail Shirt", \
    "desc" :  "A reinforced mail shirt that is rotting at the seams.", \
    "adesc" : "Includes a reinforced mail shirt that has seen better days."
},
{"name": "legend_armor_reinforced_worn_mail",             "layer": "chain", "min": 1, "max": 1, "value" : 1250, "con" : 105, "stam" : -17, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Reinforced Worn Mail", \
    "desc" :  "A long and heavy reinforced chainmail that offers good protection but is very fatiguing to wear.", \
    "adesc" : "Includes a long and heavy reinforced chainmail that offers good protection but is very fatiguing to wear."
},
{"name": "legend_armor_reinforced_worn_mail_shirt",       "layer": "chain", "min": 1, "max": 4, "value" : 350, "con" : 65, "stam" : -11, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Worn Reinforced Mail Shirt", \
    "desc" :  "A reinforced mail shirt that lost some parts over the years.", \
    "adesc" : "Includes a reinforced mail shirt that has seen better days."
},
{"name": "legend_armor_rusty_mail_shirt",                 "layer": "chain", "min": 1, "max": 11, "value" : 125, "con" : 20, "stam" : -4, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Patched Mail Shirt", \
    "desc" :  "This light mail shirt has seen better times but still grants decent protection.", \
    "adesc" : "Includes a rusty and patched mail shirt that offers decent protection."
},
{"name": "legend_armor_short_mail",                       "layer": "chain", "min": 1, "max": 1, "value" : 500, "con" : 60, "stam" : -8, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Light Mail", \
    "desc" :  "A shorter and lighter chainmail that offers good protection and is fatiguing to wear.", \
    "adesc" : "Includes a shorter and lighter chainmail that offers good protection but is fatiguing to wear."
},


# {"name": "legend_southern_skirt",                       "layer": "chain", "min": 1, "max": 1, "value" : 500, "con" : 60, "stam" : -8, "impactSound" : "chain", "invSound" : "leather", "brush" : "southern_skirt", \
#     "title" :  "Shoulder Skirt", \
#     "desc" :  "", \
#     "adesc" : ""
# },
{"name": "legend_southern_cloth",                       "layer": "chain", "min": 1, "max": 1, "value" : 50, "con" : 30, "stam" : -2, "impactSound" : "lather", "invSound" : "cloth", "brush" : "southern_cloth", \
    "title" :  "Nomad Outer Robe", \
    "desc" :  "A nomad cloth robe worn as an outer protection against both the heat and against cuts and bruises.", \
    "adesc" : "Includes a cloth robe"
},
{"name": "legend_southern_padded_chest",                       "layer": "chain", "min": 1, "max": 1, "value" : 325, "con" : 45, "stam" : -4, "impactSound" : "leather", "invSound" : "cloth", "brush" : "southern_padded_chest", \
    "title" :  "Padded Vest", \
    "desc" :  "A thick cloth vest padded with dense wool to protect against blunt hits.", \
    "adesc" : "Includes a thick cloth vest."
},
{"name": "legend_southern_mail",                       "layer": "chain", "min": 1, "max": 1, "value" : 1400, "con" : 100, "stam" : -13, "impactSound" : "chain", "invSound" : "chain", "brush" : "southern_mail", \
    "title" :  "Southern Mail", \
    "desc" :  "A long and heavy mail shirt of southern design made with slightly thinner and lighter metal rings than those used in the north", \
    "adesc" : "Includes a long southern mail shirt."
},
{"name": "legend_armor_leather_brigandine",               "layer": "plate", "min": 1, "max": 1, "value" : 750, "con" : 65, "stam" : -8, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Leather Brigandine Armor", \
    "desc" :  "A thick leather brigandine studded with steel rivets for added protection.", \
    "adesc" : "Includes leather brigandine armor."
},
{"name": "legend_armor_leather_brigandine_hardened",      "layer": "plate", "min": 1, "max": 1, "value" : 1250, "con" : 110, "stam" : -15, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Hardened Leather Brigandine Armor", \
    "desc" :  "A boiled and hardened leather brigandine studded with steel rivets for added protection.", \
    "adesc" : "Includes leather brigandine armor."
},
{"name": "legend_armor_leather_brigandine_hardened_full", "layer": "plate", "min": 1, "max": 1, "value" : 3000, "con" : 140, "stam" : -19, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Reinforced Hardened Leather Brigandine Armor", \
    "desc" :  "A boiled and hardened brigandine studded with steel rivets and reinforced with steel padded shoulders for added protection.", \
    "adesc" : "Includes hardened brigandine armor."
},
{"name": "legend_armor_leather_brigandine_named",         "layer": "plate", "min": 1, "max": 10, "value" : 2500, "con" : 75, "stam" : -6, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "", \
    "desc" :  "A rare thick leather brigandine studded with steel rivets for added protection. A piece of true craftsmanship!", \
    "adesc" : "Includes rare leather brigandine armor.", \
    "named" : True, "rminStam" : 5, "rmaxStam": 7, "rminCond" : 80, "rmaxCond" : 100,  "names" : Names + ["Harness", "Ward", "Defense", "Barrier", "Studded Vest", "Lifesaver", "Skin", "Peel", "Guard", "Tarnished Harness", "Duty", "Honor"]
},
{"name": "legend_armor_leather_jacket",                   "layer": "plate", "min": 1, "max": 9, "value" : 75, "con" : 25, "stam" : -3, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Leather Jacket", \
    "desc" :  "A leather jacket for minimal protection.", \
    "adesc" : "Includes a leather jacket for added protection."
},
{"name": "legend_armor_leather_jacket_named",             "layer": "plate", "min": 1, "max": 1, "value" : 750, "con" : 30, "stam" : -3, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "", \
    "desc" :  "A well-crafted and hardened leather armor. Light to wear but very sturdy.", \
    "adesc" : "Includes a well-crafted and hardened leather armor. Light to wear but very sturdy.", \
    "named" : True, "rminStam" : 1, "rmaxStam": 2, "rminCond" : 35, "rmaxCond" : 45,  "names" : Names + ["Leather Cuirass", "Leather Armor", "Skin", "Peel", "Guard", "Coat", "Nightcloak", "Black", "Dark Omen", "Toadskin", "Ogreskin"]
},
{"name": "legend_armor_leather_studded_jacket_named",             "layer": "plate", "min": 1, "max": 13, "value" : 750, "con" : 30, "stam" : -3, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "", \
    "desc" :  "A well-crafted leather coated jacket. Light to wear but very sturdy.", \
    "adesc" : "Includes a well-crafted leather jacket. Light to wear but very sturdy.", \
    "named" : True, "rminStam" : 1, "rmaxStam": 2, "rminCond" : 35, "rmaxCond" : 45,  "names" : Names + ["Leather Cuirass", "Leather Armor", "Skin", "Peel", "Guard", "Coat", "Nightcloak", "Black", "Dark Omen", "Toadskin", "Ogreskin"]
},
{"name": "undertakers_apron",                                  "layer": "plate", "min": 1, "max": 1, "value" : 60, "con" : 35, "stam" : -4, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Undertakers Apron", \
    "desc" :  "A leather apron usually worn by an undertaker", \
    "adesc" :""
},
{"name": "legend_armor_leather_jacket_simple",            "layer": "plate", "min": 1, "max": 6, "value" : 30, "con" : 15, "stam" : -2, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Simple Leather Jacket", \
    "desc" :  "A simple leather jacket for minimal protection.", \
    "adesc" : "Includes a simple leather jacket for added protection."
},
{"name": "legend_armor_leather_lamellar",                 "layer": "plate", "min": 1, "max": 1, "value" : 250, "con" : 50, "stam" : -6, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Leather Lamellar Armor", \
    "desc" :  "Numerous overlapping leather plates provide decent protection for most of the upper body.", \
    "adesc" : "Includes armor of overlapping leather plates."
},
{"name": "legend_armor_cult_armor",               "itemType" : "this.Const.Items.ItemType.Cultist", "layer": "plate", "min": 1, "max": 1, "value" : 250, "con" : 55, "stam" : -7, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Cultist Leather Armor", \
    "desc" :  "Numerous overlapping leather plates provide decent protection for most of the upper body.", \
    "adesc" : "Includes an occult armor of overlapping leather plates."
},
{"name": "legend_armor_leather_lamellar_harness_heavy",   "layer": "plate", "min": 1, "max": 1, "value" : 1750, "con" : 130, "stam" : -20, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Lamellar Harness", \
    "desc" :  "A body armor made of thick overlapping metal plates that cover most of the upper body.", \
    "adesc" : "Includes body armor made of thick overlapping metal plates that cover most of the upper body."
},
{"name": "legend_armor_leather_lamellar_harness_reinforced", "layer": "plate", "min": 1, "max": 1, "value" : 350, "con" : 55, "stam" : -7, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Reinforced Lamellar Harness", \
    "desc" :  "A body armor made of thick overlapping metal plates that cover most of the upper body.", \
    "adesc" : "Includes body armor made of thick overlapping metal plates that cover most of the upper body."
},
{"name": "legend_armor_leather_lamellar_heavy",           "layer": "plate", "min": 1, "max": 1, "value" : 4750, "con" : 165, "stam" : -24, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Heavy Lamellar Armor", \
    "desc" :  "A heavy lamellar armor that covers most parts of the body with thick, overlapping metal plates for maximum protection.", \
    "adesc" : "Includes heavy lamellar armor that covers most parts of the body with thick, overlapping metal plates."
},
{"name": "legend_armor_leather_lamellar_heavy_named",     "layer": "plate", "min": 1, "max": 1, "value" : 7500, "con" : 140, "stam" : -23, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "", \
    "desc" :  "An extraordinarily well-crafted piece of lamellar armor. It is covered with beaten gold, which makes it truly stand out.", \
    "adesc" : "Includes an extraordinarily well-crafted piece of lamellar armor. It is covered with beaten gold, which makes it truly stand out.", \
    "named" : True, "rminStam" : 19, "rmaxStam": 23, "rminCond" : 175, "rmaxCond" : 195,  "names" : Names + ["Harness", "Ward", "Defense", "Splendor", "Golden Lamellar"]
},
{"name": "legend_armor_leather_lamellar_reinforced",      "layer": "plate", "min": 1, "max": 1, "value" : 2500, "con" : 150, "stam" : -23, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Reinforced Leather Lamellar Armor", \
    "desc" :  "Numerous overlapping metal reinforced leather plates that provides excellent protection for most of the upper body but is very heavy.", \
    "adesc" : "Includes armor of overlapping reinforced metal leather plates."
},
{"name": "legend_armor_leather_noble",                    "layer": "plate", "min": 1, "max": 6, "value" : 1500, "con" : 65, "stam" : -6, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Noble Leather Armor", \
    "desc" :  "A truly masterfully crafted set of leather armor. Very light and flexible to reduce encumberance while still offering good protection.", \
    "adesc" : "Includes masterfully crafted leather armor."
},
{"name": "legend_armor_leather_padded",                   "layer": "plate", "min": 1, "max": 1, "value" : 175, "con" : 40, "stam" : -5, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Padded Leather Armor", \
    "desc" :  "Padded leather reinforced with fittings for added protection.", \
    "adesc" : "Includes padded leather armor."
},
{"name": "legend_armor_leather_riveted",                  "layer": "plate", "min": 1, "max": 9, "value" : 900, "con" : 95, "stam" : -13, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Sellsword\'s Leather Armor", \
    "desc" :  "A long leather armor coat reinforced with metal plates.", \
    "adesc" : "Includes a long leather coat reinforced with metal plates that offers good protection but is very fatiguing to wear."
},
{"name": "legend_heavy_mail",                  "layer": "plate", "min": 1, "max": 14, "value" : 1300, "con" : 105, "stam" : -14, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Heavy Mail", \
    "desc" :  "A long armor coat reinforced with studded metal plates and covered in colorful cloth.", \
    "adesc" : "Includes a long leather coat reinforced with metal plates that offers good protection but is very fatiguing to wear."
},
{"name": "legend_armor_leather_riveted_light",            "layer": "plate", "min": 1, "max": 1, "value" : 700, "con" : 80, "stam" : -11, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Footman\'s Leather Armor", \
    "desc" :  "A light leather armor reinforced with metal rivets.", \
    "adesc" : "Includes a leather armor coat rivetted with metal plates."
},
{"name": "legend_armor_leather_scale",                    "layer": "plate", "min": 1, "max": 1, "value" : 600, "con" : 70, "stam" : -9, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Leather Scale Armor", \
    "desc" :  "A thick leather scale armor for added protection.", \
    "adesc" : "Includes scaled leather armor."
},

{"name": "legend_armor_plate_ancient_chest",              "layer": "plate", "min": 1, "max": 1, "value" : 750, "con" : 105, "stam" : -18, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Ancient Breastplate", \
    "desc" :  "A tarnished thick breastplate of ancient origin.", \
    "adesc" : "Includes a tarnished thick breastplate of ancient origin."
},
{"name": "legend_armor_plate_ancient_chest_restored",     "layer": "plate", "min": 1, "max": 1, "value" : 1500, "con" : 110, "stam" : -15, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Restored Ancient Breastplate", \
    "desc" :  "A restored thick breastplate of ancient origin.", \
    "adesc" : "Includes a restored thick breastplate of ancient origin."
},
{"name": "legend_armor_plate_ancient_gladiator",          "layer": "plate", "min": 1, "max": 1, "value" : 100, "con" : 35, "stam" : -6, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Restored Ancient Breastplate", \
    "desc" :  "A tarnished gladiator outfit of ancient origin.", \
    "adesc" : "Includes a tarnished gladiator outfit of ancient origin."
},
{"name": "legend_armor_plate_ancient_harness",            "layer": "plate", "min": 1, "max": 1, "value" : 1500, "con" : 115, "stam" : -19, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Ancient Plate Harness", \
    "desc" :  "Made of thick metal plates and mail, this heavy ancient armor still offers great protection after countless years. It\'s crusted and rotten in parts, however, severely limiting the mobility of the wearer.", \
    "adesc" : "Includes an ancient plate harness of thick metal plates and mail."
},
{"name": "legend_armor_plate_ancient_mail",               "layer": "plate", "min": 1, "max": 1, "value" : 300, "con" : 45, "stam" : -7, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Ancient Plated Mail", \
    "desc" :  "An ancient mail armor with plated arm guards. Very heavy and severely limiting the mobility of the wearer.", \
    "adesc" : "Includes an ancient mail armor with plated arm guards."
},
{"name": "legend_armor_plate_ancient_scale",              "layer": "plate", "min": 1, "max": 1, "value" : 1000, "con" : 105, "stam" : -17, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Ancient Scale Coat", \
    "desc" :  "A heavy and tarnished scale coat of ancient design that belongs into a collection, not on the battlefield.", \
    "adesc" : "Includes an ancient heavy and tarnished scale coat."
},
{"name": "legend_armor_plate_ancient_scale_coat",         "layer": "plate", "min": 1, "max": 1, "value" : 2000, "con" : 140, "stam" : -24, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Ancient Plated Scale Coat", \
    "desc" :  "A heavy coat of scales, partly reinforced with a layer of plated metal on top. It\'s a massive armor of ancient origin that didn\'t age well.", \
    "adesc" : "Includes an ancient heavy and tarnished scale coat."
},
{"name": "legend_armor_plate_ancient_scale_harness",      "layer": "plate", "min": 1, "max": 1, "value" : 500, "con" : 75, "stam" : -12, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Ancient Scale Harness", \
    "desc" :  "A sturdy, but heavy and partly decayed ancient scale harness.", \
    "adesc" : "Includes a heavy and partly decayed ancient scale harness."
},
{"name": "legend_armor_plate_ancient_scale_coat_restored",         "layer": "plate", "min": 1, "max": 1, "value" : 3000, "con" : 170, "stam" : -23, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Embalmed Ancient Scale Coat", \
    "desc" :  "A scale coat of ancient design that is miraculously well preserved and functional.", \
    "adesc" : "Includes an ancient heavy scale coat."
},
{"name": "legend_armor_plate_ancient_scale_harness_restored",      "layer": "plate", "min": 1, "max": 1, "value" : 500, "con" : 130, "stam" : -15, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Embalmed Ancient Scale Harness", \
    "desc" :  "A sturdy, ancient scale harness that is remarkably well preserved and functional.", \
    "adesc" : "Includes an ancient scale harness."
},

{"name": "legend_armor_plate_chest",                      "layer": "plate", "min": 1, "max": 1, "value" : 2250, "con" : 125, "stam" : -17, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Breastplate Armor", \
    "desc" :  "A breastplate of solid plated steel.", \
    "adesc" : "Includes a breastplate of solid plated steel."
},
{"name": "legend_armor_plate_chest_rotten",               "layer": "plate", "min": 1, "max": 1, "value" : 1250, "con" : 100, "stam" : -16, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Decayed Breastplate Armor", \
    "desc" :  "A breastplate of solid plated steel that is worn and decayed.", \
    "adesc" : "Includes a breastplate of decaying plated steel."
},
{"name": "legend_armor_plate_cuirass",                    "layer": "plate", "min": 1, "max": 1, "value" : 3500, "con" : 150, "stam" : -21, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Plate Cuirass Armor", \
    "desc" :  "A body vest of solid plated steel.", \
    "adesc" : "Includes a body vest of solid plated steel."
},
{"name": "legend_armor_plate_milanese",               "layer": "plate", "min": 1, "max": 1, "value" : 5000, "con" : 170, "stam" : -26, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Full Harness of Plate Armor", \
    "desc" :  "A complete harness of steel plate armor.", \
    "adesc" : "Includes a full set of solid plated steel with greaves."
},
{"name": "legend_armor_plate_triangle",               "layer": "plate", "min": 1, "max": 1, "value" : 5000, "con" : 170, "stam" : -26, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Full Harness of Plate Armor", \
    "desc" :  "A complete harness of steel plate armor.", \
    "adesc" : "Includes a full set of solid plated steel with greaves."
},
{"name": "legend_armor_plate_krastenbrust",               "layer": "plate", "min": 1, "max": 1, "value" : 5000, "con" : 170, "stam" : -26, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Full Harness of Plate Armor", \
    "desc" :  "A complete harness of steel plate armor.", \
    "adesc" : "Includes a full set of solid plated steel with greaves."
},
{"name": "legend_armor_plate_full",                       "layer": "plate", "min": 1, "max": 1, "value" : 4500, "con" : 160, "stam" : -22, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Full Coat of Plate Armor", \
    "desc" :  "A full set of solid plated steel.", \
    "adesc" : "Includes a full set of solid plated steel."
},
{"name": "legend_armor_plate_full_greaves",               "layer": "plate", "min": 1, "max": 1, "value" : 5000, "con" : 170, "stam" : -26, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Full Coat of Heavy Plate Armor", \
    "desc" :  "A full set of solid plated steel with greaves.", \
    "adesc" : "Includes a full set of solid plated steel with greaves."
},
{"name": "legend_armor_plate_full_greaves_named",         "layer": "plate", "min": 1, "max": 3, "value" : 10000, "con" : 170, "stam" : -26, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Full Coat Heavy Plate Armor", \
    "desc" :  "A full set of painted solid plated steel with greaves.", \
    "adesc" : "A masterfully crafted full set of painted solid plated steel with greaves.", \
    "named" : True, "rminStam" : 23, "rmaxStam": 25, "rminCond" : 185, "rmaxCond" : 225,  "names" : Names + ["Glory", "Triumph", "Victory", "Joy"]
},
{"name": "legend_armor_plate_full_greaves_painted",       "layer": "plate", "min": 1, "max": 1, "value" : 10000, "con" : 170, "stam" : -26, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Full Coat of Painted Heavy Plate Armor", \
    "desc" :  "A full set of painted solid plated steel with greaves.", \
    "adesc" : "A masterfully crafted full set of painted solid plated steel with greaves.", \
    "named" : True, "rminStam" : 23, "rmaxStam": 25, "rminCond" : 185, "rmaxCond" : 225,  "names" : Names + ["Ward", "Death", "Barrier", "Plate Armor", "Dark Plated Armor", "Life Stealer"]
},
{"name": "legend_armor_scale",                            "layer": "plate", "min": 1, "max": 1, "value" : 2250, "con" : 100, "stam" : -12, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Scale Armor", \
    "desc" :  "A body vest with overlapping scales.", \
    "adesc" : "Includes body vest with overlapping scales."
},
{"name": "noble_padded",                            "layer": "plate", "min": 1, "max": 1, "value" : 280, "con" : 120, "stam" : -13, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Padded Noble Vest", \
    "desc" :  "An expensive padded vest with thick leather strapping", \
    "adesc" : "Includes body vest with overlapping scales."
},
{"name": "legend_armor_scale_coat",                       "layer": "plate", "min": 1, "max": 1, "value" : 2500, "con" : 120, "stam" : -15, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Coat of Scales", \
    "desc" :  "A heavy armor made of thick, overlapping metal scales covering most of the body.", \
    "adesc" : "Includes heavy armor made of thick, overlapping metal scales."
},
{"name": "legend_noble_scale",                    "layer": "plate", "min": 1, "max": 6, "value" : 2000, "con" : 80, "stam" : -10, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Noble Scale", \
    "desc" :  "A very well crafted scale mail armor", \
    "adesc" : "Includes scaled armor."
},
{"name": "legend_armor_scale_coat_named",                 "layer": "plate", "min": 1, "max": 1, "value" : 5000, "con" : 160, "stam" : -22, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "", \
    "desc" :  "A scale armor made of small, interlocking metal scales. The style and craftsmanship hint at the armor coming from a far-away region.", \
    "adesc" : "Includes a scale armor made of small, interlocking metal scales. The style and craftsmanship hint at the armor coming from a far-away region.", \
    "named" : True, "rminStam" : 10, "rmaxStam": 14, "rminCond" : 130, "rmaxCond" : 160,  "names" : Names + ["Scale Shirt", "Scale Armor", "Dragonskin", "Snakeskin", "Scales", "Wyrmskin", "Goldskin", "Scale Tunic", "Golden Armor", "Golden Reminder"]
},
{"name": "legend_armor_scale_coat_rotten",                "layer": "plate", "min": 1, "max": 1, "value" : 600, "con" : 60, "stam" : -9, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Decayed Coat of Scales", \
    "desc" :  "This coat of scales is worn and parts have come lose or are missing. It still offers very good protection if you don\'t mind the smell.", \
    "adesc" : "Includes worn and smelly heavy armor made of thick, overlapping metal scales."
},
{"name": "legend_armor_scale_shirt",                      "layer": "plate", "min": 1, "max": 1, "value" : 1750, "con" : 85, "stam" : -10, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Light Scale Armor", \
    "desc" :  "A sturdy yet flexible armor composed of small, overlapping metal scales.", \
    "adesc" : "Includes body vest with small overlapping metal scales."
},
{"name": "legend_animal_hide_armor",                     "itemType" : "this.Const.Items.ItemType.Cultist", "layer": "plate", "min": 90, "max": 90, "value" : 100, "con" : 30, "stam" : -4, "impactSound" : "leather", "invSound" : "leather", "vanilla" : "body",\
    "title" :  "Animal Hide Armor", \
    "desc" :  "Heavy hides patched together to create a decent makeshift armor.", \
    "adesc" : "Includes heavy hides patched together to create a decent makeshift armor."
},
{"name": "legend_heavy_iron_armor",                       "layer": "plate", "min": 95, "max": 95, "value" : 1000, "con" : 120, "stam" : -18, "impactSound" : "plate", "invSound" : "leather",  "vanilla" : "body", \
    "title" :  "Heavy Iron Armor", \
    "desc" :  "This armor is made from heavy metal plates, scales and pieces of chainmal. The true armor of a northern warrior.", \
    "adesc" : "Includes is made from heavy metal plates, scales and pieces of chainmal. The true armor of a northern warrior."
},
{"name": "legend_hide_and_bone_armor",                   "itemType" : "this.Const.Items.ItemType.Cultist", "layer": "plate", "min": 92, "max": 92, "value" : 350, "con" : 80, "stam" : -11, "impactSound" : "bone", "invSound" : "leather", "vanilla" : "body",\
    "title" :  "Hide and Bone Armor", \
    "desc" :  "Hide and bone are common materials in the northern regions. This armor is using both for decent protection.", \
    "adesc" : "Includes hide and bone armor that is decent protection."
},
{"name": "legend_reinforced_animal_hide_armor",           "itemType" : "this.Const.Items.ItemType.Cultist", "layer": "plate", "min": 97, "max": 97, "value" : 175, "con" : 55, "stam" : -9, "impactSound" : "leather", "invSound" : "leather", "vanilla" : "body",\
    "title" :  "Reinforced Animal Hide Armor", \
    "desc" :  "A reinforced animal hide armor fashioned from thick leather pieces with added mail and metal scales.", \
    "adesc" : "Includes A reinforced animal hide armor fashioned from thick leather pieces with added mail and metal scales."
},
{"name": "legend_rugged_scale_armor",                     "layer": "plate", "min": 93, "max": 93, "value" : 700, "con" : 95, "stam" : -15, "impactSound" : "plate", "invSound" : "leather", "vanilla" : "body",\
    "title" :  "Rugged Scale Armor", \
    "desc" :  "A heavy body armor made from thick iron scales.", \
    "adesc" : "Includes A heavy body armor made from thick iron scales."
},
{"name": "legend_scrap_metal_armor",                      "layer": "plate", "min": 94, "max": 94, "value" : 250, "con" : 65, "stam" : -10, "impactSound" : "chain", "invSound" : "leather", "vanilla" : "body",\
    "title" :  "Scrap Metal Armor", \
    "desc" :  "This armor is pieced together from scavenged metal parts that are fixed to a crude leather tunic.", \
    "adesc" : "Includes armor that is pieced together from scavenged metal parts that are fixed to a crude leather tunic."
},
{"name": "legend_thick_furs_armor",                       "layer": "plate", "min": 91, "max": 91, "value" : 15, "con" : 10, "stam" : -1, "impactSound" : "leather", "invSound" : "leather", "vanilla" : "body",\
    "title" :  "Thick Furs", \
    "desc" :  "Thick furs that are crudely dried and tied together to protect from both the cold and any incoming blows.", \
    "adesc" : "Includes Thick furs that are crudely dried and tied together to protect from both the cold and any incoming blows."
},
{"name": "legend_thick_plated_barbarian_armor",           "layer": "plate", "min": 96, "max": 96, "value" : 1500, "con" : 155, "stam" : -26, "impactSound" : "plate", "invSound" : "leather", "vanilla" : "body",\
    "title" :  "Thick Plated Barbarian Armor", \
    "desc" :  "A heavy armor that is made from mostly metal. Only one chosen by the ancestors will own a set like this.", \
    "adesc" : "Includes A heavy armor that is made from mostly metal. Only one chosen by the ancestors will own a set like this."
},

{"name": "legend_southern_named_golden_plates",           "layer": "plate", "min": 1, "max": 1, "value" : 5600, "con" : 200, "stam" : -36, "impactSound" : "plate", "invSound" : "leather", "brush" : "named_southern_gold_plates",\
    "title" :  "Composite Lamellar Plates", \
    "desc" :  "A heavy composite armor consisting of padding and lamellar elements", \
    "adesc" : "Includes composite lamellar elements",
},

{"name": "legend_southern_named_plates",                  "layer": "plate", "min": 1, "max": 1, "value" : 9000, "con" : 210, "stam" : -25, "impactSound" : "plate", "invSound" : "leather", "brush" : "southern_named_plate",\
    "title" :  "Famed Southern plates", \
    "desc" :  "Ancient knowledge has been used when smithing this unique set of armor. Its light mail overlapped with golden splints offers high protection with manageable encumberment.", \
    "adesc" : "overlapped with golden splints offering high protection with manageable encumberment.",
    "named" : True, "rminStam" : 23, "rmaxStam": 26, "rminCond" : 210, "rmaxCond" : 230,  "names" : Names + ["Gilder\'s Shining Ward", "Gilder\'s Skin", "Suncloak", "Snakeskin", "Blazing Mail", "Suntouched Harness", "Shining Hauberk", "Armor of the Scorpion King"]
},
{"name": "named_emperors_armor",                  "layer": "plate", "min": 1, "max": 1, "value" : 9000, "con" : 210, "stam" : -25, "impactSound" : "plate", "invSound" : "leather", "brush" : "southern_named_plate",\
    "title" :  "fake emperors armor", \
    "desc" :  "", \
    "adesc" : "",
    "named" : True, "rminStam" : 23, "rmaxStam": 26, "rminCond" : 210, "rmaxCond" : 230,  "names" : Names + ["Aspect of Davkul"]
},
{"name": "davkul",                  "layer": "plate", "min": 1, "max": 1, "value" : 9000, "con" : 210, "stam" : -25, "impactSound" : "plate", "invSound" : "leather", "brush" : "southern_named_plate",\
    "title" :  "fake Aspect of Davkul", \
    "desc" :  "", \
    "adesc" : "",
},
{"name": "legend_southern_plate_full",                 "layer": "plate", "min": 1, "max": 2, "value" : 750, "con" : 75, "stam" : -12, "impactSound" : "plate", "invSound" : "leather", "brush" : "southern_plate_full",\
    "title" :  "Mail with Lamellar Plating", \
    "desc" :  "A lamellar shirt made from interlapping metal plates worn atop a mail shirt.", \
    "adesc" : "interlapped with metal plates."
},
{"name": "legend_southern_plate",                    "layer": "plate", "min": 1, "max": 2, "value" : 1500, "con" : 155, "stam" : -26, "impactSound" : "plate", "invSound" : "leather", "brush" : "southern_plate",\
    "title" :  "Southern Long Mail Shirt with Padding", \
    "desc" :  "A long and heavy chest of metal plates", \
    "adesc" : "overlapped with metal plates."
},
{"name": "legend_southern_padded",                     "layer": "plate", "min": 1, "max": 12, "value" : 400, "con" : 65, "stam" : -7, "impactSound" : "plate", "invSound" : "leather", "brush" : "southern_padded",\
    "title" :  "Southern padded shirt", \
    "desc" :  "A padded shirt fashioned from slightly thinner and lighter leather than that used in the north", \
    "adesc" : "Covered in a padded shirt"
},
{"name": "legend_southern_arm_guards",                "layer": "plate", "min": 1, "max": 1, "value" : 300, "con" : 30, "stam" : -2, "impactSound" : "plate", "invSound" : "leather", "brush" : "southern_arm_gaurds",\
    "title" :  "Southern arm guards", \
    "desc" :  "Leather arm guards worn by southern assassins", \
    "adesc" : "has leathered arm guards"
},
{"name": "legend_southern_strips",                   "layer": "plate", "min": 1, "max": 4, "value" : 275, "con" : 40, "stam" : -4, "impactSound" : "plate", "invSound" : "leather", "brush" : "southern_strips",\
    "title" :  "Linothorax", \
    "desc" :  "A breastplate made of several layers of linen.", \
    "adesc" : "Has a breastplate made of several layers of linen."
},
{"name": "legend_southern_leather_jacket",           "layer": "plate", "min": 1, "max": 6, "value" : 110, "con" : 30, "stam" : -3, "impactSound" : "leather", "invSound" : "leather", "brush" : "southern_leather_jacket",\
    "title" :  "Nomad Leather Jacket", \
    "desc" :  "A jacket of patched leather of southern origin", \
    "adesc" : "Has a jacket of southern leather"
},
{"name": "legend_southern_leather_plates",           "layer": "plate", "min": 1, "max": 10, "value" : 200, "con" : 50, "stam" : -5, "impactSound" : "plate", "invSound" : "leather", "brush" : "southern_leather_plates",\
    "title" :  "Stitched Nomad Armor", \
    "desc" :  "A leather nomad armor stitched together from various hides and scraps", \
    "adesc" : "Plates of leather hide and scraps"
},
{"name": "legend_southern_leather_scale",           "layer": "plate", "min": 1, "max": 4, "value" : 300, "con" : 70, "stam" : -10, "impactSound" : "plate", "invSound" : "leather", "brush" : "southern_leather_scale",\
    "title" :  "Rusted Nomad Mail", \
    "desc" :  "A slightly worn-down, thin and light mail with additional metal plates grafted onto it.", \
    "adesc" : ""
},
{"name": "legend_southern_scale",                  "layer": "plate", "min": 1, "max": 1, "value" : 1500, "con" : 155, "stam" : -26, "impactSound" : "chain", "invSound" : "chain", "brush" : "southern_scale",\
    "title" :  "Heavy Southern Lamellar", \
    "desc" :  "A heavy lamellar plated harness", \
    "adesc" : "Has heavy lamellar plated harness"
},



{"name": "legend_shoulder_cloth",           "layer": "cloak", "min": 1, "max": 11, "value" : 50, "con" : 5, "stam" : 0, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "shoulder_cloth",\
    "title" :  "Shoulder Cloth", \
    "desc" :  "A Piece of cloth drapped over the shoulder", \
    "adesc" : "Includes a shoulder cloth"
},
{"name": "legend_noble_shawl",           "layer": "cloak", "min": 1, "max": 1, "value" : 250, "con" : 10, "stam" : 0, "bravery" : 1, "impactSound" : "leather", "invSound" : "cloth", "brush" : "noble_shawl",\
    "title" :  "Noble Shawl", \
    "desc" :  "A shawl made of exquisite material that wraps around the shoulders", \
    "adesc" : "Includes a fine noble shawl"
},
{"name": "legend_dark_wooly_cloak",           "layer": "cloak", "min": 1, "max": 1, "value" : 120, "con" : 15, "stam" : -2, "bravery" : 1, "impactSound" : "leather", "invSound" : "cloth", "brush" : "dark_wooly_cloak",\
    "title" :  "Dark Wooly Cloak", \
    "desc" :  "A cloak of dark wool that wraps around the shoulders.", \
    "adesc" : "Includes a dark wooly cloak"
},
{"name": "fur_cloak",           "layer": "cloak", "min": 1, "max": 4, "value" : 120, "con" : 35, "stam" : -6, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "fur_cloak",\
    "title" :  "Fur Cloak", \
    "desc" :  "A cloak made of rough chain and the fur of a beast", \
    "adesc" : "Includes a fur cloak"
},
{"name": "legend_armor_cloak_common",           "layer": "cloak", "min": 0, "max": 0, "value" : 100, "con" : 10, "stam" : -1, "bravery" : 1, "impactSound" : "leather", "invSound" : "cloth", "brush" : "cloak", "variants" : [8,9,10,11,12,13,14,21,22,23,32,33,34], \
    "title" :  "Simple Cloak", \
    "desc" :  "A rustic cloak made of strong warm wool, provides some small protection, from the weather if nothing else.", \
    "adesc" : "Has a stout wool cloak"
},
{"name": "decorative_hood",           "layer": "cloak", "min": 1, "max": 11, "value" : 50, "con" : 15, "stam" : -1, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "decorative_hood",  \
    "title" :  "Decorative Cowl", \
    "desc" :  "A hooded cowl with decorated edges, quite dashing", \
    "adesc" : "Has a dashing cowl"
},
{"name": "nun_wimple",           "layer": "cloak", "min": 1, "max": 1, "value" : 50, "con" : 15, "stam" : -1, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "nun_wimple",  \
    "title" :  "Nun Wimple", \
    "desc" :  "A basic wimple of a nun", \
    "adesc" : "Has a wimple"
},
{"name": "tabbed_hood",           "layer": "cloak", "min": 1, "max": 1, "value" : 40, "con" : 10, "stam" : -1, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "tabbed_hood",  \
    "title" :  "Tabbed Cowl", \
    "desc" :  "A hooded cowl with tabbed edges", \
    "adesc" : "Has a dour cowl"
},
{"name": "anatomist_hood",           "layer": "cloak", "min": 1, "max": 1, "value" : 150, "con" : 30, "stam" : -2, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "anatomist_hood",\
    "title" :  "Anatomist Hood", \
    "desc" :  "A dark hood for those who work with filth", \
    "adesc" : "Has a dark hood for working with entrails"
},
{"name": "relic_hood",           "layer": "cloak", "min": 1, "max": 10, "value" : 800, "con" : 35, "stam" : -4, "bravery" : 2, "impactSound" : "leather", "invSound" : "cloth", "brush" : "relic_hood",\
    "title" :  "Relic Hood", \
    "desc" :  "A hood and belts adorned with a holy relic", \
    "adesc" : "Has a hood and belts adorned with a holy relic"
},
{"name": "legend_armor_cloak_heavy",           "layer": "cloak", "min": 0, "max": 0, "value" : 500, "con" : 30, "stam" : -4, "bravery" : 2, "impactSound" : "leather", "invSound" : "cloth", "brush" : "cloak", "variants" : [3,8,15,16,17,18,19,20,24,26,27,28,29,30,31,35], \
    "title" :  "Heavy Cloak", \
    "desc" :  "A rustic cloak made of thick layered strong warm wool, provides protection from some blows but is quite hefty. ", \
    "adesc" : "Has a heavy thick cloak"
},
{"name": "cursed_cloak",           "layer": "cloak", "min": 1, "max": 1, "value" : 500, "con" : 20, "stam" : -1, "bravery" : -1, "impactSound" : "leather", "invSound" : "cloth", "brush" : "cursed_cloak", \
    "title" :  "Cursed Cloak", \
    "desc" :  "A cloak made of the feathers of a strange creature of the abyss. ", \
    "adesc" : "Has a cloak made of the feathers of a strange creature of the abyss."
},
{"name": "legend_armor_cloak_crusader",           "layer": "cloak", "min": 36, "max": 36, "value" : 500, "con" : 35, "stam" : -5, "bravery" : 4, "impactSound" : "leather", "invSound" : "cloth", "brush" : "cloak",\
    "title" :  "Crusader Cloak", \
    "desc" :  "A holy cloak made of thick layered strong warm wool, provides protection from some blows but is quite hefty.", \
    "adesc" : "Has a holy cloak"
},
{"name": "legend_armor_cloak_noble",           "layer": "cloak", "min": 0, "max": 0, "value" : 3000, "con" : 25, "stam" : -2, "bravery" : 3, "impactSound" : "leather", "invSound" : "cloth", "brush" : "cloak", "variants" : [1,2,4,5,6,7,25], \
    "title" :  "Noble Cloak", \
    "desc" :  "A fine cloak made of light foreign silk, provides protection and looks great. ", \
    "adesc" : "Has a flowing light cloak"
},
{"name": "dukes_cloak",           "layer": "cloak", "min": 1, "max": 4, "value" : 2000, "con" : 20, "stam" : -2, "bravery" : 4, "impactSound" : "leather", "invSound" : "cloth", "brush" : "dukes_cloak",\
    "title" :  "Dukes Cloak", \
    "desc" :  "A refined cloak for the distinguished cloak appreciator", \
    "adesc" : "Has a flowing light cloak"
},
{"name": "legend_sash",           "layer": "cloak", "min": 1, "max": 1, "value" : 150, "con" : 3, "stam" : 0, "bravery" : 1, "impactSound" : "leather", "invSound" : "cloth", "brush" : "sash",\
    "title" :  "Sash", \
    "desc" :  "Has a flowing cloth sash.", \
    "adesc" : "Has a flowing cloth sash."
},
{"name": "legend_southern_scarf",           "layer": "cloak", "min": 1, "max": 17, "value" : 100, "con" : 5, "stam" : 0, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "southern_scarf",\
    "title" :  "Southern Scarf", \
    "desc" :  "A scarf that wraps around the shoulders.", \
    "adesc" : "Includes a dark wooly cloak"
},
{"name": "legend_religious_scarf",           "layer": "cloak", "min": 1, "max": 4, "value" : 60, "con" : 10, "stam" : 0, "bravery" : 1, "impactSound" : "leather", "invSound" : "cloth", "brush" : "legend_religious_scarf",\
    "title" :  "Religious Scarf", \
    "desc" :  "An adorned scarf of dark wool that wraps around the shoulders.", \
    "adesc" : "Includes a dark wooly cloak"
},
{"name": "legend_animal_pelt",           "layer": "cloak", "min": 1, "max": 8, "value" : 250, "con" : 15, "stam" : -2, "bravery" : 2, "impactSound" : "leather", "invSound" : "cloth", "brush" : "animal_pelt",\
    "title" :  "Animal Pelt", \
    "desc" :  "A cloak of dark wool that wraps around the shoulders.", \
    "adesc" : "Includes a dark wooly cloak"
},
{"name": "legend_southern_scarf_wrap",           "layer": "cloak", "min": 1, "max": 17, "value" : 150, "con" : 15, "stam" : -1, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "southern_scarf_wrap",\
    "title" :  "Southern Scarf Wrap", \
    "desc" :  "A cloak of dark wool that wraps around the shoulders.", \
    "adesc" : "Includes a dark wooly cloak"
},
{"name": "relic_hood",           "layer": "cloak", "min": 1, "max": 10, "value" : 500, "con" : 25, "stam" : -2, "bravery" : 2, "impactSound" : "leather", "invSound" : "cloth", "brush" : "relic_hood",\
    "title" :  "Relic Hood and belts", \
    "desc" :  "Straps, bags, hood and relic of a knightly order. Offers physical and spiritual protection.", \
    "adesc" : "Straps, bags, hood and relic of a knightly order. Offers physical and spiritual protection."
},
{"name": "legend_common_tabard",           "layer": "tabard", "min": 101, "max": 113, "value" : 200, "con" : 5, "stam" : 0, "bravery" : 2, "impactSound" : "leather", "invSound" : "cloth", "brush" : "legend_tabard",\
    "title" :  "Tabard", \
    "desc" :  "A flowing cloth covering for armor, to show your allegiance. Offers minimal protection and small boost to morale.", \
    "adesc" : "Has a flowing cloth tabard"
},
{"name": "legend_noble_tabard",           "layer": "tabard", "min": 1, "max": 10, "value" : 1000, "con" : 10, "stam" : 0, "bravery" : 3, "impactSound" : "leather", "invSound" : "cloth", "brush" : "legend_tabard",\
    "title" :  "Tabard", \
    "desc" :  "A flowing cloth covering for armor, to show allegiance to a noble house. Offers minimal protection and small boost to morale.", \
    "adesc" : "Has a flowing noble tabard"
},
# {"name": "legend_tattered_tabard",           "layer": "tabard", "min": 11, "max": 20, "value" : 50, "con" : 2, "stam" : 0, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "legend_tabard",\
#     "title" :  "Tabard", \
#     "desc" :  "A tattered cloth covering for armor.", \
#     "adesc" : "Has a tattered tabard"
# },
{"name": "legend_southern_wrap_right",           "layer": "tabard", "min": 1, "max": 12, "value" : 50, "con" : 2, "stam" : 0, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "southern_wrap_right",\
    "title" :  "Right Sided Wrap", \
    "desc" :  "A southern wrapped cloth wrapped around the right shoulder", \
    "adesc" : "Has a right sided southern wrap"
},
{"name": "legend_southern_wrap_left",           "layer": "tabard", "min": 1, "max": 14, "value" : 50, "con" : 2, "stam" : 0, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "southern_wrap_left",\
    "title" :  "Left Sided Wrap", \
    "desc" :  "A southern wrapped cloth draped over the left shoulder", \
    "adesc" : "Has a left sided southern wrap"
},
{"name": "legend_southern_wide_belt",           "layer": "tabard", "min": 1, "max": 1, "value" : 50, "con" : 2, "stam" : 0, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "southern_wide_belt",\
    "title" :  "Southern Wide Belt", \
    "desc" :  "A southern belt", \
    "adesc" : "Has a southern belt"
},
{"name": "legend_noble_vest",           "layer": "tabard", "min": 1, "max": 1, "value" : 150, "con" : 10, "stam" : -1, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "noble_vest",\
    "title" :  "Noble Vest", \
    "desc" :  "A leather studded vest worn by southern city state nobles", \
    "adesc" : "Has a southern noble vest"
},
{"name": "legend_southern_wrap",           "layer": "tabard", "min": 1, "max": 8, "value" : 100, "con" : 5, "stam" : 0, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "southern_wrap",\
    "title" :  "Southern Cloth Wrap", \
    "desc" :  "A cloth wrap worn by southerners", \
    "adesc" : "Has a southern cloth wrap"
},
{"name": "legend_southern_shoulder_cloth",           "layer": "tabard", "min": 1, "max": 8, "value" : 100, "con" : 5, "stam" : 0, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "southern_shoulder_cloth",\
    "title" :  "Southern Shoulder Cloth", \
    "desc" :  "A cloth wrap worn by southerners", \
    "adesc" : "Has a southern shoulder cloth"
},
{"name": "legend_southern_overcloth",           "layer": "tabard", "min": 1, "max": 1, "value" : 150, "con" : 10, "stam" : -1, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "southern_overcloth",\
    "title" :  "Southern Overcloak", \
    "desc" :  "A heavy duty overcloak worn by southerners", \
    "adesc" : "Has a southern overcloak"
},
{"name": "legend_southern_tabard",           "layer": "tabard", "min": 1, "max": 16, "value" : 200, "con" : 5, "stam" : 0, "bravery" : 2, "impactSound" : "leather", "invSound" : "cloth", "brush" : "southern_tabard",\
    "title" :  "Southern Tabard", \
    "desc" :  "A flowing cloth covering for armor, to show your allegiance. Offers minimal protection and small boost to morale.", \
    "adesc" : "Has a flowing cloth tabard"
}

]


brush_only_layers = [
    #{"name": "legend_runed", "layer": "rune"},
    {"name": "cloak_hexe", "layer": "cloak"},
    {"name": "cloak_spider", "layer": "cloak"},
    {"name" :"named_emperors_cloak", "min" : 1, "max" : 1, "layer" : "cloak"},
    {"name" :"named_emperors_armor", "min" : 1, "max" : 1, "layer" : "plate"},
    {"name": "cloak_rich", "min" : 1, "max" : 5, "layer": "cloak"},
    {"name": "tabard_named", "min" : 1, "max" : 26, "layer": "tabard"}
]

BaseNut = '''
this.$name <- this.inherit("scripts/items/legend_armor/legend_armor", {
	m = {},
	function create()
	{
		this.legend_armor.create();
		this.m.ID = "$id";
		this.m.Name = "$title";
		this.m.Description = "$desc";
		this.m.Variants = $variants;
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = $impactSound;
		this.m.InventorySound = $invSound;
		this.m.Value = $value;
		this.m.Condition = $condition;
		this.m.ConditionMax = $condition;
		this.m.StaminaModifier = $stamina;
        this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
        this.m.ItemType = $itemType;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "$brush" + "_" + variant;
		this.m.SpriteDamaged = "$brush" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "$brush" + "_" + variant + "_dead";
		this.m.IconLarge ="$overlayLarge" + "_" + variant + ".png"
		this.m.Icon = "$overlay" + "_" + variant + ".png"
	}
});
'''

BaseNutInherit = '''
this.$name <- this.inherit("scripts/items/legend_armor/cloth/$inherit", {
	m = {},
	function create()
	{
		this.$inherit.create();
		this.m.ID = "$id";
		this.m.Name = "$title";
		this.m.Description = "$desc";
		this.m.Variants = $variants;
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Value = $value;
		this.m.Condition = $condition;
		this.m.ConditionMax = $condition;
		this.m.StaminaModifier = $stamina;
        this.m.ItemType = $itemType;
	}
});
'''

UpgradeNut = '''
this.$name <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.$type;
		this.m.ID = "$id";
		this.m.Name = "$title";
		this.m.Description = "$desc";
		this.m.ArmorDescription = "$adesc";
		this.m.Variants = $variants;
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = $impactSound;
		this.m.InventorySound = $invSound;
		this.m.Value = $value;
		this.m.Condition = $condition;
		this.m.ConditionMax = $condition;
		this.m.StaminaModifier = $stamina;
        this.m.ItemType = $itemType;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "$brush" + "_" + variant;
		this.m.SpriteDamagedBack = "$brush" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "$brush" + "_" + variant + "_dead";
		this.m.Icon = "$icon" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "$overlay" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "$overlayLarge" + "_" + variant + ".png";
	}
});
'''

UpgradeNutInherit = '''
this.$name <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.$type;
		this.m.ID = "$id";
		this.m.Name = "$title";
		this.m.Description = "$desc";
		this.m.ArmorDescription = "$adesc";
		this.m.Variants = $variants;
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = $impactSound;
		this.m.InventorySound = $invSound;
		this.m.Value = $value;
		this.m.Condition = $condition;
		this.m.ConditionMax = $condition;
		this.m.StaminaModifier = $stamina;
        this.m.ItemType = $itemType;
	}
});
'''

NamedUpgradeNut = '''
this.$name <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.$type;
		this.m.ID = "$id";
		this.m.Name = "$title";
        this.m.NameList = $names;
		this.m.Description = "$desc";
		this.m.ArmorDescription = "$adesc";
		this.m.Variants = $variants;
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = $impactSound;
		this.m.InventorySound = $invSound;
		this.m.Value = $value;
		this.m.Condition = $condition;
		this.m.ConditionMax = $condition;
		this.m.StaminaModifier = $stamina;
        this.m.ItemType = $itemType;
        this.randomizeValues();
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "$brush" + "_" + variant;
		this.m.SpriteDamagedBack = "$brush" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "$brush" + "_" + variant + "_dead";
		this.m.Icon = "$icon" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "$overlay" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "$overlayLarge" + "_" + variant + ".png";
	}

	function randomizeValues()
	{
		this.m.StaminaModifier = this.Math.rand($rminStam, $rmaxStam) * -1;
		this.m.Condition = this.Math.rand($rminCond, $rmaxCond);
		this.m.ConditionMax = this.m.Condition;
	}
});
'''

BaseNamedNut = '''
this.$name <- this.inherit("scripts/items/legend_armor/legend_cloth_named", {
	m = {},
	function create()
	{
		this.legend_cloth_named.create();
		this.m.ID = "$id";
		this.m.Name = "$title";
        this.m.NameList = $names;
		this.m.Description = "$desc";
		this.m.Variants = $variants;
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = $impactSound;
		this.m.InventorySound = $invSound;
		this.m.Value = $value;
		this.m.Condition = $condition;
		this.m.ConditionMax = $condition;
		this.m.StaminaModifier = $stamina;
        this.m.ItemType = $itemType;
        this.randomizeValues();
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "$brush" + "_" + variant;
		this.m.SpriteDamaged = "$brush" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "$brush" + "_" + variant + "_dead";
		this.m.IconLarge ="$overlayLarge" + "_" + variant + ".png"
		this.m.Icon = "$overlay" + "_" + variant + ".png"
	}

	function randomizeValues()
	{
		this.m.StaminaModifier = this.Math.rand($rminStam, $rmaxStam) * -1;
		this.m.Condition = this.Math.rand($rminCond, $rmaxCond);
		this.m.ConditionMax = this.m.Condition;
	}
});
'''

CloakNut = '''
this.$name <- this.inherit("scripts/items/legend_armor/legend_armor_cloak", {
	m = {},
	function create()
	{
		this.legend_armor_cloak.create();
		this.m.ID = "$id";
		this.m.Name = "$title";
		this.m.Description = "$desc";
		this.m.ArmorDescription = "$adesc";
		this.m.Variants = $variants;
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = $impactSound;
		this.m.InventorySound = $invSound;
		this.m.Value = $value;
		this.m.Condition = $condition;
		this.m.ConditionMax = $condition;
		this.m.StaminaModifier = $stamina;
        this.m.ItemType = $itemType;
        this.m.Bravery = $bravery;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "$brush" + "_" + variant;
		this.m.SpriteDamagedBack = "$brush" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "$brush" + "_" + variant + "_dead";
		this.m.Icon = "$icon" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "$overlay" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "$overlayLarge" + "_" + variant + ".png";
	}
});
'''

TabardNut = '''
this.$name <- this.inherit("scripts/items/legend_armor/legend_armor_tabard", {
	m = {},
	function create()
	{
		this.legend_armor_tabard.create();
		this.m.ID = "$id";
		this.m.Name = "$title";
		this.m.Description = "$desc";
		this.m.ArmorDescription = "$adesc";
		this.m.Variants = $variants;
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = $impactSound;
		this.m.InventorySound = $invSound;
		this.m.Value = $value;
		this.m.Condition = $condition;
		this.m.ConditionMax = $condition;
		this.m.StaminaModifier = $stamina;
        this.m.ItemType = $itemType;
        this.m.Bravery = $bravery;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "$brush" + "_" + variant;
		this.m.SpriteDamagedBack = "$brush" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "$brush" + "_" + variant + "_dead";
		this.m.Icon = "$icon" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "$overlay" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "$overlayLarge" + "_" + variant + ".png";
	}
});
'''

Layer = '<sprite id="$name" offsetY="35" f="64FE" ic="$ic" width="104" height="142" img="$name_path" left="-44" right="50" top="-53" bottom="13" />\n'
LayerDamaged = '<sprite id="$damaged" offsetY="35" f="64FE" ic="$ic" width="104" height="142" img="$damaged_path" left="-44" right="50" top="-53" bottom="13" />\n'
LayerDead = '<sprite id="$dead" offsetX="6" offsetY="10" f="64FE" ic="$ic" width="131" height="125" img="$dead_path" left="-57" right="59" top="-53" bottom="55" />\n'
LayerArrow = '<sprite id="$arrow" offsetX="6" offsetY="10" f="64FB" ic="$ic" width="131" height="114" img="$arrow_path" left="0" right="28" top="-8" bottom="30" />\n'
LayerJavelin = '<sprite id="$javelin" offsetX="6" offsetY="10" f="64FB" ic="$ic" width="131" height="134" img="$javelin_path" left="-11" right="35" top="-5" bottom="67" />\n'


def checkForIcon(iconpath, variants):
    dirpath = os.path.join(os.path.dirname(os.path.abspath(__file__)), "gfx", "ui", "items")
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


def makeSheet(num):
    dirpath = os.path.join(os.path.dirname(os.path.abspath(__file__)), "unpacked", "legend_armor", "" + str(num))
    if not os.path.exists(dirpath):
        os.makedirs(dirpath)

    filepath = os.path.join(dirpath, "metadata.xml")
    F = open(filepath, "w")
    F.write('<brush name="gfx/legend_armor_' + str(num) + '.png" version="17">\n')
    return F

def main():

    #Build Brushes
    fileCount = 0
    imageCount = 0
    Brush = makeSheet(fileCount)
    L = [Layer, LayerDamaged, LayerDead]
    LBase = [Layer, LayerDamaged, LayerDead, LayerArrow, LayerJavelin]

    IC = 4280560954

    #Build Nuts
    has_missing = False
    for d in layers:

        inherit = ""
        if "inherit"in d:
            inherit = d["inherit"]
        layer = d["layer"]

        temp = UpgradeNut
        if layer == "cloth":
            temp = BaseNut
            if "named" in d:
                temp = BaseNamedNut
            elif inherit != "":
                temp = BaseNutInherit
        elif layer == "cloak":
            temp = CloakNut
        elif layer == "tabard":
            temp = TabardNut
        elif "named" in d:
            temp = NamedUpgradeNut

        fname = d["name"]
        dirpath = os.path.join(os.path.dirname(os.path.abspath(__file__)),  "legend_armor_scripts", layer)
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


        impactsound = "this.Const.Sound.ArmorLeatherImpact"
        invsound = "this.Const.Sound.ArmorLeatherImpact"
        if d["invSound"] == 'cloth':
            invsound = "this.Const.Sound.ClothEquip"
        elif d["invSound"] == 'chain':
            invsound = "this.Const.Sound.ArmorChainmailImpact"

        if d["impactSound"] == 'chain':
            impactsound = "this.Const.Sound.ArmorChainmailImpact"
        elif d["impactSound"] == 'plate':
            impactsound = "this.Const.Sound.ArmorHalfplateImpact"
        elif d["impactSound"] == 'bone':
            impactsound = "this.Const.Sound.ArmorBoneImpact"


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
            overlay = "armor/icon_" + d["vanilla"]  + "_armor"
            icon = "armor/icon_" + d["vanilla"]  + "_armor"

        if inherit != "":
            if inherit == "legend_padded_surcoat":
                has_missing = has_missing or checkForIcon("legend_armor/inventory_" + "legend_gambeson", variants)
                has_missing = has_missing or checkForIcon("legend_armor/icon_" + "legend_gambeson", variants)
            else:
                has_missing = has_missing or checkForIcon("legend_armor/inventory_" + inherit, variants)
                has_missing = has_missing or checkForIcon("legend_armor/icon_" + inherit, variants)
        else:
            has_missing = has_missing or checkForIcon(overlayLarge, variants)
            has_missing = has_missing or checkForIcon(icon, variants)


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
            condition = d["con"],
            value = d["value"],
            stamina = d["stam"],
            id="legend_armor.body." + fname,
            variants = variants,
            layer = layer,
            type= d["layer"].capitalize(),
            brush = brush,
            overlayLarge = overlayLarge,
            overlay = overlay,
            icon = icon,
            impactSound = impactsound,
            invSound = invsound,
            names = namesL,
            rminStam = d["rminStam"] if "rminStam" in d else 0,
            rmaxStam = d["rmaxStam"] if "rmaxStam" in d else 0,
            rminCond = d["rminCond"] if "rminCond" in d else 0,
            rmaxCond = d["rmaxCond"] if "rmaxCond" in d else 0,
            bravery = bravery,
            itemType = itemType,
        )
        s = Template(temp)
        text = s.substitute(opts)
        F.write(text)
        F.close()

        #print('[1, "' + layer + '/' + fname + '"],' + "// " + str(d["con"]))
        #print('"' + layer + '/' + fname +'",')

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
                    ic=hex(IC).upper().lstrip('0X'),
                    name=name,
                    damaged=name + "_damaged",
                    dead=name + "_dead",
                    arrow=name + "_dead_arrows",
                    javelin=name + "_dead_javelin",
                    name_path=os.path.join("..", "entity", "legend_armor", name + ".png"),
                    damaged_path=os.path.join("..", "entity", "legend_armor", name + "_damaged.png"),
                    dead_path=os.path.join("..", "entity", "legend_armor", name + "_dead.png"),
                    arrow_path=os.path.join("..", "..",  "dead_arrows.png"),
                    javelin_path=os.path.join("..", "..", "dead_javelin.png")
                )
                s = Template(t)
                text = s.substitute(opts)
                text.replace("/", "\\")
                Brush.write(text)
                imageCount += 1
                if (imageCount > 700):
                    Brush.write('</brush>\n')
                    Brush.close()
                    imageCount = 0
                    fileCount += 1
                    Brush = makeSheet(fileCount)

    for d in brush_only_layers:
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
                    ic=hex(IC).upper().lstrip('0X'),
                    name=name,
                    damaged=name + "_damaged",
                    dead=name + "_dead",
                    arrow=name + "_dead_arrows",
                    javelin=name + "_dead_javelin",
                    name_path=os.path.join("..", "entity", "legend_armor", name + ".png"),
                    damaged_path=os.path.join("..", "entity", "legend_armor", name + "_damaged.png"),
                    dead_path=os.path.join("..", "entity", "legend_armor", name + "_dead.png"),
                    arrow_path=os.path.join("..", "..",  "dead_arrows.png"),
                    javelin_path=os.path.join("..", "..", "dead_javelin.png")
                )
                s = Template(t)
                text = s.substitute(opts)
                text.replace("/", "\\")
                Brush.write(text)
                imageCount += 1
                if (imageCount > 700):
                    Brush.write('</brush>\n')
                    Brush.close()
                    imageCount = 0
                    fileCount += 1
                    Brush = makeSheet(fileCount)


    Brush.write('</brush>\n')
    Brush.close()

    if has_missing:
        raise ValueError("Missing gfx icons")


main()
