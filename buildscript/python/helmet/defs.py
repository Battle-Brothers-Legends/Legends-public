Names = "::Const.Strings.LegendHelmetLayers"


class Defs:
    brush_only_layers = [
        ### Helm
        #{"name": "helm_emperor_named", "min" : 1, "max" : 1, "layer": "helm", "impactSound" : "plate", "invSound" : "plate"},
        #{"name": "helm_ijirok_named", "min" : 1, "max" : 1, "layer": "helm", "impactSound" : "plate", "invSound" : "plate"},
        {"name": "wild_helmet", "min" : 1, "max" : 4, "layer": "helm", "impactSound" : "chain", "invSound" : "chain"},
        ### Top
        {"name": "warlock_skull", "min" : 1, "max" : 3, "layer": "top", "impactSound" : "bone", "invSound" : "bone"},
        ### Vanity
        {"name": "demon_alp_helm", "min" : 1, "max" : 1, "layer": "vanity", "impactSound" : "leather", "invSound" : "cloth"},
        {"name": "hunter_cap", "min" : 1, "max" : 17, "layer": "vanity", "impactSound" : "leather", "invSound" : "cloth"},
        {"name": "jester_hat", "min" : 1, "max" : 66, "layer": "vanity", "impactSound" : "leather", "invSound" : "cloth"},
        {"name": "lindwurm_helm", "min" : 1, "max" : 1, "layer": "vanity", "impactSound" : "leather", "invSound" : "leather"},
        {"name": "mountain_helm", "min" : 1, "max" : 2, "layer": "vanity", "impactSound" : "plate", "invSound" : "plate"},
        {"name": "nach_helm", "min" : 1, "max" : 1, "layer": "vanity", "impactSound" : "leather", "invSound" : "cloth"},
        {"name": "pimp_hat", "min" : 1, "max" : 2, "layer": "vanity", "impactSound" : "leather", "invSound" : "cloth"},
        {"name": "redback_helm", "min" : 1, "max" : 1, "layer": "vanity", "impactSound" : "leather", "invSound" : "cloth"},
        {"name": "warlock_hood", "min" : 1, "max" : 5, "layer": "top", "impactSound" : "leather", "invSound" : "cloth"},
        {"name": "witchhunter_helm", "min" : 1, "max" : 8, "layer" : "vanity", "impactSound" : "leather", "invSound" : "cloth"},
        {"name": "white_wolf_helm", "min" : 1, "max" : 2, "layer": "vanity", "impactSound" : "leather", "invSound" : "leather"},
    ]

    layers = [
{"name" : "goblin_scarf"                     , "layer" : "hood", "min" : 1, "max" : 5, "base" : True, "value" : 5, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "true", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Goblin Scarf",
 "desc" :  "A tattered, foul-smelling scrap of cloth that offers little more than a bit of warmth.",
 "adesc":  "Includes a shoddy cloth scarf."
 },
{"name" : "barb_chain_scarf"                     , "layer" : "hood", "min" : 1, "max" : 6, "base" : True, "value" : 125, "con" : 55, "stam" : -3, "vis" : 0, "hair" : "false", "beard" : "true", "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Rusted Aventail",
 "desc" :  "A worn chain mail neck guard. The links are thick but neglected, covered in a layer of deep rust.",
 "adesc" : "Includes a rusted mail neck guard."
 },
{"name" : "barb_open_chain"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 225, "con" : 65, "stam" : -3, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Rusted Open Chain",
 "desc" :  "A worn chain mail head covering. The links are thick but neglected, covered in a layer of deep rust.",
 "adesc" : "Includes a rusted mail head covering."
 },
{"name" : "rotten_chain_scarf"                     , "layer" : "hood", "min" : 1, "max" : 5, "base" : True, "value" : 80, "con" : 50, "stam" : -3, "vis" : 0, "hair" : "false", "beard" : "true", "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Rotten Aventail",
 "desc" :  "A decaying chain mail neck guard. The metal is brittle and structurally compromised by deep corrosion.",
  "adesc" : "Includes a decaying mail neck guard."
 },
{"name" : "cloth_scarf"                     , "layer" : "hood", "min" : 1, "max" : 6, "base" : True, "value" : 10, "con" : 15, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "true", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Cloth Scarf",
 "desc" :  "A simple cloth wrap for the neck, favored by those who prefer to pass through unnoticed.",
 "adesc" : "Includes a simple cloth scarf."
 },
{"name" : "cloth_bandana"                     , "layer" : "hood", "min" : 1, "max" : 6, "base" : True, "value" : 20, "con" : 15, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Headscarf",
 "desc" :  "A light cloth wrap for the head. A practical choice for shielding oneself from the sun and dust.",
  "adesc" : "Includes a light cloth headscarf."
 },
{"name" : "patched_hood"                     , "layer" : "hood", "min" : 1, "max" : 5, "base" : True, "value" : 45, "con" : 25, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Patched Hood",
 "desc" :  "A coarse hood held together by crude, heavy stitching. The garments of a man with little to his name but the will to keep moving forward.",
"adesc": "Includes a coarse, patched hood."
 },
{"name" : "simple_hood"                     , "layer" : "hood", "min" : 1, "max" : 5, "base" : True, "value" : 50, "con" : 30, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Simple Hood",
 "desc" :  "A plain cloth hood offering a modicum of protection against the elements and light blows alike.",
 "adesc" : "Includes a simple cloth hood."
 },
{"name" : "leather_cap"                     , "layer" : "hood", "min" : 1, "max" : 4, "base" : True, "value" : 75, "con" : 35, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Leather Cap",
 "desc" :  "A sturdy leather cap that fits tightly over the head. It offers basic coverage but leaves the ears and neck exposed.",
 "adesc" : "Includes a simple leather cap."
 },
{"name" : "padded_cap"                     , "layer" : "hood", "min" : 1, "max" : 5, "base" : True, "value" : 90, "con" : 40, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Aketon Cap",
 "desc" :  "A light cap of quilted linen, providing a layer of padding for the head.",
 "adesc" : "Includes a simple padded cap."
 },
{"name" : "leather_hood"                     , "itemType" : "this.Const.Items.ItemType.Cultist", "layer" : "hood", "min" : 1, "max" : 6, "base" : True, "value" : 110, "con" : 45, "stam" : -2, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Leather Hood",
 "desc" :  "A sturdy hood made of thick leather, padded for extra protection. Counts as a cultist item.",
 "adesc" : "Includes a sturdy leather hood."
 },
{"name" : "beak_hood"                     , "itemType" : "this.Const.Items.ItemType.Cultist", "layer" : "hood", "min" : 1, "max" : 5, "base" : True, "value" : 150, "con" : 65, "stam" : -3, "vis" : -1, "hair" : "true", "beard" : "true", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Beaked Hood",
 "desc" :  "A thick leather hood with a distinctive, bird-like mask. The beak acts as a ventilator, containing sweet-smelling herbs to ward away sickness and disease. Counts as a cultist item.",
 "adesc" : "Includes a thick leather hood with a bird-like mask." 
 },
{"name" : "padded_hood"                     , "layer" : "hood", "min" : 1, "max" : 5, "base" : True, "value" : 115, "con" : 50, "stam" : -2, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Full Aketon Cap",
 "desc" :  "A light cap of quilted linen, providing a layer of padding for the head and the neck.",
 "adesc" : "Includes a padded cap with a neck guard."
 },
{"name" : "southern_cap"                     , "layer" : "hood", "min" : 1, "max" : 15, "base" : True, "value" : 30, "con" : 20, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Cap",
 "desc" :  "A thin cap of rough fabric. Provides some reprieve from the sun.",
 "adesc" : "Includes a thin cap of rough fabric."
 },
{"name" : "southern_turban_light_hood"       , "layer" : "hood", "min" : 1, "max" : 7, "base" : True, "value" : 90, "con" : 40, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Light Hood",
 "desc" :  "A head covering made of wrapped cloth layers. Its thick folds help insulate the head against heat and dust.",
 "adesc" : "Includes a head covering made of wrapped cloth layers."
 },
{"name" : "southern_niqaab"                     , "layer" : "hood", "min" : 1, "max" : 6, "base" : True, "value" : 300, "con" : 45, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "true", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Niqaab",
 "desc" :  "A full cloth head and face wrap that conceals the wearer's features entirely, leaving only a narrow opening for the eyes.",
  "adesc" : "Includes a full cloth head and face wrap."
 },
{"name" : "full_mask"                           , "layer" : "hood", "min" : 1, "max" : 6, "base" : True, "value" : 50, "con" : 25, "stam" : -1, "vis" : -1, "hair" : "true", "beard" : "true", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Full Cloth Mask",
 "desc" :  "An ominous mask of thin, tightly wrapped cloth. It helps the wearer insulate themselves from the foul stench of decay and the humors of the dead and the diseased.",
  "adesc" : "Includes a thin cloth face mask."
 },
{"name" : "open_chain_hood"                     , "layer" : "hood", "min" : 1, "max" : 3, "base" : True, "value" : 225, "con" : 65, "stam" : -3, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Chain Mail Hood",
 "desc" :  "A hood made of chain mail with a leather brim. Offers good protection and while leaving the face unobstructed.",
 "adesc" : "Includes a chain mail hood."
 },
{"name" : "aventail"                     , "layer" : "hood", "min" : 1, "max" : 5, "base" : True, "value" : 150, "con" : 60, "stam" : -3, "vis" : 0, "hair" : "false", "beard" : "true", "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Aventail",
 "desc" :  "A mail aventail that extends from below the eyeline to cover the neck and lower face.",
"adesc" : "Includes a mail aventail."
 },
{"name" : "aventail_named"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 1500, "con" : 60, "stam" : -3, "vis" : 0, "hair" : "false", "beard" : "true", "impactSound" : "chain", "invSound" : "chain", "named" : { "con": { "min" : 65, "max" : 75 }, "fat": { "min" : 2, "max" : 2 }, "vis": { "min" : 0, "max" : 0 }, "names" : Names  },
"title" :  "",
"desc" :  "Truly fit for a knight, this mail aventail is made from the highest quality materials and boasts precious decorations and ornaments.",
"adesc" : "Includes a mail aventail of the highest quality."
},
{"name" : "rusty_chain_hood"                     , "layer" : "hood", "min" : 1, "max" : 3, "base" : True, "value" : 150, "con" : 70, "stam" : -4, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Rusty Mail Coif",
 "desc" :  "A mail hood covered in a layer of rust. Offers good protection, but leaves horrible stains.",
"adesc" : "Includes a rusty mail hood."
 },
{"name" : "chain_hood"                     , "layer" : "hood", "min" : 1, "max" : 4, "base" : True, "value" : 300, "con" : 75, "stam" : -4, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Mail Coif",
 "desc" :  "A sturdy mail hood, lined with leather for comfort.",
 "adesc" : "Includes a sturdy mail hood."
 },
{"name" : "chain_hood_full"                     , "layer" : "hood", "min" : 1, "max" : 7, "base" : True, "value" : 400, "con" : 80, "stam" : -4, "vis" : 0, "hair" : "true", "beard" : "true", "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Full Mail Coif",
 "desc" :  "A full mail hood with an integrated neck guard.",
 "adesc" : "Includes a full mail hood."
 },
{"name" : "chain_hood_full_named"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 3600, "con" : 80, "stam" : -4, "vis" : 0, "hair" : "true", "beard" : "true", "impactSound" : "chain", "invSound" : "chain", "named" : { "con": { "min" : 85, "max" : 95 }, "fat": { "min" : 3, "max" : 3 }, "vis": { "min" : 0, "max" : 0 }, "names" : Names  },
 "title" :  "",
 "desc" :  "Truly fit for a knight, this mail coif is made from the highest quality materials and boasts precious decorations and ornaments.",
 "adesc" : "Includes a full mail hood of the highest quality."
 },
{"name" : "mail_coif"                     , "layer" : "hood", "min" : 1, "max" : 3, "base" : True, "value" : 450, "con" : 85, "stam" : -5, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Heavy Mail Coif",
 "desc" :  "A heavy mail hood. It features extra leather layering to help prevent chafing.",
 "adesc":  "Includes a heavy chain mail hood."
 },
{"name" : "bronze_chain"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 600, "con" : 90, "stam" : -6, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Bronze Chain",
 "desc" :  "A hood made of interlocking bronze rings. Very heavy, but offers excellent protection.",
 "adesc" : "Includes a bronze mail hood."
 },
{"name" : "enclave_bevor"                     , "layer" : "hood", "min" : 1, "max" : 6, "base" : True, "value" : 750, "con" : 95, "stam" : -7, "vis" : 0, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Bevor",
 "desc" :  "A rigid plate of shaped steel designed to guard the neck and the lower face.",
  "adesc" : "Includes a rigid steel neck guard."
 },
{"name" : "southern_chain_hood"                     , "layer" : "hood", "min" : 1, "max" : 3, "base" : True, "value" : 260, "con" : 75, "stam" : -4, "vis" : 0, "hair" : "false", "beard" : "true", "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Southern Mail Hood",
 "desc" :  "A mail hood of southern design with a reinforced circular face opening.",
  "adesc" : "Includes a southern mail hood."
 },
{"name" : "southern_open_chain_hood"                     , "layer" : "hood", "min" : 1, "max" : 3, "base" : True, "value" : 200, "con" : 65, "stam" : -3, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Southern Chain Mail Hood",
 "desc" :  "A hood made of chain mail of southern design. Offers good protection and while leaving the face unobstructed.",
  "adesc" : "Includes a southern chain mail hood."
 },
{"name" : "southern_open_hood"                     , "layer" : "hood", "min" : 1, "max" : 6, "base" : True, "value" : 90, "con" : 40, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Hood",
 "desc" :  "A southern hood made of cloth that wraps around the head leaving the face unobstructed.",
 "adesc" : "Includes an open southern hood."
 },
{"name" : "cloth_cap"                     , "layer" : "hood", "min" : 1, "max" : 6, "base" : True, "value" : 10, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Cloth Cap",
 "desc" :  "A simple piece of cloth covering the top of the head.",
  "adesc" : "Includes a simple cloth cap."
 },
{"name" : "barb_leather_cap"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 55, "con" : 25, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Patched Leather Cap",
 "desc" :  "A crude cap made from overlapping scraps of leather stitched together with thick twine to provide basic, rigid protection for the crown of the head.",
  "adesc" : "Includes a crude leather cap."
 },
{"name" : "southern_headband_coin"                     , "layer" : "hood", "min" : 1, "max" : 6, "base" : True, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Coin Headband",
 "desc" :  "A thin headband decorated with small jingling coins. Typically worn by entertainers, designed to catch the light and the ear of onlookers.",
  "adesc" : "Includes a thin headband decorated with small jingling coins."
 },
 {"name" : "diviner_wraps"                  , "layer" : "hood", "min" : 1, "max" : 11, "base" : True, "value" : 100, "con" : 50, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "true", "impactSound" : "leather", "invSound" : "cloth",
  "title" :  "Diviner's Wraps",
  "desc" :  "The headwear of The Diviner, despite not having any way to see through the fabric, once it sits on your face you can see through it as if it was never there at all.",
  "adesc" : "Includes the head wrap of The Diviner."
},
# {"name" : "mummy_bandage"                     , "layer" : "hood", "min" : 1, "max" : 4, "base" : True, "value" : 5, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "true",
#  "title" :  "Ancient Southern Facemask",
#  "desc" :  "Wrappings from a long dead embalmed corpse."
#  },

### Helm

{"name" : "ancient_conic_helm"                     , "layer" : "helm", "min" : 1, "max" : 5, "value" : 200, "con" : 60, "stam" : -6, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Ancient Conical Helm",
 "desc" :  "A conical helm with a nasal guard from a bygone era, its ragged leather lining barely hanging from the weathered shell.",
 "adesc" : "Includes an ancient conical helm."
 },
{"name" : "ancient_kettle"                     , "layer" : "helm", "min" : 1, "max" : 15, "value" : 200, "con" : 60, "stam" : -6, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Ancient Kettle",
 "desc" :  "An ancient kettle helm decorated with a tall metal crest, topped with twin feathers that have since lost their lustre.",
 "adesc" : "Includes an ancient kettle helm."
 },
{"name" : "ancient_dome"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 5, "value" : 200, "con" : 60, "stam" : -6, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Ancient Dome",
 "desc" :  "A dome helm with heavy riveted bands that has once been in possession of an ancient household guard.",
  "adesc" : "Includes an ancient dome helm."
 },
{"name" : "ancient_crested"                     , "layer" : "helm", "min" : 1, "max" : 5, "value" : 200, "con" : 60, "stam" : -6, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Ancient Crested Helm",
 "desc" :  "A helm with a heavy crest and jutting cheek guards, its glory faded by the passage of time.",
 "adesc" : "Includes an ancient crested helm."
 },
{"name" : "ancient_dome_tailed"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 5, "value" : 350, "con" : 95, "stam" : -9, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Tailed Ancient Dome",
 "desc" :  "A heavy dome helm topped with a tail, on which the time has left its distinctive mark.",
 "adesc": "Includes a heavy domed helm."
 },
{"name" : "ancient_face_plate"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 5, "value" : 350, "con" : 95, "stam" : -9, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Ancient Plate Helm",
 "desc" :  "A heavy, dilapidated plate helm with a faceplate and a tail, belonging to a legionary of yore.",
"adesc" : "Includes a heavy, ancient plate helm."
 },
{"name" : "ancient_legionary_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 5, "value" : 350, "con" : 95, "stam" : -9, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Ancient Legionary Helm",
 "desc" :  "A heavy helm with a tattered horsehair plume and dulled finish, once a symbol of a legion's iron discipline.",
 "adesc" : "Includes a heavy helm of an ancient legionary."
 },
{"name" : "ancient_side_hawk"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 5, "value" : 350, "con" : 95, "stam" : -9, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Ancient Side Hawk",
 "desc" :  "A heavy ancient helm with a once prominent side crest that has since deteriorated into a set of tattered plumes.",
 "adesc" : "Includes a heavy, ancient side-crested helm."
 },
{"name" : "ancient_tailed_conic_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 5, "value" : 350, "con" : 95, "stam" : -9, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Tailed Ancient Conical Helm",
 "desc" :  "A conical helm of ancient design, topped with a tail long stiff and matted with rot.",
 "adesc" : "Includes a heavy, ancient tailed conical helm."
 },
{"name" : "ancient_face_helm"                     , "layer" : "helm", "min" : 1, "max" : 5, "value" : 500, "con" : 120, "stam" : -10, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Ancient Face Helm",
 "desc" :  "A sturdy helm with a face mask of an ancient honor guard. Despite its age, the helm is in remarkably good condition.",
 "adesc" : "Includes a sturdy, ancient helm with a metal face mask."
 },
{"name" : "orc_strapped_helm"                     , "layer" : "helm", "min" : 1, "max" : 4, "value" : 400, "con" : 160, "stam" : -18, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Orc Looted Nasal Helm",
 "desc" :  "An orc helm made of scavenged helm parts crudely lashed together.",
 "adesc" : "Includes an orc nasal helm."
 },
{"name" : "orc_double_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 6, "value" :1000, "con" : 190, "stam" : -22, "vis" : -3, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" : "Orc Looted Kettle Hat",
 "desc" :  "A simplistic orc helm made from two kettle hats tied together and reinforced with chain mail.",
 "adesc" : "Includes an orc kettle hat."
 },
{"name" : "orc_elite_double_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 5, "value" : 1500, "con" : 225, "stam" : -25, "vis" : -3, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Orc Reinforced Looted Kettle Hat",
 "desc" :  "An orc helm made from two kettle hats tied together and reinforced with chain mail. Craftsmanship is exceptional for orc armor.",
 "adesc" : "Includes a reinforced orc kettle hat."
 },
{"name" : "orc_scale_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 4, "value" : 1200, "con" : 250, "stam" : -30, "vis" : -3, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Orc Looted Scale Plate Helm",
 "desc" :  "An orc helm made from looted heavy plated helms, patched and forged together.",
 "adesc" : "Includes an orc scale helm."
 },
{"name" : "orc_great_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 3, "value" : 3000, "con" : 280, "stam" : -32, "vis" : -4, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Orc Great Helm",
 "desc" :  "The distinctive helm of an orc warlord, extremely heavy and severely limiting sight.",
 "adesc" : "Includes an orc great helm."
 },
{"name" : "orc_behemoth_helmet"                     , "layer" : "helm", "min" : 1, "max" : 7, "value" : 600, "con" : 180, "stam" : -20, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Orc Behemoth Helm",
 "desc" :  "The distinctive helm of an orc behemoth, adorned with huge, jutting tusks.",
 "adesc" : "Includes an orc behemoth helm."
 },
{"name" : "crude_metal_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 3, "value" :500, "con" : 110, "stam" : -8, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Crude Metal Helm",
 "desc" :  "Although crudely made and rusty, this metal helm is a durable and sturdy piece of armor.",
 "adesc" : "Includes a crude metal helm."
 },
{"name" : "crude_cylinder_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 2, "value" : 600, "con" : 155, "stam" : -12, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Crude Cylinder Helm",
 "desc" :  "This heavy metal helm also protects the wearers face, albeit at the cost of visibility.",
 "adesc" : "Includes a crude cylinder helm."
 },
{"name" : "heavy_plate_helm"                     , "layer" : "helm", "min" : 1, "max" : 3, "value" : 1200, "con" : 175, "stam" : -15, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Heavy Plate Helm",
 "desc" :  "This heavy helm usually is worn as a sign of high standing and reputation within barbarian warbands.",
 "adesc" : "Includes a heavy plate helm."
 },
{"name" : "barb_ritual_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 1, "value" : 6000, "con" : 190, "stam" : -16, "vis" : -3, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Northern Ritual Helm",
 "desc" :  "This menacing and heavy full faced mask of solid iron is used during barbarian warbands rituals for reasons unknown.",
 "adesc" : "Includes a northern ritual helm."
 },
{"name" : "heavy_plate_helm_named"                     , "layer" : "helm", "min" : 1, "max" : 3, "value" : 3500, "con" : 185, "stam" : -14, "vis" : -3, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 185, "max" : 205 }, "fat": { "min" : 14, "max" : 12 }, "vis": { "min" : 3, "max" : 2 }, "names" : Names  },
 "title" :  "Famed Heavy Plate Helm",
 "desc" :  "This heavy helm has ornamental horns attached and is of exceptional quality among the barbarian clans. This is a sign of high standing and reputation within barbarian warbands.",
 "adesc" : "Includes a heavy plate helm with ornamental horns."
 },
{"name" : "crude_skull_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 1, "value" : 3500, "con" : 150, "stam" : -9, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 150, "max" : 175 }, "fat": { "min" : 9, "max" : 7 }, "vis": { "min" : 2, "max" : 1 }, "names" : Names  },
 "title" :  "Crude Skull Helm",
 "desc" :  "A heavy helm typical of the northern barbarians with a skull-like face mask. This piece is as massive as it is impressive.",
 "adesc" : "Includes a heavy helm with a skull-like face mask."
 },
{"name" : "heavy_spiked_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 4, "value" : 1800, "con" : 165, "stam" : -10, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 165, "max" : 185 }, "fat": { "min" : 10, "max" : 8 }, "vis": { "min" : 2, "max" : 1 }, "names" : Names  },
 "title" :  "Heavy Spiked Helm",
 "desc" :  "This helm must have belonged to a distinct warrior of the barbarians. Its size and design appear alien to all southern folks.",
 "adesc" : "Includes a heavy spiked helm."
 },
{"name" : "southern_leather_helm"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 60, "con" : 15, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Leather Helm",
 "desc" :  "A traditional southern leather helm. Light and providing decent protection from the sun.",
 "adesc" : "Includes a leather helm of southern make."
 },
{"name" : "southern_studded_leather_helm"                     , "layer" : "helm", "min" : 1, "max" : 5, "value" : 125, "con" : 25, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Nomad Leather Cap",
 "desc" :  "A southern leather helm reinforced with metal studs without sacrificing flexibility.",
 "adesc" : "Includes a studded southern leather helm."
 },
{"name" : "southern_cap_smooth"                     , "layer" : "helm", "min" : 1, "max" : 5, "value" : 150, "con" : 40, "stam" : -2, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Southern Smooth Cap",
 "desc" :  "An unadorned metal cap with smooth texture, common in the southern desert cities.",
 "adesc" : "Includes a smooth metal cap."
 },
{"name" : "southern_cap_spiked"                     , "layer" : "helm", "min" : 1, "max" : 5, "value" : 150, "con" : 40, "stam" : -2, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Southern Spiked Cap",
 "desc" :  "A metal skull cap topped with a fashionable spike.",
  "adesc" : "Includes a spiked metal cap."
 },
{"name" : "viking_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 7, "value" : 200, "con" : 55, "stam" : -3, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Viking Helm",
 "desc" :  "A nordic helm with a metal face mask and cheek guards.",
  "adesc" : "Includes a nordic metal helm."
 },
{"name" : "norman_helm"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 150, "con" : 50, "stam" : -3, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Nasal Helm",
 "desc" :  "A light metal helm with a nose guard.",
 "adesc" : "Includes a light metal helm."
 },
 {"name" : "norman_helm_named"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 1200, "con" : 70, "stam" : -5, "vis" : -1, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 70, "max" : 85 }, "fat": { "min" : 5, "max" : 4 }, "vis": { "min" : 1, "max" : 0 }, "names" : Names  },
 "title" :  "Norman Helm",
 "desc" :  "A conical helm of excellent quality with polished, golden elements that catch the light with a sharp, brilliant glint.",
 "adesc" : "Includes a conical helm of excellent quality with polished, golden elements."
 },
{"name" : "flat_top_helm_rusted"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 225, "con" : 70, "stam" : -5, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Rusted Flat Top Helm",
 "desc" :  "A rusted and dented helm with a flat top, a telling sign of a negligent owner.",
 "adesc" : "Includes a rusted flat metal helm."
 },
{"name" : "flat_top_helm"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 325, "con" : 85, "stam" : -5, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Flat Top Helm",
 "desc" :  "A flat metal helm with a nose guard, popular among the soldiers.",
 "adesc" : "Includes a flat metal helm."
 },
{"name" : "barbute"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 7, "value" : 1250, "con" : 75, "stam" : -3, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Barbute",
 "desc" :  "A sturdy yet light barbute helm, a design uncommon in these lands, made from especially light and durable steel.",
 "adesc" : "Includes a sturdy yet light barbute helm."
 },
{"name" : "barbute_named"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 4, "value" : 2750, "con" : 85, "stam" : -4, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 85, "max" : 105 }, "fat": { "min" : 4, "max" : 2 }, "vis": { "min" : 2, "max" : 1 }, "names" : Names  },
 "title" :  "Barbute",
 "desc" :  "A superb barbute helm of foreign origin, this piece has been painted and polished to an intense shine.",
 "adesc" : "Includes a superb barbute helm of foreign origin,."
 },
{"name" : "barbute_two_piece_named"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 11, "value" : 2850, "con" : 90, "stam" : -4, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 85, "max" : 105 }, "fat": { "min" : 4, "max" : 2 }, "vis": { "min" : 2, "max" : 1 }, "names" : Names  },
 "title" :  "Barbute",
 "desc" :  "A mastercrafted two-piece barbute helm, meticulously joined and well-maintained.",
 "adesc" : "Includes a mastercrafted two-piece barbute helm."
 },
{"name" : "horsetail"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 350, "con" : 60, "stam" : -3, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Steppe Helm",
 "desc" :  "A nasal helm with an attached tail fashioned in the way of the steppe folks.",
  "adesc" : "Includes a nasal helm with an attached tail."
 },
 {"name" : "horsetail_named"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 1500, "con" : 70, "stam" : -3, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 70, "max" : 105 }, "fat": { "min" : 3, "max" : 2 }, "vis": { "min" : 1, "max" : 0 }, "names" : Names  },
 "title" :  "Steppe Helm",
 "desc" :  "An expertly crafted nasal helm decorated with intricate golden ornaments.",
 "adesc" : "Includes an expertly crafted nasal helm."
 },
{"name" : "bascinet"                     , "layer" : "helm", "min" : 1, "max" : 7, "value" : 400, "con" : 80, "stam" : -5, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Bascinet",
 "desc" :  "A rounded steel helm with a reinforced dome, providing solid protection for the cranium.",
 "adesc" : "Includes a steel bascinet."
 },
{"name" : "bascinet_named"                     , "layer" : "helm", "min" : 1, "max" : 11, "value" : 1700, "con" : 90, "stam" : -4, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 90, "max" : 115 }, "fat": { "min" : 4, "max" : 2 }, "vis": { "min" : 1, "max" : 0 }, "names" : Names  },
 "title" :  "Bascinet",
 "desc" :  "An exquisite bascinet with a pointed head. Very comfortable thanks to its soft leather interior.",
 "adesc" : "Includes an exquisite bascinet."
 },
{"name" : "enclave_peaked_bascinet"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 6, "value" : 2800, "con" : 180, "stam" : -13, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Peaked Bascinet",
 "desc" :  "An imposing steel helm that extends into a flared gorget to protect the throat.",
 "adesc" : "Includes a peaked bascinet with a gorget."
 },
{"name" : "enclave_great_bascinet"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 6, "value" : 3000, "con" : 185, "stam" : -14, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Great Bascinet",
 "desc" :  "A tall helm composed of a peaked bascinet and riveted cheek protection.",
  "adesc" : "Includes a great bascinet."
 },
{"name" : "kettle_helm_rusted"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 300, "con" : 75, "stam" : -7, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Rusted Kettle Helm",
 "desc" :  "A low, broad-rimmed metal helm, rusted and dented.",
 "adesc" : "Includes a rusted steel kettle helm."
 },
{"name" : "kettle_helm"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 500, "con" : 95, "stam" : -7, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" : "Kettle Helm",
 "desc" :  "A metal helm with a broad rim, popular among the soldiers.",
 "adesc" : "Includes a steel kettle helm."
 },
{"name" : "kettle_helm_high"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 850, "con" : 125, "stam" : -9, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Deep Kettle Helm",
 "desc" :  "A tall metal helm with a broad rim.",
 "adesc" : "Includes a tall kettle helm."
 },
{"name" : "kettle_hat"                     , "layer" : "helm", "min" : 1, "max" : 7, "value" : 800, "con" : 120, "stam" : -9, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Kettle Hat",
 "desc" :  "A simple metal helm with a wide, sloping brim and a pointy top.",
 "adesc" : "Includes a steel kettle hat."
 },
{"name" : "kettle_helm_named"                     , "layer" : "helm", "min" : 1, "max" : 10, "value" : 3500, "con" : 130, "stam" : -9, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 130, "max" : 155 }, "fat": { "min" : 9, "max" : 7 }, "vis": { "min" : 2, "max" : 1 }, "names" : Names  },
 "title" :  "Kettle Helm",
 "desc" :  "An exceptional kettle helm of unmatched quality. Adorned with golden decorative elements.",
 "adesc" : "Includes an exceptional kettle helm of unmatched quality."
 },
{"name" : "enclave_kettle"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 1250, "con" : 145, "stam" : -10, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Kettle Sallet",
 "desc" :  "A steel helm that melds the defensive brim of a kettle hat with the sleek, protective form of a sallet.",
 "adesc" : "Includes a steel kettle sallet."
 },
{"name" : "enclave_skullcap"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 600, "con" : 65, "stam" : -4, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Metal Skullcap",
 "desc" :  "A simple, light steel cap that covers the head.",
 "adesc" : "Includes a steel cap."
 },
{"name" : "scale_helm"                     , "layer" : "helm", "min" : 1, "max" : 3, "value" : 725, "con" : 75, "stam" : -5, "vis" : -1, "hair" : "false", "beard" : "false", "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Scale Skullcap",
 "desc" :  "A skullcap composed of overlapping metal scales.",
 "adesc" : "Includes a scale skullcap."
 },
{"name" : "rondel_helm"                     , "layer" : "helm", "min" : 1, "max" : 3, "value" : 775, "con" : 85, "stam" : -6, "vis" : -1, "hair" : "false", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Rondel Helm",
 "desc" :  "A short skullcap with a pair of rondels affixed to the sides, providing extra protection to the wearer's head.",
 "adesc" : "Includes a skullcap with protective side rondels."
 },
{"name" : "deep_cervelliere"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 1000, "con" : 100, "stam" : -5, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Reinforced Deep Cervelliere",
 "desc" :  "A metal cervelliere with a deep, rounded bowl and bolted cheek guards, providing good protection.",
 "adesc" : "Includes a deep steel cervelliere."
 },
{"name" : "deep_cervelliere_named"                     , "layer" : "helm", "min" : 1, "max" : 8, "value" : 3200, "con" : 105, "stam" : -6, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 105, "max" : 125 }, "fat": { "min" : 6, "max" : 5 }, "vis": { "min" : 1, "max" : 1 }, "names" : Names  },
 "title" :  "Reinforced Deep Cervelliere",
 "desc" :  "A decorated deep cervelliere with bolted cheek guards. It bears a gilded trim with decorative leaf plates pinned to the front ridge.",
 "adesc" : "Includes an intricately decorated deep cervelliere."
 },
{"name" : "cervelliere"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 1500, "con" : 105, "stam" : -7, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Reinforced Cervelliere",
 "desc" :  "A heavy steel helm with added bolted cheek guards that offers extensive coverage for the jaw and the temples.",
 "adesc" : "Includes a steel cervelliere with bolted cheek guards."
 },
{"name" : "cervelliere_named"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 2500, "con" : 110, "stam" : -6, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 110, "max" : 135 }, "fat": { "min" : 6, "max" : 5 }, "vis": { "min" : 1, "max" : 1 }, "names" : Names  },
 "title" :  "Reinforced Cervelliere",
 "desc" :  "A skillfully painted cervelliere with added bolted cheek guards. Made of strong steel capable of protecting one's skull from all kinds of trauma.",
 "adesc" : "Includes a skillfully painted cervelliere with bolted cheek guards."
 },
{"name" : "flat_top_face_plate"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 6, "value" : 900, "con" : 120, "stam" : -9, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Flat Top Face Plate",
 "desc" :  "A flat metal helm with a bolted face plate with a perforated breath.",
 "adesc" : "Includes a flat metal helm with a bolted face plate."
 },
{"name" : "carthaginian"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 8, "value" : 1600, "con" : 105, "stam" : -5, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Carthaginian Helm",
 "desc" :  "A sturdy alloy helm of foreign design.",
 "adesc" : "Includes a foreign alloy helm."
 },
{"name" : "conic_helm"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 700, "con" : 110, "stam" : -6, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Conical Helm",
 "desc" :  "A conical helm fluted to redirect the force of the incoming blows.",
 "adesc" : "Includes a fluted conical helm."
 },
{"name" : "sallet"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 800, "con" : 50, "stam" : -2, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Sallet",
 "desc" :  "A metal sallet helm with an extended neck guard, a design uncommon in these lands. Well crafted to offer maximum protection with minimum weight, and without impairing vision.",
 "adesc" : "Includes a metal sallet."
 },
{"name" : "sallet_named"                     , "layer" : "helm", "min" : 1, "max" : 9, "value" : 1600, "con" : 55, "stam" : -2, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Gilded Sallet",
 "desc" :  "A beautifully designed metal sallet helm with an extended neck guard, a design uncommon in these lands. Expertly crafted to offer maximum protection with minimum weight, and without impairing vision.",
 "adesc" : "Includes a beautifully designed metal sallet."
 },
{"name" : "nordic_helm_low"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 6, "value" : 460, "con" : 110, "stam" : -7, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Rusted Nordic Helm",
 "desc" :  "A poorly maintained nordic helm guarding face and neck with additional metal plates. It is rusted, dented, bent and will never be fully repaired.",
 "adesc" : "Includes a rusted nordic helm."
 },
{"name" : "nordic_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 6, "value" : 1000, "con" : 125, "stam" : -8, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Nordic Helm",
 "desc" :  "A nordic helm guarding face and neck with additional metal plates.",
 "adesc" : "Includes a nordic helm."
 },
{"name" : "nordic_helm_high"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 6, "value" : 1750, "con" : 135, "stam" : -8, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Hardened Nordic Helm",
 "desc" :  "A spectacularly well constructed and maintained nordic helm guarding face and neck with additional metal plates.",
 "adesc": "Includes a hardened nordic helm."
 },
{"name" : "great_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 12, "value" : 2500, "con" : 175, "stam" : -12, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Great Helm",
 "desc" :  "A heavy, cylindrical helm reinforced with a cross-plate and a perforated breath, offering near-total head protection at the cost of peripheral vision.",
 "adesc" : "Includes a heavy, cylindrical helm."
 },
{"name" : "full_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 4, "value" : 3000, "con" : 180, "stam" : -13, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Full Helm",
 "desc" :  "A sturdy, pointed helm of heavy steel with a perforated breath, offering great protection.",
 "adesc" : "Includes a sturdy full helm."
 },
{"name" : "enclave_great_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 6, "value" : 2650, "con" : 180, "stam" : -16, "vis" : -4, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Great Helm",
 "desc" :  "A sturdy steel helm with a perforated breath. Very heavy and limiting the field of view.",
  "adesc" : "Includes a heavy great helm."
 },
{"name" : "armet"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 6, "value" : 1750, "con" : 155, "stam" : -11, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Armet",
 "desc" :  "A sophisticated steel helm offering excellent protection despite its agile silhouette.",
 "adesc" : "Includes a steel armet."
 },
{"name" : "enclave_armet"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 6, "value" : 1400, "con" : 140, "stam" : -9, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Open Armet",
 "desc" :  "A light armet without a visor.",
 "adesc" : "Includes a light open armet."
 },
{"name" : "frogmouth"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 7, "value" : 2250, "con" : 160, "stam" : -10, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Frogmouth",
 "desc" :  "A sturdy steel helm with a crafty sloped design meant to deflect blows.",
 "adesc" : "Includes a steel frogmouth helm."
 },
{"name" : "frogmouth_named"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 5, "value" : 2250, "con" : 160, "stam" : -10, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",  "named" : { "con": { "min" : 170, "max" : 195 }, "fat": { "min" : 13, "max" : 11 }, "vis": { "min" : 3, "max" : 2 }, "names" : Names  },
 "title" :  "Frogmouth",
 "desc" :  "A prestigious helm with a crafty sloped design meant to deflect blows. Such a masterpiece surely belonged to a champion of many great tournaments.",
 "adesc" : "Includes a prestigious frogmouth helm of excellent construction."
 },
{"name" : "southern_gladiator_helm_crested"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 13, "value" : 2500, "con" : 130, "stam" : -6, "vis" : -3, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Crested Gladiator Helm",
 "desc" :  "An impressive metal helm crested by a vibrant plume, meant to intimidate the opponents of celebrated pit fighters of the southern city states.",
 "adesc" : "Includes a metal helm with a vibrant plume."
 },
{"name" : "southern_gladiator_helm_split"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 6, "value" : 2500, "con" : 130, "stam" : -6, "vis" : -3, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Split Gladiator Helm",
 "desc" :  "An impressive metal helm featuring an ornate crest and a heavy lattice faceplate, meant to intimidate the opponents of celebrated pit fighters of the southern city states.",
 "adesc" : "Includes a metal helm with an ornate crest and a heavy lattice faceplate."
 },
{"name" : "southern_gladiator_helm_masked"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 6, "value" : 2500, "con" : 130, "stam" : -6, "vis" : -3, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Masked Gladiator Helm",
 "desc" :  "An impressive metal helm with a stoic face mask, crested by twin feathers, meant to intimidate the opponents of celebrated pit fighters of the southern city states.",
 "adesc" : "Includes a metal helm with a stoic face mask and a twin feather crest."
 },
{"name" : "southern_helmet_nasal"                     , "layer" : "helm", "min" : 1, "max" : 8, "value" : 1000, "con" : 125, "stam" : -7, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Heavy Lamellar Helm",
 "desc" :  "A heavy helm made from overlapping metal plates, featuring an ornate nasal guard.",
 "adesc" : "Includes a heavy lamellar helm."
 },
{"name" : "italo_norman_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 6, "value" : 425, "con" : 90, "stam" : -6, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Italo Norman Helm",
 "desc" :  "A pointed conical helm with a large duck-bill shaped faceplate covering the front.",
 "adesc" : "Includes a conical helm with a duck-bill shaped faceplate."
 },
{"name" : "giles_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 7, "value" : 1500, "con" : 100, "stam" : -6, "vis" : -3, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Sir Giles Helm",
 "desc" :  "A tight fitting helm with a perforated visor in a unique style.",
 "adesc" : "Includes a tight fitting helm with a perforated visor."
 },
{"name" : "italo_norman_helm_named"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 3, "value" : 2000, "con" : 110, "stam" : -5, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 110, "max" : 135 }, "fat": { "min" : 5, "max" : 4 }, "vis": { "min" : 2, "max" : 1 }, "names" : Names  },
 "title" :  "Italo Conical Helm",
 "desc" :  "A well-built and lavishly decorated pointed conical helm with a large duck-bill shaped faceplate covering the front.",
 "adesc" : "Includes a well-built pointed conical helm with a duck-bill shaped faceplate."
 },
{"name" : "southern_conic_helm"                     , "layer" : "helm", "min" : 1, "max" : 5, "value" : 1000, "con" : 75, "stam" : -4, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Southern Conical Helm",
 "desc" :  "A sturdy metal helm with a spiked conical crown and a reinforced nasal guard.",
 "adesc" : "Includes a spiked conical helm."
 },
{"name" : "southern_conic_named"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 2000, "con" : 85, "stam" : -3, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 85, "max" : 105 }, "fat": { "min" : 4, "max" : 3 }, "vis": { "min" : 1, "max" : 1 }, "names" : Names  },
 "title" :  "Southern Conical",
 "desc" :  "A masterwork metal helm with a spiked conical crown and a reinforced nasal guard, crested by twin feathers. Light yet sturdy.",
 "adesc" : "Includes a masterwork spiked conical helm."
 },
{"name" : "southern_peaked_helm"                     , "layer" : "helm", "min" : 1, "max" : 5, "value" : 2000, "con" : 115, "stam" : -8, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Southern Peaked Helm",
 "desc" :  "A sturdy metal helm with a heavy skullcap featuring a high pointed crown of southern design.",
 "adesc" : "Includes a peaked helm of southern design."
 },
{"name" : "southern_peaked_nasal_helm"                     , "layer" : "helm", "min" : 1, "max" : 5, "value" : 1500, "con" : 150, "stam" : -11, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Turban Helm",
 "desc" :  "A full helm crafted from overlapping long metal splints in the shape of a traditional southern head wrap.",
 "adesc" : "Includes a southern full helm with a nose guard."
 },
{"name" : "ancient_gladiator"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 6, "value" : 1200, "con" : 150, "stam" : -11, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Ancient Gladiator Helm",
 "desc" :  "A heavy helm with a tall, bladed crest and a perforated faceplate. A battered echo of past glories of those who once bled for the entertainment of a dead empire.",
 "adesc" : "Includes an ancient gladiator helm."
 },
{"name" : "ancient_legionary_helm_restored"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 19, "value" : 800, "con" : 140, "stam" : -9, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Restored Ancient Legionary helm",
 "desc" :  "A restored and polished helm of a long dead legionary, once again serving its purpose after centuries of decay and neglect.",
 "adesc" : "Includes a restored ancient legionary helm."
 },
{"name" : "tailed_conic"                     , "layer" : "helm", "min" : 1, "max" : 5, "value" : 3000, "con" : 140, "stam" : -8, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 140, "max" : 165 }, "fat": { "min" : 9, "max" : 7 }, "vis": { "min" : 2, "max" : 1 }, "names" : Names  },
 "title" :  "Feathered Nasal Helm",
 "desc" :  "A hardened nasal helm with a cloth band and a tail.",
 "adesc" : "Includes a nasal helm with a tail."
 },
{"name" : "armet_named"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 3, "value" : 4000, "con" : 170, "stam" : -11, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 165, "max" : 180 }, "fat": { "min" : 9, "max" : 8 }, "vis": { "min" : 2, "max" : 1 }, "names" : Names  },
 "title" :  "Armet",
 "desc" :  "A sophisticated steel helm offering excellent protection despite its agile silhouette. Masterfully crafted of exquisite steel and layered with decorative paint.",
 "adesc" : "Includes a masterfully crafted armet of exquisite steel."
 },
{"name" : "stag_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 8, "value" : 5000, "con" : 200, "stam" : -15, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 200, "max" : 225 }, "fat": { "min" : 16, "max" : 14 }, "vis": { "min" : 3, "max" : 2 }, "names" : Names  },
 "title" :  "Stag Helm",
 "desc" :  "The helm of a noble house champion bearing the towering antlers of a great stag, of unparalleled craftsmanship, yet quite unwieldy.",
 "adesc" : "Includes a helm with the horns of a great stag."
 },
{"name" : "swan_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 6, "value" : 5000, "con" : 200, "stam" : -15, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 200, "max" : 225 }, "fat": { "min" : 16, "max" : 14 }, "vis": { "min" : 3, "max" : 2 }, "names" : Names  },
 "title" :  "Swan Helm",
 "desc" :  "The helm of a noble house champion bearing the elegant wings of a swan, beautifully designed, yet quite impractical.",
 "adesc" : "Includes a helm adorned with the likeness of a swan."
 },
{"name" : "skin_helm"                     , "itemType" : "this.Const.Items.ItemType.Cultist", "layer" : "helm", "lower": True, "min" : 1, "max" : 1, "value" : 20000, "con" : 105, "stam" : -5, "vis" : 0, "hair" : "true", "beard" : "true", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Glimpse of Davkul",
 "desc" :  "The Glimpse of Davkul is a gift bestowed upon man by ancient and dark powers, a helm merged with human skin and bones through the most unspeakable of rituals. A glimpse of a future where man shall become one with creations from a realm beyond. It shall never break, but instead keep regrowing its scarred skin on the spot.",
 "adesc" : "Includes the Glimpse of Davkul."
 },
{"name" : "rotten_flat_top_face_mask"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 5, "value" : 400, "con" : 110, "stam" : -8, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Rotten Flat Top Face Mask",
 "desc" :  "A decayed flat-topped helm with a pitted faceplate, now little more than a crumbling shell of its former self.",
 "adesc" : "Includes a decayed flat-topped helm."
 },
{"name" : "rotten_great_helm"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 5, "value" : 750, "con" : 150, "stam" : -14, "vis" : -3, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Rotten Great Helm",
 "desc" :  "A heavy, cylindrical helm choked with rust and mold, marred by deep corrosion.",
 "adesc" : "Includes a decayed great helm."
 },
 {"name" : "rotten_great_helm_named"                     , "layer" : "helm", "lower": True, "min" : 1, "max" : 5, "value" : 3400, "con" : 190, "stam" : -13, "vis" : -3, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 190, "max" : 215 }, "fat": { "min" : 14, "max" : 12 }, "vis": { "min" : 3, "max" : 3 }, "names" : Names  },
 "title" :  "",
 "desc" :  "A heavy, cylindrical helm, which once belonged to a decorated knight. Incrusted with gold and precious gems, it betrays a craftsmanship which years of neglect could not diminish.",
 "adesc" : "Includes a decayed, heavy, cylindrical helm of exquisite craftsmanship."
 },
{"name" : "barb_metal_cap"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 150, "con" : 40, "stam" : -2, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Rusted Metal Helm",
 "desc" :  "A rusted and dented metal cap that provides protection against bumps to the head.",
 "adesc": "Includes a rusted metal cap."
 },
 {"name" : "diviner_top"                  , "layer" : "helm", "lower": True, "min" : 1, "max" : 6, "value" : 5000, "con" : 65, "stam" : -3, "vis" : -5, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
  "title" :  "Diviner's Crown",
  "desc" :  "The crown of The Diviner. Upon placing it on your head it was as if your mind expanded out from your body.",
  "adesc" : "Includes the crown of The Diviner."
},

### Top

{"name" : "mask_beak"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 7, "value" : 50, "con" : 20, "stam" : -1, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Physician's Mask",
 "desc" :  "A distinctive, bird-like mask. The beak acts as a ventilator, containing sweet-smelling herbs to ward away sickness and disease.",
 "adesc" : "Includes a distinctive, bird-like mask."
 },
{"name" : "orc_horn_mask"                     , "itemType" : "this.Const.Items.ItemType.Cultist", "layer" : "top", "lower": True, "min" : 1, "max" : 4, "value" : 200, "con" : 60, "stam" : -8, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Orc Horn Mask",
 "desc" :  "A rough horned face mask, worn by young orcs. Counts as a cultist item.",
 "adesc" : "Includes a rough, heavy horned face mask."
 },
{"name" : "orc_metal_mask"                     , "layer" : "top", "min" : 1, "max" : 3, "value" : 400, "con" : 75, "stam" : -11, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Orc Metal Plated Mask",
 "desc" :  "A simple, heavy construction of metal plates, worn by young orcs.",
 "adesc" : "Includes a simple, heavy metal mask."
 },
{"name" : "orc_leather_mask"                     , "itemType" : "this.Const.Items.ItemType.Cultist", "layer" : "top", "lower": True, "min" : 1, "max" : 4, "value" : 50, "con" : 40, "stam" : -4, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Orc Leather Mask",
 "desc" :  "A simple, heavy construction of strange leather, worn by young orcs. Counts as a cultist item.",
 "adesc" : "Includes a simple, heavy leather mask."
 },
{"name" : "goblin_leaves"                     , "layer" : "top", "min" : 1, "max" : 3, "value" : 5, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Goblin Leaves",
 "desc" :  "A set of leaves used by goblins to disguise themselves.",
 "adesc" : "Includes a set of leaves."
 },
{"name" : "undertakers_scarf"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 4, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Undertaker's Scarf",
 "desc" :  "A cloth scarf designed to shield the face from the elements and the cloying stench of the dead.",
 "adesc" : "Includes a cloth scarf worn over the mouth."
 },
{"name" : "goblin_leaf_helm"                     , "layer" : "top", "min" : 1, "max" : 14, "value" : 100, "con" : 25, "stam" : -1, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Goblin Leaf Mask",
 "desc" :  "A rudimentary mask fashioned from foliage and bark, designed to help the wearer blend into the natural surroundings.",
 "adesc" : "Includes a rudimentary goblin mask."
 },
{"name" : "goblin_gillie"                     , "layer" : "top", "min" : 1, "max" : 5, "value" : 80, "con" : 15, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Goblin Gillie",
 "desc" :  "Thick layers of forest foliage and used to disguise oneself.",
 "adesc" : "Includes a disguise made of foliage."
 },
{"name" : "goblin_leather_mask"                     , "itemType" : "this.Const.Items.ItemType.Cultist", "layer" : "top", "min" : 1, "max" : 7, "value" : 50, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Leather Goblin Mask",
 "desc" :  "A primitive mask made of tanned hides and thick stitching. Counts as a cultist item.",
 "adesc" : "Includes a primitive leather mask."
 },
{"name" : "goblin_leather_helm"                     , "layer" : "top", "min" : 1, "max" : 7, "value" : 105, "con" : 25, "stam" : -1, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Leather Goblin Helm",
 "desc" :  "A basic leather helm made of odd scraps stitched together.",
 "adesc" : "Includes a basic leather goblin helm."
 },
{"name" : "goblin_chain_helm"                     , "layer" : "top", "min" : 1, "max" : 3, "value" : 125, "con" : 30, "stam" : -3, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Goblin Chain Helm",
 "desc" :  "A scavenged skullcap reinforced with curtains of rusted mail.",
 "adesc" : "Includes a skullcap reinforced with curtains of rusted mail."
 },
{"name" : "goblin_spiked_helm"                     , "layer" : "top", "min" : 1, "max" : 6, "value" : 125, "con" : 35, "stam" : -4, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Spiked Goblin Helm",
 "desc" :  "The distinctive spiked helm of a goblin overseer, designed to instill a greater fear of the master than of the enemy in the ranks below.",
 "adesc" : "Includes a cruel helm with several iron spikes."
 },
{"name" : "ancient_beard_mask"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 5, "value" : 200, "con" : 45, "stam" : -2, "vis" : -1, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Ancient Bearded Mask",
 "desc" :  "A heavy, weathered faceplate depicting a stern, bearded visage from another time.",
 "adesc" : "Includes a heavy, weathered faceplate."
 },
# {"name" : "ancient_faceplate"                     , "layer" : "top", "min" : 1, "max" : 5, "value" : 150, "con" : 40, "stam" : -2, "vis" : -1, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
# "title" :  "Ancient Face Mask",
# "desc" :  "A Face Mask of an ancient honor guard."
# },
# {"name" : "ancient_cheekplate"                     , "layer" : "top", "min" : 1, "max" : 5, "value" : 100, "con" : 20, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
# "title" :  "Ancient Cheek Plate",
# "desc" :  "A Cheek Plate of an ancient honor guard."
# },
{"name" : "ancient_lion_mask"                     , "layer" : "top", "min" : 1, "max" : 5, "value" : 150, "con" : 40, "stam" : -2, "vis" : -1, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Ancient Lion Mask",
 "desc" :  "An dilapidated helm featuring a noble lion crest, worn by the elite guardians of a forgotten empire.",
 "adesc" : "Includes a dilapidated helm with a noble lion crest."
 },
{"name" : "ancient_mask"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 5, "value" : 100, "con" : 30, "stam" : -2, "vis" : -1, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Ancient Mask",
 "desc" :  "A haunting, weathered faceplate featuring a hollow, open-mouthed expression typical of the funerary masks of the ancients.",
 "adesc" : "Includes a weathered faceplate."
 },
{"name" : "ancient_crown"                     , "layer" : "top", "min" : 1, "max" : 7, "value" : 200, "con" : 20, "stam" : -2, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Ancient Diadem",
 "desc" :  "An ancient crown from ages past.",
 "adesc" : "Includes an ancient crown."
 },
{"name" : "barb_hood_leather"                     ,"itemType" : "this.Const.Items.ItemType.Cultist", "layer" : "top", "min" : 1, "max" : 4, "value" : 300, "con" : 45, "stam" : -4, "vis" : -2, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Barbarian Leather Hood",
 "desc" :  "The crude padded leather hood of a barbarian, it is heavy and surprisingly protective. Counts as a cultist item.",
 "adesc" : "Includes a crude leather hood."
 },
{"name" : "nose_plate"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 18, "value" : 60, "con" : 15, "stam" : -1, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Nose Plate",
 "desc" :  "A strip of metal tied on with a leather band, used for protecting the face from frontal blows.",
 "adesc" : "Includes a nose plate."
 },
{"name" : "headband_side"                     , "layer" : "top", "min" : 1, "max" : 6, "value" : 30, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Headband Side",
 "desc" :  "A rugged leather headband.",
 "adesc" : "Includes a rugged leather headband."
 },
{"name" : "headband_nose"                     , "layer" : "top", "min" : 1, "max" : 6, "value" : 30, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Headband Nose",
 "desc" :  "A rough leather headband with a small nasal guard.",
 "adesc" : "Includes a rough leather headband."
 },
{"name" : "eyemask"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 6, "value" : 125, "con" : 15, "stam" : 0, "vis" : -1, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Eye Mask",
 "desc" :  "A metal mask covering the eyes and nose from blows.",
 "adesc" : "Includes a metal eye mask."
 },
{"name" : "chain_attachment"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 3, "value" : 250, "con" : 25, "stam" : -1, "vis" : 0, "hair" : "false", "beard" : "true", "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Chain Attachment",
 "desc" :  "A curtain of mail designed to be hanged over the mouth.",
 "adesc" : "Includes a mail mouth protector."
 },
{"name" : "helm_adornment"                     , "layer" : "top", "min" : 1, "max" : 3, "value" : 500, "con" : 20, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Helm Adornment",
 "desc" :  "A set of relics of adornment used to create the helm of a true questing knight.",
 "adesc" : "Includes a set of relics of adornment."
 },
{"name" : "rotten_helm_adornment"                     , "layer" : "top", "min" : 1, "max" : 3, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Tarnished Helm Adornment",
 "desc" :  "Ancient decayed relics of adornment from the helm of a long dead questing knight.",
 "adesc" : "Includes a set of decayed relics of adornment."
 },
{"name" : "faceplate_flat"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 6, "value" : 300, "con" : 35, "stam" : -2, "vis" : -1, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Flat Faceplate",
 "desc" :  "A heavy, perforated metal faceplate.",
 "adesc" : "Includes a heavy metal faceplate."
 },
{"name" : "faceplate_curved"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 1, "value" : 300, "con" : 35, "stam" : -2, "vis" : -1, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Curved Faceplate",
 "desc" :  "A steel faceplate expertly shaped to deflect incoming thrusts away from the face.",
 "adesc" : "Includes a curved metal faceplate."
 },
{"name" : "southern_faceplate"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 6, "value" : 500, "con" : 40, "stam" : -2, "vis" : -1, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Southern Faceplate",
 "desc" :  "The grim faceplate favored by southern assassin to mask their identity as well as their intent.",
 "adesc" : "Includes a grim metal faceplate."
 },
{"name" : "faceplate_short"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 6, "value" : 140, "con" : 30, "stam" : -2, "vis" : 0, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Short Faceplate",
 "desc" :  "A compact iron jaw guard that doesn't obstruct the user's field of vision.",
 "adesc" : "Includes a compact iron jaw guard."
 },
{"name" : "cult_hood"                     , "itemType" : "this.Const.Items.ItemType.Cultist", "layer" : "top", "min" : 1, "max" : 11, "value" : 60, "con" : 15, "stam" : -1, "vis" : -1, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Cult Leather Hood",
 "desc" :  "A rough leather hood commonly used in cultist ceremonies. Counts as a cultist item.",
 "adesc" : "Includes a rough leather hood."
 },
{"name" : "faceplate_long"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 6, "value" : 180, "con" : 35, "stam" : -3, "vis" : 0, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Long Faceplate",
 "desc" :  "A sturdy iron jaw guard adjoined with a neck guard.",
 "adesc": "Includes a jaw guard with a neck guard."
 },
{"name" : "faceplate_winged"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 7, "value" : 700, "con" : 50, "stam" : -5, "vis" : -2, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Winged Faceplate",
 "desc" :  "A metal jaw guard formed into the shape of wings with a faceplate.",
 "adesc" : "Includes a metal winged jaw guard with a faceplate."
 },
 {"name" : "faceplate_winged_full"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 7, "value" : 900, "con" : 65, "stam" : -7, "vis" : -2, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Full Winged Faceplate",
 "desc" :  "A metal jaw guard formed into the shape of wings with a faceplate and a neck guard.",
 "adesc" : "Includes a metal winged jaw guard with a faceplate and a neck guard."
 },
 {"name" : "faceplate_winged_long"                     , "layer" : "top", "lower" : True, "min" : 1, "max" : 7, "value" : 600, "con" : 40, "stam" : -4, "vis" : 0, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Winged Faceplate",
 "desc" :  "A metal jaw guard formed into the shape of wings with a neck guard.",
  "adesc" : "Includes a metal winged jaw guard with a neck guard."
 },
 {"name" : "faceplate_winged_full_named"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 4, "value" : 1000, "con" : 65, "stam" : -4, "vis" : -2, "hair" : "false", "beard" : "false", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 65, "max" : 90 }, "fat": { "min" : 4, "max" : 3 }, "vis": { "min" : 2, "max" : 1 }, "names" : Names  },
 "title" :  "Full Winged Faceplate",
 "desc" :  "An exceptionally well crafted faceplate adorned with angelic wings. The design is very light and the materials are of the highest quality.",
 "adesc" : "Includes an exceptionally well crafted faceplate adorned with angelic wings."
 },
{"name" : "faceplate_snub_nose"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 6, "value" : 500, "con" : 45, "stam" : -3, "vis" : -1, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Hounskull Faceplate",
 "desc" :  "A sturdy iron faceplate with a design focused around increased breathability during combat.",
 "adesc" : "Includes a sturdy hounskull faceplate."
 },
{"name" : "faceplate_snub_slit"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 6, "value" : 500, "con" : 50, "stam" : -3, "vis" : -2, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Slit-Visored Hounskull Faceplate",
 "desc" :  "A reinforced iron faceplate with a singular visor slit, providing ample air volume.",
 "adesc" : "Includes a reinforced hounskull faceplate."
 },
 {"name" : "faceplate_pointed"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 6, "value" : 500, "con" : 50, "stam" : -4, "vis" : -1, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Sharp Hounskull Faceplate",
 "desc" :  "A long nosed iron faceplate assuring great ventilation.",
 "adesc" : "Includes a long nosed hounskull faceplate."
 },
 {"name" : "faceplate_pointed_slit"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 6, "value" : 600, "con" : 50, "stam" : -4, "vis" : -1, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Creased Hounskull Faceplate",
 "desc" :  "An iron faceplate forged with a sharp vertical crease and narrow sights, that is easy to breathe through.",
 "adesc" : "Includes a creased hounskull faceplate."
 },
 {"name" : "bascinet_visor_named"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 5, "value" : 1000, "con" : 50, "stam" : -2, "vis" : -1, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 50, "max" : 70 }, "fat": { "min" : 3, "max" : 2 }, "vis": { "min" : 1, "max" : 1 }, "names" : Names  },
 "title" :  "Gilded Hounskull Faceplate",
 "desc" :  "A gilded visor with a pointed snout and plenty of holes to breathe through, providing great protection for a knight of high standing.",
 "adesc" : "Includes a gilded hounskull faceplate."
 },
{"name" : "faceplate_sharp"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 6, "value" : 300, "con" : 35, "stam" : -2, "vis" : -1, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Sharp Faceplate",
 "desc" :  "A metal faceplate with an aggressive profile designed to deflect blows away from the wearer's face.",
 "adesc" : "Includes a sharply curved metal faceplate."
 },
{"name" : "enclave_great_jaw"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 6, "value" : 350, "con" : 50, "stam" : -5, "vis" : 0, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Rough Metal Bevor",
 "desc" :  "A crudely forged, heavy plate of iron designed to shield the throat and the jaw.",
 "adesc" : "Includes a crudely forged metal bevor."
 },
{"name" : "facemask"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 6, "value" : 150, "con" : 20, "stam" : -1, "vis" : -1, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Face Mask",
 "desc" :  "A metal faceplate in the shape of a human face.",
  "adesc" : "Includes a metal anthropomorphic faceplate."
 },
 {"name" : "facemask_named"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 7, "value" : 1200, "con" : 55, "stam" : -2, "vis" : -2, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 55, "max" : 70 }, "fat": { "min" : 3, "max" : 2 }, "vis": { "min" : 1, "max" : 1 }, "names" : Names  },
 "title" :  "Face Mask",
 "desc" :  "A heavy, exquisite metal faceplate in the shape of a face frozen in a mocking smile.",
  "adesc" : "Includes a heavy, exquisite metal anthropomorphic faceplate."
 },
{"name" : "enclave_armet_visor"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 6, "value" : 300, "con" : 35, "stam" : -2, "vis" : -1, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Armet Visor",
 "desc" :  "A visor that fits on an armet, protecting the lower jaw while leaving a slit for eyesight.",
 "adesc" : "Includes an armet visor."
 },
{"name" : "wallace_sallet_visor"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 3, "value" : 150, "con" : 20, "stam" : -1, "vis" : -1, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Sallet Visor",
 "desc" :  "A gracefully curved iron visor, featuring two eye-slits and a few breaths in the center.",
  "adesc" : "Includes a curved iron visor."
 },
{"name" : "wallace_sallet_visor_named"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 1, "value" : 700, "con" : 35, "stam" : -1, "vis" : -1, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 35, "max" : 50 }, "fat": { "min" : 2, "max" : 1 }, "vis": { "min" : 1, "max" : 1 }, "names" : Names  },
 "title" :  "Sallet Visor",
 "desc" :  "A beautifully painted visor bearing an exquisite caricature of a beast's visage upon the front, striking terror - and perhaps a touch of bewilderment - into any who gaze upon it.",
 "adesc" : "Includes a beautifully painted curved iron visor."
 },
{"name" : "enclave_great_bascinet_visor"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 6, "value" : 500, "con" : 45, "stam" : -3, "vis" : -1, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Great Bascinet Visor",
 "desc" :  "A robust, rounded iron visor designed for a great bascinet.",
 "adesc" : "Includes a rounded iron visor."
 },
{"name" : "enclave_peaked_bascinet_visor"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 6, "value" : 900, "con" : 65, "stam" : -6, "vis" : -1, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Peaked Bascinet Visor",
 "desc" :  "A reinforced iron faceplate featuring a sharp peak and a perforated breath made for specifically the peaked bascinet.",
 "adesc" : "Includes a reinforced iron faceplate with a sharp peak."
 },
{"name" : "faceplate_full"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 6, "value" : 800, "con" : 60, "stam" : -5, "vis" : -1, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Full Faceplate",
 "desc" :  "A sturdy metal faceplate covering the entirety of the face as well as the neck.",
 "adesc" : "Includes a full faceplate."
 },
{"name" : "southern_faceplate_bearded"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 6, "value" : 700, "con" : 60, "stam" : -5, "vis" : -2, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Southern Bearded Faceplate",
 "desc" :  "An exquisite golden faceplate forged into the likeness of a bearded patriarch.",
 "adesc" : "Includes an exquisite golden faceplate."
 },
{"name" : "mummy_mask"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 7, "value" : 450, "con" : 40, "stam" : -3, "vis" : -2, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Ancient Southern Face Mask",
 "desc" :  "A weathered golden visage recovered from a forgotten tomb of a long dead civilization.",
 "adesc" : "Includes a weathered golden faceplate."
 },
{"name" : "faceplate_full_breaths"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 6, "value" : 300, "con" : 35, "stam" : -2, "vis" : -1, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Breathed Faceplate",
 "desc" :  "A rounded iron visor heavily perforated with breaths.",
 "adesc" : "Includes a breathable iron faceplate."
 },
{"name" : "unhold_head_chain"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 240, "con" : 45, "stam" : -7, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "chain", "invSound" : "chain",
 "title" :  "Unhold Head Chain",
 "desc" :  "The chain used by barbarian beastmasters for controlling unholds.",
 "adesc" : "Includes an unhold head chain."
 },
{"name" : "unhold_head_spike"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 800, "con" : 90, "stam" : -13, "vis" : -2, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Unhold Head Spike",
 "desc" :  "The heavy spiked armor used by barbarian unholds.",
 "adesc" : "Includes an unhold head spike."
 },
{"name" : "golden_helm"                     , "layer" : "top", "min" : 1, "max" : 2, "value" : 3000, "con" : 90, "stam" : -7, "vis" : -2, "hair" : "true", "beard" : "true", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 90, "max" : 120 }, "fat": { "min" : 7, "max" : 6 }, "vis": { "min" : 2, "max" : 1 }, "names" : Names  },
 "title" :  "Golden Helm",
 "desc" :  "A golden helm and facemask, showing the visage of an emperor from an age long past, imbued with mystical energies. When you hold it into the light, it almost looks as if the face were moving and making expressions of disgust.",
 "adesc" : "Includes a golden helm and facemask, showing the visage of an emperor from an age long past."
 },
{"name" : "faceplate_raised"                     , "layer" : "top", "min" : 1, "max" : 11, "value" :800, "con" : 50, "stam" : -3, "vis" : 0, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 50, "max" : 70 }, "fat": { "min" : 3, "max" : 2 }, "vis": { "min" : 0, "max" : 0 }, "names" : Names  },
 "title" :  "Raised Faceplate",
 "desc" :  "A heavy, reinforced faceplate raised up to allow the user to breathe freely without obscuring his face.",
 "adesc" : "Includes a raised reinforced faceplate."
 },
{"name" : "golden_mask"                     , "layer" : "top", "lower": True, "min" : 1, "max" : 2, "value" : 1500, "con" : 60, "stam" : -4, "vis" : -1, "hair" : "false", "beard" : "true", "impactSound" : "plate", "invSound" : "plate", "named" : { "con": { "min" : 60, "max" : 80 }, "fat": { "min" : 4, "max" : 3 }, "vis": { "min" : 1, "max" : 1 }, "names" : Names  },
 "title" :  "Golden Mask",
 "desc" :  "An exquisite golden mask of distant royalty, its impassive, youthful features are rendered with such exceptional craftsmanship that one could mistake the cold metal for a living face.",
  "adesc" : "Includes an exquisite golden mask of distant royalty."
 },
 {"name" : "fleshcultist_mask"                  , "layer" : "top", "min" : 1, "max" : 5, "value" : 100, "con" : 15, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "true", "impactSound" : "leather", "invSound" : "cloth",
  "title" :  "Fleshcultist Mask",
  "desc" :  "A tattered mask that once belonged to a twisted flesh cultist.",
  "adesc" : "Includes a tattered mask."
},

### Vanity

{"name" : "hood_cloth_round"                     , "layer" : "vanity", "min" : 1, "max" : 7, "value" : 5, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Round Hood Cloth",
 "desc" :  "A rounded hood designed to be worn over a helm, shielding more expensive pieces from the rain.",
 "adesc" : "Includes a rounded cloth hood."
 },
{"name" : "hood_cloth_wide"                     , "layer" : "vanity", "min" : 1, "max" : 8,  "value" : 5, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Wide Hood Cloth",
 "desc" :  "A squared hood, pulled over a helmet to protect the underlying gear from the elements.",
 "adesc" : "Includes a wide cloth hood."
 },
{"name" : "hood_cloth_square"                     , "layer" : "vanity", "min" : 1, "max" : 7, "value" : 5, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Square Hood Cloth",
 "desc" :  "A broadly tailored hood that drapes over the shoulders, keeping the wearer protected from foul weather.",
 "adesc" : "Includes a square cloth hood."
 },
{"name" : "hood_cloth_long"                     , "layer" : "vanity", "min" : 1, "max" : 8, "value" : 30, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Cloth Long Hood",
 "desc" :  "A long, oversized hood that keeps the rain off the neck.",
 "adesc" : "Includes a long cloth hood."
 },
{"name" : "executioner_hood"                     , "itemType" : "this.Const.Items.ItemType.Cultist", "layer" : "top", "min" : 1, "max" : 1, "value" : 100, "con" : 10, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Executioner's Hood",
 "desc" :  "A heavy hood designed to hide the identity of the executioner from the vengeance of those sympathetic to the condemned. Counts as a cultist item.",
 "adesc" : "Includes a heavy cloth hood."
 },
{"name" : "southern_noble_crown"                     , "layer" : "vanity", "min" : 1, "max" : 12, "value" : 100, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Vizier's Peak",
 "desc" :  "A tall crown of a southern vizier. While its bright finish catches the eye, its light weight suggests ceremonial use.",
 "adesc" : "Includes a crown of a southern vizier."
 },
{"name" : "southern_noble_hat"                     , "layer" : "vanity", "min" : 1, "max" : 8, "value" : 50, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Vizier's Hat",
 "desc" :  "A floppy cloth hat of a southern vizier.",
 "adesc" : "Includes a hat of a southern vizier."
 },
{"name" : "southern_noble_turban"                     , "layer" : "vanity", "min" : 1, "max" : 7, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Vizier's Turban",
 "desc" :  "A tall, feathered turban of a southern vizier, made from layers of modest cloth.",
 "adesc" : "Includes a turban of a southern vizier."
 },
{"name" : "southern_helm_tailed"                     , "layer" : "vanity", "min" : 1, "max" : 6, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Tailed Desert Wrap",
 "desc" :  "A light tailed cloth head wrap bound by a gilded band.",
 "adesc" : "Includes a tailed cloth head wrap."
 },
{"name" : "southern_silk_headscarf"                     , "layer" : "vanity", "min" : 1, "max" : 14, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Headscarf",
 "desc" :  "A headscarf made of breathable silk, offering comfort to a desert traveler.",
 "adesc" : "Includes a silk headscarf."
 },
{"name" : "southern_feathered_turban"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Feathered Turban",
 "desc" :  "A light, feathered cloth with featuring a thin face mask.",
 "adesc" : "Includes a feathered cloth head wrap."
 },
{"name" : "sack"                     , "itemType" : "this.Const.Items.ItemType.Cultist", "layer" : "vanity", "min" : 1, "max" : 13, "value" : 5, "con" : 2, "stam" : 0, "vis" : -1, "hair" : "true", "beard" : "true", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Sack",
 "desc" :  "A rough hewn hessian sack with two holes for eyes in it. Counts as a cultist item.",
 "adesc" : "Includes a sack with holes for eyes."
 },
{"name" : "antler"                     , "layer" : "vanity", "min" : 1, "max" : 4, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "bone", "invSound" : "bone",
 "title" :  "Antlers",
 "desc" :  "The wide antlers of a beast, often a mark of distinction among the northern tribes.",
 "adesc" : "Includes the antlers of a beast."
 },
{"name" : "bear_head"                     , "layer" : "vanity", "min" : 1, "max" : 5, "value" : 50, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Bear Headpiece",
 "desc" :  "The dried and prepped head of a large bear. Offers some protection, but is mostly donned for the intimidating looks.",
 "adesc" : "Includes a headpiece made from a pelt of a large bear."
 },
{"name" : "beret"                     , "layer" : "vanity", "min" : 1, "max" : 6, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Beret",
 "desc" :  "A fine cloth hat typically worn by the nobles.",
 "adesc" : "Includes a fine cloth hat."
 },
{"name" : "bull_horns"                     , "layer" : "vanity", "min" : 1, "max" : 21, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "bone", "invSound" : "bone",
 "title" :  "Bull Horns",
 "desc" :  "The horns of a wild beast, marking the user a competent hunter among the northern tribes.",
 "adesc" : "Includes a pair of bull horns."
 },
{"name" : "crown"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Crown",
 "desc" :  "An ornately designed symbol of kingly authority, commanding immediate respect among those born in lower castes.",
 "adesc" : "Includes a crown."
 },
{"name" : "faction_helmet"                     , "layer" : "vanity", "min" : 1, "max" : 10, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Faction Helm Ornament",
 "desc" :  "A lavish crested heraldic ornament of a noble house, leaving no doubt as to the wearer's allegiance.",
 "adesc" : "Includes a crested ornament of a noble house."
 },
{"name" : "rotten_faction_helmet"                     , "layer" : "vanity", "min" : 1, "max" : 8, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Decayed Faction Helm Ornament",
 "desc" :  "A crested ornament of a noble house tarnished by time and rot, a grim reminder that even the highborn are not exempt from the common fate of all mortals.",
 "adesc" : "Includes a decayed crested ornament of a noble house."
 },
{"name" : "faction_helmet_2"                     , "layer" : "vanity", "min" : 1, "max" : 10, "value" : 50, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Zweihander\'s Hat",
 "desc" :  "A slumped, feathered hat favoured by noble swordsman who value a dashing appearance as much as a sharp blade.",
 "adesc" : "Includes a feathered hat."
 },
{"name" : "feather_band"                     , "layer" : "vanity", "min" : 1, "max" : 12, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Feathered Headband",
 "desc" :  "A simple cloth headband adorned with a trio of upright feathers.",
 "adesc" : "Includes a feathered headband."
 },
{"name" : "feathered_hat"                     , "layer" : "vanity", "min" : 1, "max" : 9, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Feathered Hat",
 "desc" :  "A fancy hat decorated with a pair of vibrant feathers usually worn by minstrels or nobles.",
 "adesc" : "Includes a fancy feathered hat."
 },
{"name" : "goat_horns"                     , "layer" : "vanity", "min" : 1, "max" : 4, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "bone", "invSound" : "bone",
 "title" :  "Goat Horns",
 "desc" :  "A pair of tall horns of a mountain goat, an item of choice among barbarian beast tamers.",
 "adesc" : "Includes a pair of goat horns."
 },
{"name" : "headband"                     , "layer" : "vanity", "min" : 1, "max" : 17, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Headband",
 "desc" :  "A simple cloth headband, conveniently keeping the wearer's hair away from the eyes.",
 "adesc" : "Includes a cloth headband."
 },
{"name" : "horn_decorations"                     , "layer" : "vanity", "min" : 1, "max" : 2, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "bone", "invSound" : "bone",
 "title" :  "Horn Decorations",
 "desc" :  "Decorative horns, used in the northern tribes as a totem of strength.",
 "adesc" : "Includes a set of decorative horns."
 },
# {"name" : "hunter_cap"                     , "layer" : "vanity", "min" : 1, "max" : 17, "value" : 200, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
#  "title" :  "Hunter Cap", \
#  "desc" :  "The distinctive hat of a game hunter" \
# },
{"name" : "impaled_head"                     , "layer" : "vanity", "min" : 1, "max" : 5, "value" : 50, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Impaled Head",
 "desc" :  "The severed head of a fallen foe, pointed atop a helm as a gruesome trophy as a warning to any future foe.",
 "adesc" : "Includes a severed head impaled on a spike."
 },
# {"name" : "jester_hat"                     , "layer" : "vanity", "min" : 1, "max" : 65, "value" : 200, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
#  "title" :  "Jester Hat", \
#  "desc" :  "The quintessential hat of performing folk in noble court" \
# },
{"name" : "metal_bird"                     , "layer" : "vanity", "min" : 1, "max" : 8, "value" : 100, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Metal Bird",
 "desc" :  "An ancient metal bird ornament, its carefully crafted shape and intricate details a testament to the skill of its maker.",
 "adesc" : "Includes an ancient bird ornament."
 },
{"name" : "noble_buckle"                     , "layer" : "vanity", "min" : 1, "max" : 5, "value" : 10, "con" : 2, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Noble Buckle",
 "desc" :  "A finely wrought golden buckle used to adorn noble headwear.",
 "adesc" : "Includes a golden buckle."
 },
{"name" : "noble_feather"                     , "layer" : "vanity", "min" : 1, "max" : 5, "value" : 10, "con" : 2, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Noble Feather",
 "desc" :  "A cluster of rich, decorative feathers worn by nobles in their headwear.",
 "adesc" : "Includes cluster a rich feathers."
 },
{"name" : "noble_floppy_hat"                     , "layer" : "vanity", "min" : 1, "max" : 8, "value" : 50, "con" : 8, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Floppy Noble Hat",
 "desc" :  "A fashionable fabric hat with a golden band, usually worn by the aristocrats.",
 "adesc" : "Includes a fashionable fabric hat."
 },
{"name" : "noble_hat"                     , "layer" : "vanity", "min" : 1, "max" : 6, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Noble Hat",
 "desc" :  "A beautiful hat adorned with a set of richly hued feathers, held fast by a decorative band.",
 "adesc" : "Includes a hate adorned with a set of richly hued feathers."
 },
{"name" : "chaperon"                     , "layer" : "vanity", "min" : 1, "max" : 9, "value" : 200, "con" : 15, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Chaperon",
 "desc" :  "A dyed cloth piece of storied headwear adorning a questing knight on their path of atonement.",
 "adesc" : "Includes a dyed cloth headpiece."
 },
{"name" : "felt_chaperon"                     , "layer" : "vanity", "min" : 1, "max" : 9, "value" : 20, "con" : 5, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Felt Chaperon",
 "desc" :  "A simple wrap of felted cloth, extremely popular in the streets of the southern city-states.",
 "adesc" : "Includes a simple felted cloth headpiece."
 },
{"name" : "ancient_wig"                     , "layer" : "vanity", "min" : 1, "max" : 4, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Ancient Wig",
 "desc" :  "An wig of stiff fibers, taken from an ancient embalmed noble.",
 "adesc" : "Includes a wig."
 },
{"name" : "noble_hood"                     , "layer" : "vanity", "min" : 1, "max" : 11, "value" : 100, "con" : 7, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Noble Hood",
 "desc" :  "A hood of fine cloth decorated with gilded bosses.",
 "adesc" : "Includes a fine cloth hood."
 },
{"name" : "wreath"                     , "layer" : "vanity", "min" : 1, "max" : 4, "value" : 150, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Wreath",
 "desc" :  "A wreath of woven, metallic leaves, symbolizing the past triumphs of a long gone empire.",
 "adesc" : "Includes a wreath."
 },
{"name" : "orc_bones"                     , "layer" : "vanity", "min" : 1, "max" : 3, "value" : 20, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "bone", "invSound" : "bone",
 "title" :  "Orc Bones",
 "desc" :  "A jagged, intimidating arrangement of bones, fashioned by orcs into a grisly trophy.",
 "adesc" : "Includes an arrangement of bones."
 },
{"name" : "orc_great_horns"                     , "layer" : "vanity", "min" : 1, "max" : 4, "value" : 20, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "bone", "invSound" : "bone",
 "title" :  "Orc Great Horns",
 "desc" :  "A pair of enormous horns of a massive beast, worn by the largest of orcs.",
 "adesc" : "Includes a pair of enormous horns."
 },
{"name" : "plait"                     , "layer" : "vanity", "min" : 1, "max" : 12, "value" : 50, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Plait",
 "desc" :  "A decorative plait used to adorn helms.",
 "adesc" : "Includes a decorative plait."
 },
{"name" : "thick_braid"                     , "layer" : "vanity", "min" : 1, "max" : 6, "value" : 300, "con" : 20, "stam" : -1, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Torse",
 "desc" :  "A twisted roll of linen, commonly put on the top of helm to help identify a warrior during the battle.",
 "adesc" : "Includes a linen torse."
 },
{"name" : "rotten_thick_braid"                     , "layer" : "vanity", "min" : 1, "max" : 3, "value" : 200, "con" : 15, "stam" : -1, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Rotten Torse",
 "desc" :  "An old mouldy linen torse, its fabric brittle and colors faded.",
 "adesc" : "Includes a decayed linen torse."
 },
{"name" : "ram_horns"                     , "layer" : "vanity", "min" : 1, "max" : 6, "value" : 50, "con" : 6, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "bone", "invSound" : "bone",
 "title" :  "Ram Horns",
 "desc" :  "A pair of curled horns of a wild beast, used as a sign of competency in northern tribes.",
 "adesc" : "Includes a pair of curled horns."
 },
{"name" : "side_feather"                     , "layer" : "vanity", "min" : 1, "max" : 6, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Side Feather",
 "desc" :  "A decorative feather clasped on hats.",
 "adesc" : "Includes a decorative feather."
 },
{"name" : "southern_headband"                     , "layer" : "vanity", "min" : 1, "max" : 6, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Headband",
 "desc" :  "A beautiful cloth headband from southern lands where dyes are plentiful.",
 "adesc" : "Includes a cloth headband."
 },
{"name" : "southern_patterned_headband"                     , "layer" : "vanity", "min" : 1, "max" : 7, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Patterned Headband",
 "desc" :  "A patterned cloth headband with a simple pattern, favoured by southern merchants.",
 "adesc" : "Includes a patterned cloth headband."
 },
{"name" : "southern_patterned_headwrap"                     , "layer" : "vanity", "min" : 1, "max" : 11, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Patterned Head Wrap",
 "desc" :  "A patterned cloth head wrap made by southern tailors.",
 "adesc" : "Includes a patterned cloth head wrap."
 },
{"name" : "southern_turban_open"                     , "layer" : "vanity", "min" : 1, "max" : 6, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Open Turban",
 "desc" :  "A large linen turban, worn to protect the head from the overbearing sun.",
 "adesc" : "Includes a large linen turban."
 },
{"name" : "southern_turban_patterned"                     , "layer" : "vanity", "min" : 1, "max" : 8, "value" : 30, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Patterned Turban",
 "desc" :  "A common turban with dyed pattern. Common among travelers looking to keep the sun off their necks.",
 "adesc" : "Includes a patterned turban."
 },
{"name" : "southern_turban_full"                     , "layer" : "vanity", "min" : 1, "max" : 6, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Full Turban",
 "desc" :  "A voluminous linen turban, providing ample protection from the southern sun.",
 "adesc" : "Includes a voluminous linen turban."
 },
{"name" : "southern_turban_light"                     , "layer" : "vanity", "min" : 1, "max" : 7, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Light Turban",
 "desc" :  "A simple turban made of light materials, perfect for desert heat.",
 "adesc" : "Includes a simple turban."
 },
{"name" : "southern_turban_feather"                     , "layer" : "vanity", "min" : 1, "max" : 5, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Head Wrap",
 "desc" :  "A southern head wrap topped by a decorative feather.",
 "adesc" : "Includes a feathered head wrap."
 },
{"name" : "straw_hat"                     , "layer" : "vanity", "min" : 1, "max" : 3, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Straw Hat",
 "desc" :  "A simple straw hat, often used by farmers and peasants.",
 "adesc" : "Includes a straw hat."
 },
# {"name" : "witchhunter_helm"                     , "layer" : "vanity", "min" : 1, "max" : 7, "value" : 200, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
#  "title" :  "Witchhunter Helm", \
#  "desc" :  "A tough leather hat that provides decent protection against scratches." \
# },
{"name" : "wizard_cowl"                     , "layer" : "vanity", "min" : 1, "max" : 21, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Wizard's Cowl",
 "desc" :  "A weathered pointy hat with a broad rim. Typically used by charlatans and fortune tellers trying to look the part, though a real wizard could actually wear one.",
 "adesc" : "Includes a pointy hat."
 },
{"name" : "undertakers_hat"                     , "layer" : "vanity", "min" : 1, "max" : 3, "value" : 50, "con" : 12, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Undertaker's Hat",
 "desc" :  "A wide-brimmed feathered hat, a practical choice for those whose work continues regardless of the weather.",
 "adesc" : "Includes a wide-brimmed feathered hat."
 },
{"name" : "wolf_helm"                     , "layer" : "vanity", "min" : 1, "max" : 3, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Wolf Helm",
 "desc" :  "An impressive pelt of a dire wolf made into a head covering.",
 "adesc" : "Includes a dire wolf pelt head covering."
 },
{"name" : "lion_pelt"                     , "layer" : "vanity", "min" : 1, "max" : 5, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "leather",
 "title" :  "Lion Pelt",
 "desc" :  "A luxurious pelt of a rare beast, turned by a taxidermist into a regal head covering.",
 "adesc" : "Includes a lion's pelt head covering."
 },
# {"name" : "white_wolf_helm"                     , "layer" : "vanity", "min" : 1, "max" : 2, "value" : 200, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
#  "title" :  "White Wolf Helm", \
#  "desc" :  "The trophy of a white wolf head." \
# },
{"name" : "royal_hood"                     , "layer" : "vanity", "min" : 1, "max" : 7, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Royal Hood",
 "desc" :  "The ornate hood of distant royalty, made from the finest materials. Despite having fallen into hands of lesser men, it retains some of its former succulence.",
 "adesc" : "Includes an ornate hood."
 },
{"name" : "physicians_hood"                     , "layer" : "vanity", "min" : 1, "max" : 7, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Physician's Hood",
 "desc" :  "A thick hood designed to keep out splatters and vapours.",
 "adesc" : "Includes a thick hood."
 },
{"name" : "mummy_headress"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Ancient Southern Headdress",
 "desc" :  "A headdress adorned with a idol resembling the sun, looted from a tomb of a long dead civilization.",
 "adesc" : "Includes an ancient ritualistic headdress."
 },
{"name" : "mummy_headband"                     , "layer" : "vanity", "min" : 1, "max" : 7, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Ancient Southern Headband",
 "desc" :  "A thin serpent headband that has lost much of its luster over the centuries.",
 "adesc" : "Includes an ancient serpent headband."
 },
{"name" : "southern_cloth_headress"                     , "layer" : "vanity", "min" : 1, "max" : 7, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Cloth Headdress",
 "desc" :  "A fashionable southern headdress made of soft fabrics, effectively mimicking the finery of the high courts.",
 "adesc" : "Includes a fashionable southern headdress."
 },
{"name" : "southern_veil"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 20, "con" : 2, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Veil",
 "desc" :  "A thin, wispy southern veil.",
 "adesc" : "Includes a thin veil."
 },
{"name" : "southern_earings"                     , "layer" : "vanity", "min" : 1, "max" : 4, "value" : 20, "con" : 2, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Earrings",
 "desc" :  "A pair of delicate southern metal earrings.",
 "adesc" : "Includes a pair of earrings."
 },
{"name" : "southern_headress_coin"                     , "layer" : "vanity", "min" : 1, "max" : 6, "value" : 50, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Coin Headband",
 "desc" :  "A southern headdress adorned with coins. Typically worn by entertainers, designed to catch the light and the ear of onlookers.",
 "adesc" : "Includes a southern headdress adorned with coins."
 },

# {"name" : "lindwurm_helm"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 200, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
#  "title" :  "Lindwurm Helm", \
#  "desc" :  "Lindwurm Helm" \
# },
# {"name" : "redback_helm"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 200, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
#  "title" :  "Redback Helm", \
#  "desc" :  "A sturdy yet light helm made from the carapace of a redback spider." \
# },
{"name" : "nun_habit"                     , "layer" : "vanity", "min" : 1, "max" : 7, "value" : 10, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Nun's Habit",
 "desc" :  "A modest head covering of the women of the cloth, its white lining symboling purity and innocence.",
 "adesc" : "Includes a nun habit."
 },
# {"name" : "nach_helm"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 200, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
#  "title" :  "Nacho Helm", \
#  "desc" :  "A trophy made from the face of a skin ghoul." \
# },
# {"name" : "mountain_helm"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 200, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
#  "title" :  "Mountain Helm", \
#  "desc" :  "A helm crafted from the skin and skull of a mighty rock unhold, the beast may be dead, but it continues to mend itself even after death" \
# },
# {"name" : "demon_alp_helm"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 200, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
#  "title" :  "Demon Alp Helm", \
#  "desc" :  "A trophy made from the face of a demon" \
# },
{"name" : "warlock_hood"                     ,"itemType" : "this.Const.Items.ItemType.Cultist", "layer" : "vanity", "min" : 1, "max" : 5, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Warlock's Hood",
 "desc" :  "A tattered hood of discolored fabric. Counts as a cultist item.",
 "adesc" : "Includes a tattered hood."
 },
{"name" : "goblin_bones"                     , "layer" : "vanity", "min" : 1, "max" : 6, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "bone", "invSound" : "bone",
 "title" :  "Goblin Bones",
 "desc" :  "A ritualistic skull ornament etched with arcane symbols. Used by greenskin shamans both as a focus for primal spirits and a terrifying mark of tribal authority.",
 "adesc" : "Includes a skull ornament etched with arcane symbols."
 },
{"name" : "ancient_priest_hat"                     , "layer" : "vanity", "min" : 1, "max" : 8, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Ancient Lich Crown",
 "desc" :  "A ceremonial crown that has endured the passage of time. It still carries the authority of ancient Lich Priests.",
 "adesc" : "Includes an ancient ceremonial crown."
 },
{"name" : "fencer_hat"                     , "layer" : "vanity", "min" : 1, "max" : 15, "value" : 50, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Fencer Hat",
 "desc" :  "The floppy hat of a swordsman.",
 "adesc" : "A floppy hat."
 },
{"name" : "mummy_crown"                     , "layer" : "vanity", "min" : 1, "max" : 7, "value" : 50, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Ancient Southern Crown",
 "desc" :  "A tall, once-majestic crown. Years of intense desert sun have left it desiccated and scarred.",
 "adesc" : "Includes a tall, ancient crown."
 },
{"name" : "mummy_crown_king"                     , "layer" : "vanity", "min" : 1, "max" : 8, "value" : 100, "con" : 15, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "plate", "invSound" : "plate",
 "title" :  "Ancient Southern Crested Crown",
 "desc" :  "A lion crested crown belonging to a king of a long dead civilization.",
 "adesc" : "Includes a lion crested crown."
 },
 {"name" : "fleshcultist_book"                  , "layer" : "vanity", "min" : 1, "max" : 9, "value" : 100, "con" : 15, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
  "title" :  "Fleshcultist Book",
  "desc" :  "An old book strapped to the head that once belonged to a twisted flesh cultist, every page of the book is blank.",
  "adesc" : "Includes a book strapped to the head."
},
{"name" : "fleshcultist_straps"                  , "layer" : "vanity", "min" : 1, "max" : 5, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
  "title" :  "Fleshcultist Straps",
  "desc" :  "A spattering of supple leather straps that once belonged to a twisted flesh cultist.",
  "adesc" : "Includes some leather straps."
},

### Vanity - lower

{"name" : "back_crest"                     , "layer" : "vanity", "lower" : True, "min" : 1, "max" : 4, "value" : 50, "con" : 3, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Crest",
 "desc" :  "A huge crest of colorful feathers arrayed behind a helm.",
 "adesc" : "Includes a crest of colorful feathers."
 },
{"name" : "back_feathers"                     , "layer" : "vanity", "lower" : True, "min" : 1, "max" : 4, "value" : 50, "con" : 3, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Feathers",
 "desc" :  "A set of rich feathers to be displayed behind a helm.",
 "adesc" : "Includes a set of rich feathers."
 },
{"name" : "feather_crest"                     , "layer" : "vanity", "lower" : True, "min" : 1, "max" : 5, "value" : 50, "con" : 3, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Feather Crest",
 "desc" :  "A fan of large feathers to be displayed behind a helm.",
 "adesc" : "Includes a fan of large feathers."
 },
{"name" : "knotted_tail"                     , "layer" : "vanity", "lower" : True, "min" : 1, "max" : 4, "value" : 30, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Knotted Tail",
 "desc" :  "A knotted pony tail. A sign of prowess in some of the lands.",
 "adesc" : "Includes a knotted pony tail."
 },
{"name" : "orc_tail"                     , "layer" : "vanity", "lower" : True, "min" : 1, "max" : 7, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Orc Tail",
 "desc" :  "A thick tail of hair decorated with bone pieces. A symbol of status among the orcs.",
 "adesc" : "Includes a thick tail of hair."
 },
 {"name" : "ponytail"                     , "layer" : "vanity", "lower" : True, "min" : 1, "max" : 4, "value" : 50, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Ponytail",
 "desc" :  "A long tail of horsehair used to crest helms.",
 "adesc" : "Includes a horsehair ponytail."
 },
 {"name" : "southern_top_tail"                     , "layer" : "vanity", "lower" : True, "min" : 1, "max" : 8, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Southern Top Tail",
 "desc" :  "A decorative tail made of desert animal hair.",
 "adesc" : "Includes a decorative animal hair tail."
 },
{"name" : "top_plume"                     , "layer" : "vanity", "lower" : True, "min" : 1, "max" : 6, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Top Plume",
 "desc" :  "A sleek plume of light hair designed to crest a helm.",
 "adesc" : "Includes a plume of hair."
 },
 {"name" : "top_feather"                     , "layer" : "vanity", "lower" : True, "min" : 1, "max" : 5, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Top Feather",
 "desc" :  "A short, decorative feather that can be pinned on a hat to add a dash of color.",
 "adesc" : "Includes a short, decorative feather."
 },
{"name" : "wings"                     , "layer" : "vanity", "lower" : True, "min" : 1, "max" : 6, "value" : 20, "con" : 2, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Wings",
 "desc" :  "A set of feathers arrayed on supports to form wings.",
 "adesc" : "Includes a set of feathers in the form of wings."
 },
{"name" : "goblin_tail"                     , "layer" : "vanity", "lower" : True, "min" : 1, "max" : 4, "value" : 20, "con" : 3, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false", "impactSound" : "leather", "invSound" : "cloth",
 "title" :  "Goblin Tail",
 "desc" :  "A wiry plume of matted dark hair used by a goblin to crest a helm.",
 "adesc" : ""
 },
]