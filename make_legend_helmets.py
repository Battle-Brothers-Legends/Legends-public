
from string import Template
from shutil import copyfile
import os

vanilla = [
    "aketon_cap",
    "ancient/ancient_gladiator_helmet",
    "ancient/ancient_honorguard_helmet",
    "ancient/ancient_household_helmet",
    "ancient/ancient_laurels",
    "ancient/ancient_legionary_helmet",
    "ancient/ancient_priest_diadem",
    "ancient/legend_ancient_legionary_helmet_restored",
    "ancient/legend_mummy_beard",
    "ancient/legend_mummy_bandage",
    "ancient/legend_mummy_crown_king",
    "ancient/legend_mummy_crown",
    "ancient/legend_mummy_headband",
    "ancient/legend_mummy_headress",
    "barbarians/barbarian_ritual_helmet",
    "barbarians/bear_headpiece",
    "barbarians/beastmasters_headpiece",
    "barbarians/closed_scrap_metal_helmet",
    "barbarians/crude_faceguard_helmet",
    "barbarians/crude_metal_helmet",
    "barbarians/heavy_horned_plate_helmet",
    "barbarians/leather_headband",
    "barbarians/leather_helmet",
    "barbarians/unhold_helmet_heavy",
    "barbarians/unhold_helmet_light",
    "barbute_helmet",
    "bascinet_with_mail",
    "closed_flat_top_helmet",
    "closed_flat_top_with_mail",
    "closed_flat_top_with_neckguard",
    "closed_mail_coif",
    "conic_helmet_with_closed_mail",
    "conic_helmet_with_faceguard",
    "cultist_hood",
    "cultist_leather_hood",
    "dark_cowl",
    "decayed_closed_flat_top_with_mail",
    "decayed_closed_flat_top_with_sack",
    "decayed_full_helm",
    "decayed_great_helm",
    "dented_nasal_helmet",
    "faction_helm",
    "feathered_hat",
    "flat_top_helmet",
    "flat_top_with_closed_mail",
    "flat_top_with_mail",
    "full_aketon_cap",
    "full_helm",
    "full_leather_cap",
    "greatsword_faction_helm",
    "greatsword_hat",
    "greenskins/goblin_heavy_helmet",
    "greenskins/goblin_leader_helmet",
    "greenskins/goblin_light_helmet",
    "greenskins/goblin_shaman_helmet",
    "greenskins/goblin_skirmisher_helmet",
    "greenskins/legend_orc_behemoth_helmet",
    "greenskins/orc_berserker_helmet",
    "greenskins/orc_elite_heavy_helmet",
    "greenskins/orc_warlord_helmet",
    "greenskins/orc_warrior_heavy_helmet",
    "greenskins/orc_warrior_light_helmet",
    "greenskins/orc_warrior_medium_helmet",
    "greenskins/orc_young_heavy_helmet",
    "greenskins/orc_young_light_helmet",
    "greenskins/orc_young_medium_helmet",
    "headscarf",
    "hood",
    "hunters_hat",
    "jesters_hat",
    "kettle_hat",
    "kettle_hat_with_closed_mail",
    "kettle_hat_with_mail",
    "legend_earings",
    "legend_frogmouth_helm",
    "legend_frogmouth_helm_crested",
    "legend_headband_coin",
    "legend_headress_coin",
    "legend_noble_crown",
    "legend_noble_hood",
    "legend_noble_hat",
    "legend_noble_southern_crown",
    "legend_noble_southern_hat",
    "legend_nun_habit",
    "legend_seer_hat",
    "legend_southern_cloth_headress",
    "legend_southern_veil_coin",
    "legend_southern_veil",
    "legend_vampire_lord_helmet",
    "legend_warlock_hood",
    "legendary/legend_emperors_countenance",
    "legendary/fangshire",
    "legendary/legend_ijirok_helmet",
    "legendary/legend_demonalp_helmet",
    "legendary/legend_mountain_helmet",
    "legendary/legend_redback_helmet",
    "legendary/legend_skin_helmet",
    "legendary/legend_stollwurm_helmet",
    "legendary/legend_white_wolf_helmet",
    "legendary/mask_of_davkul",
    "magician_hat",
    "mail_coif",
    "mouth_piece",
    "named/death_jesters_helm",
    "named/golden_feathers_helmet",
    "named/heraldic_mail_helmet",
    "named/jugglers_hat",
    "named/jugglers_padded_hat",
    "named/legend_frogmouth_helm_crested_painted",
    "named/legend_frogmouth_helm_decorated",
    "named/legend_mountain_helmet_named",
    "named/legend_named_warlock_hood",
    "named/lindwurm_helmet",
    "named/named_conic_helmet_with_faceguard",
    "named/named_helmet",
    "named/named_metal_bull_helmet",
    "named/named_metal_nose_horn_helmet",
    "named/named_metal_skull_helmet",
    "named/named_nordic_helmet_with_closed_mail",
    "named/named_steppe_helmet_with_mail",
    "named/nasal_feather_helmet",
    "named/norse_helmet",
    "named/sallet_green_helmet",
    "named/witchhunter_helm",
    "named/wolf_helmet",
    "named/italo_norman_helm_named",
    "named/barbute_named",
    "named/bascinet_named",
    "named/kettle_helm_named",
    "named/wallace_sallet_named",
    "nasal_helmet",
    "nasal_helmet_with_closed_mail",
    "nasal_helmet_with_mail",
    "nasal_helmet_with_rusty_mail",
    "necromancer_hat",
    "noble_arrow_helm",
    "noble_bull_helm",
    "noble_castle_helm",
    "noble_deer_helm",
    "noble_dragon_helm",
    "noble_feather_helm",
    "noble_fish_helm",
    "noble_headgear",
    "noble_lion_helm",
    "noble_sun_helm",
    "noble_swan_helm",
    "nordic_helmet",
    "nordic_helmet_with_closed_mail",
    "open_leather_cap",
    "padded_flat_top_helmet",
    "padded_kettle_hat",
    "padded_nasal_helmet",
    "reinforced_mail_coif",
    "rusty_mail_coif",
    "sallet_helmet",
    "steppe_helmet_with_mail",
    "straw_hat",
    "witchhunter_hat",
    "wizard_hat"
]



Names = "this.Const.Strings.LegendArmorLayers"

HelmObj = '''{
    ID = "$id", //$value
    Script = "",
    Sets = [{
        Hoods = [
        ],
        Helms = [
        ],
        Tops = [
        ],
        Vanity = [
        ]
    }]
},'''

BaseLayer = '''
this.$name <- this.inherit("scripts/items/legend_helmets/legend_helmet", {
	m = {},
	function create()
	{
		this.legend_helmet.create();
		this.m.ID = "$id";
		this.m.Name = "$title";
		this.m.Description = "$desc";
		this.m.Variants = $variants;
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = $value;
		this.m.Condition = $condition;
		this.m.ConditionMax = $condition;
		this.m.StaminaModifier = $stamina;
		this.m.Vision = $vision;
		this.m.HideHair = $hair;
		this.m.HideBeard = $beard;
        this.m.ItemType = $itemType;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "$brush" + "_" + variant;
		this.m.SpriteDamaged = "$brush" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "$brush" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/$icon" + "_" + variant + ".png";
        this.m.IconLarge = this.m.Icon;
	}
});
'''

Layer = '''
this.$name <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.$type;
		this.m.ID = "$id";
		this.m.Name = "$title";
		this.m.Description = "$desc";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = $variants;
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = $value;
		this.m.Condition = $condition;
		this.m.ConditionMax = $condition;
		this.m.StaminaModifier = $stamina;
		this.m.Vision = $vision;
		this.m.IsLowerVanity = $lower;
		this.m.HideHair = $hair;
		this.m.HideBeard = $beard;
        this.m.ItemType = $itemType;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "$brush" + "_" + variant;
		this.m.SpriteDamaged = "$brush" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "$brush" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/$icon" + "_" + variant + ".png";
        this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}
});
'''

NamedLayer = '''
this.$name <- this.inherit("scripts/items/legend_helmets/legend_named_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.$type;
		this.m.ID = "$id";
        this.m.NameList = $names;
		this.m.Description = "$desc";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = $variants;
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = $value;
		this.m.Condition = $condition;
		this.m.ConditionMax = $condition;
		this.m.StaminaModifier = $stamina;
		this.m.Vision = $vision;
		this.m.IsLowerVanity = $lower;
		this.m.HideHair = $hair;
		this.m.HideBeard = $beard;
        this.m.ItemType = $itemType;
        this.randomizeValues();
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "$brush" + "_" + variant;
		this.m.SpriteDamaged = "$brush" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "$brush" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/$icon" + "_" + variant + ".png";
        this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

	function randomizeValues()
	{
        this.m.Vision = this.Math.rand($rmaxViz, $rminViz) * -1 ;
		this.m.StaminaModifier = this.Math.rand($rmaxStam, $rminStam) * -1;
		this.m.Condition = this.Math.rand($rminCond, $rmaxCond);
		this.m.ConditionMax = this.m.Condition;
	}
});
'''

BLayer = '<sprite id="$name" offsetY="35" f="64F0" ic="FF4E5053" width="184" height="222" img="$name_path" left="-67" right="68" top="-40" bottom="108" />\n'
BLayerDamaged = '<sprite id="$damaged" offsetY="35" f="64F0" ic="FF4B4D51" width="184" height="222" img="$damaged_path" left="-67" right="68" top="-40" bottom="108" />\n'
BLayerDead = '<sprite id="$dead" offsetX="6" offsetY="10" f="64F0" ic="FF222933" width="131" height="125" img="$dead_path" left="-57" right="59" top="-53" bottom="55" />\n'

brush_only_layers = [
    {"name": "hunter_cap", "min" : 1, "max" : 1, "layer": "vanity"},
    {"name": "pimp_hat", "min" : 1, "max" : 1, "layer": "vanity"},
    {"name": "jester_hat", "min" : 1, "max" : 64, "layer": "vanity"},
    {"name": "witchhunter_helm", "min" : 1, "max" : 7, "layer" : "vanity"},
    {"name": "white_wolf_helm", "min" : 1, "max" : 1, "layer": "vanity"},
    {"name": "lindwurm_helm", "min" : 1, "max" : 1, "layer": "vanity"},
    {"name": "redback_helm", "min" : 1, "max" : 1, "layer": "vanity"},
    {"name": "nach_helm", "min" : 1, "max" : 1, "layer": "vanity"},
    {"name": "mountain_helm", "min" : 1, "max" : 1, "layer": "vanity"},
    {"name": "demon_alp_helm", "min" : 1, "max" : 1, "layer": "vanity"}
]

aLayer = '''$stats
 "title" :  "$title", \\
 "desc" :  "$desc" \\
},'''

layers = [
{"name" : "goblin_scarf"                     , "layer" : "hood", "min" : 1, "max" : 4, "base" : True, "value" : 5, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Goblin Scarf", \
 "desc" :  "Goblin Scarf." \
},
{"name" : "barb_chain_scarf"                     , "layer" : "hood", "min" : 1, "max" : 6, "base" : True, "value" : 125, "con" : 55, "stam" : -3, "vis" : 0, "hair" : "false", "beard" : "true",  \
 "title" :  "Rusted Aventail", \
 "desc" :  "A rusty mail aventail that still offers good protection - it leaves horrible stains though." \
},
{"name" : "barb_open_chain"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 225, "con" : 65, "stam" : -3, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Rusted Open Chain", \
 "desc" :  "A rusty open faced mail chain patched together by the northern tribes." \
},
{"name" : "rotten_chain_scarf"                     , "layer" : "hood", "min" : 1, "max" : 5, "base" : True, "value" : 80, "con" : 50, "stam" : -3, "vis" : 0, "hair" : "false", "beard" : "true",  \
 "title" :  "Rotten Aventail", \
 "desc" :  "A rotten mail aventail that extends from below the eyeline to cover the neck." \
},
{"name" : "cloth_scarf"                     , "layer" : "hood", "min" : 1, "max" : 5, "base" : True, "value" : 10, "con" : 15, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "true",  \
 "title" :  "Cloth Scarf", \
 "desc" :  "Cloth Scarf." \
},
{"name" : "cloth_bandana"                     , "layer" : "hood", "min" : 1, "max" : 5, "base" : True, "value" : 20, "con" : 15, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Headscarf", \
 "desc" :  "A thick piece of cloth wrapped around the head." \
},
{"name" : "patched_hood"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 45, "con" : 25, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Patched Hood", \
 "desc" :  "Patched Hood." \
},
{"name" : "simple_hood"                     , "layer" : "hood", "min" : 1, "max" : 5, "base" : True, "value" : 50, "con" : 30, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Simple Hood", \
 "desc" :  "A simple hood to protect against weather and scratches." \
},


{"name" : "leather_cap"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 75, "con" : 35, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Leather Cap", \
 "desc" :  "A sturdy leather cap that is not covering the ears and neck." \
},
{"name" : "padded_cap"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 90, "con" : 40, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Aketon Cap", \
 "desc" :  "A padded cloth cap." \
},
{"name" : "leather_hood"                     , "itemType" : "this.Const.Items.ItemType.Cultist", "layer" : "hood", "min" : 1, "max" : 5, "base" : True, "value" : 110, "con" : 45, "stam" : -2, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Leather Hood", \
 "desc" :  "A closed leather cap that protects the head and neck. Padded for extra protection." \
},
{"name" : "beak_hood"                     , "itemType" : "this.Const.Items.ItemType.Cultist", "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 150, "con" : 65, "stam" : -3, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Beaked Hood", \
 "desc" :  "A thick leather hood with a distinctive, bird-like mask. The beak acts as a ventilator, containing sweet-smelling herbs to ward away sickness and disease." \
},
{"name" : "padded_hood"                     , "layer" : "hood", "min" : 1, "max" : 3, "base" : True, "value" : 115, "con" : 50, "stam" : -2, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Full Aketon Cap", \
 "desc" :  "A large padded cloth cap also covering the neck." \
},
{"name" : "southern_cap"                     , "layer" : "hood", "min" : 1, "max" : 8, "base" : True, "value" : 30, "con" : 20, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Southern Cap", \
 "desc" :  "A simple cap of rough fibres." \
},
{"name" : "southern_cap_dark"                , "layer" : "hood", "min" : 1, "max" : 6, "base" : True, "value" : 30, "con" : 20, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Southern Cap", \
 "desc" :  "A simple cap of rough fibres." \
},
{"name" : "southern_turban_light_hood"       , "layer" : "hood", "min" : 1, "max" : 6, "base" : True, "value" : 90, "con" : 40, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Southern light hood", \
 "desc" :  "A southern hood made of light materials." \
},
{"name" : "southern_niqaab"                     , "layer" : "hood", "min" : 1, "max" : 4, "base" : True, "value" : 300, "con" : 45, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "true",  \
 "title" :  "Niqaab", \
 "desc" :  "A headwrap, protects from the sun and light blows." \
},
{"name" : "full_mask"                           , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 50, "con" : 25, "stam" : -1, "vis" : -1, "hair" : "true", "beard" : "true",  \
 "title" :  "Full Cloth Mask", \
 "desc" :  "An ominous black mask to cover the face" \
},
{"name" : "open_chain_hood"                     , "layer" : "hood", "min" : 1, "max" : 3, "base" : True, "value" : 225, "con" : 65, "stam" : -3, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Chain Mail Hood", \
 "desc" :  "A hood made of chainmail. Offer good protection and visibility." \
},
{"name" : "chain_scarf"                     , "layer" : "hood", "min" : 1, "max" : 5, "base" : True, "value" : 150, "con" : 55, "stam" : -3, "vis" : 0, "hair" : "false", "beard" : "true",  \
 "title" :  "Aventail", \
 "desc" :  "A mail aventail that extends from below the eyeline to cover the neck." \
},
{"name" : "aventail"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 150, "con" : 60, "stam" : -3, "vis" : 0, "hair" : "false", "beard" : "true",  \
 "title" :  "Aventail", \
 "desc" :  "A mail aventail that extends from below the eyeline to cover the neck and lower face." \
},
{"name" : "rusty_chain_hood"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 150, "con" : 70, "stam" : -4, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Rusty Mail Coif", \
 "desc" :  "A rusty mail coif that still offers good protection - it leaves horrible stains though." \
},
{"name" : "chain_hood"                     , "layer" : "hood", "min" : 1, "max" : 4, "base" : True, "value" : 300, "con" : 75, "stam" : -4, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Mail Coif", \
 "desc" :  "A sturdy chain hood." \
},
{"name" : "chain_hood_full"                     , "layer" : "hood", "min" : 1, "max" : 6, "base" : True, "value" : 400, "con" : 80, "stam" : -4, "vis" : 0, "hair" : "true", "beard" : "true",  \
 "title" :  "Full Mail Coif", \
 "desc" :  "A mail coif that also protects the neck." \
},
{"name" : "mail_coif"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 450, "con" : 85, "stam" : -5, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Heavy Mail Coif", \
 "desc" :  "A full mail coif, heavier and sturdier than most others of its kind." \
},
{"name" : "bronze_chain"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 600, "con" : 90, "stam" : -6, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Bronze Chain", \
 "desc" :  "Bronze Chain." \
},
{"name" : "enclave_bevor"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 750, "con" : 95, "stam" : -7, "vis" : 0, "hair" : "false", "beard" : "true",  \
 "title" :  "Bevor", \
 "desc" :  "A solid metal bevor." \
},
{"name" : "southern_chain_hood"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 260, "con" : 75, "stam" : -4, "vis" : 0, "hair" : "false", "beard" : "true",  \
 "title" :  "Southern Mail Hood", \
 "desc" :  "A Mail Hood of southern design." \
},
{"name" : "southern_open_chain_hood"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 200, "con" : 65, "stam" : -3, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Southern Chain Mail Hood", \
 "desc" :  "An open mail hood of southern design." \
},
{"name" : "southern_open_hood"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 90, "con" : 40, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Southern Hood", \
 "desc" :  "A southern hood made of cloth that wraps around the head." \
},
{"name" : "cloth_cap"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 10, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Cloth Cap", \
 "desc" :  "A piece of cloth covering the top of the head." \
},
{"name" : "barb_leather_cap"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 55, "con" : 25, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Patched Leather Cap", \
 "desc" :  "A piece of patched leather covering the top of the head." \
},
{"name" : "southern_headband_coin"                     , "layer" : "hood", "min" : 1, "max" : 1, "base" : True, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Southern Coin Headband", \
 "desc" :  "A southern headband of coins strung together." \
},
{"name" : "mummy_bandage"                     , "layer" : "hood", "min" : 1, "max" : 2, "base" : True, "value" : 5, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "true",  \
 "title" :  "Ancient Southern Facemask", \
 "desc" :  "Wrappings from a long dead embalmed corpse." \
},




{"name" : "ancient_conic_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 200, "con" : 60, "stam" : -6, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Ancient Conic Helm", \
 "desc" :  "Conic Helm of an ancient household guard." \
},
{"name" : "ancient_kettle"                     , "layer" : "helm", "min" : 1, "max" : 3, "value" : 200, "con" : 60, "stam" : -6, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Ancient Kettle", \
 "desc" :  "A kettle helm from an ancient honor guard." \
},
{"name" : "ancient_dome"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 200, "con" : 60, "stam" : -6, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Ancient Dome", \
 "desc" :  "A domed helm of an ancient household guard." \
},
{"name" : "ancient_crested"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 200, "con" : 60, "stam" : -6, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Ancient Crested Helm", \
 "desc" :  "Crested Helm of an ancient honor guard." \
},
{"name" : "ancient_dome_tailed"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 350, "con" : 95, "stam" : -9, "vis" : -2, "hair" : "true", "beard" : "false",  \
 "title" :  "Tailed Ancient Dome", \
 "desc" :  "A domed and tailed helm of an ancient household guard." \
},
{"name" : "ancient_face_plate"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 350, "con" : 95, "stam" : -9, "vis" : -2, "hair" : "true", "beard" : "false",  \
 "title" :  "Ancient Face Plate", \
 "desc" :  "The protective helm of an ancient legionary." \
},
{"name" : "ancient_legionaire"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 350, "con" : 95, "stam" : -9, "vis" : -2, "hair" : "true", "beard" : "false",  \
 "title" :  "Ancient Legionaire Helm", \
 "desc" :  "The helm of an ancient legionary." \
},
{"name" : "ancient_side_hawk"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 350, "con" : 95, "stam" : -9, "vis" : -2, "hair" : "true", "beard" : "false",  \
 "title" :  "Ancient Side Hawk", \
 "desc" :  "The conic helm of an ancient legionary." \
},
{"name" : "ancient_tailed_conic_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 350, "con" : 95, "stam" : -9, "vis" : -2, "hair" : "true", "beard" : "false",  \
 "title" :  "Tailed Ancient Conic Helm", \
 "desc" :  "The tailed conic helm of an ancient legionary." \
},

{"name" : "ancient_face_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 500, "con" : 120, "stam" : -10, "vis" : -2, "hair" : "true", "beard" : "false",  \
 "title" :  "Ancient Face Helm", \
 "desc" :  "A helm of an ancient honor guard." \
},

{"name" : "orc_strapped_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 400, "con" : 160, "stam" : -18, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Orc Looted Nasal Helm", \
 "desc" :  "An orc helm made of a looted nasal helm." \
},
{"name" : "orc_double_helm"                     , "layer" : "helm", "min" : 1, "max" : 2, "value" :1000, "con" : 190, "stam" : -22, "vis" : -3, "hair" : "true", "beard" : "false",  \
 "title" : "Orc Looted Kettle Hat", \
 "desc" :  "A simplistic orc helm made from two kettle hats tied together and reinforced with additional chain." \
},
{"name" : "orc_elite_double_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 1500, "con" : 225, "stam" : -25, "vis" : -3, "hair" : "true", "beard" : "false",  \
 "title" :  "Orc Reinforced Looted Kettle Hat", \
 "desc" :  "An orc helm made from two kettle hats tied together and reinforced with additional chain. Craftsmanship is exceptional for orc armor." \
},
{"name" : "orc_scale_helm"                     , "layer" : "helm", "min" : 1, "max" : 2, "value" : 1200, "con" : 250, "stam" : -30, "vis" : -3, "hair" : "true", "beard" : "false",  \
 "title" :  "Orc Looted Scale Plate Helm", \
 "desc" :  "An orc helm made from looted heavy plated helmets, patched and forged together." \
},
{"name" : "orc_great_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 3000, "con" : 280, "stam" : -32, "vis" : -4, "hair" : "true", "beard" : "false",  \
 "title" :  "Orc Great Helm", \
 "desc" :  "The distinctive helm of an orc warlord." \
},
{"name" : "orc_behemoth_helmet"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 600, "con" : 180, "stam" : -20, "vis" : -2, "hair" : "true", "beard" : "false",  \
 "title" :  "Orc Behemoth Helm", \
 "desc" :  "The distinctive helm of an orc behemoth." \
},
{"name" : "crude_metal_helm"                     , "layer" : "helm", "min" : 1, "max" : 3, "value" :500, "con" : 110, "stam" : -8, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Crude Metal Helm", \
 "desc" :  "Although crudely made and rusty, this metal helmet is a durable and sturdy piece of armor." \
},
{"name" : "crude_cylinder_helm"                     , "layer" : "helm", "min" : 1, "max" : 2, "value" : 600, "con" : 155, "stam" : -12, "vis" : -2, "hair" : "true", "beard" : "true",  \
 "title" :  "Crude Cylinder Helm", \
 "desc" :  "This heavy metal helmet also protects the wearers face, albeit at the cost of visibility." \
},
{"name" : "heavy_plate_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 1200, "con" : 175, "stam" : -15, "vis" : -2, "hair" : "true", "beard" : "false",  \
 "title" :  "Heavy Plate Helm", \
 "desc" :  "This heavy helmet usually is worn as a sign of high standing and reputation within barbarian warbands." \
},
{"name" : "barb_ritual_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 6000, "con" : 190, "stam" : -16, "vis" : -3, "hair" : "true", "beard" : "true",  \
 "title" :  "Northern Ritual Helmet", \
 "desc" :  "This menacing and heavy full faced mask of solid iron is used during barbarian warbands rituals for reasons unknown." \
},
{"name" : "heavy_plate_helm_named"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 3500, "con" : 185, "stam" : -14, "vis" : -3, "hair" : "true", "beard" : "false", "named" : True, "rmaxViz" : 2, "rminViz" : 3, "rmaxStam" : 12, "rminStam" : 14, "rminCond" : 185, "rmaxCond" : 205, "names" : Names,  \
 "title" :  "Famed Heavy Plate Helm", \
 "desc" :  "This heavy helmet has ornamental horns attached and is of exceptional quality among the barbarian clans. This is a sign of high standing and reputation within barbarian warbands." \
},
{"name" : "crude_skull_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 3500, "con" : 150, "stam" : -9, "vis" : -2, "hair" : "true", "beard" : "false", "named" : True, "rmaxViz" : 1, "rminViz" : 2, "rmaxStam" : 7, "rminStam" : 9, "rminCond" : 150, "rmaxCond" : 175, "names" : Names,  \
 "title" :  "Crude Skull Helm", \
 "desc" :  "A heavy helmet typical of the northern barbarians with a skull-like facemask. This piece is as massive as it is impressive." \
},
{"name" : "heavy_spiked_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 1800, "con" : 165, "stam" : -10, "vis" : -2, "hair" : "true", "beard" : "true", "named" : True, "rmaxViz" : 1, "rminViz" : 2, "rmaxStam" : 8, "rminStam" : 10, "rminCond" : 165, "rmaxCond" : 185, "names" : Names,  \
 "title" :  "Heavy Spiked Helm", \
 "desc" :  "This helmet must have belonged to a distinct warrior of the barbarians. Its size and design appear alien to all southern folks." \
},
{"name" : "southern_leather_helm"                     , "layer" : "helm", "min" : 1, "max" : 5, "value" : 60, "con" : 15, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Leather helm", \
 "desc" :  "A traditional southern leather helm." \
},
{"name" : "southern_studded_leather_helm"                     , "layer" : "helm", "min" : 1, "max" : 4, "value" : 125, "con" : 25, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Nomad Leather Cap", \
 "desc" :  "A light nomad leather cap." \
},
{"name" : "southern_cap_smooth"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 150, "con" : 40, "stam" : -2, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Southern Smooth Cap", \
 "desc" :  "A smooth metal cap." \
},
{"name" : "southern_cap_spiked"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 150, "con" : 40, "stam" : -2, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Southern Spiked Cap", \
 "desc" :  "A metal skull cap with a fashionable spike." \
},
{"name" : "viking_helm"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 200, "con" : 55, "stam" : -3, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Viking Helm", \
 "desc" :  "A nordic helmet guarding face and neck with additional metal plates." \
},
{"name" : "norman_helm"                     , "layer" : "helm", "min" : 1, "max" : 5, "value" : 150, "con" : 50, "stam" : -3, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Nasal Helmet", \
 "desc" :  "A metal helmet with added noseguard." \
},
{"name" : "flat_top_helm_low"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 225, "con" : 70, "stam" : -5, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Rusted Flat Top Helm", \
 "desc" :  "A flat top helm that is worn out, rusted, dented and will never be fully repairable." \
},
{"name" : "flat_top_helm"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 325, "con" : 85, "stam" : -5, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Flat Top Helm", \
 "desc" :  "A flat full-metal helmet with noseguard." \
},
{"name" : "flat_top_helm_polished"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 550, "con" : 100, "stam" : -5, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Hardened Flat Top Helm", \
 "desc" :  "An outstandingly well made and maintained flat full-metal helmet with noseguard." \
},
{"name" : "barbute"                     , "layer" : "helm", "min" : 1, "max" : 7, "value" : 1250, "con" : 75, "stam" : -3, "vis" : -2, "hair" : "true", "beard" : "false",  \
 "title" :  "Barbute", \
 "desc" :  "A sturdy yet light barbute helmet, a design uncommon in these lands, made from especially light and durable steel." \
},
{"name" : "barbute_named"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 2750, "con" : 85, "stam" : -4, "vis" : -2, "hair" : "true", "beard" : "true", "named" : True, "rmaxViz" : 1, "rminViz" : 2, "rmaxStam" : 2, "rminStam" : 4, "rminCond" : 85, "rmaxCond" : 105, "names" : Names,  \
 "title" :  "Barbute", \
 "desc" :  "A superb barbute helmet of foreign origin, this helmet has been blackened and polished to a dark shine. " \
},
{"name" : "horsetail"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 200, "con" : 60, "stam" : -3, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Steppe Helm", \
 "desc" :  "A nasal helmet witch an attached mail neck guard fashioned in the way of the steppe folks." \
},
{"name" : "basinet"                     , "layer" : "helm", "min" : 1, "max" : 7, "value" : 1250, "con" : 80, "stam" : -5, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Bascinet", \
 "desc" :  "A well made metal bascinet." \
},
{"name" : "bascinet_named"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 2500, "con" : 90, "stam" : -4, "vis" : -1, "hair" : "true", "beard" : "false", "named" : True, "rmaxViz" : 0, "rminViz" : 1, "rmaxStam" : 2, "rminStam" : 4, "rminCond" : 90, "rmaxCond" : 115, "names" : Names,  \
 "title" :  "Bascinet", \
 "desc" :  "A heavy and durable bascinet. This one has a pointed head and is blackened." \
},
{"name" : "enclave_great_bascinet"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 2800, "con" : 180, "stam" : -13, "vis" : -2, "hair" : "true", "beard" : "true",  \
 "title" :  "Peaked Bascinet", \
 "desc" :  "A well made peaked bascinet." \
},
{"name" : "enclave_venitian_bascinet"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 3000, "con" : 185, "stam" : -14, "vis" : -2, "hair" : "true", "beard" : "true",  \
 "title" :  "Great Bascinet", \
 "desc" :  "A tall helm composed of a peaked bascinet and riveted cheek protection." \
},
{"name" : "kettle_helm_low"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 300, "con" : 75, "stam" : -7, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Rusted Kettle Helm", \
 "desc" :  "A full-metal helmet with a broad rim, it has been poorly maintained and is now rusted, dented and will never be fully repaired." \
},
{"name" : "kettle_helm_med"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 500, "con" : 95, "stam" : -7, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Kettle Helm", \
 "desc" :  "A full-metal helmet with a broad rim." \
},
{"name" : "kettle_helm_high"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 850, "con" : 125, "stam" : -9, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Hardened Kettle Helm", \
 "desc" :  "A hardened full-metal helmet with a broad rim, excellent quality and military grade." \
},
{"name" : "kettle_helm"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 750, "con" : 115, "stam" : -8, "vis" : -2, "hair" : "true", "beard" : "false",  \
 "title" :  "Kettle Helm", \
 "desc" :  "A full-metal helmet with a broad rim." \
},
{"name" : "kettle_hat"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 800, "con" : 120, "stam" : -9, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Kettle Hat", \
 "desc" :  "A full-metal helmet with a very wide rim." \
},
{"name" : "kettle_helm_named"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 3500, "con" : 130, "stam" : -9, "vis" : -2, "hair" : "true", "beard" : "false", "named" : True, "rmaxViz" : 1, "rminViz" : 2, "rmaxStam" : 7, "rminStam" : 9, "rminCond" : 130, "rmaxCond" : 155, "names" : Names, \
 "title" :  "Kettle Helm", \
 "desc" :  "An exceptional and sturdy kettle helm. Blackened and polished, it has a gilded point." \
},
{"name" : "enclave_kettle"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 1250, "con" : 145, "stam" : -10, "vis" : -2, "hair" : "true", "beard" : "false",  \
 "title" :  "Kettle Sallet", \
 "desc" :  "A full-metal sallet with a broad rim." \
},
{"name" : "enclave_skullcap"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 600, "con" : 65, "stam" : -4, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Metal Skullcap", \
 "desc" :  "A metal cap that covers the head." \
},
{"name" : "scale_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 725, "con" : 75, "stam" : -5, "vis" : -1, "hair" : "false", "beard" : "false",  \
 "title" :  "Scale Skullcap", \
 "desc" :  "A skullcap composed of several overlapping metal scales." \
},
{"name" : "rondel_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 775, "con" : 85, "stam" : -6, "vis" : -1, "hair" : "false", "beard" : "false",  \
 "title" :  "Rondel Helm", \
 "desc" :  "A short skullcap with two rondels afixed to each side, providing extra protection to the wearer's head." \
},
{"name" : "deep_sallet"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 1000, "con" : 100, "stam" : -5, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Deep Sallet", \
 "desc" :  "A metal sallet with a deep skull as well as tall sides, providing good protection." \
},
{"name" : "deep_sallet_named"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 3200, "con" : 105, "stam" : -6, "vis" : -1, "hair" : "true", "beard" : "false",  "named" : True, "rmaxViz" : 1, "rminViz" : 1, "rmaxStam" : 5, "rminStam" : 6, "rminCond" : 105, "rmaxCond" : 125, "names" : Names,  \
 "title" :  "Deep Sallet", \
 "desc" :  "A decorated deep sallet. It bears a gilded trim with decorative leaf plates pinned to the front ridge." \
},
{"name" : "wallace_sallet"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 1500, "con" : 105, "stam" : -7, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Sallet", \
 "desc" :  "A deep sallet covering the head protectively." \
},
{"name" : "wallace_sallet_named"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 2500, "con" : 110, "stam" : -6, "vis" : -1, "hair" : "true", "beard" : "false", "named" : True, "rmaxViz" : 1, "rminViz" : 1, "rmaxStam" : 5, "rminStam" : 6, "rminCond" : 110, "rmaxCond" : 135, "names" : Names, \
 "title" :  "Sallet", \
 "desc" :  "A skillfully painted sallet. It is made of strong steel and should protect one's skull from all kinds of trauma." \
},
{"name" : "flat_top_face_plate"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 900, "con" : 120, "stam" : -9, "vis" : -2, "hair" : "true", "beard" : "true",  \
 "title" :  "Flat Top Face Plate", \
 "desc" :  "A flat full-metal helmet with faceplate." \
},
{"name" : "carthaginian"                     , "layer" : "helm", "min" : 1, "max" : 3, "value" : 1600, "con" : 105, "stam" : -5, "vis" : -2, "hair" : "true", "beard" : "false",  \
 "title" :  "Carthaginian Helm", \
 "desc" :  "A sturdy alloy helmet of foreign design." \
},
{"name" : "conic_helm"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 700, "con" : 110, "stam" : -6, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Conic Helm", \
 "desc" :  "A heavy conic helmet." \
},
{"name" : "sallet"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 800, "con" : 50, "stam" : -2, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Sallet", \
 "desc" :  "A metal sallet helmet with an extended neckguard, a design uncommon in these lands. It is well crafted to offer maximum protection with minimum weight, and without impairing vision." \
},
{"name" : "sallet_named"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 1600, "con" : 55, "stam" : -2, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Guilded Sallet", \
 "desc" :  "A beautifully designed metal sallet helmet with an extended neckguard, a design uncommon in these lands. It is well crafted to offer maximum protection with minimum weight, and without impairing vision." \
},
{"name" : "nordic_helm_low"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 460, "con" : 110, "stam" : -7, "vis" : -2, "hair" : "true", "beard" : "false",  \
 "title" :  "Rusted Nordic Helm", \
 "desc" :  "A poorly maintained nordic helmet guarding face and neck with additional metal plates. It is rusted, dented, bent and will never be fully repaired." \
},
{"name" : "nordic_helm"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 1000, "con" : 125, "stam" : -8, "vis" : -2, "hair" : "true", "beard" : "false",  \
 "title" :  "Nordic Helm", \
 "desc" :  "A nordic helmet guarding face and neck with additional metal plates." \
},
{"name" : "nordic_helm_high"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 1750, "con" : 135, "stam" : -8, "vis" : -2, "hair" : "true", "beard" : "false",  \
 "title" :  "Hardened Nordic Helm", \
 "desc" :  "A spectacularly well constructed and maintained nordic helmet guarding face and neck with additional metal plates." \
},
{"name" : "bronze_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 1000, "con" : 115, "stam" : -8, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Bronze Helm", \
 "desc" :  "Bronze Helm." \
},
{"name" : "great_helm"                     , "layer" : "helm", "min" : 1, "max" : 6, "value" : 2500, "con" : 175, "stam" : -12, "vis" : -2, "hair" : "true", "beard" : "true",  \
 "title" :  "Great Helm", \
 "desc" :  "A closed metal helm with breathing holes. Great in the way of protection but hard to breathe in and limiting the field of view." \
},
{"name" : "full_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 3000, "con" : 180, "stam" : -13, "vis" : -2, "hair" : "true", "beard" : "true",  \
 "title" :  "Full Helm", \
 "desc" :  "A closed metal helm with breathing holes. Lovingly maintained despite its extensive use" \
},
{"name" : "enclave_great_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 2650, "con" : 180, "stam" : -12, "vis" : -2, "hair" : "true", "beard" : "true",  \
 "title" :  "Great Helm", \
 "desc" :  "A closed metal helm with breathing holes. Great in the way of protection but hard to breathe in and limiting the field of view." \
},
{"name" : "legend_armet"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 1750, "con" : 155, "stam" : -11, "vis" : -2, "hair" : "true", "beard" : "true",  \
 "title" :  "Armet", \
 "desc" :  "A finely crafted close helm of outstanding workmanship." \
},
{"name" : "enclave_armet"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 1400, "con" : 140, "stam" : -9, "vis" : -2, "hair" : "true", "beard" : "true",  \
 "title" :  "Armet", \
 "desc" :  "A finely crafted armet of outstanding workmanship." \
},
{"name" : "legend_frogmouth"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 2250, "con" : 160, "stam" : -10, "vis" : -2, "hair" : "true", "beard" : "true",  \
 "title" :  "Frogmouth", \
 "desc" :  "A glorious frogmouth helm of excellent construction." \
},
{"name" : "legend_frogmouth_close"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 2250, "con" : 160, "stam" : -10, "vis" : -2, "hair" : "true", "beard" : "true",  "named" : True, "rmaxViz" : 2, "rminViz" : 3, "rmaxStam" : 5, "rminStam" : 10, "rminCond" : 165, "rmaxCond" : 180, "names" : Names, \
 "title" :  "Frogmouth", \
 "desc" :  "A glorious frogmouth helm of excellent construction." \
},
{"name" : "southern_gladiator_helm_crested"                     , "layer" : "helm", "min" : 1, "max" : 13, "value" : 2500, "con" : 130, "stam" : -6, "vis" : -3, "hair" : "true", "beard" : "true",  \
 "title" :  "Crested Gladiator Helm", \
 "desc" :  "An impressive metal helmet crafted to intimidate the opponents of pit fighters in arenas of the southern city states." \
},
{"name" : "southern_gladiator_helm_split"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 2500, "con" : 130, "stam" : -6, "vis" : -3, "hair" : "true", "beard" : "true",  \
 "title" :  "Split Gladiator Helm", \
 "desc" :  "An impressive metal helmet crafted to intimidate the opponents of pit fighters in arenas of the southern city states." \
},
{"name" : "southern_gladiator_helm_masked"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 2500, "con" : 130, "stam" : -6, "vis" : -3, "hair" : "true", "beard" : "true",  \
 "title" :  "Masked Gladiator Helm", \
 "desc" :  "An impressive metal helmet crafted to intimidate the opponents of pit fighters in arenas of the southern city states." \
},
{"name" : "southern_helmet_nasal"                     , "layer" : "helm", "min" : 1, "max" : 8, "value" : 1000, "con" : 125, "stam" : -7, "vis" : -2, "hair" : "true", "beard" : "false",  \
 "title" :  "Heavy Lamellar Helmet", \
 "desc" :  "A heavy helmet made from overlapping metal plates." \
},
{"name" : "italo_norman_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 425, "con" : 90, "stam" : -6, "vis" : -2, "hair" : "true", "beard" : "true",  \
 "title" :  "Italo Norman Helm", \
 "desc" :  "A curved metal helm in a distinctive style. It has a large duck-bill shaped faceplate covering the front." \
},
{"name" : "giles_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 1500, "con" : 100, "stam" : -6, "vis" : -3, "hair" : "true", "beard" : "true",  \
 "title" :  "Sir Giles Helm", \
 "desc" :  "A tight fitting helm with a mesh grille in a unique style." \
},
{"name" : "italo_norman_helm_named"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 2000, "con" : 110, "stam" : -5, "vis" : -2, "hair" : "true", "beard" : "true", "named" : True, "rmaxViz" : 1, "rminViz" : 2, "rmaxStam" : 4, "rminStam" : 5, "rminCond" : 110, "rmaxCond" : 135, "names" : Names,  \
 "title" :  "Italo Conic Helm", \
 "desc" :  "A well-built and lavishly decorated pointed conic helm. It has a large duck-bill shaped faceplate covering the front." \
},
{"name" : "southern_conic_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 1000, "con" : 75, "stam" : -4, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Southern Conic Helm", \
 "desc" :  "A conic helm from the south." \
},
{"name" : "southern_named_conic"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 2000, "con" : 85, "stam" : -3, "vis" : -1, "hair" : "true", "beard" : "false", "named" : True, "rmaxViz" : 1, "rminViz" : 1, "rmaxStam" : 3, "rminStam" : 4, "rminCond" : 85, "rmaxCond" : 105, "names" : Names,  \
 "title" :  "Southern Conic", \
 "desc" :  "An expertly crafted southern helm." \
},
{"name" : "southern_peaked_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 2000, "con" : 115, "stam" : -8, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Southern Peaked Helmet", \
 "desc" :  "A southern metal helmet usually worn with a mail coif to protect the neck." \
},
{"name" : "southern_peaked_nasal_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 1500, "con" : 150, "stam" : -11, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Turban Helmet", \
 "desc" :  "A full helmet crafted from overlapping long metal splints in the shape of a traditional southern head wrap." \
},
{"name" : "legend_ancient_gladiator"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 1200, "con" : 150, "stam" : -11, "vis" : -2, "hair" : "true", "beard" : "true",  \
 "title" :  "Ancient Gladiator Helm", \
 "desc" :  "The distinctive helm of an ancient gladiator." \
},
{"name" : "legend_ancient_legionaire_restored"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 800, "con" : 140, "stam" : -9, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Restored Ancient Legionaire", \
 "desc" :  "A restored helm from a long dead legionaire." \
},
{"name" : "dentist_helmet"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 1200, "con" : 70, "stam" : -3, "vis" : -1, "hair" : "true", "beard" : "true", "named" : True, "rmaxViz" : 0, "rminViz" : 2, "rmaxStam" : 1, "rminStam" : 3, "rminCond" : 70, "rmaxCond" : 95, "names" : Names,  \
 "title" :  "Dentist Helmet", \
 "desc" :  "Dentist Helmet." \
},
{"name" : "tailed_conic"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 3000, "con" : 140, "stam" : -8, "vis" : -2, "hair" : "true", "beard" : "false", "named" : True, "rmaxViz" : 1, "rminViz" : 2, "rmaxStam" : 7, "rminStam" : 9, "rminCond" : 140, "rmaxCond" : 165, "names" : Names,  \
 "title" :  "Feathered Nasal Helmet", \
 "desc" :  "A hardened nasal helmet with a unique neckguard made from leather scales." \
},
{"name" : "legend_armet_01_named"                     , "layer" : "helm", "min" : 1, "max" : 3, "value" : 4000, "con" : 170, "stam" : -11, "vis" : -2, "hair" : "true", "beard" : "true", "named" : True, "rmaxViz" : 1, "rminViz" : 2, "rmaxStam" : 11, "rminStam" : 13, "rminCond" : 170, "rmaxCond" : 195, "names" : Names,  \
 "title" :  "Armet", \
 "desc" :  "A finely crafted close helm of outstanding workmanship." \
},
{"name" : "stag_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 5000, "con" : 200, "stam" : -15, "vis" : -2, "hair" : "true", "beard" : "true", "named" : True, "rmaxViz" : 2, "rminViz" : 3, "rmaxStam" : 14, "rminStam" : 16, "rminCond" : 200, "rmaxCond" : 225, "names" : Names,  \
 "title" :  "Stag Helm", \
 "desc" :  "The helm of a noble house champion bearing the design of the stag, unparralled craftmanship but quite unweildy." \
},
{"name" : "swan_helm"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 5000, "con" : 200, "stam" : -15, "vis" : -2, "hair" : "true", "beard" : "true", "named" : True, "rmaxViz" : 2, "rminViz" : 3, "rmaxStam" : 14, "rminStam" : 16, "rminCond" : 200, "rmaxCond" : 225, "names" : Names,  \
 "title" :  "Swan Helm", \
 "desc" :  "The helm of a noble house champion bearing the design of the swan, beautiful design but quite impractical." \
},
{"name" : "skin_helm"                     , "itemType" : "this.Const.Items.ItemType.Cultist", "layer" : "helm", "min" : 1, "max" : 1, "value" : 20000, "con" : 105, "stam" : -5, "vis" : 0, "hair" : "true", "beard" : "true",  \
 "title" :  "Glimpse of Davkul", \
 "desc" :  "The Glimpse of Davkul is a gift bestowed upon man by ancient and dark powers, a helmet merged with human skin and bones through the most unspeakable of rituals. A glimpse of a future where man shall become one with creations from a realm beyond. It shall never break, but instead keep regrowing its scarred skin on the spot." \
},
{"name" : "rotten_flat_top_face_mask"                     , "layer" : "helm", "min" : 1, "max" : 5, "value" : 400, "con" : 110, "stam" : -8, "vis" : -2, "hair" : "true", "beard" : "true",  \
 "title" :  "Rotten Flat Top Face Mask", \
 "desc" :  "Rotten Flat Top Face Mask." \
},
{"name" : "rotten_great_helm"                     , "layer" : "helm", "min" : 1, "max" : 4, "value" : 750, "con" : 150, "stam" : -14, "vis" : -3, "hair" : "true", "beard" : "true",  \
 "title" :  "Rotten Great Helm", \
 "desc" :  "Rotten Great Helm." \
},
{"name" : "barb_metal_cap"                     , "layer" : "helm", "min" : 1, "max" : 1, "value" : 150, "con" : 40, "stam" : -2, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Rusted Metal Helm", \
 "desc" :  "A rusted and dented metal cap that provides protection against bumps to the head." \
},


{"name" : "hood_cloth_round"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 5, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Round Hood Cloth", \
 "desc" :  "A simple hood to protect against weather and scratches." \
},
{"name" : "hood_cloth_wide"                     , "layer" : "top", "min" : 1, "max" : 2,  "value" : 5, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Wide Hood Cloth", \
 "desc" :  "A simple hood to protect against weather and scratches." \
},
{"name" : "hood_cloth_square"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 5, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Square Hood Cloth", \
 "desc" :  "A simple hood to protect against weather and scratches." \
},
{"name" : "cloth_long_hood"                     , "layer" : "top", "min" : 1, "max" : 4, "value" : 30, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Cloth Long Hood", \
 "desc" :  "A simple hood to protect against weather and scratches." \
},
{"name" : "cloth_long_hood"                     , "layer" : "top", "min" : 1, "max" : 4, "value" : 30, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Cloth Long Hood", \
 "desc" :  "A simple hood to protect against weather and scratches." \
},
{"name" : "mask_beak"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 50, "con" : 20, "stam" : -1, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Physicians Mask", \
 "desc" :  "a distinctive, bird-like mask. The beak acts as a ventilator, containing sweet-smelling herbs to ward away sickness and disease" \
},
{"name" : "orc_horn_mask"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 200, "con" : 60, "stam" : -8, "vis" : -2, "hair" : "true", "beard" : "false",  \
 "title" :  "Orc Horn Mask", \
 "desc" :  "A rough horned facemask worn by young orcs." \
},
{"name" : "orc_metal_mask"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 400, "con" : 75, "stam" : -11, "vis" : -2, "hair" : "true", "beard" : "false",  \
 "title" :  "Orc Metal Plated Mask", \
 "desc" :  "A simple construction of metal plates, worn by young orcs." \
},
{"name" : "orc_leather_mask"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 50, "con" : 40, "stam" : -4, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Orc Leather Mask", \
 "desc" :  "A simple construction of strange leather, worn by young orcs." \
},
{"name" : "goblin_leaves"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 5, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Goblin Leaves", \
 "desc" :  "A set of leaves used by goblins to disguise themselves." \
},
{"name" : "undertakers_scarf"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Undertaker Scarf", \
 "desc" :  "A scarf to cover the mouth. Durable enough to protect against weather and scratches." \
},
{"name" : "goblin_leaf_helm"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 100, "con" : 25, "stam" : -1, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Goblin Leaf Mask", \
 "desc" :  "A goblin mask made for blending in with cover." \
},
{"name" : "goblin_gillie"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 80, "con" : 15, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Goblin Gillie", \
 "desc" :  "Helmet camouflague used by goblin ambushers." \
},
{"name" : "goblin_leather_mask"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 50, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Leather Goblin Mask", \
 "desc" :  "A simple goblin face covering." \
},
{"name" : "goblin_leather_helm"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 105, "con" : 25, "stam" : -1, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Leather Goblin Helm", \
 "desc" :  "A basic leather helm of goblin design." \
},
{"name" : "goblin_chain_helm"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 125, "con" : 30, "stam" : -3, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Goblin Chain Helm", \
 "desc" :  "A chainlink helm of goblin design." \
},
{"name" : "goblin_spiked_helm"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 125, "con" : 35, "stam" : -4, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Spiked Goblin Helm", \
 "desc" :  "The distinctive spiked helm of a goblin overseer." \
},
{"name" : "ancient_beard_mask"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 200, "con" : 45, "stam" : -2, "vis" : -1, "hair" : "true", "beard" : "true",  \
 "title" :  "Ancient Bearded Mask", \
 "desc" :  "Bearded Mask of an ancient honor guard." \
},
{"name" : "ancient_lion_mask"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 150, "con" : 40, "stam" : -2, "vis" : -1, "hair" : "true", "beard" : "true",  \
 "title" :  "Ancient Lion Mask", \
 "desc" :  "A Lion Mask of an ancient honor guard." \
},
{"name" : "ancient_mask"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 100, "con" : 30, "stam" : -2, "vis" : -1, "hair" : "true", "beard" : "true",  \
 "title" :  "Ancient Mask", \
 "desc" :  "A masked helm of an ancient honor guard." \
},
{"name" : "vampire_crown"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Ancient Crown", \
 "desc" :  "A crown of ancient design, relic of a bygone era in a far away land." \
},
{"name" : "ancient_crown"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 200, "con" : 20, "stam" : -2, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Ancient Diadem", \
 "desc" :  "An ancient crown from ages past." \
},
{"name" : "leather_hood_barb"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 300, "con" : 45, "stam" : -4, "vis" : -2, "hair" : "true", "beard" : "false",  \
 "title" :  "Leather Hood Barb", \
 "desc" :  "The crude padded leather hood of a barbarian, it is heavy and surprisingly protective." \
},
{"name" : "nose_plate"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 60, "con" : 15, "stam" : -1, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Nose Plate", \
 "desc" :  "A strip of metal tied on with a leather band, used for protecting the face from frontal blows." \
},
{"name" : "headband_side"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 30, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Headband Side", \
 "desc" :  "A rugged leather headband." \
},
{"name" : "headband_nose"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 30, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Headband Nose", \
 "desc" :  "A rough leather headband with a small nose protection." \
},
{"name" : "eyemask"                     , "layer" : "top", "min" : 1, "max" : 2, "value" : 125, "con" : 15, "stam" : 0, "vis" : -1, "hair" : "false", "beard" : "false",  \
 "title" :  "Eyemask", \
 "desc" :  "A metal mask covering the eyes and nose from blows." \
},
{"name" : "chain_attachment"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 250, "con" : 25, "stam" : -1, "vis" : 0, "hair" : "false", "beard" : "true",  \
 "title" :  "Chain Attachment", \
 "desc" :  "A piece of mail used for hanging over the mouth and nose." \
},
{"name" : "helm_adornment"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 500, "con" : 20, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Helm Adornment", \
 "desc" :  "Relics of adornment to create the helmet of a true questing knight" \
},
{"name" : "helm_adornment_rotten"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Tarnished Helm Adornment", \
 "desc" :  "Ancient rotten relics of adornment from the helmet of a long dead questing knight" \
},
{"name" : "faceplate_flat"                     , "layer" : "top", "min" : 1, "max" : 6, "value" : 300, "con" : 35, "stam" : -2, "vis" : -1, "hair" : "false", "beard" : "false",  \
 "title" :  "Flat Faceplate", \
 "desc" :  "Flat Faceplate." \
},
{"name" : "faceplate_curved"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 300, "con" : 35, "stam" : -2, "vis" : -1, "hair" : "false", "beard" : "false",  \
 "title" :  "Curved Faceplate", \
 "desc" :  "Curved Faceplate." \
},
{"name" : "southern_faceplate"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 500, "con" : 40, "stam" : -2, "vis" : -1, "hair" : "false", "beard" : "false",  \
 "title" :  "Southern Faceplate", \
 "desc" :  "The faceplate of a southern assasin" \
},
{"name" : "faceplate_short"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 140, "con" : 30, "stam" : -2, "vis" : 0, "hair" : "false", "beard" : "true",  \
 "title" :  "Short Faceplate", \
 "desc" :  "A short squat faceplate." \
},
{"name" : "cult_hood"                     , "itemType" : "this.Const.Items.ItemType.Cultist", "layer" : "top", "min" : 1, "max" : 7, "value" : 60, "con" : 15, "stam" : -1, "vis" : -1, "hair" : "true", "beard" : "false",  \
 "title" :  "Cult Leather Hood", \
 "desc" :  "A leather hood used in cultist ceremonies." \
},
{"name" : "faceplate_long"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 180, "con" : 35, "stam" : -3, "vis" : -1, "hair" : "false", "beard" : "true",  \
 "title" :  "Long Faceplate", \
 "desc" :  "A long faceplate." \
},
{"name" : "faceplate_winged"                     , "layer" : "top", "min" : 1, "max" : 2, "value" : 600, "con" : 45, "stam" : -4, "vis" : 0, "hair" : "false", "beard" : "true",  \
 "title" :  "Winged Faceplate", \
 "desc" :  "A glorious faceplate formed into the shape of wings." \
},
{"name" : "faceplate_snub_nose"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 500, "con" : 45, "stam" : -3, "vis" : -1, "hair" : "false", "beard" : "true",  \
 "title" :  "Snub Nose Faceplate", \
 "desc" :  "A round nosed faceplate." \
},
{"name" : "faceplate_snub_slit"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 500, "con" : 45, "stam" : -2, "vis" : -1, "hair" : "false", "beard" : "false",  \
 "title" :  "Slitted Snub Faceplate", \
 "desc" :  "Slitted Snub Faceplate." \
},
{"name" : "faceplate_sharp"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 300, "con" : 35, "stam" : -2, "vis" : -1, "hair" : "false", "beard" : "false",  \
 "title" :  "Sharp Faceplate", \
 "desc" :  "Sharp Faceplate." \
},
{"name" : "enclave_great_jaw"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 350, "con" : 50, "stam" : -5, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Rough Metal Bevor", \
 "desc" :  "A rough metal bevor." \
},
{"name" : "facemask"                     , "layer" : "top", "min" : 1, "max" : 6, "value" : 150, "con" : 20, "stam" : -1, "vis" : -1, "hair" : "false", "beard" : "true",  \
 "title" :  "Facemask", \
 "desc" :  "A metal faceplate in the shape of a mask." \
},
{"name" : "faceplate_pointed"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 600, "con" : 50, "stam" : -4, "vis" : -1, "hair" : "false", "beard" : "true",  \
 "title" :  "Pointed Faceplate", \
 "desc" :  "A long nosed faceplate designed to deflect glancing blows." \
},
{"name" : "enclave_armet_visor"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 300, "con" : 35, "stam" : -2, "vis" : -1, "hair" : "false", "beard" : "true",  \
 "title" :  "Armet Visor", \
 "desc" :  "A visor that fits on the armet, protecting the lower jaw while leaving a slit for eyesight." \
},
{"name" : "wallace_sallet_visor"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 150, "con" : 20, "stam" : -1, "vis" : -1, "hair" : "false", "beard" : "true",  \
 "title" :  "Sallet Visor", \
 "desc" :  "A visor made for sallets. It has two eye-slits as well as a few breathing holes in the center." \
},
{"name" : "wallace_sallet_visor_named"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 700, "con" : 35, "stam" : -1, "vis" : -1, "hair" : "false", "beard" : "true", "named" : True, "rmaxViz" : 1, "rminViz" : 1, "rmaxStam" : 1, "rminStam" : 2, "rminCond" : 35, "rmaxCond" : 50, "names" : Names, \
 "title" :  "Sallet Visor", \
 "desc" :  "This visor bears an exquisite caricature of a beast's face on the front, putting terror into any who gaze upon it." \
},
{"name" : "enclave_venitian_bascinet_visor"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 500, "con" : 45, "stam" : -3, "vis" : -1, "hair" : "false", "beard" : "true",  \
 "title" :  "Great Bascinet Visor", \
 "desc" :  "A visor that fits on the great bascinet, covering the only hole for the face, it increases the wearer's defense greatly." \
},
{"name" : "enclave_great_bascinet_visor"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 900, "con" : 65, "stam" : -6, "vis" : -1, "hair" : "false", "beard" : "true",  \
 "title" :  "Great Bascinet Visor", \
 "desc" :  "Visor made for the great bascinet. Provides much protection to the wearer's face, but limits vision." \
},
{"name" : "faceplate_pointed_slit"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 600, "con" : 50, "stam" : -4, "vis" : -1, "hair" : "false", "beard" : "true",  \
 "title" :  "Slit Pointed Faceplate", \
 "desc" :  "Slit Pointed Faceplate." \
},
{"name" : "faceplate_full"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 800, "con" : 60, "stam" : -5, "vis" : -1, "hair" : "false", "beard" : "true",  \
 "title" :  "Full Faceplate", \
 "desc" :  "A very well crafted full faceplate." \
},
{"name" : "bascinet_visor_named"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 1000, "con" : 50, "stam" : -2, "vis" : -1, "hair" : "false", "beard" : "true", "named" : True, "rmaxViz" : 1, "rminViz" : 1, "rmaxStam" : 2, "rminStam" : 3, "rminCond" : 50, "rmaxCond" : 70, "names" : Names,  \
 "title" :  "Pointed Visor", \
 "desc" :  "A gilded visor with a pointed snout and plenty of holes to breathe through." \
},
# {"name" : "southern_faceplate"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 450, "con" : 50, "stam" : -3, "vis" : -2, "hair" : "false", "beard" : "true",  \
#  "title" :  "Southern Faceplate", \
#  "desc" :  "A faceplate in the southern style" \ 
# },
{"name" : "southern_faceplate_bearded"                     , "layer" : "top", "min" : 1, "max" : 2, "value" : 700, "con" : 60, "stam" : -5, "vis" : -2, "hair" : "false", "beard" : "true",  \
 "title" :  "Southern Bearded Faceplate", \
 "desc" :  "A faceplate in the southern bearded style." \
},
{"name" : "mummy_mask"                     , "layer" : "top", "min" : 1, "max" : 2, "value" : 450, "con" : 40, "stam" : -3, "vis" : -2, "hair" : "false", "beard" : "true",  \
 "title" :  "Ancient Southern Facemask", \
 "desc" :  "A facemask from a long dead civilisation." \
},

{"name" : "mummy_beard"                     , "layer" : "top", "min" : 1, "max" : 3, "value" : 200, "con" : 15, "stam" : -1, "vis" : 0, "hair" : "false", "beard" : "true",  \
 "title" :  "Ancient Southern Beard", \
 "desc" :  "A beard cover from a long dead civilisation." \
},

{"name" : "faceplate_full_breaths"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 300, "con" : 35, "stam" : -2, "vis" : -1, "hair" : "false", "beard" : "true",  \
 "title" :  "Breathed Faceplate", \
 "desc" :  "A faceplate filled with breathes for easy breathing and increased sight." \
},
{"name" : "unhold_head_chain"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 240, "con" : 45, "stam" : -7, "vis" : 0, "hair" : "false", "beard" : "true",  \
 "title" :  "Unhold Head Chain", \
 "desc" :  "The chain used by barbarian beastmasters for controlling unholds." \
},
{"name" : "unhold_head_spike"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 800, "con" : 90, "stam" : -13, "vis" : -2, "hair" : "false", "beard" : "true",  \
 "title" :  "Unhold head Spike", \
 "desc" :  "The heavy spiked armor used by barbarian unholds." \
},
{"name" : "faceplate_gold"                     , "layer" : "top", "min" : 1, "max" : 2, "value" : 1600, "con" : 65, "stam" : -5, "vis" : -1, "hair" : "false", "beard" : "true", "named" : True, "rmaxViz" : 0, "rminViz" : 1, "rmaxStam" : 4, "rminStam" : 5, "rminCond" : 65, "rmaxCond" : 85, "names" : Names,  \
 "title" :  "Gold Faceplate", \
 "desc" :  "A gilded faceplate of excellent quality." \
},
{"name" : "faceplate_full_gold"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 1000, "con" : 65, "stam" : -4, "vis" : -2, "hair" : "false", "beard" : "false", "named" : True, "rmaxViz" : 1, "rminViz" : 2, "rmaxStam" : 3, "rminStam" : 4, "rminCond" : 65, "rmaxCond" : 90, "names" : Names,  \
 "title" :  "Golden Full Faceplate", \
 "desc" :  "Golden Full Faceplate." \
},

{"name" : "golden_helm"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 3000, "con" : 90, "stam" : -7, "vis" : -2, "hair" : "true", "beard" : "true", "named" : True, "rmaxViz" : 1, "rminViz" : 2, "rmaxStam" : 6, "rminStam" : 7, "rminCond" : 90, "rmaxCond" : 120, "names" : Names,  \
 "title" :  "Golden Helm", \
 "desc" :  "A golden helmet and facemask, showing the visage of an emperor from an age long past, imbued with mystical energies. When you hold it into the light, it almost looks as if the face were moving and making expressions of disgust." \
},
{"name" : "faceplate_raised"                     , "layer" : "top", "min" : 1, "max" : 2, "value" :800, "con" : 50, "stam" : -3, "vis" : 0, "hair" : "false", "beard" : "true", "named" : True, "rminViz" : 0, "rmaxViz" : 0, "rmaxStam" : 2, "rminStam" : 3, "rminCond" : 50, "rmaxCond" : 70, "names" : Names,  \
 "title" :  "Raised Faceplate", \
 "desc" :  "A faceplate raised up to give more air and vision." \
},
{"name" : "faceplate_full_01_named"                     , "layer" : "top", "min" : 1, "max" : 3, "value" : 2000, "con" : 75, "stam" : -6, "vis" : -2, "hair" : "false", "beard" : "true", "named" : True, "rmaxViz" : 1, "rminViz" : 2, "rmaxStam" : 5, "rminStam" : 6, "rminCond" : 75, "rmaxCond" : 100, "names" : Names,  \
 "title" :  "Full Faceplate", \
 "desc" :  "An exceptionally well crafted faceplate of high worksmanship." \
},
{"name" : "golden_mask"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 1500, "con" : 60, "stam" : -4, "vis" : -1, "hair" : "false", "beard" : "true", "named" : True, "rmaxViz" : 1, "rminViz" : 1, "rmaxStam" : 3, "rminStam" : 4, "rminCond" : 60, "rmaxCond" : 80, "names" : Names,  \
 "title" :  "Golden Mask", \
 "desc" :  "An exquisit golden mask from distant royalty, exceptional craftmanship." \
},
{"name" : "warlock_skull"                     , "itemType" : "this.Const.Items.ItemType.Cultist", "layer" : "top", "min" : 1, "max" : 3, "value" : 2000, "con" : 45, "stam" : -2, "vis" : 0, "hair" : "false", "beard" : "true", "named" : True, "rmaxViz" : 0, "rminViz" : 1, "rmaxStam" : 1, "rminStam" : 2, "rminCond" : 90, "rmaxCond" : 115, "names" : Names,  \
 "title" :  "Warlock Skill Helm", \
 "desc" :  "Warlock Skill Helm." \
},
{"name" : "fencer_hat"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 225, "con" : 15, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
"title" :  "Fencer Hat", \
"desc" :  "The floppy hat of a swordsman." \
},



{"name" : "noble_southern_crown"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 100, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Vizier Peak", \
 "desc" :  "The crown of a southern vizier." \
},
{"name" : "noble_southern_hat"                     , "layer" : "vanity", "min" : 1, "max" : 7, "value" : 50, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Vizier Hat", \
 "desc" :  "The hat of a southern vizier." \
},
{"name" : "southern_noble_turban"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Vizier Turban", \
 "desc" :  "The turban of a southern vizier." \
},
{"name" : "southern_helm_tailed"                     , "layer" : "vanity", "min" : 1, "max" : 6, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Southern Tailed Helmet", \
 "desc" :  "A helmet tail from the southern lands." \
},
{"name" : "southern_silk_headscarf"                     , "layer" : "vanity", "min" : 1, "max" : 13, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Southern Headscarf", \
 "desc" :  "A headscarf made of exotic materials." \
},
{"name" : "southern_feathered_turban"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Feathered Turban", \
 "desc" :  "A feathered blade dancer turban." \
},
# {"name" : "southern_turban_open"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 60, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
#  "title" :  "Open Turban", \
#  "desc" :  "A turban with open face." \
# },
{"name" : "sack"                     , "itemType" : "this.Const.Items.ItemType.Cultist", "layer" : "vanity", "min" : 1, "max" : 12, "value" : 5, "con" : 2, "stam" : 0, "vis" : -1, "hair" : "true", "beard" : "true",  \
 "title" :  "Sack", \
 "desc" :  "A rough hewn hession sack with two holes in it." \
},
{"name" : "antler"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Antlers", \
 "desc" :  "The wide antlers of a beast, often a mark of distinction in northern tribes." \
},
{"name" : "bear_head"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 50, "con" : 8, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Bear Headpiece", \
 "desc" :  "The dried and prepped head of a large bear. Offers some protection, but is mostly donned for the looks." \
},
{"name" : "beret"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Beret", \
 "desc" :  "A beret typically worn by nobles." \
},
{"name" : "bull_horns"                     , "layer" : "vanity", "min" : 1, "max" : 2, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Bull Horns", \
 "desc" :  "The horns of a wild beast, used as a sign of prowess in northern tribes." \
},
{"name" : "crown"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Crown", \
 "desc" :  "An ornately designed symbol of authority." \
},
{"name" : "faction_helmet"                     , "layer" : "vanity", "min" : 1, "max" : 10, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Faction Helmet Ornament", \
 "desc" :  "Ornament top of a noble house." \
},
{"name" : "faction_decayed_helmet"                     , "layer" : "vanity", "min" : 1, "max" : 2, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Decayed Faction Helmet Ornament", \
 "desc" :  "Decayed ornament top of a noble house." \
},
{"name" : "faction_helmet_2"                     , "layer" : "vanity", "min" : 1, "max" : 10, "value" : 50, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Zweihander\'s Hat", \
 "desc" :  "The feathered hat of a noble swordsman." \
},
{"name" : "feather_band"                     , "layer" : "vanity", "min" : 1, "max" : 2, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Feather Band", \
 "desc" :  "A band holding a feather, purely for decoration." \
},
{"name" : "feathered_hat"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Feathered Hat", \
 "desc" :  "A feathered hat as is the latest fashion among the courtisans." \
},
{"name" : "goat_horns"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Goat Horns", \
 "desc" :  "The tall horns of a barbarian beastmaster." \
},
{"name" : "headband"                     , "layer" : "vanity", "min" : 1, "max" : 16, "value" : 20, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Headband", \
 "desc" :  "A simple leather headband from a northern tribe." \
},
{"name" : "horn_decorations"                     , "layer" : "vanity", "min" : 1, "max" : 2, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Horn Decorations", \
 "desc" :  "Decorative horns, fashionable in the northern tribes." \
},
# {"name" : "hunter_cap"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 200, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
#  "title" :  "Hunter Cap", \
#  "desc" :  "The distinctive hat of a game hunter" \
# },
{"name" : "impaled_head"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 50, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Impaled Head", \
 "desc" :  "A rotting and withered human head, quite disgusting." \
},
# {"name" : "jester_hat"                     , "layer" : "vanity", "min" : 1, "max" : 65, "value" : 200, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
#  "title" :  "Jester Hat", \
#  "desc" :  "The quintisential hat of performing folk in noble court" \
# },
{"name" : "metal_bird"                     , "layer" : "vanity", "min" : 1, "max" : 2, "value" : 100, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Metal Bird", \
 "desc" :  "An ancient metal bird statue." \
},
{"name" : "noble_buckle"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 10, "con" : 2, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Noble Buckle", \
 "desc" :  "A decorative buckle used on noble hats." \
},
{"name" : "noble_feather"                     , "layer" : "vanity", "min" : 1, "max" : 4, "value" : 10, "con" : 2, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Noble Feather", \
 "desc" :  "A decorative feature found on the hats of nobles." \
},
{"name" : "noble_floppy_hat"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 50, "con" : 8, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Floppy Noble Hat", \
 "desc" :  "A fashionable hat for aristocrats." \
},
{"name" : "noble_hat"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Noble Hat", \
 "desc" :  "A fashionable hat for courtesans." \
},
{"name" : "chaperon"                     , "layer" : "vanity", "min" : 1, "max" : 9, "value" : 200, "con" : 15, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Chaperon", \
 "desc" :  "Fashionable headerware for adorning a questing knight" \
},
{"name" : "felt_chaperon"                     , "layer" : "vanity", "min" : 1, "max" : 9, "value" : 20, "con" : 5, "stam" : -1, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Felt Chaperon", \
 "desc" :  "The most popular headerware on any city street" \
},
{"name" : "ancient_wig"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Ancient Wig", \
 "desc" :  "A wig from an ancient embalmed noble." \
},
{"name" : "noble_hood"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 100, "con" : 7, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Noble Hood", \
 "desc" :  "A hood made of high quality materials." \
},
{"name" : "wreath"                     , "layer" : "vanity", "min" : 1, "max" : 2, "value" : 150, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Wreath", \
 "desc" :  "A metallic wreath in the ancient style." \
},
{"name" : "orc_bones"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Orc Bones", \
 "desc" :  "Decorative bones, fashionable among orcs." \
},
{"name" : "orc_great_horns"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Orc Great Horns", \
 "desc" :  "The horns of a massive beast, worn by the largest of orcs." \
},
{"name" : "plait"                     , "layer" : "vanity", "min" : 1, "max" : 12, "value" : 50, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Plait", \
 "desc" :  "A decorative plait used to adorn helms." \
},
{"name" : "thick_braid"                     , "layer" : "vanity", "min" : 1, "max" : 6, "value" : 300, "con" : 20, "stam" : -1, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Torse", \
 "desc" :  "A padded roller made of linen, that is put on the top of helmet. Helps to identify a warrior during the battle and amortize hits in the head" \
},
{"name" : "thick_braid_rotten"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 200, "con" : 15, "stam" : -1, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Rotten Torse", \
 "desc" :  "An old mouldy linen torse. The colours are faded but it still offers some small protection" \
},
{"name" : "ponytail"                     , "layer" : "vanity", "min" : 1, "max" : 4, "value" : 50, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Ponytail", \
 "desc" :  "A long tail of hair used to adorn helms." \
},
{"name" : "ram_horns"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 50, "con" : 6, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Ram Horns", \
 "desc" :  "The horns of a wild beast, used as a sign of competency in northern tribes." \
},
{"name" : "side_feather"                     , "layer" : "vanity", "min" : 1, "max" : 5, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Side Feather", \
 "desc" :  "A decorative feather used on hats." \
},
{"name" : "southern_headband"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Southern Headband", \
 "desc" :  "A beautiful headband from southern lands where dyes are plentiful." \
},
{"name" : "southern_patterned_headband"                     , "layer" : "vanity", "min" : 1, "max" : 6, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Patterned Headband", \
 "desc" :  "A gorgeous patterned headband from southern merchants." \
},
{"name" : "southern_patterned_headwrap"                     , "layer" : "vanity", "min" : 1, "max" : 10, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Patterned Headwrap", \
 "desc" :  "A beautiful patterned headwrap from the south." \
},
{"name" : "southern_turban_open"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Open Turban", \
 "desc" :  "A turban with open face." \
},
{"name" : "southern_turban_full"                     , "layer" : "vanity", "min" : 1, "max" : 4, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Full Turban", \
 "desc" :  "A full turban." \
},
{"name" : "southern_turban_light"                     , "layer" : "vanity", "min" : 1, "max" : 6, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Light Turban", \
 "desc" :  "A turban made of light materials, perfect for desert heat." \
},
{"name" : "southern_turban_feather"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Southern Head Wrap", \
 "desc" :  "A southern feathered head wrap." \
},
{"name" : "southern_top_tail"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Southern Top Tail", \
 "desc" :  "A decorative tail made of desert animal hair." \
},
{"name" : "straw_hat"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Straw Hat", \
 "desc" :  "A simple straw hat, often used by farmers and peasants." \
},
{"name" : "top_feather"                     , "layer" : "vanity", "min" : 1, "max" : 5, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Top Feather", \
 "desc" :  "A decorative feather used on hats." \
},
# {"name" : "witchhunter_helm"                     , "layer" : "vanity", "min" : 1, "max" : 7, "value" : 200, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
#  "title" :  "Witchhunter Helm", \
#  "desc" :  "A tough leather hat that provides decent protection against scratches." \
# },
{"name" : "wizard_cowl"                     , "layer" : "vanity", "min" : 1, "max" : 20, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Wizard Cowl", \
 "desc" :  "A pointy hat with a broad rim." \
},
{"name" : "undertakers_hat"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 50, "con" : 12, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Undertaker Hat", \
 "desc" :  "A wide-brimmed feathered hat to protect against weather and scratches." \
},
{"name" : "wolf_helm"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Wolf Helm", \
 "desc" :  "An impressive wolf head covering." \
},
{"name" : "lion_pelt"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Lion Pelt", \
 "desc" :  "A luxurious lion's pelt, worn atop one's head." \
},
# {"name" : "white_wolf_helm"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 200, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
#  "title" :  "White Wolf Helm", \
#  "desc" :  "The trophy of a white wolf head." \
# },
{"name" : "royal_hood"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Royal Hood", \
 "desc" :  "The ornate hood of distant royalty, made from the finest materials." \
},
{"name" : "physicians_hood"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Physician Hood", \
 "desc" :  "A thick hood for keeping out splatters and vapours" \
},
{"name" : "mummy_headress"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Ancient Southern Headress", \
 "desc" :  "A headress of a long dead civilisation." \
},
{"name" : "mummy_headband"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Ancient Southern Headband", \
 "desc" :  "A serpent headband from a long dead civlisation." \
},
{"name" : "southern_cloth_headress"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Southern Cloth Headress", \
 "desc" :  "A southern headress made of soft fabrics." \
},
{"name" : "southern_veil"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 20, "con" : 2, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Southern Veil", \
 "desc" :  "A thin wispy southern veil." \
},

{"name" : "southern_veil_coin"                     , "layer" : "top", "min" : 1, "max" : 1, "value" : 30, "con" : 3, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Southern Coin Veil", \
 "desc" :  "A southern veil made of coins threaded togther." \
},
{"name" : "southern_earings"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 2, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Southern Earings", \
 "desc" :  "Delicate southern metal earings." \
},



{"name" : "southern_headress_coin"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 50, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Southern Coin Headress", \
 "desc" :  "A southern headress of coins strung together." \
},


# {"name" : "lindwurm_helm"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 200, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
#  "title" :  "Lindwurm Helm", \
#  "desc" :  "Lindwurm Helm" \
# },
# {"name" : "redback_helm"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 200, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
#  "title" :  "Redback Helm", \
#  "desc" :  "A sturdy yet light helmet made from the carapace of a redback spider." \
# },
{"name" : "nun_habit"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 10, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Nun Habit", \
 "desc" :  "A characteristic head covering of the convent." \
},
# {"name" : "nach_helm"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 200, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
#  "title" :  "Nacho Helm", \
#  "desc" :  "A trophy made from the face of a skin ghoul." \
# },
# {"name" : "mountain_helm"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 200, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
#  "title" :  "Mountain Helm", \
#  "desc" :  "A helmet crafted from the skin and skull of a mighty rock unhold, the beast may be dead, but it continues to mend itself even after death" \
# },
# {"name" : "demon_alp_helm"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 200, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
#  "title" :  "Demon Alp Helm", \
#  "desc" :  "A trophy made from the face of a demon" \
# },
{"name" : "warlock_hood"                     ,"itemType" : "this.Const.Items.ItemType.Cultist", "layer" : "vanity", "min" : 1, "max" : 4, "value" : 100, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Warlock Hood", \
 "desc" :  "Warlock Hood." \
},
{"name" : "goblin_bones"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Goblin Bones", \
 "desc" :  "Skull ornament used by greenskin shamans." \
},
{"name" : "ancient_priest_hat"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Ancient Lich Crown", \
 "desc" :  "Cermonial crown of an ancient Lich Priests." \
},
{"name" : "fencerhat"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 50, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
"title" :  "Fencer Hat", \
"desc" :  "The floppy hat of a swordsman." \
},

{"name" : "mummy_crown"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 50, "con" : 10, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Ancient Southern Crown", \
 "desc" :  "A tall crown of a long dead civilisation." \
},
{"name" : "mummy_crown_king"                     , "layer" : "vanity", "min" : 1, "max" : 1, "value" : 100, "con" : 15, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Ancient Southern Crested Crown", \
 "desc" :  "A crested crown of a long dead civilisation." \
},


{"name" : "back_crest"                     , "layer" : "vanity", "lowervanity" : True, "min" : 1, "max" : 4, "value" : 50, "con" : 3, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Crest", \
 "desc" :  "A huge crest of feathers arrayed behind a helm." \
},
{"name" : "back_feathers"                     , "layer" : "vanity", "lowervanity" : True, "min" : 1, "max" : 4, "value" : 50, "con" : 3, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Feathers", \
 "desc" :  "A set of feathers displayed behind a helm." \
},
{"name" : "feather_crest"                     , "layer" : "vanity", "lowervanity" : True, "min" : 1, "max" : 5, "value" : 50, "con" : 3, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Feather Crest", \
 "desc" :  "A fan of feathers displayed behind a helm." \
},
{"name" : "knotted_tail"                     , "layer" : "vanity", "lowervanity" : True, "min" : 1, "max" : 4, "value" : 30, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Knotted Tail", \
 "desc" :  "A knotted pony tail, used as a sign of prowess in foreign lands." \
},
{"name" : "orc_tail"                     , "layer" : "vanity", "lowervanity" : True, "min" : 1, "max" : 2, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Orc Tail", \
 "desc" :  "A knotted tail of hair used as decoration by an orc, there is still a scalp attached." \
},
{"name" : "top_plume"                     , "layer" : "vanity", "lowervanity" : True, "min" : 1, "max" : 1, "value" : 20, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Top Plume", \
 "desc" :  "Top Plume." \
},
{"name" : "wings"                     , "layer" : "vanity", "lowervanity" : True, "min" : 1, "max" : 6, "value" : 20, "con" : 2, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Wings", \
 "desc" :  "A set of feathers arrayed on supports to form wings." \
},
{"name" : "goblin_tail"                     , "layer" : "vanity", "lowervanity" : True, "min" : 1, "max" : 1, "value" : 20, "con" : 3, "stam" : 0, "vis" : 0, "hair" : "false", "beard" : "false",  \
 "title" :  "Goblin Tail", \
 "desc" :  "A knotted tail of hair used as decoration by an goblin." \
}
]


helmets = r"""
<sprite id="italo_norman_helm_named_01" offsetY="35" ic="FF383D5F" width="104" height="142" img="entity\legend_helmets\italo_norman_helm_named_01.png" left="-31" right="30" top="-18" bottom="70" />
<sprite id="italo_norman_helm_named_01_damaged" offsetY="35" ic="FF383D5F" width="104" height="142" img="entity\legend_helmets\italo_norman_helm_named_01_damaged.png" left="-31" right="30" top="-18" bottom="70" />
<sprite id="italo_norman_helm_named_01_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444850" width="131" height="125" img="entity\legend_helmets\italo_norman_helm_named_01_dead.png" left="-60" right="13" top="-68" bottom="5" />
<sprite id="wallace_sallet_named_01" offsetY="35" ic="FF383D5F" width="104" height="142" img="entity\legend_helmets\wallace_sallet_named_01.png" left="-29" right="28" top="-12" bottom="70" />
<sprite id="wallace_sallet_named_01_damaged" offsetY="35" ic="FF383D5F" width="104" height="142" img="entity\legend_helmets\wallace_sallet_named_01_damaged.png" left="-29" right="28" top="-12" bottom="70" />
<sprite id="wallace_sallet_named_01_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444850" width="131" height="125" img="entity\legend_helmets\wallace_sallet_named_01_dead.png" left="-53" right="10" top="-60" bottom="6" />
<sprite id="bascinet_named_01" offsetY="35" ic="FF383D5F" width="104" height="142" img="entity\legend_helmets\bascinet_named_01.png" left="-32" right="32" top="-20" bottom="70" />
<sprite id="bascinet_named_01_damaged" offsetY="35" ic="FF383D5F" width="104" height="142" img="entity\legend_helmets\bascinet_named_01_damaged.png" left="-32" right="32" top="-20" bottom="70" />
<sprite id="bascinet_named_01_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444850" width="131" height="125" img="entity\legend_helmets\bascinet_named_01_dead.png" left="-53" right="20" top="-70" bottom="10" />
<sprite id="barbute_named_01" offsetY="35" ic="FF383D5F" width="104" height="142" img="entity\legend_helmets\barbute_named_01.png" left="-28" right="29" top="-11" bottom="70" />
<sprite id="barbute_named_01_damaged" offsetY="35" ic="FF383D5F" width="104" height="142" img="entity\legend_helmets\barbute_named_01_damaged.png" left="-28" right="29" top="-11" bottom="70" />
<sprite id="barbute_named_01_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444850" width="131" height="125" img="entity\legend_helmets\barbute_named_01_dead.png" left="-44" right="23" top="-64" bottom="8" />
<sprite id="kettle_helm_named_01" offsetY="35" ic="FF383D5F" width="104" height="142" img="entity\legend_helmets\kettle_helm_named_01.png" left="-35" right="33" top="-12" bottom="77" />
<sprite id="kettle_helm_named_01_damaged" offsetY="35" ic="FF383D5F" width="104" height="142" img="entity\legend_helmets\kettle_helm_named_01_damaged.png" left="-35" right="33" top="-12" bottom="77" />
<sprite id="kettle_helm_named_01_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444850" width="131" height="125" img="entity\legend_helmets\kettle_helm_named_01_dead.png" left="-53" right="20" top="-64" bottom="8" />
<sprite id="legend_frogmouth_01" offsetY="35" ic="FF383D5F" width="184" height="222" img="entity\legend_helmets\legend_frogmouth_01.png" left="-41" right="43" top="-28" bottom="106" />
<sprite id="legend_frogmouth_01_damaged" offsetY="35" ic="FF353857" width="184" height="222" img="entity\legend_helmets\legend_frogmouth_01_damaged.png" left="-41" right="43" top="-29" bottom="105" />
<sprite id="legend_frogmouth_01_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF353957" width="191" height="185" img="entity\legend_helmets\legend_frogmouth_01_dead.png" left="-88" right="22" top="-92" bottom="10" />
<sprite id="legend_frogmouth_close_01" offsetY="35" ic="FF383D5F" width="184" height="222" img="entity\legend_helmets\legend_frogmouth_04.png" left="-41" right="43" top="-28" bottom="106" />
<sprite id="legend_frogmouth_close_01_damaged" offsetY="35" ic="FF353857" width="184" height="222" img="entity\legend_helmets\legend_frogmouth_04_damaged.png" left="-41" right="43" top="-29" bottom="105" />
<sprite id="legend_frogmouth_close_01_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF353957" width="191" height="185" img="entity\legend_helmets\legend_frogmouth_04_dead.png" left="-88" right="22" top="-92" bottom="10" />
<sprite id="legend_frogmouth_03" offsetY="35" ic="FF383D5F" width="184" height="222" img="entity\legend_helmets\legend_frogmouth_03.png" left="-41" right="43" top="-28" bottom="106" />
<sprite id="legend_frogmouth_03_damaged" offsetY="35" ic="FF353857" width="184" height="222" img="entity\legend_helmets\legend_frogmouth_03_damaged.png" left="-41" right="43" top="-29" bottom="105" />
<sprite id="legend_frogmouth_03_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF353957" width="191" height="185" img="entity\legend_helmets\legend_frogmouth_03_dead.png" left="-88" right="22" top="-92" bottom="10" />
<sprite id="legend_frogmouth_04" offsetY="35" ic="FF383D5F" width="184" height="222" img="entity\legend_helmets\legend_frogmouth_04.png" left="-41" right="43" top="-28" bottom="106" />
<sprite id="legend_frogmouth_04_damaged" offsetY="35" ic="FF353857" width="184" height="222" img="entity\legend_helmets\legend_frogmouth_04_damaged.png" left="-41" right="43" top="-29" bottom="105" />
<sprite id="legend_frogmouth_04_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF353957" width="191" height="185" img="entity\legend_helmets\legend_frogmouth_04_dead.png" left="-88" right="22" top="-92" bottom="10" />
<sprite id="legend_ancient_gladiator" offsetY="35" ic="FF383D5F" width="184" height="222" img="entity\legend_helmets\legend_ancient_gladiator.png" left="-41" right="43" top="-28" bottom="106" />
<sprite id="legend_ancient_gladiator_damaged" offsetY="35" ic="FF353857" width="184" height="222" img="entity\legend_helmets\legend_ancient_gladiator_damaged.png" left="-41" right="43" top="-29" bottom="105" />
<sprite id="legend_ancient_gladiator_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF353957" width="191" height="185" img="entity\legend_helmets\legend_ancient_gladiator_dead.png" left="-88" right="22" top="-92" bottom="10" />
<sprite id="legend_ancient_legionaire_restored" offsetY="35" ic="FF383D5F" width="184" height="222" img="entity\legend_helmets\legend_ancient_legionaire_restored.png" left="-41" right="43" top="-28" bottom="106" />
<sprite id="legend_ancient_legionaire_restored_damaged" offsetY="35" ic="FF353857" width="184" height="222" img="entity\legend_helmets\legend_ancient_legionaire_restored_damaged.png" left="-41" right="43" top="-29" bottom="105" />
<sprite id="legend_ancient_legionaire_restored_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF353957" width="191" height="185" img="entity\legend_helmets\legend_ancient_legionaire_restored_dead.png" left="-88" right="22" top="-92" bottom="10" />
<sprite id="wizard_cowl_02" offsetY="35" ic="FF403F3F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_02.png" left="-39" right="45" top="-36" bottom="60" />
<sprite id="wizard_cowl_02_damaged" offsetY="35" ic="FF41403F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_02_damaged.png" left="-37" right="45" top="-29" bottom="61" />
<sprite id="wizard_cowl_02_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444343" width="131" height="125" img="entity\legend_helmets\wizard_cowl_02_dead.png" left="-57" right="25" top="-63" bottom="3" />
<sprite id="wizard_cowl_03" offsetY="35" ic="FF403F3F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_03.png" left="-39" right="45" top="-36" bottom="60" />
<sprite id="wizard_cowl_03_damaged" offsetY="35" ic="FF41403F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_03_damaged.png" left="-37" right="45" top="-29" bottom="61" />
<sprite id="wizard_cowl_03_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444343" width="131" height="125" img="entity\legend_helmets\wizard_cowl_03_dead.png" left="-57" right="25" top="-63" bottom="3" />
<sprite id="wizard_cowl_04" offsetY="35" ic="FF403F3F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_04.png" left="-39" right="45" top="-36" bottom="60" />
<sprite id="wizard_cowl_04_damaged" offsetY="35" ic="FF41403F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_04_damaged.png" left="-37" right="45" top="-29" bottom="61" />
<sprite id="wizard_cowl_04_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444343" width="131" height="125" img="entity\legend_helmets\wizard_cowl_04_dead.png" left="-57" right="25" top="-63" bottom="3" />
<sprite id="wizard_cowl_05" offsetY="35" ic="FF403F3F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_05.png" left="-39" right="45" top="-36" bottom="60" />
<sprite id="wizard_cowl_05_damaged" offsetY="35" ic="FF41403F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_05_damaged.png" left="-37" right="45" top="-29" bottom="61" />
<sprite id="wizard_cowl_05_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444343" width="131" height="125" img="entity\legend_helmets\wizard_cowl_05_dead.png" left="-57" right="25" top="-63" bottom="3" />
<sprite id="wizard_cowl_06" offsetY="35" ic="FF403F3F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_06.png" left="-39" right="45" top="-36" bottom="60" />
<sprite id="wizard_cowl_06_damaged" offsetY="35" ic="FF41403F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_06_damaged.png" left="-37" right="45" top="-29" bottom="61" />
<sprite id="wizard_cowl_06_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444343" width="131" height="125" img="entity\legend_helmets\wizard_cowl_06_dead.png" left="-57" right="25" top="-63" bottom="3" />
<sprite id="wizard_cowl_07" offsetY="35" ic="FF403F3F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_07.png" left="-39" right="45" top="-36" bottom="60" />
<sprite id="wizard_cowl_07_damaged" offsetY="35" ic="FF41403F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_07_damaged.png" left="-37" right="45" top="-29" bottom="61" />
<sprite id="wizard_cowl_07_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444343" width="131" height="125" img="entity\legend_helmets\wizard_cowl_07_dead.png" left="-57" right="25" top="-63" bottom="3" />
<sprite id="wizard_cowl_08" offsetY="35" ic="FF403F3F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_08.png" left="-39" right="45" top="-36" bottom="60" />
<sprite id="wizard_cowl_08_damaged" offsetY="35" ic="FF41403F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_08_damaged.png" left="-37" right="45" top="-29" bottom="61" />
<sprite id="wizard_cowl_08_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444343" width="131" height="125" img="entity\legend_helmets\wizard_cowl_08_dead.png" left="-57" right="25" top="-63" bottom="3" />
<sprite id="wizard_cowl_09" offsetY="35" ic="FF403F3F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_09.png" left="-39" right="45" top="-36" bottom="60" />
<sprite id="wizard_cowl_09_damaged" offsetY="35" ic="FF41403F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_09_damaged.png" left="-37" right="45" top="-29" bottom="61" />
<sprite id="wizard_cowl_09_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444343" width="131" height="125" img="entity\legend_helmets\wizard_cowl_09_dead.png" left="-57" right="25" top="-63" bottom="3" />
<sprite id="wizard_cowl_10" offsetY="35" ic="FF403F3F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_10.png" left="-39" right="45" top="-36" bottom="60" />
<sprite id="wizard_cowl_10_damaged" offsetY="35" ic="FF41403F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_10_damaged.png" left="-37" right="45" top="-29" bottom="61" />
<sprite id="wizard_cowl_10_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444343" width="131" height="125" img="entity\legend_helmets\wizard_cowl_10_dead.png" left="-57" right="25" top="-63" bottom="3" />
<sprite id="wizard_cowl_11" offsetY="35" ic="FF403F3F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_11.png" left="-39" right="45" top="-36" bottom="60" />
<sprite id="wizard_cowl_11_damaged" offsetY="35" ic="FF41403F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_11_damaged.png" left="-37" right="45" top="-29" bottom="61" />
<sprite id="wizard_cowl_11_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444343" width="131" height="125" img="entity\legend_helmets\wizard_cowl_11_dead.png" left="-57" right="25" top="-63" bottom="3" />
<sprite id="wizard_cowl_12" offsetY="35" ic="FF403F3F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_12.png" left="-39" right="45" top="-36" bottom="60" />
<sprite id="wizard_cowl_12_damaged" offsetY="35" ic="FF41403F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_12_damaged.png" left="-37" right="45" top="-29" bottom="61" />
<sprite id="wizard_cowl_12_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444343" width="131" height="125" img="entity\legend_helmets\wizard_cowl_12_dead.png" left="-57" right="25" top="-63" bottom="3" />
<sprite id="wizard_cowl_13" offsetY="35" ic="FF403F3F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_13.png" left="-39" right="45" top="-36" bottom="60" />
<sprite id="wizard_cowl_13_damaged" offsetY="35" ic="FF41403F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_13_damaged.png" left="-37" right="45" top="-29" bottom="61" />
<sprite id="wizard_cowl_13_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444343" width="131" height="125" img="entity\legend_helmets\wizard_cowl_13_dead.png" left="-57" right="25" top="-63" bottom="3" />
<sprite id="wizard_cowl_14" offsetY="35" ic="FF403F3F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_14.png" left="-39" right="45" top="-36" bottom="60" />
<sprite id="wizard_cowl_14_damaged" offsetY="35" ic="FF41403F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_14_damaged.png" left="-37" right="45" top="-29" bottom="61" />
<sprite id="wizard_cowl_14_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444343" width="131" height="125" img="entity\legend_helmets\wizard_cowl_14_dead.png" left="-57" right="25" top="-63" bottom="3" />
<sprite id="wizard_cowl_15" offsetY="35" ic="FF403F3F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_15.png" left="-39" right="45" top="-36" bottom="60" />
<sprite id="wizard_cowl_15_damaged" offsetY="35" ic="FF41403F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_15_damaged.png" left="-37" right="45" top="-29" bottom="61" />
<sprite id="wizard_cowl_15_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444343" width="131" height="125" img="entity\legend_helmets\wizard_cowl_15_dead.png" left="-57" right="25" top="-63" bottom="3" />
 <sprite id="wizard_cowl_16" offsetY="35" ic="FF403F3F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_16.png" left="-39" right="45" top="-36" bottom="60" />
<sprite id="wizard_cowl_16_damaged" offsetY="35" ic="FF41403F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_16_damaged.png" left="-37" right="45" top="-29" bottom="61" />
<sprite id="wizard_cowl_16_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444343" width="131" height="125" img="entity\legend_helmets\wizard_cowl_16_dead.png" left="-57" right="25" top="-63" bottom="3" />
 <sprite id="wizard_cowl_17" offsetY="35" ic="FF403F3F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_17.png" left="-39" right="45" top="-36" bottom="60" />
<sprite id="wizard_cowl_17_damaged" offsetY="35" ic="FF41403F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_17_damaged.png" left="-37" right="45" top="-29" bottom="61" />
<sprite id="wizard_cowl_17_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444343" width="131" height="125" img="entity\legend_helmets\wizard_cowl_17_dead.png" left="-57" right="25" top="-63" bottom="3" />
 <sprite id="wizard_cowl_18" offsetY="35" ic="FF403F3F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_18.png" left="-39" right="45" top="-36" bottom="60" />
<sprite id="wizard_cowl_18_damaged" offsetY="35" ic="FF41403F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_18_damaged.png" left="-37" right="45" top="-29" bottom="61" />
<sprite id="wizard_cowl_18_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444343" width="131" height="125" img="entity\legend_helmets\wizard_cowl_18_dead.png" left="-57" right="25" top="-63" bottom="3" />
 <sprite id="wizard_cowl_19" offsetY="35" ic="FF403F3F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_19.png" left="-39" right="45" top="-36" bottom="60" />
<sprite id="wizard_cowl_19_damaged" offsetY="35" ic="FF41403F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_19_damaged.png" left="-37" right="45" top="-29" bottom="61" />
<sprite id="wizard_cowl_19_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444343" width="131" height="125" img="entity\legend_helmets\wizard_cowl_19_dead.png" left="-57" right="25" top="-63" bottom="3" />
 <sprite id="wizard_cowl_20" offsetY="35" ic="FF403F3F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_20.png" left="-39" right="45" top="-36" bottom="60" />
<sprite id="wizard_cowl_20_damaged" offsetY="35" ic="FF41403F" width="104" height="142" img="entity\legend_helmets\wizard_cowl_20_damaged.png" left="-37" right="45" top="-29" bottom="61" />
<sprite id="wizard_cowl_20_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF444343" width="131" height="125" img="entity\legend_helmets\wizard_cowl_20_dead.png" left="-57" right="25" top="-63" bottom="3" />
 <sprite id="jester_hat_01" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_01.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_01_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_01_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_01_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_01_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_02" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_02.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_02_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_02_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_02_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_02_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_03" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_03.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_03_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_03_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_03_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_03_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_04" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_04.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_04_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_04_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_04_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_04_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_05" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_05.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_05_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_05_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_05_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_05_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_06" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_06.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_06_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_06_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_06_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_06_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_07" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_07.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_07_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_07_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_07_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_07_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_08" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_08.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_08_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_08_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_08_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_08_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_09" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_09.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_09_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_09_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_09_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_09_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_10" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_10.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_10_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_10_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_10_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_10_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_11" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_11.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_11_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_11_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_11_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_11_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_12" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_12.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_12_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_12_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_12_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_12_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_13" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_13.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_13_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_13_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_13_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_13_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_14" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_14.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_14_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_14_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_14_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_14_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_15" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_15.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_15_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_15_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_15_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_15_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_16" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_16.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_16_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_16_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_16_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_16_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_17" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_17.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_17_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_17_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_17_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_17_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_18" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_18.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_18_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_18_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_18_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_18_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_19" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_19.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_19_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_19_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_19_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_19_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_20" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_20.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_20_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_20_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_20_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_20_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_21" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_21.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_21_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_21_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_21_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_21_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_22" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_22.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_22_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_22_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_22_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_22_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_23" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_23.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_23_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_23_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_23_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_23_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_24" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_24.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_24_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_24_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_24_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_24_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_25" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_25.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_25_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_25_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_25_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_25_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_26" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_26.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_26_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_26_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_26_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_26_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_27" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_27.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_27_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_27_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_27_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_27_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_28" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_28.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_28_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_28_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_28_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_28_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_29" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_29.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_29_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_29_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_29_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_29_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_30" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_30.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_30_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_30_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_30_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_30_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_31" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_31.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_31_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_31_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_31_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_31_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_32" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_32.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_32_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_32_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_32_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_32_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_33" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_33.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_33_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_33_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_33_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_33_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_34" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_34.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_34_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_34_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_34_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_34_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_35" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_35.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_35_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_35_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_35_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_35_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_36" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_36.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_36_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_36_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_36_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_36_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_37" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_37.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_37_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_37_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_37_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_37_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_38" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_38.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_38_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_38_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_38_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_38_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_39" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_39.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_39_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_39_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_39_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_39_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_40" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_40.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_40_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_40_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_40_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_40_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_41" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_41.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_41_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_41_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_41_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_41_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_42" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_42.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_42_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_42_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_42_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_42_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_43" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_43.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_43_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_43_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_43_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_43_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_44" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_44.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_44_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_44_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_44_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_44_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_45" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_45.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_45_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_45_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_45_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_45_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_46" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_46.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_46_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_46_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_46_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_46_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_47" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_47.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_47_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_47_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_47_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_47_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_48" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_48.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_48_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_48_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_48_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_48_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_49" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_49.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_49_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_49_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_49_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_49_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_50" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_50.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_50_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_50_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_50_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_50_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_51" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_51.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_51_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_51_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_51_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_51_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_52" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_52.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_52_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_52_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_52_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_52_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_53" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_53.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_53_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_53_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_53_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_53_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_54" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_54.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_54_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_54_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_54_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_54_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_55" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_55.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_55_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_55_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_55_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_55_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_56" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_56.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_56_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_56_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_56_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_56_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_57" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_57.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_57_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_57_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_57_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_57_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_58" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_58.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_58_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_58_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_58_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_58_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_59" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_59.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_59_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_59_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_59_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_59_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_60" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_60.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_60_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_60_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_60_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_60_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_61" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_61.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_61_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_61_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_61_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_61_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_62" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_62.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_62_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_62_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_62_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_62_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_63" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_63.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_63_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_63_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_63_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_63_dead.png" left="-70" right="20" top="-76" bottom="4" />
 <sprite id="jester_hat_64" offsetY="35" ic="FF5D5D5B" width="104" height="142" img="entity\legend_helmets\jester_hat_64.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_64_damaged" offsetY="35" ic="FF555552" width="104" height="142" img="entity\legend_helmets\jester_hat_64_damaged.png" left="-38" right="50" top="-14" bottom="70" />
 <sprite id="jester_hat_64_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF585854" width="191" height="185" img="entity\legend_helmets\jester_hat_64_dead.png" left="-70" right="20" top="-76" bottom="4" />
  <sprite id="legendhelms_witchhunter_helm_01" offsetY="35" ic="FF4E5053" width="184" height="222" img="entity\legend_helmets\witchhunter_helm_01.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_witchhunter_helm_02" offsetY="35" ic="FF4E5053" width="184" height="222" img="entity\legend_helmets\witchhunter_helm_02.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_witchhunter_helm_03" offsetY="35" ic="FF4E5053" width="184" height="222" img="entity\legend_helmets\witchhunter_helm_03.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_witchhunter_helm_04" offsetY="35" ic="FF4E5053" width="184" height="222" img="entity\legend_helmets\witchhunter_helm_04.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_witchhunter_helm_05" offsetY="35" ic="FF4E5053" width="184" height="222" img="entity\legend_helmets\witchhunter_helm_05.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_witchhunter_helm_06" offsetY="35" ic="FF4E5053" width="184" height="222" img="entity\legend_helmets\witchhunter_helm_06.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_witchhunter_helm_07" offsetY="35" ic="FF4E5053" width="184" height="222" img="entity\legend_helmets\witchhunter_helm_07.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_witchhunter_helm_01_damaged" offsetY="35" ic="FF4B4D51" width="184" height="222" img="entity\legend_helmets\witchhunter_helm_01_damaged.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_witchhunter_helm_02_damaged" offsetY="35" ic="FF4B4D51" width="184" height="222" img="entity\legend_helmets\witchhunter_helm_02_damaged.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_witchhunter_helm_03_damaged" offsetY="35" ic="FF4B4D51" width="184" height="222" img="entity\legend_helmets\witchhunter_helm_03_damaged.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_witchhunter_helm_04_damaged" offsetY="35" ic="FF4B4D51" width="184" height="222" img="entity\legend_helmets\witchhunter_helm_04_damaged.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_witchhunter_helm_05_damaged" offsetY="35" ic="FF4B4D51" width="184" height="222" img="entity\legend_helmets\witchhunter_helm_05_damaged.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_witchhunter_helm_06_damaged" offsetY="35" ic="FF4B4D51" width="184" height="222" img="entity\legend_helmets\witchhunter_helm_06_damaged.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_witchhunter_helm_07_damaged" offsetY="35" ic="FF4B4D51" width="184" height="222" img="entity\legend_helmets\witchhunter_helm_07_damaged.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_witchhunter_helm_01_dead" offsetX="6" offsetY="10" f="64F0" ic="FF222933" width="131" height="125" img="entity\legend_helmets\witchhunter_helm_01_dead.png" left="-57" right="59" top="-53" bottom="55" />
<sprite id="legendhelms_witchhunter_helm_02_dead" offsetX="6" offsetY="10" f="64F0" ic="FF222933" width="131" height="125" img="entity\legend_helmets\witchhunter_helm_02_dead.png" left="-57" right="59" top="-53" bottom="55" />
<sprite id="legendhelms_witchhunter_helm_03_dead" offsetX="6" offsetY="10" f="64F0" ic="FF222933" width="131" height="125" img="entity\legend_helmets\witchhunter_helm_03_dead.png" left="-57" right="59" top="-53" bottom="55" />
<sprite id="legendhelms_witchhunter_helm_04_dead" offsetX="6" offsetY="10" f="64F0" ic="FF222933" width="131" height="125" img="entity\legend_helmets\witchhunter_helm_04_dead.png" left="-57" right="59" top="-53" bottom="55" />
<sprite id="legendhelms_witchhunter_helm_05_dead" offsetX="6" offsetY="10" f="64F0" ic="FF222933" width="131" height="125" img="entity\legend_helmets\witchhunter_helm_05_dead.png" left="-57" right="59" top="-53" bottom="55" />
<sprite id="legendhelms_witchhunter_helm_06_dead" offsetX="6" offsetY="10" f="64F0" ic="FF222933" width="131" height="125" img="entity\legend_helmets\witchhunter_helm_06_dead.png" left="-57" right="59" top="-53" bottom="55" />
<sprite id="legendhelms_witchhunter_helm_07_dead" offsetX="6" offsetY="10" f="64F0" ic="FF222933" width="131" height="125" img="entity\legend_helmets\witchhunter_helm_07_dead.png" left="-57" right="59" top="-53" bottom="55" />
<sprite id="legendhelms_white_wolf_helm_01" offsetY="35" ic="FF4E5053" width="184" height="222" img="entity\legend_helmets\white_wolf_helm_01.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_white_wolf_helm_01_damaged" offsetY="35" ic="FF4B4D51" width="184" height="222" img="entity\legend_helmets\white_wolf_helm_01_damaged.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_white_wolf_helm_01_dead" offsetX="6" offsetY="10" f="64F0" ic="FF222933" width="131" height="125" img="entity\legend_helmets\white_wolf_helm_01_dead.png" left="-57" right="59" top="-53" bottom="55" />
<sprite id="legendhelms_lindwurm_helm_01" offsetY="35" ic="FF4E5053" width="184" height="222" img="entity\legend_helmets\lindwurm_helm_01.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_lindwurm_helm_01_damaged" offsetY="35" ic="FF4B4D51" width="184" height="222" img="entity\legend_helmets\lindwurm_helm_01_damaged.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_lindwurm_helm_01_dead" offsetX="6" offsetY="10" f="64F0" ic="FF222933" width="131" height="125" img="entity\legend_helmets\lindwurm_helm_01_dead.png" left="-57" right="59" top="-53" bottom="55" />
<sprite id="legendhelms_redback_helm_01" offsetY="35" ic="FF4E5053" width="184" height="222" img="entity\legend_helmets\redback_helm_01.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_redback_helm_01_damaged" offsetY="35" ic="FF4B4D51" width="184" height="222" img="entity\legend_helmets\redback_helm_01_damaged.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_redback_helm_01_dead" offsetX="6" offsetY="10" f="64F0" ic="FF222933" width="131" height="125" img="entity\legend_helmets\redback_helm_01_dead.png" left="-57" right="59" top="-53" bottom="55" />
<sprite id="legendhelms_nach_helm_01" offsetY="35" ic="FF4E5053" width="184" height="222" img="entity\legend_helmets\nach_helm_01.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_nach_helm_01_damaged" offsetY="35" ic="FF4B4D51" width="184" height="222" img="entity\legend_helmets\nach_helm_01_damaged.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_nach_helm_01_dead" offsetX="6" offsetY="10" f="64F0" ic="FF222933" width="131" height="125" img="entity\legend_helmets\nach_helm_01_dead.png" left="-57" right="59" top="-53" bottom="55" />
<sprite id="legendhelms_mountain_helm_01" offsetY="35" ic="FF4E5053" width="184" height="222" img="entity\legend_helmets\mountain_helm_01.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_mountain_helm_01_damaged" offsetY="35" ic="FF4B4D51" width="184" height="222" img="entity\legend_helmets\mountain_helm_01_damaged.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_mountain_helm_01_dead" offsetX="6" offsetY="10" f="64F0" ic="FF222933" width="131" height="125" img="entity\legend_helmets\mountain_helm_01_dead.png" left="-57" right="59" top="-53" bottom="55" />
<sprite id="legendhelms_demon_alp_helm_01" offsetY="35" ic="FF4E5053" width="184" height="222" img="entity\legend_helmets\demon_alp_helm_01.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_demon_alp_helm_01_damaged" offsetY="35" ic="FF4B4D51" width="184" height="222" img="entity\legend_helmets\demon_alp_helm_01_damaged.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legendhelms_demon_alp_helm_01_dead" offsetX="6" offsetY="10" f="64F0" ic="FF222933" width="131" height="125" img="entity\legend_helmets\demon_alp_helm_01_dead.png" left="-57" right="59" top="-53" bottom="55" />


  <sprite id="jester_helm_01" offsetY="35" ic="FF2E5B82" width="184" height="222" img="entity\legend_helmets\jester_helm_01.png" left="-34" right="42" top="-28" bottom="100" />
  <sprite id="jester_helm_01_damaged" offsetY="35" ic="FF2E5374" width="184" height="222" img="entity\legend_helmets\jester_helm_01_damaged.png" left="-34" right="42" top="-29" bottom="87" />
  <sprite id="jester_helm_01_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF305374" width="191" height="185" img="entity\legend_helmets\jester_helm_01_dead.png" left="-80" right="22" top="-76" bottom="8" />

  <sprite id="jester_helm_02" offsetY="35" ic="FF2E5B82" width="184" height="222" img="entity\legend_helmets\jester_helm_02.png" left="-34" right="42" top="-28" bottom="100" />
  <sprite id="jester_helm_02_damaged" offsetY="35" ic="FF2E5374" width="184" height="222" img="entity\legend_helmets\jester_helm_02_damaged.png" left="-34" right="42" top="-29" bottom="87" />
  <sprite id="jester_helm_02_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF305374" width="191" height="185" img="entity\legend_helmets\jester_helm_02_dead.png" left="-80" right="22" top="-76" bottom="8" />

  <sprite id="jester_helm_03" offsetY="35" ic="FF2E5B82" width="184" height="222" img="entity\legend_helmets\jester_helm_03.png" left="-34" right="42" top="-28" bottom="100" />
  <sprite id="jester_helm_03_damaged" offsetY="35" ic="FF2E5374" width="184" height="222" img="entity\legend_helmets\jester_helm_03_damaged.png" left="-34" right="42" top="-29" bottom="87" />
  <sprite id="jester_helm_03_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF305374" width="191" height="185" img="entity\legend_helmets\jester_helm_03_dead.png" left="-80" right="22" top="-76" bottom="8" />

  <sprite id="jester_helm_04" offsetY="35" ic="FF2E5B82" width="184" height="222" img="entity\legend_helmets\jester_helm_04.png" left="-34" right="42" top="-28" bottom="100" />
  <sprite id="jester_helm_04_damaged" offsetY="35" ic="FF2E5374" width="184" height="222" img="entity\legend_helmets\jester_helm_04_damaged.png" left="-34" right="42" top="-29" bottom="87" />
  <sprite id="jester_helm_04_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF305374" width="191" height="185" img="entity\legend_helmets\jester_helm_04_dead.png" left="-80" right="22" top="-76" bottom="8" />

  <sprite id="jester_helm_05" offsetY="35" ic="FF2E5B82" width="184" height="222" img="entity\legend_helmets\jester_helm_05.png" left="-34" right="42" top="-28" bottom="100" />
  <sprite id="jester_helm_05_damaged" offsetY="35" ic="FF2E5374" width="184" height="222" img="entity\legend_helmets\jester_helm_05_damaged.png" left="-34" right="42" top="-29" bottom="87" />
  <sprite id="jester_helm_05_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF305374" width="191" height="185" img="entity\legend_helmets\jester_helm_05_dead.png" left="-80" right="22" top="-76" bottom="8" />

  <sprite id="jester_helm_06" offsetY="35" ic="FF2E5B82" width="184" height="222" img="entity\legend_helmets\jester_helm_06.png" left="-34" right="42" top="-28" bottom="100" />
  <sprite id="jester_helm_06_damaged" offsetY="35" ic="FF2E5374" width="184" height="222" img="entity\legend_helmets\jester_helm_06_damaged.png" left="-34" right="42" top="-29" bottom="87" />
  <sprite id="jester_helm_06_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF305374" width="191" height="185" img="entity\legend_helmets\jester_helm_06_dead.png" left="-80" right="22" top="-76" bottom="8" />

  <sprite id="jester_padded_01" offsetY="35" ic="FF2E5B82" width="184" height="222" img="entity\legend_helmets\jester_padded_01.png" left="-34" right="42" top="-28" bottom="100" />
  <sprite id="jester_padded_01_damaged" offsetY="35" ic="FF2E5374" width="184" height="222" img="entity\legend_helmets\jester_padded_01_damaged.png" left="-34" right="42" top="-29" bottom="87" />
  <sprite id="jester_padded_01_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF305374" width="191" height="185" img="entity\legend_helmets\jester_padded_01_dead.png" left="-80" right="22" top="-76" bottom="8" />

  <sprite id="jester_padded_02" offsetY="35" ic="FF2E5B82" width="184" height="222" img="entity\legend_helmets\jester_padded_02.png" left="-34" right="42" top="-28" bottom="100" />
  <sprite id="jester_padded_02_damaged" offsetY="35" ic="FF2E5374" width="184" height="222" img="entity\legend_helmets\jester_padded_02_damaged.png" left="-34" right="42" top="-29" bottom="87" />
  <sprite id="jester_padded_02_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF305374" width="191" height="185" img="entity\legend_helmets\jester_padded_02_dead.png" left="-80" right="22" top="-76" bottom="8" />
  <sprite id="jester_padded_03" offsetY="35" ic="FF2E5B82" width="184" height="222" img="entity\legend_helmets\jester_padded_03.png" left="-34" right="42" top="-28" bottom="100" />
  <sprite id="jester_padded_03_damaged" offsetY="35" ic="FF2E5374" width="184" height="222" img="entity\legend_helmets\jester_padded_03_damaged.png" left="-34" right="42" top="-29" bottom="87" />
  <sprite id="jester_padded_03_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF305374" width="191" height="185" img="entity\legend_helmets\jester_padded_03_dead.png" left="-80" right="22" top="-76" bottom="8" />

  <sprite id="jester_padded_04" offsetY="35" ic="FF2E5B82" width="184" height="222" img="entity\legend_helmets\jester_padded_04.png" left="-34" right="42" top="-28" bottom="100" />
  <sprite id="jester_padded_04_damaged" offsetY="35" ic="FF2E5374" width="184" height="222" img="entity\legend_helmets\jester_padded_04_damaged.png" left="-34" right="42" top="-29" bottom="87" />
  <sprite id="jester_padded_04_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF305374" width="191" height="185" img="entity\legend_helmets\jester_padded_04_dead.png" left="-80" right="22" top="-76" bottom="8" />
  <sprite id="jester_padded_05" offsetY="35" ic="FF2E5B82" width="184" height="222" img="entity\legend_helmets\jester_padded_05.png" left="-34" right="42" top="-28" bottom="100" />
  <sprite id="jester_padded_05_damaged" offsetY="35" ic="FF2E5374" width="184" height="222" img="entity\legend_helmets\jester_padded_05_damaged.png" left="-34" right="42" top="-29" bottom="87" />
  <sprite id="jester_padded_05_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF305374" width="191" height="185" img="entity\legend_helmets\jester_padded_05_dead.png" left="-80" right="22" top="-76" bottom="8" />
  <sprite id="jester_padded_06" offsetY="35" ic="FF2E5B82" width="184" height="222" img="entity\legend_helmets\jester_padded_06.png" left="-34" right="42" top="-28" bottom="100" />
  <sprite id="jester_padded_06_damaged" offsetY="35" ic="FF2E5374" width="184" height="222" img="entity\legend_helmets\jester_padded_06_damaged.png" left="-34" right="42" top="-29" bottom="87" />
  <sprite id="jester_padded_06_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF305374" width="191" height="185" img="entity\legend_helmets\jester_padded_06_dead.png" left="-80" right="22" top="-76" bottom="8" />
  <sprite id="jester_padded_07" offsetY="35" ic="FF2E5B82" width="184" height="222" img="entity\legend_helmets\jester_padded_07.png" left="-34" right="42" top="-28" bottom="100" />
  <sprite id="jester_padded_07_damaged" offsetY="35" ic="FF2E5374" width="184" height="222" img="entity\legend_helmets\jester_padded_07_damaged.png" left="-34" right="42" top="-29" bottom="87" />
  <sprite id="jester_padded_07_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF305374" width="191" height="185" img="entity\legend_helmets\jester_padded_07_dead.png" left="-80" right="22" top="-76" bottom="8" />
  <sprite id="jester_padded_08" offsetY="35" ic="FF2E5B82" width="184" height="222" img="entity\legend_helmets\jester_padded_08.png" left="-34" right="42" top="-28" bottom="100" />
  <sprite id="jester_padded_08_damaged" offsetY="35" ic="FF2E5374" width="184" height="222" img="entity\legend_helmets\jester_padded_08_damaged.png" left="-34" right="42" top="-29" bottom="87" />
  <sprite id="jester_padded_08_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF305374" width="191" height="185" img="entity\legend_helmets\jester_padded_08_dead.png" left="-80" right="22" top="-76" bottom="8" />
  <sprite id="jester_padded_09" offsetY="35" ic="FF2E5B82" width="184" height="222" img="entity\legend_helmets\jester_padded_09.png" left="-34" right="42" top="-28" bottom="100" />
  <sprite id="jester_padded_09_damaged" offsetY="35" ic="FF2E5374" width="184" height="222" img="entity\legend_helmets\jester_padded_09_damaged.png" left="-34" right="42" top="-29" bottom="87" />
  <sprite id="jester_padded_09_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF305374" width="191" height="185" img="entity\legend_helmets\jester_padded_09_dead.png" left="-80" right="22" top="-76" bottom="8" />
  <sprite id="jester_padded_10" offsetY="35" ic="FF2E5B82" width="184" height="222" img="entity\legend_helmets\jester_padded_10.png" left="-34" right="42" top="-28" bottom="100" />
  <sprite id="jester_padded_10_damaged" offsetY="35" ic="FF2E5374" width="184" height="222" img="entity\legend_helmets\jester_padded_10_damaged.png" left="-34" right="42" top="-29" bottom="87" />
  <sprite id="jester_padded_10_dead" offsetX="6" offsetY="10" f="64F0" f1="-15" f2="-15" ic="FF305374" width="191" height="185" img="entity\legend_helmets\jester_padded_10_dead.png" left="-80" right="22" top="-76" bottom="8" />
<sprite id="legend_jewelry_01" offsetY="35" ic="FF4E5053" width="184" height="222" img="entity\legend_helmets\legend_jewelry_01.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legend_jewelry_01_damaged" offsetY="35" ic="FF4B4D51" width="184" height="222" img="entity\legend_helmets\legend_jewelry_01_damaged.png" left="-67" right="68" top="-40" bottom="108" />
<sprite id="legend_jewelry_01_dead" offsetX="6" offsetY="10" f="64F0" ic="FF222933" width="131" height="125" img="entity\legend_helmets\legend_jewelry_01_dead.png" left="-57" right="59" top="-53" bottom="55" />

"""

def checkForIcon(iconpath, variants):
    dirpath = os.path.join(os.path.dirname(os.path.abspath(__file__)), "gfx", "ui", "items", "legend_helmets")
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

def makeSheet(num):
    dirpath = os.path.join(os.path.dirname(os.path.abspath(__file__)), "unpacked", "legend_helmets", "" + str(num))
    if not os.path.exists(dirpath):
        os.makedirs(dirpath)

    filepath = os.path.join(dirpath, "metadata.xml")
    F = open(filepath, "w")
    F.write('<brush name="gfx/legend_helmets_' + str(num) + '.png" version="17">\n')
    return F

def makeBrushes():
    filepath = os.path.join(os.path.dirname(os.path.abspath(__file__)), "unpacked", "legend_helmets", "metadata.xml")
    F = open(filepath, "w")
    F.write('<brush name="gfx/legend_helmets.png" version="17">\n')
    F.write(helmets)
    F.write('</brush>\n')
    F.close()

    fileCount = 0
    imageCount = 0
    F = makeSheet(fileCount)

    L = [BLayer, BLayerDamaged, BLayerDead]
    for d in layers:
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
                opts = dict(
                    name="legendhelms_" + name,
                    damaged= "legendhelms_" + name + "_damaged",
                    dead= "legendhelms_" + name + "_dead",
                    name_path=os.path.join("..", "entity", "legend_helmets", "layers", name + ".png"),
                    damaged_path=os.path.join("..", "entity", "legend_helmets", "layers", name + "_damaged.png"),
                    dead_path=os.path.join("..", "entity", "legend_helmets", "layers", name + "_dead.png")
                )
                s = Template(t)
                text = s.substitute(opts)
                text.replace("/", "\\")
                F.write(text)
                imageCount += 1
                if (imageCount > 150):
                    F.write('</brush>\n')
                    F.close()
                    imageCount = 0
                    fileCount += 1
                    F = makeSheet(fileCount)

    for d in brush_only_layers:
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
                opts = dict(
                    name="legendhelms_" + name,
                    damaged= "legendhelms_" + name + "_damaged",
                    dead= "legendhelms_" + name + "_dead",
                    name_path=os.path.join("..", "entity", "legend_helmets", "layers", name + ".png"),
                    damaged_path=os.path.join("..", "entity", "legend_helmets", "layers", name + "_damaged.png"),
                    dead_path=os.path.join("..", "entity", "legend_helmets", "layers", name + "_dead.png")
                )
                s = Template(t)
                text = s.substitute(opts)
                text.replace("/", "\\")
                F.write(text)
                imageCount += 1
                if (imageCount > 150):
                    F.write('</brush>\n')
                    F.close()
                    imageCount = 0
                    fileCount += 1
                    F = makeSheet(fileCount)


    F.write('</brush>\n')
    F.close()

def main():
    has_missing = False
    for d in layers:

        layer = d["layer"]

        lower = "false"

        temp = Layer
        if "base" in d:
            temp = BaseLayer
        if "named" in d:
            temp = NamedLayer

        if "lowervanity" in d:
            layer += "_lower"
            lower = "true"

        fname = "legend_helmet_" + d["name"]

        # print('"' + layer + '/' + fname + '",')
        # continue

        dirpath = os.path.join(os.path.dirname(os.path.abspath(__file__)), "helmet_scripts", layer)
        if not os.path.exists(dirpath):
            os.makedirs(dirpath)

        filepath = os.path.join(dirpath, fname + ".nut")
        F = open(filepath, "w")
        variants = []
        for x in range(d["max"]):
            variants.append(x+1)

        title = d["title"]
        desc = d["desc"]

        has_missing = has_missing or checkForIcon("inventory_" + d["name"], variants)

        itemType = "this.m.ItemType"
        if "itemType" in d:
            itemType += " | " + d["itemType"]

        opts = dict(
            test="true",
            name=fname,
            title=title,
            desc=desc,
            condition = d["con"],
            value = d["value"],
            stamina = d["stam"],
            vision = d["vis"],
            id="armor.head." + fname,
            variants = variants,
            layer = layer,
            type= d["layer"].capitalize(),
            brush = "legendhelms_" + d["name"],
            icon = "inventory_" + d["name"],
            lower = lower,
            hair = d["hair"],
            beard = d["beard"],
            names = d["names"] if "names" in d else [],
            rminViz = d["rminViz"] if "rminViz" in d else 0,
            rmaxViz = d["rmaxViz"] if "rmaxViz" in d else 0,
            rminStam = d["rminStam"] if "rminStam" in d else 0,
            rmaxStam = d["rmaxStam"] if "rmaxStam" in d else 0,
            rminCond = d["rminCond"] if "rminCond" in d else 0,
            rmaxCond = d["rmaxCond"] if "rmaxCond" in d else 0,
            itemType = itemType,
        )
        s = Template(temp)
        text = s.substitute(opts)
        F.write(text)
        F.close()

        # print('[1, "' + layer + '/' + fname + '"], //' + str(d["con"]))
        # WR = open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "temp.nut"), "w")
        # F = open("search.txt")
        # WR.write("gt.Const.LegendMod.HelmetObjs <- [")
        # while True:
        #     line1 = F.readline()
        #     line2 = F.readline()
        #     whitespace = F.readline()
        #     if not line2: break
        #     line1 = line1.split("\\")
        #     if line1[-2] != 'helmets':
        #         line1 = line1[-2] + "\\" + line1[-1]
        #     else:
        #         line1 = line1[-1]
        #     line1 = line1[:-6]
        #     line2 = line2.rsplit(" ")
        #     line2 = line2[-1]
        #     line2 = line2[:-2]
        #     s = Template(HelmObj)
        #     text = s.substitute(dict(id=line1, value=line2))
        #     WR.write(text)
        # WR.write("]")
        # WR.close()


    makeBrushes()

    if has_missing:
        raise ValueError("Missing gfx icons")

    # filepath = os.path.join(os.path.dirname(os.path.abspath(__file__)), "temp.nut")
    # F = open(filepath, "w")
    # F.write("gt.Const.LegendMod.HelmetObjs <- [")
    # for v in vanilla:
    #     s = Template(HelmObj)
    #     text = s.substitute(dict(id=v))
    #     F.write(text)
    # F.write("]")
    # F.close()


main()


'''

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
        [1, "hood/legend_helmet_cloth_long_hood"], //30
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
'''
