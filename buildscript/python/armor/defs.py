Names = "::Const.Strings.LegendArmorLayers"


class Defs:
    brush_only_layers = [ #sounds unused, only for readability
        ### Plate
        {"name" :"armor_davkul_named", "min" : 1, "max" : 1, "layer" : "plate"}, # custom sounds
        {"name" :"armor_emperors_named", "min" : 1, "max" : 5, "layer" : "plate", "impactSound" : "plate", "invSound" : "plate"},
        #{"name": "armor_ijirok_named", "min" : 1, "max" : 1, "layer": "plate", "impactSound" : "plate", "invSound" : "plate"},
        {"name": "mountain_armor", "min" : 1, "max" : 2, "layer": "plate", "impactSound" : "plate", "invSound" : "plate"},
        {"name": "skin_armor", "min" : 1, "max" : 2, "layer": "plate", "impactSound" : "leather", "invSound" : "leather"},
        {"name": "wild_scale", "min" : 1, "max" : 1, "layer" : "chain", "impactSound" : "chain", "invSound" : "chain"},
        {"name" :"wurm_hauberk", "min" : 1, "max" : 1, "layer" : "chain", "impactSound" : "chain", "invSound" : "chain"},
        ### Tabard
        {"name": "tabard_named", "min" : 1, "max" : 26, "layer": "tabard", "impactSound" : "leather", "invSound" : "cloth"},
        ### Cloak
        {"name": "cloak_basilisk", "min" : 1, "max" : 1, "layer": "cloak", "impactSound" : "leather", "invSound" : "cloth"},
        {"name": "cloak_cursed", "min" : 1, "max" : 5, "layer": "cloak", "impactSound" : "leather", "invSound" : "cloth"},
        {"name" :"cloak_emperors_named", "min" : 1, "max" : 4, "layer" : "cloak", "impactSound" : "leather", "invSound" : "cloth"},
        {"name": "cloak_fur_hyena", "min" : 1, "max" : 1, "layer": "cloak", "impactSound" : "leather", "invSound" : "cloth", "front_back": { "front" : [-63,1,-50,12], "front_dead" : [-4,58,-59,7], "back": [-61,55,-50,42], "back_dead": [-57,33,-76,28] }},
        {"name": "cloak_fur_unhold", "min" : 1, "max" : 1, "layer": "cloak", "impactSound" : "leather", "invSound" : "cloth", "front_back": { "front" : [-64,-2,-59,11], "front_dead" : [-2,60,-55,11], "back": [-43,57,-32,28], "back_dead": [-59,35,-61,9] }},
        {"name": "cloak_hexe", "min" : 1, "max" : 5, "layer": "cloak", "impactSound" : "leather", "invSound" : "cloth"},
        {"name": "cloak_lindwurm", "min" : 1, "max" : 1, "layer": "cloak", "impactSound" : "leather", "invSound" : "cloth"},
        {"name": "cloak_pelt_wolf_dire", "min" : 1, "max" : 1, "layer": "cloak", "impactSound" : "leather", "invSound" : "cloth", "front_back": { "front" : [-70,0,-56,18], "front_dead" : [-14,60,-76,2], "back": [-61,55,-49,43], "back_dead": [-56,50,-71,23] }},
        {"name": "cloak_pelt_wolf_white", "min" : 1, "max" : 1, "layer": "cloak", "impactSound" : "leather", "invSound" : "cloth", "front_back": { "front" : [-70,0,-56,18], "front_dead" : [-14,60,-76,2], "back": [-61,55,-49,43], "back_dead": [-56,50,-71,23] }},
        {"name": "cloak_redback", "min" : 1, "max" : 4, "layer": "cloak", "impactSound" : "leather", "invSound" : "cloth"},
        {"name": "cloak_serpent", "min" : 1, "max" : 1, "layer": "cloak", "impactSound" : "leather", "invSound" : "cloth"},
        {"name": "cloak_stollwurm", "min" : 1, "max" : 2, "layer": "cloak", "impactSound" : "leather", "invSound" : "cloth"},
        {"name": "cloak_rich", "min" : 1, "max" : 6, "layer": "cloak", "impactSound" : "leather", "invSound" : "cloth"},
        ### Pauldrons
        #{"name": "horn_plate", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "plate", "invSound" : "plate"},
        {"name": "pauldrons", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "plate", "invSound" : "plate"},
        {"name": "pauldrons_barbarian_horn", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "bone", "invSound" : "bone", "front_back": { "front" : [-54,4,-57,21], "front_dead" : [-9,43,-55,29], "back": [9,51,-41,19], "back_dead": [-51,-17,-50,16] }},
        {"name": "pauldrons_belt_shield", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "leather", "invSound" : "leather"},
        {"name": "pauldrons_bone_platings", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "bone", "invSound" : "bone"},
        {"name": "pauldrons_chain_and_mail", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "chain", "invSound" : "chain"},
        {"name": "pauldrons_double_mail", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "chain", "invSound" : "chain"},
        {"name": "pauldrons_gladiator_light", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "leather", "invSound" : "cloth"},
        {"name": "pauldrons_gladiator_heavy", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "plate", "invSound" : "plate"},
        {"name": "pauldrons_heavy", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "plate", "invSound" : "plate"},
        {"name": "pauldrons_heraldic_plates", "min" : 1, "max" : 2, "layer": "attachment", "impactSound" : "plate", "invSound" : "plate"},
        {"name": "pauldrons_joint_cover", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "plate", "invSound" : "plate"},
        {"name": "pauldrons_leather", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "leather", "invSound" : "leather"},
        {"name": "pauldrons_leather_neck", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "leather", "invSound" : "leather"},
        {"name": "pauldrons_mail_patch", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "chain", "invSound" : "chain"},
        {"name": "pauldrons_metal", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "plate", "invSound" : "plate"},
        {"name": "pauldrons_metal_plates", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "plate", "invSound" : "plate"},
        {"name": "pauldrons_named", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "plate", "invSound" : "plate"},
        {"name": "pauldrons_padding_fur", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "leather", "invSound" : "cloth", "front_back": { "front" : [-56,4,-57,21], "front_dead" : [-2,50,-69,13], "back": [15,55,-54,16], "back_dead": [-58,-12,-48,26] }},
        {"name": "pauldrons_padding_light", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "leather", "invSound" : "cloth"},
        {"name": "pauldrons_protective_runes", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "leather", "invSound" : "leather"},
        {"name": "pauldrons_shoulderplates_heraldic", "min" : 1, "max" : 5, "layer": "attachment", "impactSound" : "leather", "invSound" : "leather", "front_back": { "front" : [-47,-9,-39,3], "front_dead" : [2,44,-47,-5], "back": [23,49,-31,3], "back_dead": [-53,-31,-36,-2] }},
        {"name": "pauldrons_skull_chain", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "chain", "invSound" : "chain"},
        {"name": "pauldrons_spiked_chain", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "chain", "invSound" : "chain"},
        {"name": "pauldrons_stag", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "plate", "invSound" : "plate"},
        {"name": "pauldrons_strong", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "plate", "invSound" : "plate"},
        {"name": "pauldrons_swan", "min" : 1, "max" : 1, "layer": "attachment", "impactSound" : "plate", "invSound" : "plate"},
        #{"name": "runed", "layer": "rune"}
    ]

    layers = [
### Cloth
{"name": "ancient_cloth",                          "layer": "cloth", "min": 1, "max": 11, "value" : 20, "con" : 30, "stam" : -5, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Ancient Cloth",
 "desc" :  "An ancient cloth wrap, heavy and offering little protection.",
 "adesc" :""
},
{"name": "ancient_cloth_restored",                 "layer": "cloth", "min": 1, "max": 5, "value" : 40, "con" : 35, "stam" : -4, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Ancient Cloth",
 "desc" :  "A restored ancient cloth wrap, heavy and offering little protection.",
 "adesc" :""
},
{"name": "apron_butcher",                          "layer": "cloth", "min": 1, "max": 4, "value" : 50, "con" : 30, "stam" : -3, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Butcher\'s Apron",
 "desc" :  "A rugged apron worn by butchers to protect against accidental cuts.",
 "adesc" :""
},
{"name": "apron",                                  "layer": "cloth", "min": 1, "max": 7, "value" : 60, "con" : 35, "stam" : -4, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Blacksmith Apron",
 "desc" :  "A heavy leather apron of withstanding intense heat and stray sparks. Favored by blacksmiths.",
 "adesc" :""
},
{"name": "southern_gladiator_harness",                       "layer": "cloth", "min": 1, "max": 1, "value" : 150, "con" : 40, "stam" : -4, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Gladiator Harness",
 "desc" :  "A flashy harness commonly worn by pit fighters in arenas of the southern city states.",
 "adesc" :""
},
{"name": "gambeson",                               "layer": "cloth", "min": 1, "max": 40, "value" : 250, "con" : 65, "stam" : -8, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Gambeson",
 "desc" :  "A heavy, padded tunic that offers decent protection.",
 "adesc" :""
},
{"name": "gambeson_wolf",                          "layer": "cloth", "min": 1, "max": 2, "value" : 300, "con" : 70, "stam" : -9, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Wolf Gambeson",
 "desc" :  "A heavy tunic lined with a thick wolf pelt that offers decent protection.",
 "adesc" :""
},
{"name": "gambeson_named",                         "layer": "cloth", "min": 1, "max": 13, "value" : 1500, "con" : 70, "stam" : -7, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "",
 "desc" :  "A mastercrafted heavy padded tunic that offers excellent protection.",
 "adesc" :"",
 "named" : { "con": { "min" : 75, "max" : 90 }, "fat": { "min" : 6, "max" : 4 }, "names" : ["Heraldic Gambeson", "Splendor", "Grandiosity", "Pageantry", "Swank", "Noble Gambeson", "Duty", "Honor", "Noble\'s Burden", "Protector", "Ward"] } 
},
{"name": "quilted_aketon",                         "layer": "cloth", "min": 1, "max": 31, "value" : 150, "con" : 55, "stam" : -6, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Quilted Aketon",
 "desc" :  "A sturdy, quilted coat that offers decent protection.",
 "adesc" :""
},
{"name": "studded_aketon",                         "layer": "cloth", "min": 1, "max": 1, "value" : 350, "con" : 80, "stam" : -9, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Studded Aketon",
 "desc" :  "A long, sturdy coat reinforced with metal studs that offers good protection.",
 "adesc" :""
},
{"name": "peasant_dress",                          "layer": "cloth", "min": 1, "max": 22, "value" : 25, "con" : 25, "stam" : -2, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Peasant\'s Dress",
 "desc" :  "A simple dress of rough fabric commonly dyed.",
 "adesc" :""
},
{"name": "robes",                                  "layer": "cloth", "min": 1, "max": 11, "value" : 25, "con" : 25, "stam" : -2, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Monk\'s Robe",
 "desc" :  "A rugged, large robe made of simple cloth usually worn by monks and similar individuals who don\'t care for fashion.",
 "adesc" :""
},
{"name": "vala_dress",                                  "layer": "cloth", "min": 1, "max": 1, "value" : 0, "con" : 40, "stam" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Vala\'s Dress",
 "desc" :  "A strong leather dress worn by a vala on her travels.",
 "adesc" :""
},
{"name": "vala_robe",                                  "layer": "cloth", "min": 1, "max": 1, "value" : 0, "con" : 60, "stam" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Vala\'s Cloak",
 "desc" :  "A rugged, surprisingly light cloak ideal for a vala\'s journeys through the lands.",
 "adesc" :""
},
{"name": "fur_rabble",                            "layer": "cloth", "min": 1, "max": 1, "value" : 100, "con" : 5, "stam" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Fur Armor",
 "desc" :  "Matted fur and rags, torn and filthy.",
 "adesc" :""
},
{"name": "robes_magic",                            "layer": "cloth", "min": 1, "max": 7, "value" : 100, "con" : 5, "stam" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Magician\'s Robe",
 "desc" :  "A soft, shiny robe worn by practitioners of the arcane arts.",
 "adesc" :""
},
{"name": "robes_wizard",                            "layer": "cloth", "min": 1, "max": 12, "value" : 50, "con" : 5, "stam" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Beautiful Robe",
 "desc" :  "A soft, wide robe worn by practitioners of the arcane arts.",
 "adesc" :""
},
{"name": "robes_anatomist",                            "layer": "cloth", "min": 1, "max": 1, "value" : 350, "con" : 70, "stam" : -7, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Anatomist\'s Robe",
 "desc" :  "A dark robe and gloves worn by those who tinker with flesh and filth.",
 "adesc" :""
},
{"name": "wanderers_coat",                            "layer": "cloth", "min": 1, "max": 1, "value" : 120, "con" : 45, "stam" : -4, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Wanderer\'s Coat",
 "desc" :  "A coat well suited to wandering the lands.",
 "adesc" :""
},
{"name": "robes_nun",                              "layer": "cloth", "min": 1, "max": 2, "value" : 25, "con" : 22, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Nun\'s Robe",
 "desc" :  "A rugged, large robe made of simple cloth. Usually worn by young nuns.",
 "adesc" :""
},
{"name": "sackcloth_tattered",                     "layer": "cloth", "min": 1, "max": 7, "value" : 5, "con" : 5, "stam" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Tattered Sackcloth",
 "desc" :  "A thin, tattered cloth sack that offers a sliver of protection.",
 "adesc" :""
},
{"name": "sackcloth",                              "layer": "cloth", "min": 1, "max": 10, "value" : 15, "con" : 10, "stam" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Sackcloth",
 "desc" :  "A thin cloth sack that offers a touch of protection.",
 "adesc" :""
},
{"name": "sackcloth_patched",                      "layer": "cloth", "min": 1, "max": 8, "value" : 25, "con" : 15, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Leather Wraps",
 "desc" :  "Various uneven patches of rough leather sewn together.",
 "adesc" :""
},
{"name": "bandages",                              "layer": "cloth", "min": 1, "max": 6, "value" : 1, "con" : 5, "stam" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Bandages",
 "desc" :  "Normally used for dressing wounds rather than preventing new ones.",
 "adesc" :""
},
{"name": "thick_tunic",                            "layer": "cloth", "min": 1, "max": 24, "value" : 40, "con" : 30, "stam" : -3, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Thick Tunic",
 "desc" :  "A thick cloth tunic that offers protection from light blows and weather alike.",
 "adesc" :""
},
{"name": "tunic",                                  "layer": "cloth", "min": 1, "max": 13, "value" : 25, "con" : 20, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Linen Tunic",
 "desc" :  "A simple cloth tunic that offers limited protection.",
 "adesc" :""
},
{"name": "tunic_wrap",                                  "layer": "cloth", "min": 1, "max": 12, "value" : 25, "con" : 20, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Linen Tunic Wrap",
 "desc" :  "A simple cloth wrapped tunic that offers limited protection.",
 "adesc" :""
},
{"name": "tunic_collar_thin",                                  "layer": "cloth", "min": 1, "max": 5, "value" : 25, "con" : 20, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Thin Collar Linen Tunic",
 "desc" :  "A simple cloth tunic with a thin collar that offers limited protection.",
 "adesc" :""
},
{"name": "tunic_collar_deep",                                  "layer": "cloth", "min": 1, "max": 1, "value" : 25, "con" : 20, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth",
 "title" : "Deep Collar Linen Tunic",
 "desc" : "A simple cloth tunic with a deep collar that offers limited protection.",
 "adesc" :""
},
{"name": "tunic_dark",                             "layer": "cloth", "min": 1, "max": 3, "value" : 50, "con" : 35, "stam" : -4, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Dark Tunic",
 "desc" :  "A dark, heavy cloth tunic. Bulky, but offering additional protection.",
 "adesc" :""
},
{"name": "tunic_noble",                            "layer": "cloth", "min": 1, "max": 10, "value" : 500, "con" : 10, "stam" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Noble Tunic",
 "desc" :  "A thin, linen tunic of exquisite material, embroidered with pleasing patterns. Fashionable, but offering little protection.",
 "adesc" :""
},
{"name": "tunic_noble_named",                      "layer": "cloth", "min": 1, "max": 3, "value" : 1500, "con" : 40, "stam" : -2, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "",
 "desc" :  "A fine, linen tunic of exquisite material, embroidered with pleasing patterns. Light and sturdy.",
 "adesc" :"",
 "named" : { "con": { "min" : 46, "max" : 56 }, "fat": { "min" : 2, "max" : 0 }, "names" : ['Heraldic Tunic', "Splendor", "Grandiosity", "Pageantry", "Swank", "Duty", "Honor", "Noble"]  }
},
{"name": "southern_robe",                 "layer": "cloth", "min": 1, "max": 6, "value" : 35, "con" : 25, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth",
 "title" : "Southern Wool Robe",
 "desc" :  "A dense wool wrap to protect against blunt hits.",
 "adesc" : ""
},
{"name": "knightly_robe",                 "layer": "cloth", "min": 1, "max": 9, "value" : 450, "con" : 60, "stam" : -2, "impactSound" : "leather", "invSound" : "cloth",
 "title" : "Knight\'s Robe",
 "desc" :  "A padded robe of superior quality designed to go under armor and absorb blows.",
 "adesc" : ""
},
{"name": "southern_gambeson",           "layer": "cloth", "min": 1, "max": 8, "value" : 250, "con" : 65, "stam" : -8, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Gambeson",
 "desc" :  "A long, sturdy and tunic of southern origin that offers decent protection.",
 "adesc" : ""
},
{"name": "southern_split_gambeson",           "layer": "cloth", "min": 1, "max": 1, "value" : 250, "con" : 65, "stam" : -8, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Split Gambeson",
 "desc" :  "A long, sturdy tunic of southern origin that is split at the bottom.",
 "adesc" : ""
},
{"name": "southern_tunic",           "layer": "cloth", "min": 1, "max": 6, "value" : 50, "con" : 25, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Tunic",
 "desc" :  "A light and well made checkered tunic of southern origin.",
 "adesc" : ""
},
{"name": "southern_noble_aketon",           "layer": "cloth", "min": 1, "max": 10, "value" : 350, "con" : 55, "stam" : -6, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Noble Aketon",
 "desc" :  "A bright, decorated coat that offers decent protection.",
 "adesc" : ""
},
{"name": "fleshcultist_tunic",           "layer": "cloth", "min": 1, "max": 12, "value" : 350, "con" : 55, "stam" : -4, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Fleshcultist Tunic",
 "desc" :  "An elaborate leather tunic.",
 "adesc" : ""
},

# {"name": "southern_cloth_sash",           "layer": "cloth", "min": 0, "max": 0, "value" : 30, "con" : 20, "stam" : 0, "impactSound" : "leather", "invSound" : "cloth", "vanilla" : "body_southern", "variants" : [12,18,19], \
#     "title" :  "Cloth Sash", \
#     "desc" :  "A double sash made from thick cloth that is worn across the body.", \
#     "adesc" : ""
# },
# {"name": "southern_robe_nomad",           "layer": "cloth", "min": 0, "max": 0, "value" : 50, "con" : 35, "stam" : -2, "impactSound" : "leather", "invSound" : "cloth", "vanilla" : "body_southern", "variants" : [16], \
#     "title" :  "Nomad Robe", \
#     "desc" :  "A nomad cloth robe worn to protect against both the heat and against cuts and bruises.", \
#     "adesc" : ""
# },
# {"name": "southern_robe_nomad_thick",     "layer": "cloth", "min": 0, "max": 0, "value" : 80, "con" : 50, "stam" : -5, "impactSound" : "leather", "invSound" : "cloth", "vanilla" : "body_southern", "variants" : [17], \
#     "title" :  "Thick Nomad Robe", \
#     "desc" :  "A double layered robe fashioned from thick cloth.", \
#     "adesc" : ""
# }


### Chain


{"name": "ancient_double_mail",              "layer": "chain", "min": 1, "max": 5, "value" : 750, "con" : 80, "stam" : -14, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Ancient Double Layer Mail",
 "desc" :  "Heavy and rotten double-layered mail of ancient design offering decent protection, but very fatiguing to wear.",
 "adesc" :"Includes a set of heavy and rotten double-layered mail of ancient design."
},
{"name": "ancient_mail",                     "layer": "chain", "min": 1, "max": 5, "value" : 300, "con" : 35, "stam" : -6, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Ancient Mail",
 "desc" :  "Old and crusted heavy mail of ancient design offering some protection, but fatiguing to wear.",
 "adesc" :"Includes a set of old and crusted heavy mail of ancient design."
},
{"name": "basic_mail",                       "layer": "chain", "min": 1, "max": 4, "value" : 800, "con" : 85, "stam" : -12, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Basic Mail",
 "desc" :  "A set of chain mail that offers good protection, but is very fatiguing to wear.",
 "adesc" : "Includes a set of long and heavy chain mail."
},
{"name": "hauberk",                          "layer": "chain", "min": 1, "max": 1, "value" : 1750, "con" : 95, "stam" : -11, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Hauberk",
 "desc" :  "Heavy chain mail that offers good protection, but is very fatiguing to wear.",
 "adesc" : "Includes a set of long and heavy chain mail."
},
{"name": "hauberk_full",                     "layer": "chain", "min": 1, "max": 1, "value" : 2500, "con" : 115, "stam" : -14, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Full Hauberk",
 "desc" :  "Long and heavy chain mail that offers good protection, but is very fatiguing to wear.",
 "adesc" : "Includes a set of long and heavy chain mail."
},
{"name": "hauberk_full_named",               "layer": "chain", "min": 1, "max": 1, "value" : 5000, "con" : 120, "stam" : -15, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "",
 "desc" :  "Truly fit for a knight, this mail hauberk is made from the highest quality materials and boasts precious decorations and ornaments.",
 "adesc" : "Includes a mail hauberk made from the highest quality materials and boasting precious decorations and ornaments.",
 "named" : { "con": { "min" : 125, "max" : 150 }, "fat": { "min" : 13, "max" : 9 }, "names" : ["Heraldic Mail", "Splendor", "Grandiosity", "Pageantry", "Swank", "Full Mail", "Mail Hauberk", "Chain Mail", "Duty", "Honor", "Noble Mail"]  } 
},
{"name": "hauberk_sleeveless",                "layer": "chain", "min": 1, "max": 1, "value" : 1250, "con" : 65, "stam" : -7, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Sleeveless Hauberk",
 "desc" :  "Long and heavy chain mail that offers good protection, but is very fatiguing to wear.",
 "adesc" : "Includes a set of long and heavy chain mail."
},
{"name": "mail_shirt",                       "layer": "chain", "min": 1, "max": 1, "value" : 375, "con" : 50, "stam" : -6, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Basic Mail Shirt",
 "desc" :  "A basic mail shirt. Offers decent and affordable protection against slashing and piercing attacks.",
 "adesc" : "Includes a basic mail shirt."
},
{"name": "mail_shirt_simple",                "layer": "chain", "min": 1, "max": 1, "value" : 250, "con" : 25, "stam" : -3, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Simple Mail Shirt",
 "desc" :  "A simple mail shirt. Offers decent and affordable protection against slashing and piercing attacks.",
 "adesc" : "Includes a simple mail shirt."
},
{"name": "reinforced_mail",                  "layer": "chain", "min": 1, "max": 1, "value" : 1750, "con" : 110, "stam" : -15, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Reinforced Mail",
 "desc" :  "Long and heavy reinforced chain mail that offers good protection, but is very fatiguing to wear.",
 "adesc" : "Includes a set of long and heavy reinforced chain mail."
},
{"name": "reinforced_mail_shirt",            "layer": "chain", "min": 1, "max": 1, "value" : 1000, "con" : 80, "stam" : -10, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Reinforced Mail Shirt",
 "desc" :  "A reinforced mail shirt with shoulder guards providing excellent protection against most weapons.",
 "adesc" : "Includes a reinforced mail shirt."
},
{"name": "reinforced_rotten_mail_shirt",     "layer": "chain", "min": 1, "max": 4, "value" : 200, "con" : 45, "stam" : -7, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Rotten Reinforced Mail Shirt",
 "desc" :  "A reinforced mail shirt that is rotting at the seams.",
 "adesc" : "Includes a rotten, reinforced mail shirt."
},
{"name": "reinforced_worn_mail",             "layer": "chain", "min": 1, "max": 1, "value" : 1250, "con" : 105, "stam" : -17, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Reinforced Worn Mail",
 "desc" :  "Long and heavy reinforced chain mail that offers good protection, but is very fatiguing to wear.",
 "adesc" : "Includes a set of long and heavy reinforced, worn chain mail."
},
{"name": "reinforced_worn_mail_shirt",       "layer": "chain", "min": 1, "max": 4, "value" : 350, "con" : 65, "stam" : -11, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Worn Reinforced Mail Shirt",
 "desc" :  "A reinforced mail shirt that lost some parts over the years.",
 "adesc" : "Includes a worn reinforced mail shirt."
},
{"name": "rusty_mail_shirt",                 "layer": "chain", "min": 1, "max": 11, "value" : 125, "con" : 20, "stam" : -4, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Patched Mail Shirt",
 "desc" :  "This light mail shirt has seen better times, but still grants decent protection.",
 "adesc" : "Includes a rusty and patched mail shirt."
},
{"name": "short_mail",                       "layer": "chain", "min": 1, "max": 1, "value" : 500, "con" : 60, "stam" : -8, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Short Mail",
 "desc" :  "Short chain mail that offers good protection, but is fatiguing to wear.",
 "adesc" : "Includes a set of short chain mail."
},
#{"name": "noble_mail",                  "layer": "chain", "min": 1, "max": 14, "value" : 1300, "con" : 60, "stam" : -7, "impactSound" : "chain", "invSound" : "leather", "brush" : "heavy_mail",
# "title" :  "Noble Mail",
# "desc" :  "A wonderful long leather coat sewn over a light chain provides excellent protection for the vitals, while not weighing you down.",
# "adesc" : "Includes a wonderful long leather coat sewn over a light chain provides excellent protection for the vitals, while not weighing you down.",
# "named" : True, "rminStam" : 5, "rmaxStam": 7, "rminCond" : 70, "rmaxCond" : 90,  "names" : ['Heraldic Mail', "Splendor", "Grandiosity", "Pageantry", "Swank", "Full Mail", "Mail Hauberk", "Chain Mail", "Duty", "Honor", "Noble Mail"]
#},


# {"name": "southern_skirt",                       "layer": "chain", "min": 1, "max": 1, "value" : 500, "con" : 60, "stam" : -8, "impactSound" : "chain", "invSound" : "leather", "brush" : "southern_skirt", \
#     "title" :  "Shoulder Skirt", \
#     "desc" :  "", \
#     "adesc" : ""
# },
{"name": "southern_cloth",                       "layer": "chain", "min": 1, "max": 1, "value" : 50, "con" : 30, "stam" : -2, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Nomad Outer Robe",
 "desc" :  "A durable cloth robe designed to shield the wearer from the sun's heat and the sting of minor cuts.",
 "adesc" : "Includes a heavy nomad robe."
},
{"name": "southern_padded_chest",                       "layer": "chain", "min": 1, "max": 13, "value" : 325, "con" : 45, "stam" : -4, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Padded Vest",
 "desc" :  "A thick cloth vest padded with dense wool to protect against blunt hits.",
 "adesc" : "Includes a thick cloth vest."
},
{"name": "southern_mail",                       "layer": "chain", "min": 1, "max": 1, "value" : 1400, "con" : 100, "stam" : -13, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Southern Mail",
 "desc" :  "A long and heavy mail shirt of southern design made with slightly thinner and lighter metal rings than those used in the north",
 "adesc" : "Includes a long and heavy mail shirt."
},

### Plate

{"name": "leather_brigandine",               "layer": "plate", "min": 1, "max": 1, "value" : 750, "con" : 65, "stam" : -8, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Leather Brigandine Armor",
 "desc" :  "A thick leather brigandine studded with steel rivets for added protection.",
 "adesc" : "Includes a thick studded leather brigandine."
},
{"name": "leather_brigandine_hardened",      "layer": "plate", "min": 1, "max": 1, "value" : 1250, "con" : 110, "stam" : -15, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Hardened Leather Brigandine Armor",
 "desc" :  "A boiled and hardened leather brigandine studded with steel rivets for added protection.",
 "adesc" : "Includes a boiled and hardened leather brigandine."
},
{"name": "leather_brigandine_hardened_full", "layer": "plate", "min": 1, "max": 1, "value" : 3000, "con" : 140, "stam" : -19, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Reinforced Hardened Leather Brigandine Armor",
 "desc" :  "A boiled and hardened brigandine studded with steel rivets and reinforced with steel padded shoulders for added protection.",
 "adesc" : "Includes a reinforced and hardened leather brigandine."
},
{"name": "leather_brigandine_named",         "layer": "plate", "min": 1, "max": 11, "value" : 2500, "con" : 75, "stam" : -6, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "",
 "desc" :  "A rare thick leather brigandine studded with steel rivets for added protection. A piece of true craftsmanship!",
 "adesc" : "Includes a masterwork reinforced leather brigandine.",
 "named" : { "con": { "min" : 80, "max" : 100 }, "fat": { "min" : 7, "max" : 5 }, "names" : ["Harness", "Ward", "Defense", "Barrier", "Studded Vest", "Lifesaver", "Skin", "Peel", "Guard", "Tarnished Harness", "Duty", "Honor"]  }
},
{"name": "leather_jacket",                   "layer": "plate", "min": 1, "max": 10, "value" : 75, "con" : 25, "stam" : -3, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Leather Jacket",
 "desc" :  "A leather jacket that offers modest protection against the elements and light physical harm.",
 "adesc" : "Includes a leather jacket providing basic protection."
},
{"name": "leather_jacket_fine",                    "layer": "plate", "min": 1, "max": 7, "value" : 350, "con" : 35, "stam" : -2, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Fine Leather Jacket",
 "desc" :  "A well-crafted leather jacket of northern make that offers good protection and flexibility.",
 "adesc" : "Includes a well-crafted leather jacket."
},
{"name": "leather_jacket_named",             "layer": "plate", "min": 1, "max": 1, "value" : 750, "con" : 30, "stam" : -3, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "",
 "desc" :  "A well-crafted, hardened leather armor. Light to wear, yet exceptionally sturdy.",
 "adesc" : "Includes a masterwork hardened leather jacket.",
 "named" : { "con": { "min" : 35, "max" : 45 }, "fat": { "min" : 2, "max" : 1 }, "names" : ["Leather Cuirass", "Leather Armor", "Skin", "Peel", "Guard", "Coat", "Nightcloak", "Black Leather", "Dark Omen", "Toadskin", "Ogreskin"]  }
},
{"name": "leather_studded_jacket_named",             "layer": "plate", "min": 1, "max": 13, "value" : 750, "con" : 30, "stam" : -3, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "",
 "desc" :  "A well-crafted, studded leather jacket with reinforced padding. Light to wear, but very sturdy.",
 "adesc" : "Includes a well-crafted studded leather jacket.",
 "named" : { "con": { "min" : 35, "max" : 45 }, "fat": { "min" : 2, "max" : 1 }, "names" : ["Leather Cuirass", "Leather Armor", "Skin", "Peel", "Guard", "Coat", "Nightcloak", "Black Leather", "Dark Omen", "Toadskin", "Ogreskin"]  }
},
{"name": "apron_undertakers",                                  "layer": "plate", "min": 1, "max": 10, "value" : 60, "con" : 35, "stam" : -4, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Undertaker's Apron",
 "desc" :  "A heavy leather apron designed to protect the wearer's clothing from stains and fluids. Usually worn by those who tend to the dead.",
 "adesc" :"Includes a heavy leather undertaker's apron."
},
{"name": "leather_jacket_simple",            "layer": "plate", "min": 1, "max": 6, "value" : 30, "con" : 15, "stam" : -2, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Simple Leather Jacket",
 "desc" :  "A basic leather jacket offering modest protection.",
 "adesc" : "Includes a basic leather jacket."
},
{"name": "leather_lamellar",                 "layer": "plate", "min": 1, "max": 1, "value" : 250, "con" : 50, "stam" : -6, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Leather Lamellar Armor",
 "desc" :  "Numerous overlapping leather plates provide decent protection for most of the upper body.",
 "adesc" : "Includes armor of overlapping leather plates."
},
{"name": "cult_armor",               "itemType" : "this.Const.Items.ItemType.Cultist", "layer": "plate", "min": 1, "max": 30, "value" : 250, "con" : 55, "stam" : -7, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Cultist Leather Armor",
 "desc" :  "Dark, heavy leather armor adorned with occult symbols. It offers sturdy protection and was likely used in grim rituals.",
 "adesc" : "Includes leather armor adorned with occult symbols."
},
{"name": "leather_lamellar_harness_heavy",   "layer": "plate", "min": 1, "max": 1, "value" : 1750, "con" : 130, "stam" : -20, "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Lamellar Harness",
 "desc" :  "A rugged body harness made of thick overlapping metal plates that cover most of the upper body, but is exceptionally heavy.",
 "adesc" : "Includes a heavy lamellar harness made of thick overlapping metal plates."
},
{"name": "leather_lamellar_harness_reinforced", "layer": "plate", "min": 1, "max": 1, "value" : 350, "con" : 55, "stam" : -7, "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Reinforced Lamellar Harness",
 "desc" :  "A body armor made of thick overlapping metal plates that cover most of the upper body.",
 "adesc" : "Includes body armor made of thick overlapping metal plates that cover most of the upper body."
},
{"name": "leather_lamellar_heavy",           "layer": "plate", "min": 1, "max": 1, "value" : 4750, "con" : 165, "stam" : -24, "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Heavy Lamellar Armor",
 "desc" :  "A heavy lamellar armor that covers most parts of the body with thick, overlapping metal plates for maximum protection.",
 "adesc" : "Includes heavy lamellar armor that covers most parts of the body with thick, overlapping metal plates."
},
{"name": "leather_lamellar_heavy_named",     "layer": "plate", "min": 1, "max": 1, "value" : 7500, "con" : 140, "stam" : -23, "impactSound" : "plate", "invSound" : "plate",
 "title" :  "",
 "desc" :  "An extraordinarily well-crafted piece of lamellar armor. It is overlaid with beaten gold, which makes it truly stand out.",
 "adesc" : "Includes an extraordinarily well-crafted gold plated lamellar harness.",
 "named" : { "con": { "min" : 175, "max" : 195 }, "fat": { "min" : 23, "max" : 19 }, "names" : ["Harness", "Ward", "Defense", "Splendor", "Golden Lamellar"]  }
},
{"name": "leather_lamellar_reinforced",      "layer": "plate", "min": 1, "max": 1, "value" : 2500, "con" : 150, "stam" : -23, "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Reinforced Leather Lamellar Armor",
 "desc" :  "Numerous overlapping metal reinforced leather plates that provides excellent protection for most of the upper body but is very heavy.",
 "adesc" : "Includes armor of overlapping reinforced metal leather plates."
},
{"name": "leather_padded",                   "layer": "plate", "min": 1, "max": 2, "value" : 175, "con" : 40, "stam" : -5, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Padded Leather Armor",
 "desc" :  "A suit of padded leather reinforced with metal studs for added protection.",
 "adesc" : "Includes a suit of reinforced padded leather armor."
},
{"name": "leather_riveted",                  "layer": "plate", "min": 1, "max": 9, "value" : 900, "con" : 95, "stam" : -13, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Sellsword\'s Leather Armor",
 "desc" :  "A long leather coat reinforced with large metal rivets offering good protection, but very fatiguing to wear.",
 "adesc" : "Includes a long leather coat reinforced with large metal rivets."
},
{"name": "leather_riveted_light",            "layer": "plate", "min": 1, "max": 1, "value" : 700, "con" : 80, "stam" : -11, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Footman\'s Leather Armor",
 "desc" :  "A leather armor reinforced with metal rivets. Fatiguing to wear.",
 "adesc" : "Includes a leather armor reinforced with metal rivets."
},
{"name": "leather_scale",                    "layer": "plate", "min": 1, "max": 1, "value" : 600, "con" : 70, "stam" : -9, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Leather Scale Armor",
 "desc" :  "A thick leather scale armor that offers extra protection.",
 "adesc" : "Includes a thick scaled leather armor."
},
{"name": "plate_ancient_chest",              "layer": "plate", "min": 1, "max": 1, "value" : 750, "con" : 105, "stam" : -18, "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Ancient Breastplate",
 "desc" :  "A heavy tarnished thick breastplate of ancient origin that offers some protection.",
 "adesc" : "Includes a heavy tarnished thick breastplate of ancient origin."
},
{"name": "plate_ancient_chest_restored",     "layer": "plate", "min": 1, "max": 1, "value" : 1500, "con" : 110, "stam" : -15, "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Restored Ancient Breastplate",
 "desc" :  "A restored thick breastplate of ancient origin made lighter and more durable.",
 "adesc" : "Includes a restored thick breastplate of ancient origin."
},
{"name": "plate_ancient_gladiator",          "layer": "plate", "min": 1, "max": 1, "value" : 100, "con" : 35, "stam" : -6, "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Ancient Gladiator Harness",
 "desc" :  "A tarnished gladiator outfit of ancient origin providing basic protection.",
 "adesc" : "Includes a tarnished gladiator outfit of ancient origin."
},
{"name": "plate_ancient_harness",            "layer": "plate", "min": 1, "max": 1, "value" : 1500, "con" : 115, "stam" : -19, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Ancient Plate Harness",
 "desc" :  "Made of thick metal plates and mail, this heavy ancient armor still offers great protection even after countless years. It\'s crusted and rotten in parts, however, severely limiting the mobility of the wearer.",
 "adesc" : "Includes an ancient plate harness of thick metal plates and mail."
},
{"name": "plate_ancient_mail",               "layer": "plate", "min": 1, "max": 1, "value" : 300, "con" : 45, "stam" : -7, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Ancient Plated Mail",
 "desc" :  "An ancient mail armor with plated arm guards. Despite offering limited protection, it's very heavy and severely limits the mobility of the wearer.",
 "adesc" : "Includes an ancient mail armor with plated arm guards."
},
{"name": "plate_ancient_scale",              "layer": "plate", "min": 1, "max": 1, "value" : 1000, "con" : 105, "stam" : -17, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Ancient Scale Coat",
 "desc" :  "A heavy, tarnished scale coat of ancient design, which belongs in a collection rather than on the battlefield.",
 "adesc" : "Includes an ancient, heavy, tarnished scale coat."
},
{"name": "plate_ancient_scale_coat",         "layer": "plate", "min": 1, "max": 1, "value" : 2000, "con" : 140, "stam" : -24, "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Ancient Plated Scale Coat",
 "desc" :  "A heavy coat of scales, partly reinforced with a layer of plated metal on top. It\'s a massive armor of ancient origin that didn\'t age well.",
 "adesc" : "Includes an ancient, heavy, reinforced scale coat."
},
{"name": "plate_ancient_scale_harness",      "layer": "plate", "min": 1, "max": 1, "value" : 500, "con" : 75, "stam" : -12, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Ancient Scale Harness",
 "desc" :  "A sturdy, but heavy and partly decayed ancient scale harness.",
 "adesc" : "Includes a heavy and partly decayed ancient scale harness."
},
{"name": "plate_ancient_scale_coat_restored",         "layer": "plate", "min": 1, "max": 1, "value" : 3000, "con" : 170, "stam" : -23, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Embalmed Ancient Scale Coat",
 "desc" :  "A scale coat of ancient design, miraculously well preserved and functional despite its age.",
 "adesc" : "Includes an ancient heavy scale coat in excellent condition."
},
{"name": "plate_ancient_scale_harness_restored",      "layer": "plate", "min": 1, "max": 1, "value" : 500, "con" : 130, "stam" : -15, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Embalmed Ancient Scale Harness",
 "desc" :  "A sturdy, ancient scale harness, remarkably well-preserved and functional.",
 "adesc" : "Includes a remarkably well-preserved ancient scale harness."
},
{"name": "plate_chest",                      "layer": "plate", "min": 1, "max": 1, "value" : 2250, "con" : 125, "stam" : -17, "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Breastplate Armor",
 "desc" :  "A heavy breastplate made of solid, plated steel, offering formidable protection at the cost of significant weight.",
 "adesc" : "Includes a breastplate of solid, plated steel."
},
{"name": "rotten_plate_chest",               "layer": "plate", "min": 1, "max": 1, "value" : 1250, "con" : 100, "stam" : -16, "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Decayed Breastplate Armor",
 "desc" :  "A worn breastplate of decaying, plated steel. Long years of neglect have left the metal pitted and brittle, offering only some of its former protection.",
 "adesc" : "Includes a worn breastplate of decaying, plated steel."
},
{"name": "plate_cuirass",                    "layer": "plate", "min": 1, "max": 1, "value" : 3500, "con" : 150, "stam" : -21, "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Plate Cuirass Armor",
 "desc" :  "A heavy body vest of solid, plated steel designed for protecting the vitals.",
 "adesc" : "Includes a heavy body vest of solid, plated steel."
},
{"name": "plate_full",                       "layer": "plate", "min": 1, "max": 1, "value" : 4500, "con" : 160, "stam" : -22, "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Full Coat of Plate Armor",
 "desc" :  "A full set of solid, plated steel armor.",
 "adesc" : "Includes a full set of solid, plated steel armor."
},
{"name": "plate_full_greaves",               "layer": "plate", "min": 1, "max": 4, "value" : 5000, "con" : 170, "stam" : -26, "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Full Coat of Heavy Plate Armor",
 "desc" :  "A complete harness of solid, plated steel that provides complete protection for the torso and limbs.",
 "adesc" : "Includes a full set of solid, plated steel armor with greaves."
},
{"name": "plate_full_greaves_named",         "layer": "plate", "min": 1, "max": 3, "value" : 10000, "con" : 170, "stam" : -26, "impactSound" : "plate", "invSound" : "plate",
 "title" :  "",
 "desc" :  "A masterfully crafted harness of solid, plated steel.",
 "adesc" : "Includes a masterfully crafted set of painted, solid plated steel with matching greaves.",
 "named" : { "con": { "min" : 185, "max" : 225 }, "fat": { "min" : 25, "max" : 23 }, "names" : ["Glory", "Triumph", "Victory", "Joy"]  }
},
{"name": "plate_full_greaves_painted",       "layer": "plate", "min": 1, "max": 1, "value" : 10000, "con" : 170, "stam" : -26, "impactSound" : "plate", "invSound" : "plate",
 "title" :  "",
 "desc" :  "A masterfully crafted harness of solid, plated steel, finished with a layer of decorative paint.",
 "adesc" : "Includes a masterfully crafted set of painted, solid plated steel with matching greaves.",
 "named" : { "con": { "min" : 185, "max" : 225 }, "fat": { "min" : 25, "max" : 23 }, "names" : ["Ward", "Death", "Barrier", "Plate Armor", "Dark Plated Armor", "Life Stealer"]  }
},
{"name": "scale",                            "layer": "plate", "min": 1, "max": 1, "value" : 2250, "con" : 100, "stam" : -12, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Scale Armor",
 "desc" :  "A sturdy body vest made of overlapping metal scales.",
 "adesc" : "Includes a body vest of overlapping metal scales."
},
{"name": "noble_padded",                            "layer": "plate", "min": 1, "max": 1, "value" : 2800, "con" : 70, "stam" : -6, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Padded Noble Vest",
 "desc" :  "An expensive padded vest with thick leather strapping, tailored for high-society protection.",
 "adesc" : "Includes an expensive padded vest with thick leather strapping."
},
{"name": "scale_coat",                       "layer": "plate", "min": 1, "max": 1, "value" : 2500, "con" : 120, "stam" : -15, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Coat of Scales",
 "desc" :  "A heavy coat of thick, overlapping metal scales, which cover most of the body.",
 "adesc" : "Includes a heavy coat of thick, overlapping metal scales."
},
{"name": "noble_scale",                    "layer": "plate", "min": 1, "max": 7, "value" : 2000, "con" : 75, "stam" : -7, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Noble Scale",
 "desc" :  "A very well crafted scale armor of considerable value.",
 "adesc" : "Includes a well crafted scale armor."
},
{"name": "scale_coat_named",                 "layer": "plate", "min": 1, "max": 1, "value" : 5000, "con" : 160, "stam" : -22, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "",
 "desc" :  "A heavy coat of small, interlocking metal scales that cover most of the body. The style and craftsmanship hint at the armor coming from a far-away region.",
 "adesc" : "Includes a heavy coat of small, interlocking metal scales.",
 "named" : { "con": { "min" : 130, "max" : 160 }, "fat": { "min" : 14, "max" : 10 }, "names" : ["Scale Shirt", "Scale Armor", "Dragonskin", "Snakeskin", "Scales", "Wyrmskin", "Goldskin", "Scale Tunic", "Golden Armor", "Golden Reminder"]  }
},
{"name": "rotten_scale_coat",                "layer": "plate", "min": 1, "max": 1, "value" : 600, "con" : 60, "stam" : -9, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Decayed Coat of Scales",
 "desc" :  "A heavy coat of thick, overlapping metal scales that are worn and missing in places, offering questionable protection for its weight.",
 "adesc" : "Includes a heavy coat of thick, overlapping metal scales that are worn and decaying."
},
{"name": "scale_shirt",                      "layer": "plate", "min": 1, "max": 1, "value" : 1750, "con" : 85, "stam" : -10, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Light Scale Armor",
 "desc" :  "A sturdy yet flexible shirt of small, overlapping metal scales.",
 "adesc" : "Includes body vest with small overlapping metal scales."
},
{"name": "animal_hide_armor",                     "itemType" : "this.Const.Items.ItemType.Cultist", "layer": "plate", "min": 90, "max": 90, "value" : 100, "con" : 30, "stam" : -4, "impactSound" : "leather", "invSound" : "leather", "vanilla" : "body",
 "title" :  "Animal Hide Armor",
 "desc" :  "Heavy hides patched together to create a decent makeshift armor.",
 "adesc" : "Includes heavy hides patched together to create a decent makeshift armor."
},
{"name": "heavy_iron_armor",                       "layer": "plate", "min": 95, "max": 95, "value" : 1000, "con" : 120, "stam" : -18, "impactSound" : "plate", "invSound" : "plate",  "vanilla" : "body",
 "title" :  "Heavy Iron Armor",
 "desc" :  "This armor is made from heavy metal plates, scales and pieces of chain mail. The true armor of a northern warrior.",
 "adesc" : "Includes heavy metal plates, scales and pieces of chain mail. The true armor of a northern warrior."
},
{"name": "hide_and_bone_armor",                   "itemType" : "this.Const.Items.ItemType.Cultist", "layer": "plate", "min": 92, "max": 92, "value" : 350, "con" : 80, "stam" : -11, "impactSound" : "bone", "invSound" : "leather", "vanilla" : "body",
 "title" :  "Hide and Bone Armor",
 "desc" :  "Hide and bone are common materials in the northern regions. This armor is using both for decent protection.",
 "adesc" : "Includes hide and bone armor that is decent protection."
},
{"name": "animal_hide_armor_reinforced",           "itemType" : "this.Const.Items.ItemType.Cultist", "layer": "plate", "min": 97, "max": 97, "value" : 175, "con" : 55, "stam" : -9, "impactSound" : "leather", "invSound" : "leather", "vanilla" : "body",
 "title" :  "Reinforced Animal Hide Armor",
 "desc" :  "A reinforced animal hide armor fashioned from thick leather pieces with added mail and metal scales.",
 "adesc" : "Includes a reinforced animal hide armor fashioned from thick leather pieces with added mail and metal scales."
},
{"name": "rugged_scale_armor",                     "layer": "plate", "min": 93, "max": 93, "value" : 700, "con" : 95, "stam" : -15, "impactSound" : "chain", "invSound" : "chain", "vanilla" : "body",
 "title" :  "Rugged Scale Armor",
 "desc" :  "A heavy body armor made from thick iron scales.",
 "adesc" : "Includes a heavy body armor made from thick iron scales."
},
{"name": "scrap_metal_armor",                      "layer": "plate", "min": 94, "max": 94, "value" : 250, "con" : 65, "stam" : -10, "impactSound" : "plate", "invSound" : "plate", "vanilla" : "body",
 "title" :  "Scrap Metal Armor",
 "desc" :  "This armor is pieced together from scavenged metal parts that are fixed to a crude leather tunic.",
 "adesc" : "Includes armor that is pieced together from scavenged metal parts that are fixed to a crude leather tunic."
},
{"name": "thick_furs_armor",                       "layer": "plate", "min": 91, "max": 91, "value" : 15, "con" : 10, "stam" : -1, "impactSound" : "leather", "invSound" : "leather", "vanilla" : "body",
 "title" :  "Thick Furs",
 "desc" :  "Thick furs that are crudely dried and tied together to protect from both the cold and any incoming blows.",
 "adesc" : "Includes thick furs that are crudely dried and tied together to protect from both the cold and any incoming blows."
},
{"name": "thick_plated_barbarian_armor",           "layer": "plate", "min": 96, "max": 96, "value" : 1500, "con" : 155, "stam" : -26, "impactSound" : "chain", "invSound" : "chain", "vanilla" : "body",
 "title" :  "Thick Plated Barbarian Armor",
 "desc" :  "A heavy armor that is made from mostly metal. Only one chosen by the ancestors will own a set like this.",
 "adesc" : "Includes a heavy armor that is made from mostly metal. Only one chosen by the ancestors will own a set like this."
},
{"name": "thick_plated_barbarian_armor_named",           "layer": "plate", "min": 103, "max": 103, "value" : 5500, "con" : 155, "stam" : -26, "impactSound" : "plate", "invSound" : "plate", "vanilla" : "body",
 "title" :  "",
 "desc" :  "This armor is composed of a strange alloy, and well crafted for barbarian standards. A truly rare and remarkable piece.",
 "adesc" : "Includes a heavy armor composed of a strange alloy, and well crafted for barbarian standards. A truly rare and remarkable piece.",
 "named" : { "con": { "min" : 155, "max" : 175 }, "fat": { "min" : 26, "max" : 23 }, "names" : ["Tarnished Harness", "Alloy Plate Armor", "Tainted Bulwark", "Tribal Plate"]  }
},
#{"name": "bronze_armor_named",           "layer": "plate", "min": 104, "max": 104, "value" : 4000, "con" : 130, "stam" : -14, "impactSound" : "plate", "invSound" : "plate", "vanilla" : "body",
# "title" :  "Rivet Plated Fur Armor",
# "desc" :  "A simple fur and leather armor with thick layers of metal plates rivetted on top. A very simple and heavy design, but quite effective in combat.",
# "adesc" : "Includes a heavy armor that is made from fur and leather armor with thick layers of metal plates rivetted on top. A very simple and heavy design, but quite effective in combat.",
# "named" : True, "rminStam" : 12, "rmaxStam": 15, "rminCond" : 93, "rmaxCond" : 113,  "names" : ["Plated Fur Armor", "Plate Harness", "Plate-covered Hide", "Rivetted Fur"]
#},

#{"name": "southern_named_golden_plates",           "layer": "plate", "min": 1, "max": 1, "value" : 5600, "con" : 200, "stam" : -36, "impactSound" : "plate", "invSound" : "leather", "brush" : "named_southern_gold_plates",
# "title" :  "Composite Lamellar Plates",
# "desc" :  "A heavy composite armor consisting of padding and lamellar elements",
# "adesc" : "Includes composite lamellar elements and extra padding.",
#},

{"name": "southern_named_plate",                  "layer": "plate", "min": 1, "max": 1, "value" : 9000, "con" : 210, "stam" : -25, "impactSound" : "plate", "invSound" : "plate",
 "title" :  "",
 "desc" :  "Ancient knowledge has been used when forging this unique set of armor. Its light mail overlapped with golden splints offers high protection with manageable encumbrance.",
 "adesc" : "Includes light mail overlapped with golden splints offering high protection with manageable encumbrance.",
    "named" : { "con": { "min" : 210, "max" : 230 }, "fat": { "min" : 26, "max" : 23 }, "names" : ["Gilder\'s Shining Ward", "Gilder\'s Skin", "Suncloak", "Snakeskin", "Blazing Mail", "Suntouched Harness", "Shining Hauberk", "Armor of the Scorpion King"]  }
},
#{"name": "armor_emperors_named",                  "layer": "plate", "min": 1, "max": 1, "value" : 9000, "con" : 210, "stam" : -25, "impactSound" : "plate", "invSound" : "leather", "brush" : "southern_named_plate",
# "title" :  "fake emperors armor",
# "desc" :  "",
# "adesc" : "",
#    "named" : True, "rminStam" : 23, "rmaxStam": 26, "rminCond" : 210, "rmaxCond" : 230,  "names" : ["Aspect of Davkul"]
#},
#{"name": "davkul",                  "layer": "plate", "min": 1, "max": 1, "value" : 9000, "con" : 210, "stam" : -25, "impactSound" : "plate", "invSound" : "leather", "brush" : "southern_named_plate",
# "title" :  "fake Aspect of Davkul",
# "desc" :  "",
# "adesc" : "",
#},
{"name": "southern_plate",                 "layer": "plate", "min": 1, "max": 2, "value" : 750, "con" : 75, "stam" : -8, "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Mail with Lamellar Plating",
 "desc" :  "A heavy shirt of interlapping metal plates worn over mail.",
 "adesc" : "Includes a heavy shirt of interlapping metal plates."
},
{"name": "southern_plate_full",                    "layer": "plate", "min": 1, "max": 2, "value" : 1500, "con" : 155, "stam" : -26, "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Southern Long Mail Coat with Padding",
 "desc" :  "A padded, heavy coat of overlapping metal plates that provides extensive protection for the torso.",
 "adesc" : "Includes a padded, heavy coat of overlapping metal plates."
},
{"name": "southern_padded",                     "layer": "plate", "min": 1, "max": 13, "value" : 400, "con" : 65, "stam" : -7, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern padded shirt",
 "desc" :  "A padded shirt fashioned from slightly thinner and lighter leather than that used in the north.",
 "adesc" : "Includes a light padded shirt."
},
{"name": "southern_arm_guards",                "layer": "plate", "min": 1, "max": 1, "value" : 300, "con" : 30, "stam" : -2, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Southern arm guards",
 "desc" :  "A pair of leather arm guards favored by southern assassins for their lightweight design.",
 "adesc" : "Includes a pair of leather arm guards."
},
{"name": "southern_strips",                   "layer": "plate", "min": 1, "max": 5, "value" : 275, "con" : 40, "stam" : -4, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Linothorax",
 "desc" :  "A breastplate made of several layers of linen that provides basic protection.",
 "adesc" : "Includes a light breastplate made of several layers of linen."
},
{"name": "southern_leather_jacket",           "layer": "plate", "min": 1, "max": 6, "value" : 110, "con" : 30, "stam" : -3, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Nomad Leather Jacket",
 "desc" :  "A jacket of patched southern leather that is light enough for long journeys through the desert.",
 "adesc" : "Includes a jacket of patched southern leather."
},
{"name": "southern_leather_plates",           "layer": "plate", "min": 1, "max": 11, "value" : 200, "con" : 50, "stam" : -5, "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Stitched Nomad Armor",
 "desc" :  "A leather nomad armor stitched together from various hides and scraps.",
 "adesc" : "Includes a stitched armor of leather hide and scraps."
},
{"name": "southern_leather_scale",           "layer": "plate", "min": 1, "max": 4, "value" : 300, "con" : 70, "stam" : -10, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Rusted Nomad Mail",
 "desc" :  "A worn-down, light mail shirt with rusted metal plates grafted onto it.",
 "adesc" : "Includes a light mail shirt with rusted metal plates grafted onto it."
},
{"name": "southern_scale",                  "layer": "plate", "min": 1, "max": 1, "value" : 1500, "con" : 155, "stam" : -26, "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Heavy Southern Lamellar",
 "desc" :  "A heavy lamellar harness of metal plates that provides good protection, but is very fatiguing to wear.",
 "adesc" : "Includes a heavy lamellar harness of metal plates."
},
{"name": "diviner_jacket",           "itemType" : "this.Const.Items.ItemType.Cultist", "layer": "plate", "min": 1, "max": 6, "value" : 3000, "con" : 40, "stam" : -3, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Diviner's Jacket",
 "desc" :  "An embellished jacket previously worn by the Diviner. You\'d expect the stench of rotting flesh to cling to it, but it remains pristine.",
 "adesc" : "Includes an embellished jacket.",
 "named" : { "con": { "min" : 35, "max" : 60 }, "fat": { "min" : 4, "max" : 2 }, "names" : ["Heretic\'s Wrap", "Beholder\'s vestments", "Jacket of the Augur", "Empyrian Coat", "Attestor\'s Skin", "Goreflesh Mantle"]  }
},
{"name": "fleshcultist_jacket",           "itemType" : "this.Const.Items.ItemType.Cultist", "layer": "plate", "min": 1, "max": 6, "value" : 350, "con" : 30, "stam" : -3, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Faultfinder Jacket",
 "desc" :  "A heavy linen jacket worn by fault finders.",
 "adesc" : "Includes a heavy linen jacket worn by fault finders."
},

### Cloak

{"name": "shoulder_cloth",           "layer": "cloak", "min": 1, "max": 12, "value" : 50, "con" : 5, "stam" : 0, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Shoulder Cloth",
 "desc" :  "A piece of cloth draped over the shoulder to protect against the sun and wind.",
 "adesc" : "Includes a piece of cloth draped over the shoulder."
},
{"name": "noble_shawl",           "layer": "cloak", "min": 1, "max": 2, "value" : 250, "con" : 10, "stam" : 0, "bravery" : 1, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Noble Shawl",
 "desc" :  "A shawl of exquisite material that wraps around the shoulders, signifying high status and wealth.",
 "adesc" : "Includes a fine noble shawl."
},
{"name": "cloak_wooly_dark",           "layer": "cloak", "min": 1, "max": 4, "value" : 120, "con" : 15, "stam" : -2, "bravery" : 1, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Dark Wooly Cloak",
 "desc" :  "A cloak of dark wool that wraps around the shoulders.",
 "adesc" : "Includes a cloak of dark wool."
},
{"name": "cloak_fur",           "layer": "cloak", "min": 1, "max": 5, "value" : 120, "con" : 35, "stam" : -6, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Fur Cloak",
 "desc" :  "A cloak made of rough chain and the thick fur of a beast.",
 "adesc" : "Includes a thick fur cloak."
},
{"name": "cloak",           "layer": "cloak", "min": 1, "max": 12, "value" : 100, "con" : 10, "stam" : -1, "bravery" : 1, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Simple Cloak",
 "desc" :  "A rustic cloak of strong, warm wool that provides protection from the weather if nothing else.",
 "adesc" : "Includes a rustic wool cloak."
},
{"name": "cloak_heavy",           "layer": "cloak", "min": 1, "max": 17, "value" : 500, "con" : 30, "stam" : -4, "bravery" : 2, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Heavy Cloak",
 "desc" :  "A rustic cloak of thick, layered, warm wool that provides some protection, but is quite hefty. ",
 "adesc" : "Includes a heavy wool cloak."
},
{"name": "decorative_hood",           "layer": "cloak", "min": 1, "max": 11, "value" : 50, "con" : 15, "stam" : -1, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Decorative Cowl",
 "desc" :  "A hooded cowl with decorated, scalloped edges that provides a quite dashing appearance.",
 "adesc" : "Includes a hooded cowl with decorated, scalloped edges."
},
{"name": "nun_wimple",           "layer": "cloak", "min": 1, "max": 1, "value" : 50, "con" : 15, "stam" : -1, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Nun's Wimple",
 "desc" :  "A basic wimple of plain grey cloth that signifies a life of devotion and poverty.",
 "adesc" : "Includes a basic wimple of plain grey cloth."
},
{"name": "tabbed_hood",           "layer": "cloak", "min": 1, "max": 1, "value" : 40, "con" : 10, "stam" : -1, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Tabbed Cowl",
 "desc" :  "A hooded cowl with dour, tabbed edges that helps one stay unremarkable and unassuming.",
 "adesc" : "Includes a hooded cowl with dour, tabbed edges."
},
{"name": "anatomist_hood",           "layer": "cloak", "min": 1, "max": 7, "value" : 150, "con" : 30, "stam" : -2, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Anatomist Hood",
 "desc" :  "A dark hood with reinforced edges popular with those working with filth and entrails.",
 "adesc" : "Includes a dark hood with reinforced edges."
},
{"name": "cloak_cursed",           "layer": "cloak", "min": 1, "max": 5, "value" : 500, "con" : 20, "stam" : -1, "bravery" : -1, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Cursed Cloak",
 "desc" :  "A cloak of the feathers of a strange creature of the abyss. ",
 "adesc" : "Includes a cloak of the feathers of a strange creature of the abyss."
},
{"name": "cloak_crusader",           "layer": "cloak", "min": 1, "max": 6, "value" : 500, "con" : 35, "stam" : -5, "bravery" : 4, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Crusader's Cloak",
 "desc" :  "A holy cloak of thick, layered, warm wool that provides some protection, but is quite hefty.",
 "adesc" : "Includes a holy cloak of thick, layered wool."
},
{"name": "cloak_noble",           "layer": "cloak", "min": 1, "max": 7, "value" : 3000, "con" : 25, "stam" : -2, "bravery" : 3, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Noble Cloak",
 "desc" :  "A fine, flowing cloak made of light foreign silk that provides protection while looking exceptionally grand.",
 "adesc" : "Includes a fine, flowing cloak of light foreign silk."
},
{"name": "cloak_duke",           "layer": "cloak", "min": 1, "max": 4, "value" : 2000, "con" : 20, "stam" : -2, "bravery" : 4, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Duke's Cloak",
 "desc" :  "A refined cloak of fine, lightweight silk that marks the wearer as a distinguished figure of the highest circles.",
 "adesc" : "Includes a refined cloak of fine, lightweight silk."
},
{"name": "sash",           "layer": "cloak", "min": 1, "max": 2, "value" : 150, "con" : 3, "stam" : 0, "bravery" : 1, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Sash",
 "desc" :  "A flowing cloth sash that adds a vibrant splash of color to any attire.",
 "adesc" : "Includes a flowing cloth sash."
},
{"name": "southern_scarf",           "layer": "cloak", "min": 1, "max": 18, "value" : 100, "con" : 5, "stam" : 0, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Scarf",
 "desc" :  "A simple scarf that wraps around the shoulders.",
 "adesc" : "Includes a simple scarf."
},
{"name": "religious_scarf",           "layer": "cloak", "min": 1, "max": 4, "value" : 60, "con" : 10, "stam" : 0, "bravery" : 1, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Religious Scarf",
 "desc" :  "A plain scarf that wraps around the shoulders with a beaded religious icon.",
 "adesc" : "Includes a plain scarf with a religious icon attached."
},
{"name": "animal_pelt",           "layer": "cloak", "min": 1, "max": 9, "value" : 250, "con" : 15, "stam" : -2, "bravery" : 2, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Animal Pelt",
 "desc" :  "A pelt of spotted fur that wraps around the shoulders.",
 "adesc" : "Includes a pelt of spotted fur."
},
{"name": "southern_scarf_wrap",           "layer": "cloak", "min": 1, "max": 18, "value" : 150, "con" : 15, "stam" : -1, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Scarf Wrap",
 "desc" :  "A simple scarf that wraps around the neck and shoulders.",
 "adesc" : "Includes a simple scarf."
},
{"name": "relic_hood",           "layer": "cloak", "min": 1, "max": 10, "value" : 500, "con" : 25, "stam" : -2, "bravery" : 2, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Relic Hood and Belts",
 "desc" :  "A set of straps, bags, a hooded cowl and a relic of a knightly order that offer physical and spiritual protection.",
 "adesc" : "Includes a set of leather straps, bags, a hooded cowl and a relic of a knightly order."
},

### Tabard

{"name": "tabard",           "layer": "tabard", "min": 1, "max": 14, "value" : 200, "con" : 5, "stam" : 0, "bravery" : 2, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Tabard",
 "desc" :  "A flowing cloth covering for armor that displays some colors or heraldry. It provides a layer of protection and a sense of belonging.",
 "adesc" : "Includes a flowing cloth tabard."
},
{"name": "tabard_noble",           "layer": "tabard", "min": 1, "max": 10, "value" : 1000, "con" : 10, "stam" : 0, "bravery" : 3, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Noble Tabard",
 "desc" :  "A fine, flowing cloth covering for armor that displays noble colors or heraldry. It provides a layer of protection and a sense of belonging.",
 "adesc" : "Includes a fine, flowing cloth tabard."
},
# {"name": "tattered_tabard",           "layer": "tabard", "min": 11, "max": 20, "value" : 50, "con" : 2, "stam" : 0, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth", "brush" : "tabard",\
#     "title" :  "Tabard", \
#     "desc" :  "A tattered cloth covering for armor.", \
#     "adesc" : "Has a tattered tabard"
# },
{"name": "southern_wrap_right",           "layer": "tabard", "min": 1, "max": 13, "value" : 50, "con" : 2, "stam" : 0, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Right Sided Wrap",
 "desc" :  "A southern cloth wrapped around the right shoulder.",
 "adesc" : "Includes a right sided southern wrap."
},
{"name": "southern_wrap_left",           "layer": "tabard", "min": 1, "max": 15, "value" : 50, "con" : 2, "stam" : 0, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Left Sided Wrap",
 "desc" :  "A southern cloth draped over and the left shoulder.",
 "adesc" : "Includes a left sided southern wrap."
},
{"name": "southern_wide_belt",           "layer": "tabard", "min": 1, "max": 1, "value" : 50, "con" : 2, "stam" : 0, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Wide Belt",
 "desc" :  "A simple wide belt that wraps around the waist.",
 "adesc" : "Includes a simple wide belt."
},
{"name": "noble_vest",           "layer": "tabard", "min": 1, "max": 1, "value" : 150, "con" : 10, "stam" : -1, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Noble Vest",
 "desc" :  "A studded leather vest with decorative metallic fasteners popular among the southern nobles.",
 "adesc" : "Includes a studded leather vest."
},
{"name": "southern_wrap",           "layer": "tabard", "min": 1, "max": 9, "value" : 100, "con" : 5, "stam" : 0, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Cloth Wrap",
 "desc" :  "A simple cloth wrap with a studded leather belt and pouches.",
 "adesc" : "Includes a simple cloth wrap."
},
{"name": "southern_shoulder_cloth",           "layer": "tabard", "min": 1, "max": 9, "value" : 100, "con" : 5, "stam" : 0, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Shoulder Cloth",
 "desc" :  "A simple cloth wrap draped over the shoulder.",
 "adesc" : "Includes a simple cloth wrap."
},
{"name": "southern_overcloth",           "layer": "tabard", "min": 1, "max": 1, "value" : 150, "con" : 10, "stam" : -1, "bravery" : 0, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Overcloak",
 "desc" :  "A heavy cloth overcloak cinched with a buckled leather strap.",
 "adesc" : "Includes a heavy cloth overcloak."
},
{"name": "southern_tabard",           "layer": "tabard", "min": 1, "max": 17, "value" : 200, "con" : 5, "stam" : 0, "bravery" : 2, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Tabard",
 "desc" :  "A flowing cloth covering for armor that displays some colors or heraldry cut in the southern style. It provides a layer of protection and a sense of belonging.",
 "adesc" : "Includes a flowing cloth tabard."
},
{"name": "diviner_tabard",           "layer": "tabard", "min": 1, "max": 6, "value" : 200, "con" : 10, "stam" : 0, "bravery" : 3, "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Diviner\'s Sash",
 "desc" :  "A decorated sash and belt previously worn by the Diviner.",
 "adesc" : "Includes a decorated sash and belt previously worn by the Diviner."
},
{"name": "fleshcultist_tabard",           "layer": "tabard", "min": 1, "max": 6, "value" : 200, "con" : 5, "stam" : 0, "bravery" : 2, "impactSound" : "leather", "invSound" : "cloth",
  "title" :  "Fleshcultist's Sash",
  "desc" :  "A linen sash and belt previously worn by followers of the Diviner.",
  "adesc" : "Includes a linen sash and belt previously worn by followers of the Diviner."
 }
]