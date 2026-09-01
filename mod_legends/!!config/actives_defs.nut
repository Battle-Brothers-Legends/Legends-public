if (!("Actives" in ::Legends)) {
	::Legends.Actives <- {};
}

if (!("Active" in ::Legends)) {
	::Legends.Active <- {};
}

::Legends.Actives.ActiveDefObjects <- [];

::Legends.Actives.addActiveDefObjects <- function (_activeDefObjects) {
	local size = ::Legends.Actives.ActiveDefObjects.len();
	::Legends.Actives.ActiveDefObjects.extend(_activeDefObjects);
	foreach (i, activeDefObject in _activeDefObjects) {
		if (activeDefObject.Const in ::Legends.Active) {
			::Legends.Active[activeDefObject.Const] = size + i;
		} else {
			::Legends.Active[activeDefObject.Const] <- size + i;
		}
	}
}

local activesDefs = [];

::Legends.Active.Adrenaline <- null;
activesDefs.push({
	ID = "actives.adrenaline",
	Script = "scripts/skills/actives/adrenaline_skill",
	Const = "Adrenaline",
	Name = "Adrenaline",
	Icon = "ui/perks/perk_37_active.png",
	IconDisabled = "ui/perks/perk_37_active_sw.png",
	Overlay = "perk_37_active",
});

::Legends.Active.AimedShot <- null;
activesDefs.push({
	ID = "actives.aimed_shot",
	Script = "scripts/skills/actives/aimed_shot",
	Const = "AimedShot",
	Name = "Aimed Shot",
	Icon = "skills/active_18.png",
	IconDisabled = "skills/active_18_sw.png",
	Overlay = "active_18",
});

::Legends.Active.AlpTeleport <- null;
activesDefs.push({
	ID = "actives.alp_teleport",
	Script = "scripts/skills/actives/alp_teleport_skill",
	Const = "AlpTeleport",
	Name = "Fade",
	Icon = "",
	IconDisabled = "",
	Overlay = "",
});

::Legends.Active.Assault <- null;
activesDefs.push({
	ID = "actives.assault",
	Script = "scripts/skills/actives/assault_skill",
	Const = "Assault",
	Name = "Assault",
	Icon = "skills/active_240.png",
	IconDisabled = "skills/active_240_sw.png",
	Overlay = "active_240",
});

::Legends.Active.BandageAlly <- null;
activesDefs.push({
	ID = "actives.bandage_ally",
	Script = "scripts/skills/actives/bandage_ally_skill",
	Const = "BandageAlly",
	Name = "Use Bandages",
	Icon = "skills/active_105.png",
	IconDisabled = "skills/active_105_sw.png",
	Overlay = "active_105",
});

::Legends.Active.BarbarianFury <- null;
activesDefs.push({
	ID = "actives.barbarian_fury",
	Script = "scripts/skills/actives/barbarian_fury_skill",
	Const = "BarbarianFury",
	Name = "Barbarian Fury",
		Icon = "ui/skills/active_175.png",
		IconDisabled = "ui/skills/active_175.png",
		Overlay = "active_175",
});

::Legends.Active.Bash <- null;
activesDefs.push({
	ID = "actives.bash",
	Script = "scripts/skills/actives/bash",
	Const = "Bash",
	Name = "Bash",
	Icon = "skills/active_02.png",
	IconDisabled = "skills/active_02_sw.png",
	Overlay = "active_02",
});

::Legends.Active.Batter <- null;
activesDefs.push({
	ID = "actives.batter",
	Script = "scripts/skills/actives/batter_skill",
	Const = "Batter",
	Name = "Batter",
	Icon = "skills/active_136.png",
	IconDisabled = "skills/active_136_sw.png",
	Overlay = "active_136",
});

::Legends.Active.BerserkerMushrooms <- null;
activesDefs.push({
	ID = "actives.berserker_mushrooms",
	Script = "scripts/skills/actives/berserker_mushrooms_skill",
	Const = "BerserkerMushrooms",
	Name = "Eat or Give Strange Mushrooms",
	Icon = "skills/active_98.png",
	IconDisabled = "skills/active_98_sw.png",
	Overlay = "active_98",
});

::Legends.Active.BreakAllyFree <- null;
activesDefs.push({
	ID = "actives.break_ally_free",
	Script = "scripts/skills/actives/break_ally_free_skill",
	Const = "BreakAllyFree",
	Name = "Free Ally",
	Icon = "skills/active_151.png",
	IconDisabled = "skills/active_151_sw.png",
	Overlay = "active_151",
});

::Legends.Active.BreakFree <- null;
activesDefs.push({
	ID = "actives.break_free",
	Script = "scripts/skills/actives/break_free_skill",
	Const = "BreakFree",
	Name = "Break Free",
	Icon = "skills/active_15.png",
	IconDisabled = "skills/active_15_sw.png",
	Overlay = "active_15",
});

::Legends.Active.Cascade <- null;
activesDefs.push({
	ID = "actives.cascade",
	Script = "scripts/skills/actives/cascade_skill",
	Const = "Cascade",
	Name = "Cascade",
	Icon = "skills/active_125.png",
	IconDisabled = "skills/active_125_sw.png",
	Overlay = "active_125",
});

::Legends.Active.CenserCastigate <- null;
activesDefs.push({
	ID = "actives.censer_castigate",
	Script = "scripts/skills/actives/censer_castigate_skill",
	Const = "CenserCastigate",
	Name = "Castigate",
	Icon = "skills/active_231.png",
	IconDisabled = "skills/active_231_sw.png",
	Overlay = "active_231",
});

::Legends.Active.CenserStrike <- null;
activesDefs.push({
	ID = "actives.censer_strike",
	Script = "scripts/skills/actives/censer_strike",
	Const = "CenserStrike",
	Name = "Censer Strike",
	Icon = "skills/active_228.png",
	IconDisabled = "skills/active_228_sw.png",
	Overlay = "active_228",
});

::Legends.Active.Charge <- null;
activesDefs.push({
	ID = "actives.charge",
	Script = "scripts/skills/actives/charge",
	Const = "Charge",
	Name = "Charge",
	Icon = "skills/active_52.png",
	IconDisabled = "skills/active_52_sw.png",
	Overlay = "active_52",
});

::Legends.Active.Charm <- null;
activesDefs.push({
	ID = "actives.charm",
	Script = "scripts/skills/actives/charm_skill",
	Const = "Charm",
	Name = "Charm",
	Icon = "skills/active_120.png",
	IconDisabled = "skills/active_120.png",
	Overlay = "active_120",
});

::Legends.Active.Chop <- null;
activesDefs.push({
	ID = "actives.chop",
	Script = "scripts/skills/actives/chop",
	Const = "Chop",
	Name = "Chop",
	Icon = "skills/active_25.png",
	IconDisabled = "skills/active_25_sw.png",
	Overlay = "active_25",
});

::Legends.Active.Cleave <- null;
activesDefs.push({
	ID = "actives.cleave",
	Script = "scripts/skills/actives/cleave",
	Const = "Cleave",
	Name = "Cleave",
	Icon = "skills/active_19.png",
	IconDisabled = "skills/active_19_sw.png",
	Overlay = "active_19",
});

::Legends.Active.CoatWithPoison <- null;
activesDefs.push({
	ID = "actives.coat_with_poison",
	Script = "scripts/skills/actives/coat_with_poison_skill",
	Const = "CoatWithPoison",
	Name = "Use Poison",
	Icon = "skills/active_95.png",
	IconDisabled = "skills/active_95_sw.png",
	Overlay = "active_95",
});

::Legends.Active.CoatWithSpiderPoison <- null;
activesDefs.push({
	ID = "actives.coat_with_spider_poison",
	Script = "scripts/skills/actives/coat_with_spider_poison_skill",
	Const = "CoatWithSpiderPoison",
	Name = "Use Poisoned Oil",
	Icon = "skills/active_139.png",
	IconDisabled = "skills/active_139_sw.png",
	Overlay = "active_139",
});

::Legends.Active.CorpseExplosion <- null;
activesDefs.push({
	ID = "actives.corpse_explosion",
	Script = "scripts/skills/actives/corpse_explosion_skill",
	Const = "CorpseExplosion",
	Name = "Corpse Explosion",
	Icon = "skills/active_234.png",
	IconDisabled = "skills/active_234.png",
	Overlay = "active_234",
});

::Legends.Active.CorpseHurl <- null;
activesDefs.push({
	ID = "actives.corpse_hurl_skill",
	Script = "scripts/skills/actives/corpse_hurl_skill",
	Const = "CorpseHurl",
	Name = "Corpse Hurl",
	Icon = "skills/active_233.png",
	IconDisabled = "skills/active_233.png",
	Overlay = "active_233",
});

::Legends.Active.CrackTheWhip <- null;
activesDefs.push({
	ID = "actives.crack_the_whip",
	Script = "scripts/skills/actives/crack_the_whip_skill",
	Const = "CrackTheWhip",
	Name = "Crack the Whip",
	Icon = "skills/active_162.png",
	IconDisabled = "skills/active_162.png",
	Overlay = "active_162",
});

::Legends.Active.Crumble <- null;
activesDefs.push({
	ID = "actives.crumble",
	Script = "scripts/skills/actives/crumble_skill",
	Const = "Crumble",
	Name = "Crumble",
	Icon = "skills/active_205.png",
	IconDisabled = "skills/active_205_sw.png",
	Overlay = "active_205",
});

::Legends.Active.CrushArmor <- null;
activesDefs.push({
	ID = "actives.crush_armor",
	Script = "scripts/skills/actives/crush_armor",
	Const = "CrushArmor",
	Name = "Destroy Armor",
	Icon = "skills/active_36.png",
	IconDisabled = "skills/active_36_sw.png",
	Overlay = "active_36",
});

::Legends.Active.Cudgel <- null;
activesDefs.push({
	ID = "actives.cudgel",
	Script = "scripts/skills/actives/cudgel_skill",
	Const = "Cudgel",
	Name = "Cudgel",
	Icon = "skills/active_133.png",
	IconDisabled = "skills/active_133_sw.png",
	Overlay = "active_133",
});

::Legends.Active.Darkflight <- null;
activesDefs.push({
	ID = "actives.darkflight",
	Script = "scripts/skills/actives/darkflight",
	Const = "Darkflight",
	Name = "Darkflight",
	Icon = "skills/darkflight.png",
	IconDisabled = "skills/darkflight_bw.png",
	Overlay = "active_28",
});

::Legends.Active.Deathblow <- null;
activesDefs.push({
	ID = "actives.deathblow",
	Script = "scripts/skills/actives/deathblow_skill",
	Const = "Deathblow",
	Name = "Deathblow",
	Icon = "skills/active_199.png",
	IconDisabled = "skills/active_199_sw.png",
	Overlay = "active_199",
});

::Legends.Active.Debilitate <- null; // vanilla implementation - activate and next strike debilitates / shelved
activesDefs.push({
	ID = "actives.debilitate",
	Script = "scripts/skills/actives/debilitate",
	Const = "Debilitate",
	Name = "Debilitate",
	Icon = "ui/perks/perk_34_active.png",
	IconDisabled = "ui/perks/perk_34_active_sw.png",
	Overlay = "perk_34_active",
});

::Legends.Active.Decapitate <- null;
activesDefs.push({
	ID = "actives.decapitate",
	Script = "scripts/skills/actives/decapitate",
	Const = "Decapitate",
	Name = "Decapitate",
	Icon = "skills/active_34.png",
	IconDisabled = "skills/active_34_sw.png",
	Overlay = "active_34",
});

::Legends.Active.DemolishArmor <- null;
activesDefs.push({
	ID = "actives.demolish_armor",
	Script = "scripts/skills/actives/demolish_armor_skill",
	Const = "DemolishArmor",
	Name = "Demolish Armor",
	Icon = "skills/active_137.png",
	IconDisabled = "skills/active_137_sw.png",
	Overlay = "active_137",
});

::Legends.Active.Disarm <- null;
activesDefs.push({
	ID = "actives.disarm",
	Script = "scripts/skills/actives/disarm_skill",
	Const = "Disarm",
	Name = "Disarm",
	Icon = "skills/active_170.png",
	IconDisabled = "skills/active_170_sw.png",
	Overlay = "active_170",
});

::Legends.Active.DrinkAntidote <- null;
activesDefs.push({
	ID = "actives.drink_antidote",
	Script = "scripts/skills/actives/drink_antidote_skill",
	Const = "DrinkAntidote",
	Name = "Drink or Give Antidote",
	Icon = "skills/active_96.png",
	IconDisabled = "skills/active_96_sw.png",
	Overlay = "active_96",
});

::Legends.Active.DrumsOfWar <- null;
activesDefs.push({
	ID = "actives.drums_of_war",
	Script = "scripts/skills/actives/drums_of_war_skill",
	Const = "DrumsOfWar",
	Name = "Drums of War",
	Icon = "skills/active_163.png",
	IconDisabled = "skills/active_163.png",
	Overlay = "active_163",
});

::Legends.Active.EstocStab <- null;
activesDefs.push({
	ID = "actives.estoc_stab",
	Script = "scripts/skills/actives/estoc_stab_skill",
	Const = "EstocStab",
	Name = "Stab",
	Icon = "skills/active_236.png",
	IconDisabled = "skills/active_236_sw.png",
	Overlay = "active_236",
});

::Legends.Active.Execute <- null;
activesDefs.push({
	ID = "actives.execute",
	Script = "scripts/skills/actives/execute_skill",
	Const = "Execute",
	Name = "Execute",
	Icon = "skills/active_239.png",
	IconDisabled = "skills/active_239_sw.png",
	Overlay = "active_239",
});

::Legends.Active.ExeSwordDecapitate <- null;
activesDefs.push({
	ID = "actives.exesword_decapitate",
	Script = "scripts/skills/actives/exesword_decapitate",
	Const = "ExeSwordDecapitate",
	Name = "Decapitate",
	Icon = "skills/active_34.png",
	IconDisabled = "skills/active_34_sw.png",
	Overlay = "active_34",
});

::Legends.Active.Explode <- null;
activesDefs.push({
	ID = "actives.explode",
	Script = "scripts/skills/actives/explode_skill",
	Const = "Explode",
	Name = "Explode",
	Icon = "skills/active_221.png",
	IconDisabled = "skills/active_221.png",
	Overlay = "active_221",
});

::Legends.Active.FakeDrinkNightVision <- null;
activesDefs.push({
	ID = "actives.fake_drink_night_vision",
	Script = "scripts/skills/actives/fake_drink_night_vision_skill",
	Const = "FakeDrinkNightVision",
	Name = "Drink Night Owl Elixir",
	Icon = "skills/active_142.png",
	IconDisabled = "skills/active_142_sw.png",
	Overlay = "active_142",
});

::Legends.Active.FireHandgonne <- null;
activesDefs.push({
	ID = "actives.fire_handgonne",
	Script = "scripts/skills/actives/fire_handgonne_skill",
	Const = "FireHandgonne",
	Name = "Fire Handgonne",
	Icon = "skills/active_203.png",
	IconDisabled = "skills/active_203_sw.png",
	Overlay = "active_203",
});

::Legends.Active.FireMortar <- null;
activesDefs.push({
	ID = "actives.fire_mortar",
	Script = "scripts/skills/actives/fire_mortar_skill",
	Const = "FireMortar",
	Name = "Fire Mortar",
		Icon = "skills/active_211.png",
		IconDisabled = "skills/active_211.png",
		Overlay = "active_211",
});

::Legends.Active.FirstAid <- null;
activesDefs.push({
	ID = "actives.first_aid",
	Script = "scripts/skills/actives/first_aid_skill",
	Const = "FirstAid",
	Name = "First Aid",
		Icon = "ui/perks/perk_55_active.png",
		IconDisabled = "ui/perks/perk_55_active_sw.png",
		Overlay = "perk_55_active",
});

::Legends.Active.Flail <- null;
activesDefs.push({
	ID = "actives.flail",
	Script = "scripts/skills/actives/flail_skill",
	Const = "Flail",
	Name = "Flail",
	Icon = "skills/active_39.png",
	IconDisabled = "skills/active_39_sw.png",
	Overlay = "active_39",
});

::Legends.Active.FleshPull <- null;
activesDefs.push({
	ID = "actives.flesh_pull",
	Script = "scripts/skills/actives/flesh_pull_skill",
	Const = "FleshPull",
	Name = "Flesh Pull",
	Icon = "skills/active_235.png",
	IconDisabled = "skills/active_235.png",
	Overlay = "active_235",
});

::Legends.Active.FlingBack <- null;
activesDefs.push({
	ID = "actives.fling_back",
	Script = "scripts/skills/actives/fling_back_skill",
	Const = "FlingBack",
	Name = "Fling Back",
	Icon = "skills/active_111.png",
	IconDisabled = "skills/active_111.png",
	Overlay = "active_111",
});

::Legends.Active.Flurry <- null;
activesDefs.push({
	ID = "actives.flurry_skill",
	Script = "scripts/skills/actives/flurry_skill",
	Const = "Flurry",
	Name = "Flurry",
	Icon = "skills/active_229.png",
	IconDisabled = "skills/active_229.png",
	Overlay = "active_229",
});

::Legends.Active.Footwork <- null;
activesDefs.push({
	ID = "actives.footwork",
	Script = "scripts/skills/actives/footwork",
	Const = "Footwork",
	Name = "Footwork",
	Icon = "ui/perks/perk_25_active.png",
	IconDisabled = "ui/perks/perk_25_active_sw.png",
	Overlay = "perk_25_active",
});

::Legends.Active.Gash <- null;
activesDefs.push({
	ID = "actives.gash",
	Script = "scripts/skills/actives/gash_skill",
	Const = "Gash",
	Name = "Gash",
	Icon = "skills/active_189.png",
	IconDisabled = "skills/active_189_sw.png",
	Overlay = "active_189",
});

::Legends.Active.GeomancyOnce <- null;
activesDefs.push({
	ID = "actives.geomancy_once",
	Script = "scripts/skills/actives/geomancy_once_skill",
	Const = "GeomancyOnce",
	Name = "Geomancy",
	Icon = "skills/active_220.png",
	IconDisabled = "skills/active_220.png",
	Overlay = "active_220",
});

::Legends.Active.Geomancy <- null;
activesDefs.push({
	ID = "actives.geomancy",
	Script = "scripts/skills/actives/geomancy_skill",
	Const = "Geomancy",
	Name = "Geomancy",
	Icon = "skills/active_220.png",
	IconDisabled = "skills/active_220.png",
	Overlay = "active_220",
});

::Legends.Active.GhastlyTouch <- null;
activesDefs.push({
	ID = "actives.ghastly_touch",
	Script = "scripts/skills/actives/ghastly_touch",
	Const = "GhastlyTouch",
	Name = "Ghastly Touch",
	Icon = "skills/active_42.png",
	IconDisabled = "skills/active_42.png",
	Overlay = "active_42",
});

::Legends.Active.GhostOverheadStrike <- null;
activesDefs.push({
	ID = "actives.ghost_overhead_strike",
	Script = "scripts/skills/actives/ghost_overhead_strike",
	Const = "GhostOverheadStrike",
	Name = "Overhead Strike",
	Icon = "skills/active_152.png",
	IconDisabled = "skills/active_152.png",
	Overlay = "active_152",
});

::Legends.Active.GhostSplit <- null;
activesDefs.push({
	ID = "actives.ghost_split",
	Script = "scripts/skills/actives/ghost_split_skill",
	Const = "GhostSplit",
	Name = "Split",
	Icon = "skills/active_153.png",
	IconDisabled = "skills/active_153.png",
	Overlay = "active_153",
});

::Legends.Active.GhostSwing <- null;
activesDefs.push({
	ID = "actives.ghost_swing",
	Script = "scripts/skills/actives/ghost_swing_skill",
	Const = "GhostSwing",
	Name = "Swing",
	Icon = "skills/active_154.png",
	IconDisabled = "skills/active_154_sw.png",
	Overlay = "active_154",
});

::Legends.Active.GhoulClaws <- null;
activesDefs.push({
	ID = "actives.ghoul_claws",
	Script = "scripts/skills/actives/ghoul_claws",
	Const = "GhoulClaws",
	Name = "Ghoul Claws",
	Icon = "skills/active_21.png",
	IconDisabled = "skills/active_21_sw.png",
	Overlay = "active_21",
});

::Legends.Active.GoblinWhip <- null;
activesDefs.push({
	ID = "actives.goblin_whip",
	Script = "scripts/skills/actives/goblin_whip",
	Const = "GoblinWhip",
	Name = "Whip",
	Icon = "skills/active_72.png",
	IconDisabled = "skills/active_72_sw.png",
	Overlay = "active_72",
});

::Legends.Active.GolemGrapple <- null;
activesDefs.push({
	ID = "actives.golem_grapple",
	Script = "scripts/skills/actives/golem_grapple_skill",
	Const = "GolemGrapple",
	Name = "Grapple",
	Icon = "skills/active_232.png",
	IconDisabled = "skills/active_232.png",
	Overlay = "active_232",
});

::Legends.Active.Gore <- null;
activesDefs.push({
	ID = "actives.gore",
	Script = "scripts/skills/actives/gore_skill",
	Const = "Gore",
	Name = "Gore",
	Icon = "skills/active_166.png",
	IconDisabled = "skills/active_166.png",
	Overlay = "active_166",
});

::Legends.Active.Gorge <- null;
activesDefs.push({
	ID = "actives.gorge",
	Script = "scripts/skills/actives/gorge_skill",
	Const = "Gorge",
	Name = "Gorge",
	Icon = "skills/active_107.png",
	IconDisabled = "skills/active_107.png",
	Overlay = "active_107",
});

::Legends.Active.GrantNightVision <- null;
activesDefs.push({
	ID = "actives.grant_night_vision",
	Script = "scripts/skills/actives/grant_night_vision_skill",
	Const = "GrantNightVision",
	Name = "Grant Night Vision",
	Icon = "skills/active_156.png",
	IconDisabled = "skills/active_156.png",
	Overlay = "active_156",
});

::Legends.Active.GreaterFleshGolemAttack <- null;
activesDefs.push({
	ID = "actives.greater_flesh_golem_attack",
	Script = "scripts/skills/actives/greater_flesh_golem_attack_skill",
	Const = "GreaterFleshGolemAttack",
	Name = "Clout",
	Icon = "skills/active_227.png",
	IconDisabled = "skills/active_227.png",
	Overlay = "active_227",
});

::Legends.Active.GrowShield <- null;
activesDefs.push({
	ID = "actives.grow_shield",
	Script = "scripts/skills/actives/grow_shield_skill",
	Const = "GrowShield",
	Name = "Grow Shield",
	Icon = "skills/active_121.png",
	IconDisabled = "skills/active_121.png",
	Overlay = "active_121",
});

::Legends.Active.GruesomeFeast <- null;
activesDefs.push({
	ID = "actives.gruesome_feast",
	Script = "scripts/skills/actives/gruesome_feast",
	Const = "GruesomeFeast",
	Name = "Gruesome Feast",
	Icon = "skills/active_40.png",
	IconDisabled = "skills/active_40.png",
	Overlay = "active_40",
});

::Legends.Active.Hail <- null;
activesDefs.push({
	ID = "actives.hail",
	Script = "scripts/skills/actives/hail_skill",
	Const = "Hail",
	Name = "Hail",
	Icon = "skills/active_126.png",
	IconDisabled = "skills/active_126_sw.png",
	Overlay = "active_126",
});

::Legends.Active.Hammer <- null;
activesDefs.push({
	ID = "actives.hammer",
	Script = "scripts/skills/actives/hammer",
	Const = "Hammer",
	Name = "Batter",
	Icon = "skills/active_35.png",
	IconDisabled = "skills/active_35_sw.png",
	Overlay = "active_35",
});

::Legends.Active.HandToHand <- null;
activesDefs.push({
	ID = "actives.hand_to_hand",
	Script = "scripts/skills/actives/hand_to_hand",
	Const = "HandToHand",
	Name = "Hand-to-Hand Attack",
	Icon = "skills/active_08.png",
	IconDisabled = "skills/active_08_sw.png",
	Overlay = "active_08",
});

::Legends.Active.Headbutt <- null;
activesDefs.push({
	ID = "actives.headbutt",
	Script = "scripts/skills/actives/headbutt_skill",
	Const = "Headbutt",
	Name = "Headbutt",
	Icon = "skills/active_195.png",
	IconDisabled = "skills/active_195.png",
	Overlay = "active_195",
});

::Legends.Active.Hex <- null;
activesDefs.push({
	ID = "actives.hex",
	Script = "scripts/skills/actives/hex_skill",
	Const = "Hex",
	Name = "Hex",
	Icon = "skills/active_119.png",
	IconDisabled = "skills/active_119.png",
	Overlay = "active_119",
});

::Legends.Active.Hook <- null;
activesDefs.push({
	ID = "actives.hook",
	Script = "scripts/skills/actives/hook",
	Const = "Hook",
	Name = "Hook",
	Icon = "skills/active_31.png",
	IconDisabled = "skills/active_31_sw.png",
	Overlay = "active_31",
});

::Legends.Active.HorrificScream <- null;
activesDefs.push({
	ID = "actives.horrific_scream",
	Script = "scripts/skills/actives/horrific_scream",
	Const = "HorrificScream",
	Name = "Horrific Scream",
	Icon = "skills/active_41.png",
	IconDisabled = "skills/active_41.png",
	Overlay = "active_41",
});

::Legends.Active.Horror <- null;
activesDefs.push({
	ID = "actives.horror",
	Script = "scripts/skills/actives/horror_skill",
	Const = "Horror",
	Name = "Horror",
	Icon = "skills/active_102.png",
	IconDisabled = "skills/active_102.png",
	Overlay = "active_102",
});

::Legends.Active.HyenaBite <- null;
activesDefs.push({
	ID = "actives.hyena_bite",
	Script = "scripts/skills/actives/hyena_bite_skill",
	Const = "HyenaBite",
	Name = "Hyena Bite",
	Icon = "skills/active_197.png",
	IconDisabled = "skills/active_197.png",
	Overlay = "active_197",
});

::Legends.Active.IgniteFirelance <- null;
activesDefs.push({
	ID = "actives.ignite_firelance",
	Script = "scripts/skills/actives/ignite_firelance_skill",
	Const = "IgniteFirelance",
	Name = "Ignite",
	Icon = "skills/active_202.png",
	IconDisabled = "skills/active_202_sw.png",
	Overlay = "active_202",
});

::Legends.Active.Impale <- null;
activesDefs.push({
	ID = "actives.impale",
	Script = "scripts/skills/actives/impale",
	Const = "Impale",
	Name = "Impale",
	Icon = "skills/active_30.png",
	IconDisabled = "skills/active_30_sw.png",
	Overlay = "active_30",
});

::Legends.Active.Indomitable <- null;
activesDefs.push({
	ID = "actives.indomitable",
	Script = "scripts/skills/actives/indomitable",
	Const = "Indomitable",
	Name = "Indomitable",
	Icon = "ui/perks/perk_30_active.png",
	IconDisabled = "ui/perks/perk_30_active_sw.png",
	Overlay = "perk_30_active",
});

::Legends.Active.Insects <- null;
activesDefs.push({
	ID = "actives.insects",
	Script = "scripts/skills/actives/insects_skill",
	Const = "Insects",
	Name = "Swarm of Insects",
	Icon = "skills/active_69.png",
	IconDisabled = "skills/active_69_sw.png",
	Overlay = "active_69",
});

::Legends.Active.KnockBack <- null;
activesDefs.push({
	ID = "actives.knock_back",
	Script = "scripts/skills/actives/knock_back",
	Const = "KnockBack",
	Name = "Knock Back",
	Icon = "skills/active_10.png",
	IconDisabled = "skills/active_10_sw.png",
	Overlay = "active_10",
});

::Legends.Active.KnockOut <- null;
activesDefs.push({
	ID = "actives.knock_out",
	Script = "scripts/skills/actives/knock_out",
	Const = "KnockOut",
	Name = "Knock Out",
	Icon = "skills/active_32.png",
	IconDisabled = "skills/active_32_sw.png",
	Overlay = "active_32",
});

::Legends.Active.KnockOver <- null;
activesDefs.push({
	ID = "actives.knock_over",
	Script = "scripts/skills/actives/knock_over_skill",
	Const = "KnockOver",
	Name = "Knock Over",
	Icon = "skills/active_206.png",
	IconDisabled = "skills/active_206_sw.png",
	Overlay = "active_206",
});

::Legends.Active.KrakenBite <- null;
activesDefs.push({
	ID = "actives.kraken_bite",
	Script = "scripts/skills/actives/kraken_bite_skill",
	Const = "KrakenBite",
	Name = "Bite",
	Icon = "skills/active_146.png",
	IconDisabled = "skills/active_146_sw.png",
	Overlay = "active_146",
});

::Legends.Active.KrakenDevour <- null;
activesDefs.push({
	ID = "actives.kraken_devour",
	Script = "scripts/skills/actives/kraken_devour_skill",
	Const = "KrakenDevour",
	Name = "Devour",
	Icon = "skills/active_150.png",
	IconDisabled = "skills/active_150.png",
	Overlay = "active_150",
});

::Legends.Active.KrakenEnsnare <- null;
activesDefs.push({
	ID = "actives.kraken_ensnare",
	Script = "scripts/skills/actives/kraken_ensnare_skill",
	Const = "KrakenEnsnare",
	Name = "Ensnare",
	Icon = "skills/active_147.png",
	IconDisabled = "skills/active_147_sw.png",
	Overlay = "active_147",
});

::Legends.Active.KrakenMoveEnsnared <- null;
activesDefs.push({
	ID = "actives.kraken_move_ensnared",
	Script = "scripts/skills/actives/kraken_move_ensnared_skill",
	Const = "KrakenMoveEnsnared",
	Name = "Drag",
	Icon = "skills/active_147.png",
	IconDisabled = "skills/active_147_sw.png",
	Overlay = "active_147",
});

::Legends.Active.KrakenMove <- null;
activesDefs.push({
	ID = "actives.kraken_move",
	Script = "scripts/skills/actives/kraken_move_skill",
	Const = "KrakenMove",
	Name = "Move Tentacle",
	Icon = "skills/active_149.png",
	IconDisabled = "skills/active_149_sw.png",
	Overlay = "active_149",
});

::Legends.Active.Lash <- null;
activesDefs.push({
	ID = "actives.lash",
	Script = "scripts/skills/actives/lash_skill",
	Const = "Lash",
	Name = "Lash",
	Icon = "skills/active_91.png",
	IconDisabled = "skills/active_91_sw.png",
	Overlay = "active_91",
});

::Legends.Active.LesserFleshGolemAttack <- null;
activesDefs.push({
	ID = "actives.lesser_flesh_golem_attack",
	Script = "scripts/skills/actives/lesser_flesh_golem_attack_skill",
	Const = "LesserFleshGolemAttack",
	Name = "Smack",
	Icon = "skills/active_227.png",
	IconDisabled = "skills/active_227.png",
	Overlay = "active_227",
});

::Legends.Active.LightningStorm <- null;
activesDefs.push({
	ID = "actives.lightning_storm",
	Script = "scripts/skills/actives/lightning_storm_skill",
	Const = "LightningStorm",
	Name = "Lightning Strike",
	Icon = "skills/active_216.png",
	IconDisabled = "skills/active_216.png",
	Overlay = "active_216",
});

::Legends.Active.LineBreaker <- null;
activesDefs.push({
	ID = "actives.line_breaker",
	Script = "scripts/skills/actives/line_breaker",
	Const = "LineBreaker",
	Name = "Line Breaker",
	Icon = "skills/active_53.png",
	IconDisabled = "skills/active_53.png",
	Overlay = "active_53",
});

::Legends.Active.LoadMortar <- null;
activesDefs.push({
	ID = "actives.load_mortar",
	Script = "scripts/skills/actives/load_mortar_skill",
	Const = "LoadMortar",
	Name = "Load Mortar",
	Icon = "skills/active_212.png",
	IconDisabled = "skills/active_212.png",
	Overlay = "active_212",
});

::Legends.Active.Lunge <- null;
activesDefs.push({
	ID = "actives.lunge",
	Script = "scripts/skills/actives/lunge_skill",
	Const = "Lunge",
	Name = "Lunge",
	Icon = "skills/active_135.png",
	IconDisabled = "skills/active_135_sw.png",
	Overlay = "active_135",
});

::Legends.Active.MergeGolem <- null;
activesDefs.push({
	ID = "actives.merge_golem",
	Script = "scripts/skills/actives/merge_golem_skill",
	Const = "MergeGolem",
	Name = "Merge Living Sands",
	Icon = "skills/active_194.png",
	IconDisabled = "skills/active_194.png",
	Overlay = "active_194",
});

::Legends.Active.Miasma <- null;
activesDefs.push({
	ID = "actives.miasma",
	Script = "scripts/skills/actives/miasma_skill",
	Const = "Miasma",
	Name = "Miasma",
	Icon = "skills/active_101.png",
	IconDisabled = "skills/active_101.png",
	Overlay = "active_101",
});

::Legends.Active.MoveTail <- null;
activesDefs.push({
	ID = "actives.move_tail",
	Script = "scripts/skills/actives/move_tail_skill",
	Const = "MoveTail",
	Name = "Move Tail",
	Icon = "skills/active_109.png",
	IconDisabled = "skills/active_109.png",
	Overlay = "active_109",
});

::Legends.Active.Nightmare <- null;
activesDefs.push({
	ID = "actives.nightmare",
	Script = "scripts/skills/actives/nightmare_skill",
	Const = "Nightmare",
	Name = "Nightmare",
	Icon = "skills/active_117.png",
	IconDisabled = "skills/active_117.png",
	Overlay = "active_117",
});

::Legends.Active.OverheadStrike <- null;
activesDefs.push({
	ID = "actives.overhead_strike",
	Script = "scripts/skills/actives/overhead_strike",
	Const = "OverheadStrike",
	Name = "Overhead Strike",
	Icon = "skills/active_20.png",
	IconDisabled = "skills/active_20_sw.png",
	Overlay = "active_20",
});

::Legends.Active.PerfectFocus <- null;
activesDefs.push({
	ID = "actives.perfect_focus",
	Script = "scripts/skills/actives/perfect_focus",
	Const = "PerfectFocus",
	Name = "Perfect Focus",
	Icon = "ui/perks/perk_37_active.png",
	IconDisabled = "ui/perks/perk_37_active_sw.png",
	Overlay = "perk_37_active",
});

::Legends.Active.Perforate <- null;
activesDefs.push({
	ID = "actives.perforate",
	Script = "scripts/skills/actives/perforate_skill",
	Const = "Perforate",
	Name = "Perforate",
	Icon = "skills/active_237.png",
	IconDisabled = "skills/active_237_sw.png",
	Overlay = "active_237",
});

::Legends.Active.PossessUndead <- null;
activesDefs.push({
	ID = "actives.possess_undead",
	Script = "scripts/skills/actives/possess_undead_skill",
	Const = "PossessUndead",
	Name = "Possess Undead",
	Icon = "skills/active_99.png",
	IconDisabled = "skills/active_99.png",
	Overlay = "active_99",
});

::Legends.Active.Pound <- null;
activesDefs.push({
	ID = "actives.pound",
	Script = "scripts/skills/actives/pound",
	Const = "Pound",
	Name = "Pound",
	Icon = "skills/active_50.png",
	IconDisabled = "skills/active_50_sw.png",
	Overlay = "active_50",
});

::Legends.Active.Prong <- null;
activesDefs.push({
	ID = "actives.prong",
	Script = "scripts/skills/actives/prong_skill",
	Const = "Prong",
	Name = "Prong",
	Icon = "skills/active_123.png",
	IconDisabled = "skills/active_123_sw.png",
	Overlay = "active_123",
});

::Legends.Active.Puncture <- null;
activesDefs.push({
	ID = "actives.puncture",
	Script = "scripts/skills/actives/puncture",
	Const = "Puncture",
	Name = "Puncture",
	Icon = "skills/active_27.png",
	IconDisabled = "skills/active_27_sw.png",
	Overlay = "active_27",
});

::Legends.Active.QuickShot <- null;
activesDefs.push({
	ID = "actives.quick_shot",
	Script = "scripts/skills/actives/quick_shot",
	Const = "QuickShot",
	Name = "Quick Shot",
	Icon = "skills/active_05.png",
	IconDisabled = "skills/active_05_sw.png",
	Overlay = "active_05",
});

::Legends.Active.RaiseAllUndead <- null;
activesDefs.push({
	ID = "actives.raise_all_undead",
	Script = "scripts/skills/actives/raise_all_undead_skill",
	Const = "RaiseAllUndead",
	Name = "The Black Book",
	Icon = "skills/active_213.png",
	IconDisabled = "skills/active_213.png",
	Overlay = "active_213",
});

::Legends.Active.RaiseUndead <- null;
activesDefs.push({
	ID = "actives.raise_undead",
	Script = "scripts/skills/actives/raise_undead",
	Const = "RaiseUndead",
	Name = "Raise Undead",
	Icon = "skills/active_26.png",
	IconDisabled = "skills/active_01_sw.png",
	Overlay = "active_26",
});

::Legends.Active.RallyTheTroops <- null;
activesDefs.push({
	ID = "actives.rally_the_troops",
	Script = "scripts/skills/actives/rally_the_troops",
	Const = "RallyTheTroops",
	Name = "Rally",
	Icon = "ui/perks/perk_42_active.png",
	IconDisabled = "ui/perks/perk_42_active_sw.png",
	Overlay = "perk_42_active",
});

::Legends.Active.Reap <- null;
activesDefs.push({
	ID = "actives.reap",
	Script = "scripts/skills/actives/reap_skill",
	Const = "Reap",
	Name = "Reap",
	Icon = "skills/active_100.png",
	IconDisabled = "skills/active_100_sw.png",
	Overlay = "active_100",
});

::Legends.Active.Recover <- null;
activesDefs.push({
	ID = "actives.recover",
	Script = "scripts/skills/actives/recover_skill",
	Const = "Recover",
	Name = "Recover",
	Icon = "ui/perks/perk_54_active.png",
	IconDisabled = "ui/perks/perk_54_active_sw.png",
	Overlay = "perk_54_active",
});

::Legends.Active.ReleaseFalcon <- null;
activesDefs.push({
	ID = "actives.release_falcon",
	Script = "scripts/skills/actives/release_falcon_skill",
	Const = "ReleaseFalcon",
	Name = "Release Falcon",
	Icon = "skills/active_104.png",
	IconDisabled = "skills/active_104_sw.png",
	Overlay = "active_104",
});

::Legends.Active.ReloadBolt <- null;
activesDefs.push({
	ID = "actives.reload_bolt",
	Script = "scripts/skills/actives/reload_bolt",
	Const = "ReloadBolt",
	Name = "Reload",
	Icon = "skills/active_16.png",
	IconDisabled = "skills/active_16_sw.png",
	Overlay = "active_16",
});

::Legends.Active.ReloadHandgonne <- null;
activesDefs.push({
	ID = "actives.reload_handgonne",
	Script = "scripts/skills/actives/reload_handgonne_skill",
	Const = "ReloadHandgonne",
	Name = "Reload",
	Icon = "skills/active_204.png",
	IconDisabled = "skills/active_204_sw.png",
	Overlay = "active_204",
});

::Legends.Active.Repel <- null;
activesDefs.push({
	ID = "actives.repel",
	Script = "scripts/skills/actives/repel",
	Const = "Repel",
	Name = "Repel",
	Icon = "skills/active_55.png",
	IconDisabled = "skills/active_55_sw.png",
	Overlay = "active_55",
});

::Legends.Active.ReturnFavor <- null;
activesDefs.push({
	ID = "actives.return_favor",
	Script = "scripts/skills/actives/return_favor",
	Const = "ReturnFavor",
	Name = "Return Favor",
	Icon = "ui/perks/perk_31_active.png",
	IconDisabled = "ui/perks/perk_31_active_sw.png",
	Overlay = "perk_31_active",
});

::Legends.Active.Riposte <- null;
activesDefs.push({
	ID = "actives.riposte",
	Script = "scripts/skills/actives/riposte",
	Const = "Riposte",
	Name = "Riposte",
	Icon = "skills/active_33.png",
	IconDisabled = "skills/active_33_sw.png",
	Overlay = "active_33",
});

::Legends.Active.Root <- null;
activesDefs.push({
	ID = "actives.root",
	Script = "scripts/skills/actives/root_skill",
	Const = "Root",
	Name = "Root",
	Icon = "skills/active_70.png",
	IconDisabled = "skills/active_70_sw.png",
	Overlay = "active_70",
});

::Legends.Active.Rotation <- null;
activesDefs.push({
	ID = "actives.rotation",
	Script = "scripts/skills/actives/rotation",
	Const = "Rotation",
	Name = "Rotation",
	Icon = "ui/perks/perk_11_active.png",
	IconDisabled = "ui/perks/perk_11_active_sw.png",
	Overlay = "perk_11_active",
});

::Legends.Active.RoundSwing <- null;
activesDefs.push({
	ID = "actives.round_swing",
	Script = "scripts/skills/actives/round_swing",
	Const = "RoundSwing",
	Name = "Round Swing",
	Icon = "skills/active_48.png",
	IconDisabled = "skills/active_48_sw.png",
	Overlay = "active_48",
});

::Legends.Active.Rupture <- null;
activesDefs.push({
	ID = "actives.rupture",
	Script = "scripts/skills/actives/rupture",
	Const = "Rupture",
	Name = "Rupture",
	Icon = "skills/active_80.png",
	IconDisabled = "skills/active_80_sw.png",
	Overlay = "active_80",
});

::Legends.Active.SerpentBite <- null;
activesDefs.push({
	ID = "actives.serpent_bite",
	Script = "scripts/skills/actives/serpent_bite_skill",
	Const = "SerpentBite",
	Name = "Serpent Bite",
	Icon = "skills/active_196.png",
	IconDisabled = "skills/active_196_sw.png",
	Overlay = "active_196",
});

::Legends.Active.SerpentHook <- null;
activesDefs.push({
	ID = "actives.serpent_hook",
	Script = "scripts/skills/actives/serpent_hook_skill",
	Const = "SerpentHook",
	Name = "Drag",
	Icon = "skills/active_192.png",
	IconDisabled = "skills/active_192_sw.png",
	Overlay = "active_192",
});

::Legends.Active.Shatter <- null;
activesDefs.push({
	ID = "actives.shatter",
	Script = "scripts/skills/actives/shatter_skill",
	Const = "Shatter",
	Name = "Shatter",
	Icon = "skills/active_90.png",
	IconDisabled = "skills/active_90_sw.png",
	Overlay = "active_90",
});

::Legends.Active.Shieldwall <- null;
activesDefs.push({
	ID = "actives.shieldwall",
	Script = "scripts/skills/actives/shieldwall",
	Const = "Shieldwall",
	Name = "Shieldwall",
	Icon = "skills/active_15.png",
	IconDisabled = "skills/active_15_sw.png",
	Overlay = "active_15",
});

::Legends.Active.ShootBolt <- null;
activesDefs.push({
	ID = "actives.shoot_bolt",
	Script = "scripts/skills/actives/shoot_bolt",
	Const = "ShootBolt",
	Name = "Shoot Bolt",
	Icon = "skills/active_17.png",
	IconDisabled = "skills/active_17_sw.png",
	Overlay = "active_17",
});

::Legends.Active.ShootStake <- null;
activesDefs.push({
	ID = "actives.shoot_stake",
	Script = "scripts/skills/actives/shoot_stake",
	Const = "ShootStake",
	Name = "Shoot Heavy Bolt",
	Icon = "skills/active_81.png",
	IconDisabled = "skills/active_81_sw.png",
	Overlay = "active_81",
});

::Legends.Active.Skewer <- null;
activesDefs.push({
	ID = "actives.skewer",
	Script = "scripts/skills/actives/skewer_skill",
	Const = "Skewer",
	Name = "Skewer",
	Icon = "skills/active_238.png",
	IconDisabled = "skills/active_238_sw.png",
	Overlay = "active_238",
});

::Legends.Active.Slash <- null;
activesDefs.push({
	ID = "actives.slash",
	Script = "scripts/skills/actives/slash",
	Const = "Slash",
	Name = "Slash",
	Icon = "skills/active_01.png",
	IconDisabled = "skills/active_01_sw.png",
	Overlay = "active_01",
});

::Legends.Active.SlashLightning <- null;
activesDefs.push({
	ID = "actives.slash_lightning",
	Script = "scripts/skills/actives/slash_lightning",
	Const = "SlashLightning",
	Name = "Lightbringer",
	Icon = "skills/active_155.png",
	IconDisabled = "skills/active_155_sw.png",
	Overlay = "active_155",
});

::Legends.Active.Sleep <- null;
activesDefs.push({
	ID = "actives.sleep",
	Script = "scripts/skills/actives/sleep_skill",
	Const = "Sleep",
	Name = "Sleep",
	Icon = "skills/active_116.png",
	IconDisabled = "skills/active_116.png",
	Overlay = "active_116",
});

::Legends.Active.SlingStone <- null;
activesDefs.push({
	ID = "actives.sling_stone",
	Script = "scripts/skills/actives/sling_stone_skill",
	Const = "SlingStone",
	Name = "Sling Stone",
	Icon = "skills/active_12.png",
	IconDisabled = "skills/active_12_sw.png",
	Overlay = "active_12",
});

::Legends.Active.Smite <- null;
activesDefs.push({
	ID = "actives.smite",
	Script = "scripts/skills/actives/smite_skill",
	Const = "Smite",
	Name = "Smite",
	Icon = "skills/active_89.png",
	IconDisabled = "skills/active_89_sw.png",
	Overlay = "active_89",
});

::Legends.Active.Spearwall <- null;
activesDefs.push({
	ID = "actives.spearwall",
	Script = "scripts/skills/actives/spearwall",
	Const = "Spearwall",
	Name = "Spearwall",
	Icon = "skills/active_23.png",
	IconDisabled = "skills/active_23_sw.png",
	Overlay = "active_23",
});

::Legends.Active.SpiderBite <- null;
activesDefs.push({
	ID = "actives.spider_bite",
	Script = "scripts/skills/actives/spider_bite_skill",
	Const = "SpiderBite",
	Name = "Webknecht Bite",
	Icon = "skills/active_115.png",
	IconDisabled = "skills/active_115_sw.png",
	Overlay = "active_115",
});

::Legends.Active.Spike <- null;
activesDefs.push({
	ID = "actives.spike_skill",
	Script = "scripts/skills/actives/spike_skill",
	Const = "Spike",
	Name = "Spike",
	Icon = "skills/active_230.png",
	IconDisabled = "skills/active_230.png",
	Overlay = "active_230",
});

::Legends.Active.Split <- null;
activesDefs.push({
	ID = "actives.split",
	Script = "scripts/skills/actives/split",
	Const = "Split",
	Name = "Split",
	Icon = "skills/active_07.png",
	IconDisabled = "skills/active_07_sw.png",
	Overlay = "active_07",
});

::Legends.Active.SplitAxe <- null;
activesDefs.push({
	ID = "actives.split_axe",
	Script = "scripts/skills/actives/split_axe",
	Const = "SplitAxe",
	Name = "Split",
	Icon = "skills/active_169.png",
	IconDisabled = "skills/active_169_sw.png",
	Overlay = "active_169",
});

::Legends.Active.SplitMan <- null;
activesDefs.push({
	ID = "actives.split_man",
	Script = "scripts/skills/actives/split_man",
	Const = "SplitMan",
	Name = "Split Man",
	Icon = "skills/active_09.png",
	IconDisabled = "skills/active_09_sw.png",
	Overlay = "active_09",
});

::Legends.Active.SplitShield <- null;
activesDefs.push({
	ID = "actives.split_shield",
	Script = "scripts/skills/actives/split_shield",
	Const = "SplitShield",
	Name = "Split Shield",
});

::Legends.Active.Stab <- null;
activesDefs.push({
	ID = "actives.stab",
	Script = "scripts/skills/actives/stab",
	Const = "Stab",
	Name = "Stab",
	Icon = "skills/active_03.png",
	IconDisabled = "skills/active_03_sw.png",
	Overlay = "active_03",
});

::Legends.Active.Stealth <- null;
activesDefs.push({
	ID = "actives.stealth",
	Script = "scripts/skills/actives/stealth_skill",
	Const = "Stealth",
	Name = "Stealth",
	Icon = "skills/active_15.png",
	IconDisabled = "skills/active_15_sw.png",
	Overlay = "active_15",
});

::Legends.Active.StrikeDown <- null;
activesDefs.push({
	ID = "actives.strike_down",
	Script = "scripts/skills/actives/strike_down_skill",
	Const = "StrikeDown",
	Name = "Strike Down",
	Icon = "skills/active_134.png",
	IconDisabled = "skills/active_134_sw.png",
	Overlay = "active_134",
});

::Legends.Active.Strike <- null;
activesDefs.push({
	ID = "actives.strike",
	Script = "scripts/skills/actives/strike_skill",
	Const = "Strike",
	Name = "Strike",
	Icon = "skills/active_66.png",
	IconDisabled = "skills/active_66_sw.png",
	Overlay = "active_66",
});

::Legends.Active.SummonFlyingSkulls <- null;
activesDefs.push({
	ID = "actives.flying_skulls",
	Script = "scripts/skills/actives/summon_flying_skulls_skill",
	Const = "SummonFlyingSkulls",
	Name = "Raise Screaming Skulls",
	Icon = "skills/active_219.png",
	IconDisabled = "skills/active_219.png",
	Overlay = "active_219",
});

::Legends.Active.SummonMirrorImage <- null;
activesDefs.push({
	ID = "actives.mirror_image",
	Script = "scripts/skills/actives/summon_mirror_image_skill",
	Const = "SummonMirrorImage",
	Name = "Mirror Image",
	Icon = "skills/active_218.png",
	IconDisabled = "skills/active_218.png",
	Overlay = "active_218",
});

::Legends.Active.SwallowWhole <- null;
activesDefs.push({
	ID = "actives.swallow_whole",
	Script = "scripts/skills/actives/swallow_whole_skill",
	Const = "SwallowWhole",
	Name = "Swallow Whole",
	Icon = "skills/active_103.png",
	IconDisabled = "skills/active_103.png",
	Overlay = "active_103",
});

::Legends.Active.Sweep <- null;
activesDefs.push({
	ID = "actives.sweep",
	Script = "scripts/skills/actives/sweep_skill",
	Const = "Sweep",
	Name = "Sweeping Strike",
	Icon = "skills/active_112.png",
	IconDisabled = "skills/active_112.png",
	Overlay = "active_112",
});

::Legends.Active.SweepZoc <- null;
activesDefs.push({
	ID = "actives.sweep_zoc",
	Script = "scripts/skills/actives/sweep_zoc_skill",
	Const = "SweepZoc",
	Name = "Sweeping Strike",
	Icon = "skills/active_112.png",
	IconDisabled = "skills/active_112.png",
	Overlay = "active_112",
});

::Legends.Active.Swing <- null;
activesDefs.push({
	ID = "actives.swing",
	Script = "scripts/skills/actives/swing",
	Const = "Swing",
	Name = "Swing",
	Icon = "skills/active_06.png",
	IconDisabled = "skills/active_06_sw.png",
	Overlay = "active_06",
});

::Legends.Active.TailSlamBig <- null;
activesDefs.push({
	ID = "actives.tail_slam_big",
	Script = "scripts/skills/actives/tail_slam_big_skill",
	Const = "TailSlamBig",
	Name = "Tail Slam",
	Icon = "skills/active_108.png",
	IconDisabled = "skills/active_108.png",
	Overlay = "active_108",
});

::Legends.Active.TailSlam <- null;
activesDefs.push({
	ID = "actives.tail_slam",
	Script = "scripts/skills/actives/tail_slam_skill",
	Const = "TailSlam",
	Name = "Tail Slam",
	Icon = "skills/active_108.png",
	IconDisabled = "skills/active_108.png",
	Overlay = "active_108",
});

::Legends.Active.TailSlamSplit <- null;
activesDefs.push({
	ID = "actives.tail_slam_split",
	Script = "scripts/skills/actives/tail_slam_split_skill",
	Const = "TailSlamSplit",
	Name = "Tail Slam",
	Icon = "skills/active_108.png",
	IconDisabled = "skills/active_108.png",
	Overlay = "active_108",
});

::Legends.Active.TailSlamZoc <- null;
activesDefs.push({
	ID = "actives.tail_slam_zoc",
	Script = "scripts/skills/actives/tail_slam_zoc_skill",
	Const = "TailSlamZoc",
	Name = "Tail Slam",
	Icon = "skills/active_108.png",
	IconDisabled = "skills/active_108.png",
	Overlay = "active_108",
});

::Legends.Active.Taunt <- null;
activesDefs.push({
	ID = "actives.taunt",
	Script = "scripts/skills/actives/taunt",
	Const = "Taunt",
	Name = "Taunt",
	Icon = "ui/perks/perk_38_active.png",
	IconDisabled = "ui/perks/perk_38_active_sw.png",
	Overlay = "perk_38_active",
});

::Legends.Active.Teleport <- null;
activesDefs.push({
	ID = "actives.teleport",
	Script = "scripts/skills/actives/teleport_skill",
	Const = "Teleport",
	Name = "Spirit Walk",
	Icon = "skills/active_167.png",
	IconDisabled = "skills/active_167.png",
	Overlay = "active_167",
});

::Legends.Active.Thresh <- null;
activesDefs.push({
	ID = "actives.thresh",
	Script = "scripts/skills/actives/thresh",
	Const = "Thresh",
	Name = "Thresh",
	Icon = "skills/active_46.png",
	IconDisabled = "skills/active_46_sw.png",
	Overlay = "active_46",
});

::Legends.Active.ThrowAcidFlask <- null;
activesDefs.push({
	ID = "actives.throw_acid_flask",
	Script = "scripts/skills/actives/throw_acid_flask",
	Const = "ThrowAcidFlask",
	Name = "Throw Acid Flask",
	Icon = "skills/active_106.png",
	IconDisabled = "skills/active_106_sw.png",
	Overlay = "active_106",
});

::Legends.Active.ThrowAxe <- null;
activesDefs.push({
	ID = "actives.throw_axe",
	Script = "scripts/skills/actives/throw_axe",
	Const = "ThrowAxe",
	Name = "Throw Axe",
	Icon = "skills/active_87.png",
	IconDisabled = "skills/active_87_sw.png",
	Overlay = "active_87",
});

::Legends.Active.ThrowBalls <- null;
activesDefs.push({
	ID = "actives.throw_balls",
	Script = "scripts/skills/actives/throw_balls",
	Const = "ThrowBalls",
	Name = "Throw Bola",
	Icon = "skills/active_82.png",
	IconDisabled = "skills/active_82_sw.png",
	Overlay = "active_82",
});

::Legends.Active.ThrowDazeBomb <- null;
activesDefs.push({
	ID = "actives.throw_daze_bomb",
	Script = "scripts/skills/actives/throw_daze_bomb_skill",
	Const = "ThrowDazeBomb",
	Name = "Throw Flash Pot",
	Icon = "skills/active_207.png",
	IconDisabled = "skills/active_207_sw.png",
	Overlay = "active_207",
});

::Legends.Active.ThrowDirt <- null;
activesDefs.push({
	ID = "actives.throw_dirt",
	Script = "scripts/skills/actives/throw_dirt_skill",
	Const = "ThrowDirt",
	Name = "Throw Dirt",
	Icon = "skills/active_215.png",
	IconDisabled = "skills/active_215.png",
	Overlay = "active_215",
});

::Legends.Active.ThrowFireBomb <- null;
activesDefs.push({
	ID = "actives.throw_fire_bomb",
	Script = "scripts/skills/actives/throw_fire_bomb_skill",
	Const = "ThrowFireBomb",
	Name = "Throw Fire Pot",
	Icon = "skills/active_209.png",
	IconDisabled = "skills/active_209_sw.png",
	Overlay = "active_209",
});

::Legends.Active.ThrowGolem <- null;
activesDefs.push({
	ID = "actives.throw_golem",
	Script = "scripts/skills/actives/throw_golem_skill",
	Const = "ThrowGolem",
	Name = "Throw Living Sand",
	Icon = "skills/active_193.png",
	IconDisabled = "skills/active_193.png",
	Overlay = "active_193",
});

::Legends.Active.ThrowHolyWater <- null;
activesDefs.push({
	ID = "actives.throw_holy_water",
	Script = "scripts/skills/actives/throw_holy_water",
	Const = "ThrowHolyWater",
	Name = "Throw Blessed Water",
	Icon = "skills/active_97.png",
	IconDisabled = "skills/active_97_sw.png",
	Overlay = "active_97",
});

::Legends.Active.ThrowJavelin <- null;
activesDefs.push({
	ID = "actives.throw_javelin",
	Script = "scripts/skills/actives/throw_javelin",
	Const = "ThrowJavelin",
	Name = "Throw Javelin",
	Icon = "skills/active_43.png",
	IconDisabled = "skills/active_43_sw.png",
	Overlay = "active_43",
});

::Legends.Active.ThrowNet <- null;
activesDefs.push({
	ID = "actives.throw_net",
	Script = "scripts/skills/actives/throw_net",
	Const = "ThrowNet",
	Name = "Throw Net",
	Icon = "skills/active_73.png",
	IconDisabled = "skills/active_73_sw.png",
	Overlay = "active_73",
});

::Legends.Active.ThrowSmokeBomb <- null;
activesDefs.push({
	ID = "actives.throw_smoke_bomb",
	Script = "scripts/skills/actives/throw_smoke_bomb_skill",
	Const = "ThrowSmokeBomb",
	Name = "Throw Smoke Pot",
	Icon = "skills/active_208.png",
	IconDisabled = "skills/active_208_sw.png",
	Overlay = "active_208",
});

::Legends.Active.ThrowSpear <- null;
activesDefs.push({
	ID = "actives.throw_spear",
	Script = "scripts/skills/actives/throw_spear_skill",
	Const = "ThrowSpear",
	Name = "Throw Spear",
	Icon = "skills/active_138.png",
	IconDisabled = "skills/active_138_sw.png",
	Overlay = "active_138",
});

::Legends.Active.Thrust <- null;
activesDefs.push({
	ID = "actives.thrust",
	Script = "scripts/skills/actives/thrust",
	Const = "Thrust",
	Name = "Thrust",
	Icon = "skills/active_04.png",
	IconDisabled = "skills/active_04_sw.png",
	Overlay = "active_04",
});

::Legends.Active.UnleashWardog <- null;
activesDefs.push({
	ID = "actives.unleash_wardog",
	Script = "scripts/skills/actives/unleash_wardog",
	Const = "UnleashWardog",
	Name = "Unleash Wardog",
	Icon = "skills/active_83.png",
	IconDisabled = "skills/active_83_sw.png",
	Overlay = "active_83",
});

::Legends.Active.UnleashWolf <- null;
activesDefs.push({
	ID = "actives.unleash_wolf",
	Script = "scripts/skills/actives/unleash_wolf",
	Const = "UnleashWolf",
	Name = "Unleash Wardog",
	Icon = "skills/active_83.png",
	IconDisabled = "skills/active_83_sw.png",
	Overlay = "active_83",
});

::Legends.Active.UnstoppableCharge <- null;
activesDefs.push({
	ID = "actives.unstoppable_charge",
	Script = "scripts/skills/actives/unstoppable_charge_skill",
	Const = "UnstoppableCharge",
	Name = "Unstoppable Charge",
	this.m.Icon = "skills/active_110.png";
	this.m.IconDisabled = "skills/active_110.png";
	this.m.Overlay = "active_110";
});

::Legends.Active.Uproot <- null;
activesDefs.push({
	ID = "actives.uproot",
	Script = "scripts/skills/actives/uproot_skill",
	Const = "Uproot",
	Name = "Uproot",
	Icon = "skills/active_122.png",
	IconDisabled = "skills/active_122.png",
	Overlay = "active_122",
});

::Legends.Active.UprootSmall <- null;
activesDefs.push({
	ID = "actives.uproot_small",
	Script = "scripts/skills/actives/uproot_small_skill",
	Const = "UprootSmall",
	Name = "Uproot",
	Icon = "skills/active_122.png",
	IconDisabled = "skills/active_122.png",
	Overlay = "active_122",
});

::Legends.Active.UprootSmallZoc <- null;
activesDefs.push({
	ID = "actives.uproot_small_zoc",
	Script = "scripts/skills/actives/uproot_small_zoc_skill",
	Const = "UprootSmallZoc",
	Name = "Uproot",
	Icon = "skills/active_122.png",
	IconDisabled = "skills/active_122.png",
	Overlay = "active_122",
});

::Legends.Active.UprootZoc <- null;
activesDefs.push({
	ID = "actives.uproot_zoc",
	Script = "scripts/skills/actives/uproot_zoc_skill",
	Const = "UprootZoc",
	Name = "Uproot",
	Icon = "skills/active_122.png",
	IconDisabled = "skills/active_122.png",
	Overlay = "active_122",
});

::Legends.Active.VoiceOfDavkul <- null;
activesDefs.push({
	ID = "actives.voice_of_davkul",
	Script = "scripts/skills/actives/voice_of_davkul_skill",
	Const = "VoiceOfDavkul",
	Name = "Voice of Davkul",
	Icon = "skills/active_176.png",
	IconDisabled = "skills/active_176_sw.png",
	Overlay = "active_176",
});

::Legends.Active.WakeAlly <- null;
activesDefs.push({
	ID = "actives.wake_ally",
	Script = "scripts/skills/actives/wake_ally_skill",
	Const = "WakeAlly",
	Name = "Wake Ally",
	Icon = "skills/active_118.png",
	IconDisabled = "skills/active_118_sw.png",
	Overlay = "active_118",
});

::Legends.Active.Warcry <- null;
activesDefs.push({
	ID = "actives.warcry",
	Script = "scripts/skills/actives/warcry",
	Const = "Warcry",
	Name = "Warcry",
	Icon = "skills/active_41.png",
	IconDisabled = "skills/active_41.png",
	Overlay = "active_49",
});

::Legends.Active.WardogBite <- null;
activesDefs.push({
	ID = "actives.wardog_bite",
	Script = "scripts/skills/actives/wardog_bite",
	Const = "WardogBite",
	Name = "Bite",
	Icon = "skills/active_84.png",
	Icon = "skills/active_84_sw.png",
	Overlay = "active_84",
});

::Legends.Active.WarhoundBite <- null;
activesDefs.push({
	ID = "actives.warhound_bite",
	Script = "scripts/skills/actives/warhound_bite",
	Const = "WarhoundBite",
	Name = "Bite",
	Icon = "skills/active_164.png",
	IconDisabled = "skills/active_164_sw.png",
	Overlay = "active_164",
});

::Legends.Active.Web <- null;
activesDefs.push({
	ID = "actives.web",
	Script = "scripts/skills/actives/web_skill",
	Const = "Web",
	Name = "Weave Web",
	Icon = "skills/active_114.png",
	IconDisabled = "skills/active_114_sw.png",
	Overlay = "active_114",
});

::Legends.Active.WerewolfBite <- null;
activesDefs.push({
	ID = "actives.werewolf_bite",
	Script = "scripts/skills/actives/werewolf_bite",
	Const = "WerewolfBite",
	Name = "Direwolf Bite",
	Icon = "skills/active_71.png",
	IconDisabled = "skills/active_71_sw.png",
	Overlay = "active_71",
});

::Legends.Active.Whip <- null;
activesDefs.push({
	ID = "actives.whip",
	Script = "scripts/skills/actives/whip_skill",
	Const = "Whip",
	Name = "Whip",
	Icon = "skills/active_161.png",
	IconDisabled = "skills/active_161_sw.png",
	Overlay = "active_161",
});

::Legends.Active.WhipSlave <- null;
activesDefs.push({
	ID = "actives.whip_slave",
	Script = "scripts/skills/actives/whip_slave_skill",
	Const = "WhipSlave",
	Name = "Crack the Whip",
	Icon = "skills/active_214.png",
	IconDisabled = "skills/active_214_sw.png",
	Overlay = "active_214",
});

::Legends.Active.Wither <- null;
activesDefs.push({
	ID = "actives.wither",
	Script = "scripts/skills/actives/wither_skill",
	Const = "Wither",
	Name = "Wither",
	Icon = "skills/active_217.png",
	IconDisabled = "skills/active_217_sw.png",
	Overlay = "active_217",
});

::Legends.Active.WolfBite <- null;
activesDefs.push({
	ID = "actives.wolf_bite",
	Script = "scripts/skills/actives/wolf_bite",
	Const = "WolfBite",
	Name = "Bite",
	Icon = "skills/active_71.png",
	IconDisabled = "skills/active_71_sw.png",
	Overlay = "active_71",
});

::Legends.Active.ZombieBite <- null;
activesDefs.push({
	ID = "actives.zombie_bite",
	Script = "scripts/skills/actives/zombie_bite",
	Const = "ZombieBite",
	Name = "Bite",
	Icon = "skills/active_24.png",
	IconDisabled = "skills/active_24_sw.png",
	Overlay = "active_24",
});

::Legends.Active.LegendAlpSummonNightmare <- null;
activesDefs.push({
	ID = "actives.legend_alp_summon_nightmare",
	Script = "scripts/skills/actives/legend_alp_summon_nightmare_skill",
	Const = "LegendAlpSummonNightmare",
	Name = "Conjure Nightmare",
	Icon = "skills/active_160.png",
	IconDisabled = "skills/active_160.png",
	Overlay = "active_160",
});

::Legends.Active.LegendAlpNightmareManifestation <- null;
activesDefs.push({
	ID = "actives.legend_alp_nightmare_manifestation",
	Script = "scripts/skills/actives/legend_alp_nightmare_manifestation_skill",
	Const = "LegendAlpNightmareManifestation",
	Name = "Conjure Nightmare",
	Icon = "skills/active_160.png",
	IconDisabled = "skills/active_160.png",
	Overlay = "active_160",
});

::Legends.Active.LegendAlpRealmOfShadow <- null;
activesDefs.push({
	ID = "actives.legend_alp_realm_of_shadow",
	Script = "scripts/skills/actives/legend_alp_realm_of_shadow_skill",
	Const = "LegendAlpRealmOfShadow",
	Name = "Shadow Mist",
	Icon = "skills/nightvision_square.png",
	IconDisabled = "skills/nightvision_square.png",
	Overlay = "bust_nightmare";
});

::Legends.Active.LegendApothecaryMushrooms <- null;
activesDefs.push({
	ID = "actives.legend_apothecary_mushrooms",
	Script = "scripts/skills/actives/legend_apothecary_mushrooms_skill",
	Const = "LegendApothecaryMushrooms",
	Name = "Eat or Give Strange Mushrooms",
	Icon = "skills/active_98.png",
	IconDisabled = "skills/active_98_sw.png",
	Overlay = "active_98",
});

::Legends.Active.LegendAttackTarget <- null;
activesDefs.push({
	ID = "actives.legend_attack_target",
	Script = "scripts/skills/actives/legend_attack_target_skill",
	Const = "LegendAttackTarget",
	Name = "Chopper sick balls!",
	Icon = "skills/houndattack.png",
	IconDisabled = "skills/houndattack_bw.png",
	Overlay = "perk_38_active",
});

::Legends.Active.LegendBackstab <- null;
activesDefs.push({
	ID = "actives.legend_backstab",
	Script = "scripts/skills/actives/legend_backstab_skill",
	Const = "LegendBackstab",
	Name = "Backstab",
	Icon = "skills/active_03.png",
	IconDisabled = "skills/active_03_sw.png",
	Overlay = "active_03",
});

::Legends.Active.LegendBandage <- null;
activesDefs.push({
	ID = "actives.legend_bandage",
	Script = "scripts/skills/actives/legend_bandage_skill",
	Const = "LegendBandage",
	Name = "Use Bandages",
	this.m.Icon = "skills/active_105.png";
	this.m.IconDisabled = "skills/active_105_sw.png";
	this.m.Overlay = "active_105";
});

::Legends.Active.LegendBansheeScream <- null;
activesDefs.push({
	ID = "actives.legend_banshee_scream",
	Script = "scripts/skills/actives/legend_banshee_scream",
	Const = "LegendBansheeScream",
	Name = "Banshee Scream",
	this.m.Icon = "skills/active_41.png";
	this.m.IconDisabled = "skills/active_41.png";
	this.m.Overlay = "active_41";
});

::Legends.Active.LegendBasiliskPeck <- null;
activesDefs.push({
	ID = "actives.legend_basilisk_peck",
	Script = "scripts/skills/actives/legend_basilisk_peck_skill",
	Const = "LegendBasiliskPeck",
	Name = "Peck",
	this.m.Icon = "skills/basilisk_peck.png";
	this.m.IconDisabled = "skills/basilisk_peck.png";
	this.m.Overlay = "basilisk_peck";
});

::Legends.Active.LegendBasiliskSentryFowleye <- null;
activesDefs.push({
	ID = "actives.legend_basilisk_sentry_fowleye",
	Script = "scripts/skills/actives/legend_basilisk_sentry_fowleye_skill",
	Const = "LegendBasiliskSentryFowleye",
	Name = "Fowl Eye",
	this.m.Icon = "skills/sentry_fowleye.png";
	this.m.IconDisabled = "sentry_fowleye.png";
	this.m.Overlay = "sentry_fowleye";
});

::Legends.Active.LegendBasiliskSentryInject <- null;
activesDefs.push({
	ID = "actives.legend_basilisk_sentry_inject",
	Script = "scripts/skills/actives/legend_basilisk_sentry_inject_skill",
	Const = "LegendBasiliskSentryInject",
	Name = "Inject",
	this.m.Icon = "skills/sentry_inject.png";
	this.m.IconDisabled = "skills/sentry_inject.png";
	this.m.Overlay = "sentry_inject";
});

::Legends.Active.LegendBearBite <- null;
activesDefs.push({
	ID = "actives.legend_bear_bite",
	Script = "scripts/skills/actives/legend_bear_bite_skill",
	Const = "LegendBearBite",
	Name = "Bear Bite",
	this.m.Icon = "skills/active_71.png";
	this.m.IconDisabled = "skills/active_71_bw.png";
	this.m.Overlay = "active_71";
});

::Legends.Active.LegendBearClaws <- null;
activesDefs.push({
	ID = "actives.legend_bear_claws",
	Script = "scripts/skills/actives/legend_bear_claws_skill",
	Const = "LegendBearClaws",
	Name = "Bear Claws",
	this.m.Icon = "skills/active_21.png";
	this.m.IconDisabled = "skills/active_21_bw.png";
	this.m.Overlay = "active_21";
});

::Legends.Active.LegendBreach <- null;
activesDefs.push({
	ID = "actives.legend_breach",
	Script = "scripts/skills/actives/legend_breach_skill",
	Const = "LegendBreach",
	Name = "Breach",
	Icon = "skills/active_01.png",
	IconDisabled = "skills/active_01_sw.png",
	Overlay = "active_01",
});

::Legends.Active.LegendBucklerBash <- null;
activesDefs.push({
	ID = "actives.legend_buckler_bash",
	Script = "scripts/skills/actives/legend_buckler_bash_skill",
	Const = "LegendBucklerBash",
	Name = "Buckler Bash",
	this.m.Icon = "skills/buckler_bash_square.png";
	this.m.IconDisabled = "skills/buckler_bash_square_bw.png";
	this.m.Overlay = "active_133";
});

::Legends.Active.LegendCallLightning <- null;
activesDefs.push({
	ID = "actives.legend_call_lightning",
	Script = "scripts/skills/actives/legend_call_lightning_skill",
	Const = "LegendCallLightning",
	Name = "Call Lightning",
	this.m.Icon = "skills/storm_square.png";
	this.m.IconDisabled = "skills/storm_square_bw.png";
	this.m.Overlay = "storm_square";
});

::Legends.Active.LegendCatBite <- null;
activesDefs.push({
	ID = "actives.legend_cat_bite",
	Script = "scripts/skills/actives/legend_cat_bite_skill",
	Const = "LegendCatBite",
	Name = "Cat Bite",
	this.m.Icon = "skills/cat_bite.png";
	this.m.IconDisabled = "skills/cat_bite_sw.png";
	this.m.Overlay = "cat_bite";
});

::Legends.Active.LegendCatapultBoulder <- null;
activesDefs.push({
	ID = "actives.legend_catapult_boulder",
	Script = "scripts/skills/actives/legend_catapult_boulder_skill",
	Const = "LegendCatapultBoulder",
	Name = "Catapult Boulder",
	this.m.Icon = "skills/active_12.png";
	this.m.IconDisabled = "skills/active_12_sw.png";
	this.m.Overlay = "active_12";
});

::Legends.Active.LegendChainLightning <- null;
activesDefs.push({
	ID = "actives.legend_chain_lightning",
	Script = "scripts/skills/actives/legend_chain_lightning_skill",
	Const = "LegendChainLightning",
	Name = "Chain Lightning",
	this.m.Icon = "skills/lightning_square.png";
	this.m.IconDisabled = "skills/lightning_square_bw.png";
	this.m.Overlay = "lightning_square";
});

::Legends.Active.LegendCheerOn <- null;
activesDefs.push({
	ID = "actives.legend_cheer_on",
	Script = "scripts/skills/actives/legend_cheer_on_skill",
	Const = "LegendCheerOn",
	Name = "Cheer On",
	this.m.Icon = "skills/cheered_on_square.png";
	this.m.IconDisabled = "skills/cheered_on_square_bw.png";
	this.m.Overlay = "cheered_on_square";
});

::Legends.Active.LegendChoke <- null;
activesDefs.push({
	ID = "actives.legend_choke",
	Script = "scripts/skills/actives/legend_choke_skill",
	Const = "LegendChoke",
	Name = "Choke",
	this.m.Icon = "skills/choke_square.png";
	this.m.IconDisabled = "skills/choke_square_bw.png";
	this.m.Overlay = "active_choke";
});

::Legends.Active.LegendClimb <- null;
activesDefs.push({
	ID = "actives.legend_climb",
	Script = "scripts/skills/actives/legend_climb_skill",
	Const = "LegendClimb",
	Name = "Climb",
	this.m.Icon = "skills/active_climb.png";
	this.m.IconDisabled = "skills/active_climb_bw.png";
	this.m.Overlay = "active_climb";
});

::Legends.Active.LegendCoatWithRedbackPoison <- null;
activesDefs.push({
	ID = "actives.legend_coat_with_redback_poison",
	Script = "scripts/skills/actives/legend_coat_with_redback_poison_skill",
	Const = "LegendCoatWithRedbackPoison",
	Name = "Use Redback Poison",
	this.m.Icon = "skills/active_legend_coat_with_redback_poison.png";
	this.m.IconDisabled = "skills/active_legend_coat_with_redback_poison_bw.png";
	this.m.Overlay = "active_legend_coat_with_redback_poison";
});

::Legends.Active.LegendCommandLegion <- null;
activesDefs.push({
	ID = "actives.legend_command_legion",
	Script = "scripts/skills/actives/legend_command_legion_skill",
	Const = "LegendCommandLegion",
	Name = "Command Legionary",
	this.m.Icon = "skills/legend_legion_command_square.png";
	this.m.IconDisabled = "skills/legend_legion_command_square_bw.png";
	this.m.Overlay = "legend_legion_command_square";
});

::Legends.Active.LegendCoordinatedVolleys <- null;
activesDefs.push({
	ID = "actives.legend_coordinated_volleys",
	Script = "scripts/skills/actives/legend_coordinated_volleys_skill",
	Const = "LegendCoordinatedVolleys",
	Name = "Coordinated Volleys",
	this.m.Icon = "skills/coordinated_volleys_square.png";
	this.m.IconDisabled = "skills/coordinated_volleys_square_bw.png";
	this.m.Overlay = "coordinated_volleys_square";
});

::Legends.Active.LegendCurseofyears <- null;
activesDefs.push({
	ID = "actives.legend_curseofyears",
	Script = "scripts/skills/actives/legend_curseofyears_skill",
	Const = "LegendCurseofyears",
	Name = "Decrepify",
	this.m.Icon = "skills/active_117.png";
	this.m.IconDisabled = "skills/active_117_sw.png";
	this.m.Overlay = "active_117";
});

::Legends.Active.LegendDaze <- null;
activesDefs.push({
	ID = "actives.legend_daze",
	Script = "scripts/skills/actives/legend_daze_skill",
	Const = "LegendDaze",
	Name = "Stupefy",
	this.m.Icon = "skills/daze_square.png";
	this.m.IconDisabled = "skills/daze_square_bw.png";
	this.m.Overlay = "daze_square";
});

::Legends.Active.LegendDeathtouch <- null;
activesDefs.push({
	ID = "actives.legend_deathtouch",
	Script = "scripts/skills/actives/legend_deathtouch_skill",
	Const = "LegendDeathtouch",
	Name = "Death Touch",
	this.m.Icon = "skills/deathtouch_square.png";
	this.m.IconDisabled = "skills/deathtouch_square_bw.png";
	this.m.Overlay = "deathtouch_square";
});

::Legends.Active.LegendDebilitate <- null; // active debilitate
activesDefs.push({
	ID = "actives.legend_debilitate",
	Script = "scripts/skills/actives/legend_debilitate_skill", 
	Const = "LegendDebilitate",
	Name = "Debilitate",
	Icon = "ui/perks/perk_34_active.png",
	IconDisabled = "ui/perks/perk_34_active_sw.png",
	Overlay = "perk_34_active",
});

::Legends.Active.LegendDemonHoundBite <- null;
activesDefs.push({
	ID = "actives.legend_demon_hound_bite",
	Script = "scripts/skills/actives/legend_demon_hound_bite_skill",
	Const = "LegendDemonHoundBite",
	Name = "Höllenhund Bite",
	this.m.Icon = "skills/demon_hound_bite.png";
	this.m.IconDisabled = "skills/demon_hound_bite_bw.png";
	this.m.Overlay = "demon_hound_bite";
});

::Legends.Active.LegendDonkeyKick <- null;
activesDefs.push({
	ID = "actives.legend_donkey_kick",
	Script = "scripts/skills/actives/legend_donkey_kick_skill",
	Const = "LegendDonkeyKick",
	Name = "Donkey Kick",
	this.m.Icon = "skills/horse_kick.png";
	this.m.IconDisabled = "skills/horse_kick_bw.png";
	this.m.Overlay = "horse_kick";
});

::Legends.Active.LegendDoubleSwing <- null;
activesDefs.push({
	ID = "actives.legend_double_swing",
	Script = "scripts/skills/actives/legend_double_swing_skill",
	Const = "LegendDoubleSwing",
	Name = "Double Swing",
	this.m.Icon = "skills/legend_double_swing.png";
	this.m.IconDisabled = "skills/legend_double_swing_sw.png";
	this.m.Overlay = "legend_double_swing";
});

::Legends.Active.LegendDrain <- null;
activesDefs.push({
	ID = "actives.legend_drain",
	Script = "scripts/skills/actives/legend_drain_skill",
	Const = "LegendDrain",
	Name = "Drain Life",
	this.m.Icon = "skills/blooddrop_square.png";
	this.m.IconDisabled = "skills/blooddrop_square_bw.png";
	this.m.Overlay = "blooddrop_square";
});

::Legends.Active.LegendDrinkBeer <- null;
activesDefs.push({
	ID = "actives.legend_drink_beer",
	Script = "scripts/skills/actives/legend_drink_beer_skill",
	Const = "LegendDrinkBeer",
	Name = "Drink or Give Beer",
	this.m.Icon = "skills/beer_square.png";
	this.m.IconDisabled = "skills/beer_square_bw.png";
	this.m.Overlay = "active_144";
});

::Legends.Active.LegendDrinkHeartwoodSap <- null;
activesDefs.push({
	ID = "actives.legend_drink_heartwood_sap",
	Script = "scripts/skills/actives/legend_drink_heartwood_sap_skill",
	Const = "LegendDrinkHeartwoodSap",
	Name = "Drink or Give Heartwood Sap",
	this.m.Icon = "skills/heartwood_sap_potion_square.png";
	this.m.IconDisabled = "skills/blood_potion_square_bw.png";
	this.m.Overlay = "active_144";
});

::Legends.Active.LegendDrinkHexeIchorPotion <- null;
activesDefs.push({
	ID = "actives.legend_drink_hexe_ichor_potion",
	Script = "scripts/skills/actives/legend_drink_hexe_ichor_potion_skill",
	Const = "LegendDrinkHexeIchorPotion",
	Name = "Drink or Give Hexe Ichor Potion",
	this.m.Icon = "skills/ichor_potion_square.png";
	this.m.IconDisabled = "skills/ichor_potion_square_bw.png";
	this.m.Overlay = "active_140";
});

::Legends.Active.LegendDrinkLiquor <- null;
activesDefs.push({
	ID = "actives.legend_drink_liquor",
	Script = "scripts/skills/actives/legend_drink_liquor_skill",
	Const = "LegendDrinkLiquor",
	Name = "Drink or Give Liquor",
	this.m.Icon = "skills/mead_square.png";
	this.m.IconDisabled = "skills/mead_square_bw.png";
	this.m.Overlay = "active_144";
});

::Legends.Active.LegendDrinkMead <- null;
activesDefs.push({
	ID = "actives.legend_drink_mead",
	Script = "scripts/skills/actives/legend_drink_mead_skill",
	Const = "LegendDrinkMead",
	Name = "Drink or Give Mead",
	this.m.Icon = "skills/mead_square.png";
	this.m.IconDisabled = "skills/mead_square_bw.png";
	this.m.Overlay = "active_144";
});

::Legends.Active.LegendDrinkSkinGhoulBlood <- null;
activesDefs.push({
	ID = "actives.legend_drink_skin_ghoul_blood",
	Script = "scripts/skills/actives/legend_drink_skin_ghoul_blood_skill",
	Const = "LegendDrinkSkinGhoulBlood",
	Name = "Drink or Give Skin Ghoul Blood",
	this.m.Icon = "skills/blooddrop_square.png";
	this.m.IconDisabled = "skills/blooddrop_square_bw.png";
	this.m.Overlay = "active_144";
});

::Legends.Active.LegendDrinkStollwurmBlood <- null;
activesDefs.push({
	ID = "actives.legend_drink_stollwurm_blood",
	Script = "scripts/skills/actives/legend_drink_stollwurm_blood_skill",
	Const = "LegendDrinkStollwurmBlood",
	Name = "Drink or Give Stollwurm Blood",
	this.m.Icon = "skills/stollwurm_blood_potion_square.png";
	this.m.IconDisabled = "skills/blood_potion_square_bw.png";
	this.m.Overlay = "active_144";
});

::Legends.Active.LegendDrinkWine <- null;
activesDefs.push({
	ID = "actives.legend_drink_wine",
	Script = "scripts/skills/actives/legend_drink_wine_skill",
	Const = "LegendDrinkWine",
	Name = "Drink or Give Wine",
	this.m.Icon = "skills/wine_square.png";
	this.m.IconDisabled = "skills/wine_square_bw.png";
	this.m.Overlay = "active_144";
});

::Legends.Active.LegendDrumsOfLife <- null;
activesDefs.push({
	ID = "actives.legend_drums_of_life",
	Script = "scripts/skills/actives/legend_drums_of_life_skill",
	Const = "LegendDrumsOfLife",
	Name = "Song of Life",
	this.m.Icon = "skills/drums_of_life_square.png";
	this.m.IconDisabled = "skills/drums_of_life_square_bw.png";
	this.m.Overlay = "drums_of_life_square";
});

::Legends.Active.LegendDrumsOfWar <- null;
activesDefs.push({
	ID = "actives.legend_drums_of_war",
	Script = "scripts/skills/actives/legend_drums_of_war_skill",
	Const = "LegendDrumsOfWar",
	Name = "War Chant",
	this.m.Icon = "skills/drums_of_war_square.png";
	this.m.IconDisabled = "skills/drums_of_war_square_bw.png";
	this.m.Overlay = "drums_of_war_square";
});

::Legends.Active.LegendEatPie <- null;
activesDefs.push({
	ID = "actives.legend_eat_pie",
	Script = "scripts/skills/actives/legend_eat_pie_skill",
	Const = "LegendEatPie",
	Name = "Eat or Give Pie",
	this.m.Icon = "skills/pie_square.png";
	this.m.IconDisabled = "skills/pie_square_bw.png";
	this.m.Overlay = "active_144";
});

::Legends.Active.LegendEatPorridge <- null;
activesDefs.push({
	ID = "actives.legend_eat_porridge",
	Script = "scripts/skills/actives/legend_eat_porridge_skill",
	Const = "LegendEatPorridge",
	Name = "Eat or Give Porridge",
	this.m.Icon = "skills/porridge_square.png";
	this.m.IconDisabled = "skills/porridge_square_bw.png";
	this.m.Overlay = "active_144";
});

::Legends.Active.LegendEatPudding <- null;
activesDefs.push({
	ID = "actives.legend_eat_pudding",
	Script = "scripts/skills/actives/legend_eat_pudding_skill",
	Const = "LegendEatPudding",
	Name = "Eat or Give Pudding",
	this.m.Icon = "skills/pudding_square.png";
	this.m.IconDisabled = "skills/pudding_square_bw.png";
	this.m.Overlay = "active_144";
});

::Legends.Active.LegendEatRations <- null;
activesDefs.push({
	ID = "actives.legend_eat_rations",
	Script = "scripts/skills/actives/legend_eat_rations_skill",
	Const = "LegendEatRations",
	Name = "Eat or Give Food",
	this.m.Icon = "skills/rations_square.png";
	this.m.IconDisabled = "skills/rations_square_bw.png";	
	this.m.Overlay = "active_144";
});

::Legends.Active.LegendEnragedHyenaBite <- null;
activesDefs.push({
	ID = "actives.legend_enraged_hyena_bite",
	Script = "scripts/skills/actives/legend_enraged_hyena_bite_skill",
	Const = "LegendEnragedHyenaBite",
	Name = "Enraged Hyena Bite",
	this.m.Icon = "skills/active_197.png";
	this.m.IconDisabled = "skills/active_197_sw.png";
	this.m.Overlay = "active_197";
});

::Legends.Active.LegendEntice <- null;
activesDefs.push({
	ID = "actives.legend_entice",
	Script = "scripts/skills/actives/legend_entice_skill",
	Const = "LegendEntice",
	Name = "Entice",
	this.m.Icon = "skills/entice.png";
	this.m.IconDisabled = "skills/entice_bw.png";
	this.m.Overlay = "entice";
});

::Legends.Active.LegendEvasion <- null;
activesDefs.push({
	ID = "actives.legend_evasion",
	Script = "scripts/skills/actives/legend_evasion_skill",
	Const = "LegendEvasion",
	Name = "Evasion",
	this.m.Icon = "skills/evasion.png";
	this.m.IconDisabled = "skills/evasion_bw.png";
	this.m.Overlay = "evasion";
});

::Legends.Active.LegendFalcon <- null;
activesDefs.push({
	ID = "actives.legend_falcon",
	Script = "scripts/skills/actives/legend_falcon_skill",
	Const = "LegendFalcon",
	Name = "Unleash Falcon",
	this.m.Icon = "skills/active_104.png";
	this.m.IconDisabled = "skills/active_104_sw.png";
	this.m.Overlay = "active_104";
});

::Legends.Active.LegendFieldTriage <- null;
activesDefs.push({
	ID = "actives.legend_field_triage",
	Script = "scripts/skills/actives/legend_field_triage_skill",
	Const = "LegendFieldTriage",
	Name = "Field Triage",
	this.m.Icon = "skills/triage_square.png";
	this.m.IconDisabled = "skills/triage_square_bw.png";
	this.m.Overlay = "active_41";
});

::Legends.Active.LegendFirefield <- null;
activesDefs.push({
	ID = "actives.legend_firefield",
	Script = "scripts/skills/actives/legend_firefield_skill",
	Const = "LegendFirefield",
	Name = "Fire Pot",
	this.m.Icon = "skills/fire_square.png";
	this.m.IconDisabled = "skills/fire_square_bw.png";
	this.m.Overlay = "fire_circle";
});

::Legends.Active.LegendFlagellate <- null;
activesDefs.push({
	ID = "actives.legend_flagellate",
	Script = "scripts/skills/actives/legend_flagellate_skill",
	Const = "LegendFlagellate",
	Name = "Flagellate",
	this.m.Icon = "skills/flagellate.png";
	this.m.IconDisabled = "skills/flagellate.png";
	this.m.Overlay = "flagellate";
});

::Legends.Active.LegendFlogging <- null;
activesDefs.push({
	ID = "actives.legend_flogging",
	Script = "scripts/skills/actives/legend_flogging_skill",
	Const = "LegendFlogging",
	Name = "Flogging",
	this.m.Icon = "skills/bleed_square.png";
	this.m.IconDisabled = "skills/bleed_square_bw.png";
	this.m.Overlay = "bleed";
});

::Legends.Active.LegendFlourish <- null;
activesDefs.push({
	ID = "actives.legend_flourish",
	Script = "scripts/skills/actives/legend_flourish_skill",
	Const = "LegendFlourish",
	Name = "Flourish",
	this.m.Icon = "ui/perks/perk_41_active.png";
	this.m.IconDisabled = "ui/perks/perk_41_active_sw.png";
	this.m.Overlay = "perk_41_active";
});

::Legends.Active.LegendFlowingSlash <- null;
activesDefs.push({
	ID = "actives.legend_flowing_slash",
	Script = "scripts/skills/actives/legend_flowing_slash_skill",
	Const = "LegendFlowingSlash",
	Name = "Flowing Slash",
	this.m.Icon = "skills/active_172.png";
	this.m.IconDisabled = "skills/active_172_sw.png";
	this.m.Overlay = "active_172";
});

::Legends.Active.LegendFullDraw <- null;
activesDefs.push({
	ID = "actives.legend_full_draw",
	Script = "scripts/skills/actives/legend_full_draw_skill",
	Const = "LegendFullDraw",
	Name = "Full Draw",
	this.m.Icon = "skills/legend_full_draw.png";
	this.m.IconDisabled = "skills/legend_full_draw_bw.png";
	this.m.Overlay = "legend_full_draw";
});

::Legends.Active.LegendGrapple <- null;
activesDefs.push({
	ID = "actives.legend_grapple",
	Script = "scripts/skills/actives/legend_grapple_skill",
	Const = "LegendGrapple",
	Name = "Grapple",
	this.m.Icon = "skills/grapple_square.png";
	this.m.IconDisabled = "skills/grapple_square_bw.png";
	this.m.Overlay = "active_grapple";
});

::Legends.Active.LegendGrowGreenwoodShield <- null;
activesDefs.push({
	ID = "actives.legend_grow_greenwood_shield",
	Script = "scripts/skills/actives/legend_grow_greenwood_shield_skill",
	Const = "LegendGrowGreenwoodShield",
	Name = "Grow Greenwood Shield",
	this.m.Icon = "skills/active_121.png";
	this.m.IconDisabled = "skills/active_121.png";
	this.m.Overlay = "active_121";
});

::Legends.Active.LegendGruesomeFeast <- null;
activesDefs.push({
	ID = "actives.legend_gruesome_feast",
	Script = "scripts/skills/actives/legend_gruesome_feast_skill",
	Const = "LegendGruesomeFeast",
	Name = "Gruesome Feast",
	this.m.Icon = "skills/gruesome_square.png";
	this.m.IconDisabled = "skills/gruesome_square_bw.png";
	this.m.Overlay = "gruesome_square";
});

::Legends.Active.LegendGut <- null;
activesDefs.push({
	ID = "actives.legend_gut",
	Script = "scripts/skills/actives/legend_gut_skill",
	Const = "LegendGut",
	Name = "Gut",
	this.m.Icon = "skills/active_237.png";
	this.m.IconDisabled = "skills/active_237_sw.png";
	this.m.Overlay = "active_237";
});

::Legends.Active.LegendHaftstrike <- null;
activesDefs.push({
	ID = "actives.legend_haftstrike",
	Script = "scripts/skills/actives/legend_haftstrike",
	Const = "LegendHaftstrike",
	Name = "Haftstrike",
	this.m.Icon = "skills/active_haftstrike.png";
	this.m.IconDisabled = "skills/active_haftstrike_bw.png";
	this.m.Overlay = "active_haftstrike";
});

::Legends.Active.LegendHalberdSmite <- null;
activesDefs.push({
	ID = "actives.legend_halberd_smite",
	Script = "scripts/skills/actives/legend_halberd_smite_skill",
	Const = "LegendHalberdSmite",
	Name = "Smite",
	this.m.Icon = "skills/legend_halberd_smite.png";
	this.m.IconDisabled = "skills/legend_halberd_smite_bw.png";
	this.m.Overlay = "legend_halberd_smite";
});

::Legends.Active.LegendHalfsword <- null;
activesDefs.push({
	ID = "actives.legend_halfsword",
	Script = "scripts/skills/actives/legend_halfsword_skill",
	Const = "LegendHalfsword",
	Name = "Halfsword",
	this.m.Icon = "skills/active_halfsword.png";
	this.m.IconDisabled = "skills/active_halfsword_bw.png";
	this.m.Overlay = "active_halfsword";
});

::Legends.Active.LegendHarvest <- null;
activesDefs.push({
	ID = "actives.legend_harvest",
	Script = "scripts/skills/actives/legend_harvest_skill",
	Const = "LegendHarvest",
	Name = "Harvest",
	this.m.Icon = "skills/active_06.png";
	this.m.IconDisabled = "skills/active_06_sw.png";
	this.m.Overlay = "active_06";
});

::Legends.Active.LegendHeartseeker <- null;
activesDefs.push({
	ID = "actives.legend_heartseeker",
	Script = "scripts/skills/actives/legend_heartseeker_skill",
	Const = "LegendHeartseeker",
	Name = "Heartseeker",
	this.m.Icon = "skills/active_legend_heartseeker.png";
	this.m.IconDisabled = "skills/active_legend_heartseeker_bw.png";
	this.m.Overlay = "active_legend_heartseeker";
});

::Legends.Active.LegendHew <- null;
activesDefs.push({
	ID = "actives.legend_hew",
	Script = "scripts/skills/actives/legend_hew_skill",
	Const = "LegendHew",
	Name = "Hew",
	this.m.Icon = "skills/active_210.png";
	this.m.IconDisabled = "skills/active_210_sw.png";
	this.m.Overlay = "active_210";
});

// insert here


::Legends.Active.LegendObliterate <- null;
activesDefs.push({
	ID = "actives.legend_obliterate",
	Script = "scripts/skills/actives/legend_obliterate_skill",
	Const = "LegendObliterate",
	Name = "Obliterate",
});









::Legends.Active.LegendThrowBackupSpear <- null;
activesDefs.push({
	ID = "actives.legend_throw_backup_spear",
	Script = "scripts/skills/actives/legend_throw_backup_spear_skill",
	Const = "LegendThrowBackupSpear",
	Name = "Throw Backup Spear",
});



::Legends.Active.LegendThrowBackupAxe <- null;
activesDefs.push({
	ID = "actives.legend_throw_backup_axe",
	Script = "scripts/skills/actives/legend_throw_backup_axe_skill",
	Const = "LegendThrowBackupAxe",
	Name = "Throw Backup Axe",
});


































::Legends.Active.LegendWhipDebilitate <- null; // active debilitate
activesDefs.push({
	ID = "actives.legend_debilitate",
	Script = "scripts/skills/actives/legend_whip_debilitate_skill", 
	Const = "LegendWhipDebilitate",
	Name = "Debilitate",
		Icon = "ui/perks/perk_34_active.png",
		IconDisabled = "ui/perks/perk_34_active_sw.png",
		Overlay = "perk_34_active",
});



::Legends.Active.LegendSlingHeavyStone <- null;
activesDefs.push({
	ID = "actives.legend_sling_heavy_stone",
	Script = "scripts/skills/actives/legend_sling_heavy_stone_skill",
	Const = "LegendSlingHeavyStone",
	Name = "Sling Heavy Stone",
});

::Legends.Active.LegendShootDart <- null;
activesDefs.push({
	ID = "actives.legend_shoot_dart",
	Script = "scripts/skills/actives/legend_shoot_dart_skill",
	Const = "LegendShootDart",
	Name = "Shoot Dart",
});



::Legends.Active.LegendRunThrough <- null;
activesDefs.push({
	ID = "actives.legend_run_through",
	Script = "scripts/skills/actives/legend_run_through_skill",
	Const = "LegendRunThrough",
	Name = "Run Through",
});





::Legends.Active.LegendSkinGhoulClaws <- null;
activesDefs.push({
	ID = "actives.legend_skin_ghoul_claws",
	Script = "scripts/skills/actives/legend_skin_ghoul_claws",
	Const = "LegendSkinGhoulClaws",
	Name = "Skin Ghoul Claws",
});

::Legends.Active.LegendWhiteWolfBite <- null;
activesDefs.push({
	ID = "actives.legend_white_wolf_bite",
	Script = "scripts/skills/actives/legend_white_wolf_bite_skill",
	Const = "LegendWhiteWolfBite",
	Name = "White Direwolf Bite",
});

::Legends.Active.LegendRedbackSpiderBite <- null;
activesDefs.push({
	ID = "actives.legend_redback_spider_bite",
	Script = "scripts/skills/actives/legend_redback_spider_bite_skill",
	Const = "LegendRedbackSpiderBite",
	Name = "Redback Webknecht Bite",
});



::Legends.Active.LegendRangedFlail <- null;
activesDefs.push({
	ID = "actives.legend_ranged_flail",
	Script = "scripts/skills/actives/legend_ranged_flail_skill",
	Const = "LegendRangedFlail",
	Name = "Flail",
});

::Legends.Active.LegendScytheCleave <- null;
activesDefs.push({
	ID = "actives.legend_scythe_cleave",
	Script = "scripts/skills/actives/legend_scythe_cleave_skill",
	Const = "LegendScytheCleave",
	Name = "Cleave",
});

::Legends.Active.LegendHorseKick <- null;
activesDefs.push({
	ID = "actives.legend_horse_kick",
	Script = "scripts/skills/actives/legend_horse_kick_skill",
	Const = "LegendHorseKick",
	Name = "Horse Kick",
});





::Legends.Active.LegendNightmareTouch <- null;
activesDefs.push({
	ID = "actives.legend_nightmare_touch",
	Script = "scripts/skills/actives/legend_nightmare_touch_skill",
	Const = "LegendNightmareTouch",
	Name = "Terror",
});



::Legends.Active.LegendNinetailsDisarm <- null;
activesDefs.push({
	ID = "actives.legend_ninetails_disarm",
	Script = "scripts/skills/actives/legend_ninetails_disarm_skill",
	Const = "LegendNinetailsDisarm",
	Name = "Disarm",
});

::Legends.Active.LegendRangedLash <- null;
activesDefs.push({
	ID = "actives.legend_ranged_lash",
	Script = "scripts/skills/actives/legend_ranged_lash_skill",
	Const = "LegendRangedLash",
	Name = "Lash",
});



::Legends.Active.LegendSkinGhoulSwallowWhole <- null;
activesDefs.push({
	ID = "actives.legend_skin_ghoul_swallow_whole",
	Script = "scripts/skills/actives/legend_skin_ghoul_swallow_whole_skill",
	Const = "LegendSkinGhoulSwallowWhole",
	Name = "Swallow Whole",
});





::Legends.Active.LegendPushForward <- null;
activesDefs.push({
	ID = "actives.legend_push_forward",
	Script = "scripts/skills/actives/legend_push_forward_skill",
	Const = "LegendPushForward",
	Name = "Push Forward",
});



::Legends.Active.LegendHorseCharge <- null;
activesDefs.push({
	ID = "actives.legend_horse_charge",
	Script = "scripts/skills/actives/legend_horse_charge_skill",
	Const = "LegendHorseCharge",
	Name = "Horse Charge",
});

::Legends.Active.LegendIntenselyCharm <- null;
activesDefs.push({
	ID = "actives.legend_intensely_charm",
	Script = "scripts/skills/actives/legend_intensely_charm_skill",
	Const = "LegendIntenselyCharm",
	Name = "Infatuate",
});

::Legends.Active.LegendTeleport <- null;
activesDefs.push({
	ID = "actives.legend_teleport",
	Script = "scripts/skills/actives/legend_teleport_skill",
	Const = "LegendTeleport",
	Name = "Teleport",
});

::Legends.Active.LegendRevolt <- null;
activesDefs.push({
	ID = "actives.legend_revolt",
	Script = "scripts/skills/actives/legend_revolt_skill",
	Const = "LegendRevolt",
	Name = "Revolt",
});

::Legends.Active.LegendPush <- null;
activesDefs.push({
	ID = "actives.legend_push",
	Script = "scripts/skills/actives/legend_push_skill",
	Const = "LegendPush",
	Name = "Revolt",
});

::Legends.Active.LegendStaffRiposte <- null;
activesDefs.push({
	ID = "actives.legend_staff_riposte",
	Script = "scripts/skills/actives/legend_staff_riposte_skill",
	Const = "LegendStaffRiposte",
	Name = "Riposte",
});

::Legends.Active.LegendHorsePirouette <- null;
activesDefs.push({
	ID = "actives.legend_horse_pirouette",
	Script = "scripts/skills/actives/legend_horse_pirouette_skill",
	Const = "LegendHorsePirouette",
	Name = "Pirouette",
});

::Legends.Active.LegendMagicMissile <- null;
activesDefs.push({
	ID = "actives.legend_magic_missile",
	Script = "scripts/skills/actives/legend_magic_missile_skill",
	Const = "LegendMagicMissile",
	Name = "Missile",
});

::Legends.Active.LegendShootStone <- null;
activesDefs.push({
	ID = "actives.legend_shoot_stone",
	Script = "scripts/skills/actives/legend_shoot_stone_skill",
	Const = "LegendShootStone",
	Name = "Loose Stone",
});

::Legends.Active.LegendShootPreciseStone <- null;
activesDefs.push({
	ID = "actives.legend_shoot_precise_stone",
	Script = "scripts/skills/actives/legend_shoot_precise_stone_skill",
	Const = "LegendShootPreciseStone",
	Name = "Precise Shot",
});

::Legends.Active.LegendBoarCharge <- null;
activesDefs.push({
	ID = "actives.legend_boar_charge",
	Script = "scripts/skills/actives/legend_boar_charge_skill",
	Const = "LegendBoarCharge",
	Name = "Boar Charge",
});

::Legends.Active.LegendStollwurmMoveTail <- null;
activesDefs.push({
	ID = "actives.legend_stollwurm_move_tail",
	Script = "scripts/skills/actives/legend_stollwurm_move_tail_skill",
	Const = "LegendStollwurmMoveTail",
	Name = "Burrow Tail",
});

::Legends.Active.LegendMarkTarget <- null;
activesDefs.push({
	ID = "actives.legend_mark_target",
	Script = "scripts/skills/actives/legend_mark_target_skill",
	Const = "LegendMarkTarget",
	Name = "Mark Target",
});

::Legends.Active.LegendThrowKnife <- null;
activesDefs.push({
	ID = "actives.legend_throw_knife",
	Script = "scripts/skills/actives/legend_throw_knife_skill",
	Const = "LegendThrowKnife",
	Name = "Throw Knife",
});

::Legends.Active.LegendWerewolfHowl <- null;
activesDefs.push({
	ID = "actives.legend_werewolf_howl",
	Script = "scripts/skills/actives/legend_werewolf_howl_skill",
	Const = "LegendWerewolfHowl",
	Name = "Howl",
});

::Legends.Active.LegendWhiteWolfHowl <- null;
activesDefs.push({
	ID = "actives.legend_white_wolf_howl",
	Script = "scripts/skills/actives/legend_white_wolf_howl_skill",
	Const = "LegendWhiteWolfHowl",
	Name = "White Wolf Howl",
});

::Legends.Active.LegendShadows <- null;
activesDefs.push({
	ID = "actives.legend_shadows",
	Script = "scripts/skills/actives/legend_shadows_skill",
	Const = "LegendShadows",
	Name = "Realm of Nightmares",
});

::Legends.Active.LegendValaWardenPaleTouch <- null;
activesDefs.push({
	ID = "actives.legend_vala_warden_pale_touch",
	Script = "scripts/skills/actives/legend_vala_warden_pale_touch_skill",
	Const = "LegendValaWardenPaleTouch",
	Name = "Pale Touch",
});

::Legends.Active.LegendValaWardenWail <- null;
activesDefs.push({
	ID = "actives.legend_vala_warden_wail",
	Script = "scripts/skills/actives/legend_vala_warden_wail_skill",
	Const = "LegendValaWardenWail",
	Name = "Wail",
});

::Legends.Active.LegendProtectTarget <- null;
activesDefs.push({
	ID = "actives.legend_protect_target",
	Script = "scripts/skills/actives/legend_protect_target_skill",
	Const = "LegendProtectTarget",
	Name = "Defend! Good boy!",
});

::Legends.Active.LegendVolley <- null;
activesDefs.push({
	ID = "actives.legend_volley",
	Script = "scripts/skills/actives/legend_volley_skill",
	Const = "LegendVolley",
	Name = "Volley",
});



::Legends.Active.LegendHolyflame <- null;
activesDefs.push({
	ID = "actives.legend_holyflame",
	Script = "scripts/skills/actives/legend_holyflame_skill",
	Const = "LegendHolyflame",
	Name = "Holy Flame",
});

::Legends.Active.LegendHoldTheLine <- null;
activesDefs.push({
	ID = "actives.legend_hold_the_line",
	Script = "scripts/skills/actives/legend_hold_the_line",
	Const = "LegendHoldTheLine",
	Name = "Hold the line",
});

::Legends.Active.LegendIncoming <- null;
activesDefs.push({
	ID = "actives.legend_incoming",
	Script = "scripts/skills/actives/legend_incoming_skill",
	Const = "LegendIncoming",
	Name = "Incoming!",
});

::Legends.Active.LegendInspire <- null;
activesDefs.push({
	ID = "actives.legend_inspire",
	Script = "scripts/skills/actives/legend_inspire_skill",
	Const = "LegendInspire",
	Name = "Inspire",
});

::Legends.Active.LegendKick <- null;
activesDefs.push({
	ID = "actives.legend_kick",
	Script = "scripts/skills/actives/legend_kick_skill",
	Const = "LegendKick",
	Name = "Kick",
});

::Legends.Active.LegendLeap <- null;
activesDefs.push({
	ID = "actives.legend_leap",
	Script = "scripts/skills/actives/legend_leap_skill",
	Const = "LegendLeap",
	Name = "Leap",
});

::Legends.Active.LegendLevitatePerson <- null;
activesDefs.push({
	ID = "actives.legend_levitate_person",
	Script = "scripts/skills/actives/legend_levitate_person_skill",
	Const = "LegendLevitatePerson",
	Name = "Levitate Person",
});

::Legends.Active.LegendMagicBurningHands <- null;
activesDefs.push({
	ID = "actives.legend_magic_burning_hands",
	Script = "scripts/skills/actives/legend_magic_burning_hands",
	Const = "LegendMagicBurningHands",
	Name = "Burning Hands",
});

::Legends.Active.LegendMagicChainLightning <- null;
activesDefs.push({
	ID = "actives.legend_magic_chain_lightning",
	Script = "scripts/skills/actives/legend_magic_chain_lightning_skill",
	Const = "LegendMagicChainLightning",
	Name = "Chain Lightning",
});

::Legends.Active.LegendMagicCircleOfProtection <- null;
activesDefs.push({
	ID = "actives.legend_magic_circle_of_protection",
	Script = "scripts/skills/actives/legend_magic_circle_of_protection_skill",
	Const = "LegendMagicCircleOfProtection",
	Name = "Magic Circle of Protection",
});

::Legends.Active.LegendMagicDaze <- null;
activesDefs.push({
	ID = "actives.legend_magic_daze",
	Script = "scripts/skills/actives/legend_magic_daze_skill",
	Const = "LegendMagicDaze",
	Name = "Stupefy",
});

::Legends.Active.LegendMagicHailstone <- null;
activesDefs.push({
	ID = "actives.legend_magic_hailstone",
	Script = "scripts/skills/actives/legend_magic_hailstone_skill",
	Const = "LegendMagicHailstone",
	Name = "Hailstone",
});

::Legends.Active.LegendMagicHealingWind <- null;
activesDefs.push({
	ID = "actives.legend_magic_healing_wind",
	Script = "scripts/skills/actives/legend_magic_healing_wind_skill",
	Const = "LegendMagicHealingWind",
	Name = "Healing Mist",
});

::Legends.Active.LegendMagicImbue <- null;
activesDefs.push({
	ID = "actives.legend_magic_imbue",
	Script = "scripts/skills/actives/legend_magic_imbue_skill",
	Const = "LegendMagicImbue",
	Name = "Imbue",
});

::Legends.Active.LegendMagicLevitate <- null;
activesDefs.push({
	ID = "actives.legend_magic_levitate",
	Script = "scripts/skills/actives/legend_magic_levitate_skill",
	Const = "LegendMagicLevitate",
	Name = "Levitate Person",
});

::Legends.Active.LegendMagicPsybeam <- null;
activesDefs.push({
	ID = "actives.legend_magic_psybeam",
	Script = "scripts/skills/actives/legend_magic_psybeam_skill",
	Const = "LegendMagicPsybeam",
	Name = "Psybeam",
});

::Legends.Active.LegendMagicSleep <- null;
activesDefs.push({
	ID = "actives.legend_magic_sleep",
	Script = "scripts/skills/actives/legend_magic_sleep_skill",
	Const = "LegendMagicSleep",
	Name = "Sleep",
});

::Legends.Active.LegendMagicSoothingWind <- null;
activesDefs.push({
	ID = "actives.legend_magic_soothing_wind",
	Script = "scripts/skills/actives/legend_magic_soothing_wind_skill",
	Const = "LegendMagicSoothingWind",
	Name = "Soothing Wind",
});

::Legends.Active.LegendStun <- null;
activesDefs.push({
	ID = "actives.legend_stun",
	Script = "scripts/skills/actives/legend_magic_stun_skill",
	Const = "LegendStun",
	Name = "Stun",
});

::Legends.Active.LegendMagicTeleport <- null;
activesDefs.push({
	ID = "actives.legend_magic_teleport",
	Script = "scripts/skills/actives/legend_magic_teleport_skill",
	Const = "LegendMagicTeleport",
	Name = "Teleport",
});

::Legends.Active.LegendMagicWebBolt <- null;
activesDefs.push({
	ID = "actives.legend_magic_web_bolt",
	Script = "scripts/skills/actives/legend_magic_web_bolt_skill",
	Const = "LegendMagicWebBolt",
	Name = "Web Bolt",
});

::Legends.Active.LegendMiasma <- null;
activesDefs.push({
	ID = "actives.legend_miasma",
	Script = "scripts/skills/actives/legend_miasma_skill",
	Const = "LegendMiasma",
	Name = "Miasma",
});

::Legends.Active.LegendMinorSleep <- null;
activesDefs.push({
	ID = "actives.legend_minor_sleep",
	Script = "scripts/skills/actives/legend_minor_sleep_skill",
	Const = "LegendMinorSleep",
	Name = "Minor Sleep",
});

::Legends.Active.LegendNightmareAoe <- null;
activesDefs.push({
	ID = "actives.legend_nightmare_aoe",
	Script = "scripts/skills/actives/legend_nightmare_aoe_skill",
	Const = "LegendNightmareAoe",
	Name = "Nightmare",
});

::Legends.Active.LegendNightmareTouchZoc <- null;
activesDefs.push({
	ID = "actives.legend_nightmare_touch_zoc",
	Script = "scripts/skills/actives/legend_nightmare_touch_zoc_skill",
	Const = "LegendNightmareTouchZoc",
	Name = "Terror",
});

::Legends.Active.LegendNightvision <- null;
activesDefs.push({
	ID = "actives.legend_nightvision",
	Script = "scripts/skills/actives/legend_nightvision_skill",
	Const = "LegendNightvision",
	Name = "Nightvision",
});

::Legends.Active.LegendOmsAmphora <- null;
activesDefs.push({
	ID = "actives.legend_oms_amphora",
	Script = "scripts/skills/actives/legend_oms_amphora_skill",
	Const = "LegendOmsAmphora",
	Name = "Drink from Amphora",
});

::Legends.Active.LegendPass <- null;
activesDefs.push({
	ID = "actives.legend_pass",
	Script = "scripts/skills/actives/legend_pass_skill",
	Const = "LegendPass",
	Name = "Pass Item",
});

::Legends.Active.LegendPiercingJavelin <- null;
activesDefs.push({
	ID = "actives.legend_piercing_javelin",
	Script = "scripts/skills/actives/legend_piercing_javelin_skill",
	Const = "LegendPiercingJavelin",
	Name = "Piercing Javelin",
});

::Legends.Active.LegendPiercingBolt <- null;
activesDefs.push({
	ID = "actives.legend_piercing_bolt",
	Script = "scripts/skills/actives/legend_piercing_bolt_skill",
	Const = "LegendPiercingBolt",
	Name = "Piercing Bolt",
});

::Legends.Active.LegendPoisonWeapon <- null;
activesDefs.push({
	ID = "actives.legend_poison_weapon",
	Script = "scripts/skills/actives/legend_poison_weapon_skill",
	Const = "LegendPoisonWeapon",
	Name = "Use Poison",
});

::Legends.Active.LegendPossession <- null;
activesDefs.push({
	ID = "actives.legend_possession",
	Script = "scripts/skills/actives/legend_possession_skill",
	Const = "LegendPossession",
	Name = "Possess Undead",
});

::Legends.Active.LegendPrayerOfFaith <- null;
activesDefs.push({
	ID = "actives.legend_prayer_of_faith",
	Script = "scripts/skills/actives/legend_prayer_of_faith_skill",
	Const = "LegendPrayerOfFaith",
	Name = "Prayer of Faith",
});

::Legends.Active.LegendPrayerOfLife <- null;
activesDefs.push({
	ID = "actives.legend_prayer_of_life",
	Script = "scripts/skills/actives/legend_prayer_of_life_skill",
	Const = "LegendPrayerOfLife",
	Name = "Prayer of Hope",
});

::Legends.Active.LegendPrepareBleed <- null;
activesDefs.push({
	ID = "actives.legend_prepare_bleed",
	Script = "scripts/skills/actives/legend_prepare_bleed_skill",
	Const = "LegendPrepareBleed",
	Name = "Prepare to Bleed",
});

::Legends.Active.LegendPrepareGraze <- null;
activesDefs.push({
	ID = "actives.legend_prepare_graze",
	Script = "scripts/skills/actives/legend_prepare_graze_skill",
	Const = "LegendPrepareGraze",
	Name = "Prepare to Graze",
});

::Legends.Active.LegendWindUp <- null;
activesDefs.push({
	ID = "actives.legend_wind_up",
	Script = "scripts/skills/actives/legend_wind_up_skill",
	Const = "LegendWindUp",
	Name = "Wind Up",
});

::Legends.Active.LegendQuickStep <- null;
activesDefs.push({
	ID = "actives.legend_quick_step",
	Script = "scripts/skills/actives/legend_quick_step_skill",
	Const = "LegendQuickStep",
	Name = "Quick Step",
});

::Legends.Active.LegendRaiseUndead <- null;
activesDefs.push({
	ID = "actives.legend_raise_undead",
	Script = "scripts/skills/actives/legend_raise_undead_skill",
	Const = "LegendRaiseUndead",
	Name = "Conduct Seance",
});

::Legends.Active.LegendReadOmensTrance <- null;
activesDefs.push({
	ID = "actives.legend_read_omens_trance",
	Script = "scripts/skills/actives/legend_read_omens_trance_skill",
	Const = "LegendReadOmensTrance",
	Name = "Read Omens (Trance)",
});

::Legends.Active.LegendRedbackPuncture <- null;
activesDefs.push({
	ID = "actives.legend_redback_puncture",
	Script = "scripts/skills/actives/legend_redback_puncture_skill",
	Const = "LegendRedbackPuncture",
	Name = "Redback Poison Puncture",
});

::Legends.Active.LegendRelax <- null;
activesDefs.push({
	ID = "actives.legend_relax",
	Script = "scripts/skills/actives/legend_relax_skill",
	Const = "LegendRelax",
	Name = "Relax",
});

::Legends.Active.LegendRoot <- null;
activesDefs.push({
	ID = "actives.legend_root",
	Script = "scripts/skills/actives/legend_root_skill",
	Const = "LegendRoot",
	Name = "Root",
});

::Legends.Active.LegendRust <- null;
activesDefs.push({
	ID = "actives.legend_rust",
	Script = "scripts/skills/actives/legend_rust_skill",
	Const = "LegendRust",
	Name = "Rust",
});

::Legends.Active.LegendSafeguard <- null;
activesDefs.push({
	ID = "actives.legend_safeguard",
	Script = "scripts/skills/actives/legend_safeguard_skill",
	Const = "LegendSafeguard",
	Name = "Safeguard",
});

::Legends.Active.LegendScry <- null;
activesDefs.push({
	ID = "actives.legend_scry",
	Script = "scripts/skills/actives/legend_scry_skill",
	Const = "LegendScry",
	Name = "Scry",
});

::Legends.Active.LegendScryTrance <- null;
activesDefs.push({
	ID = "actives.legend_scry_trance",
	Script = "scripts/skills/actives/legend_scry_trance_skill",
	Const = "LegendScryTrance",
	Name = "Scry Area (Trance)",
});

::Legends.Active.LegendSiphon <- null;
activesDefs.push({
	ID = "actives.legend_siphon",
	Script = "scripts/skills/actives/legend_siphon_skill",
	Const = "LegendSiphon",
	Name = "Life Siphon",
});

::Legends.Active.LegendSleep <- null;
activesDefs.push({
	ID = "actives.legend_sleep",
	Script = "scripts/skills/actives/legend_sleep_skill",
	Const = "LegendSleep",
	Name = "Sleep",
});

::Legends.Active.LegendSlingstaffBash <- null;
activesDefs.push({
	ID = "actives.legend_slingstaff_bash",
	Script = "scripts/skills/actives/legend_slingstaff_bash_skill",
	Const = "LegendSlingstaffBash",
	Name = "Slingstaff Bash",
});

::Legends.Active.LegendSpawnSkeletonHighArcher <- null;
activesDefs.push({
	ID = "actives.legend_spawn_skeleton_high_archer",
	Script = "scripts/skills/actives/legend_spawn_skeleton_high_archer_skill",
	Const = "LegendSpawnSkeletonHighArcher",
	Name = "Summon Heavy Archer Skeleton",
});

::Legends.Active.LegendSpawnSkeletonHigh <- null;
activesDefs.push({
	ID = "actives.legend_spawn_skeleton_high",
	Script = "scripts/skills/actives/legend_spawn_skeleton_high_skill",
	Const = "LegendSpawnSkeletonHigh",
	Name = "Summon Heavy Skeleton",
});

::Legends.Active.LegendSpawnSkeletonLowArcher <- null;
activesDefs.push({
	ID = "actives.legend_spawn_skeleton_low_archer",
	Script = "scripts/skills/actives/legend_spawn_skeleton_low_archer_skill",
	Const = "LegendSpawnSkeletonLowArcher",
	Name = "Summon Light Archer Skeleton",
});

::Legends.Active.LegendSpawnSkeletonLow <- null;
activesDefs.push({
	ID = "actives.legend_spawn_skeleton_low",
	Script = "scripts/skills/actives/legend_spawn_skeleton_low_skill",
	Const = "LegendSpawnSkeletonLow",
	Name = "Summon Light Skeleton",
});

::Legends.Active.LegendSpawnSkeletonMedArcher <- null;
activesDefs.push({
	ID = "actives.legend_spawn_skeleton_med_archer",
	Script = "scripts/skills/actives/legend_spawn_skeleton_med_archer_skill",
	Const = "LegendSpawnSkeletonMedArcher",
	Name = "Summon Medium Archer Skeleton",
});

::Legends.Active.LegendSpawnSkeletonMed <- null;
activesDefs.push({
	ID = "actives.legend_spawn_skeleton_med",
	Script = "scripts/skills/actives/legend_spawn_skeleton_med_skill",
	Const = "LegendSpawnSkeletonMed",
	Name = "Summon Medium Skeleton",
});

::Legends.Active.LegendSpawnZombieHigh <- null;
activesDefs.push({
	ID = "actives.legend_spawn_zombie_high",
	Script = "scripts/skills/actives/legend_spawn_zombie_high_skill",
	Const = "LegendSpawnZombieHigh",
	Name = "Summon Heavy Zombie",
});

::Legends.Active.LegendSpawnZombieHighXbow <- null;
activesDefs.push({
	ID = "actives.legend_spawn_zombie_high_xbow",
	Script = "scripts/skills/actives/legend_spawn_zombie_high_xbow_skill",
	Const = "LegendSpawnZombieHighXbow",
	Name = "Summon Heavy Xbow Zombie",
});

::Legends.Active.LegendSpawnZombieLow <- null;
activesDefs.push({
	ID = "actives.legend_spawn_zombie_low",
	Script = "scripts/skills/actives/legend_spawn_zombie_low_skill",
	Const = "LegendSpawnZombieLow",
	Name = "Summon Light Zombie",
});

::Legends.Active.LegendSpawnZombieLowXbow <- null;
activesDefs.push({
	ID = "actives.legend_spawn_zombie_low_xbow",
	Script = "scripts/skills/actives/legend_spawn_zombie_low_xbow_skill",
	Const = "LegendSpawnZombieLowXbow",
	Name = "Summon Light Xbow Zombie",
});

::Legends.Active.LegendSpawnZombieMed <- null;
activesDefs.push({
	ID = "actives.legend_spawn_zombie_med",
	Script = "scripts/skills/actives/legend_spawn_zombie_med_skill",
	Const = "LegendSpawnZombieMed",
	Name = "Summon Medium Zombie",
});

::Legends.Active.LegendSpawnZombieMedXbow <- null;
activesDefs.push({
	ID = "actives.legend_spawn_zombie_med_xbow",
	Script = "scripts/skills/actives/legend_spawn_zombie_med_xbow_skill",
	Const = "LegendSpawnZombieMedXbow",
	Name = "Summon Medium Xbow Zombie",
});

::Legends.Active.LegendStrafingRun <- null;
activesDefs.push({
	ID = "actives.legend_sprint",
	Script = "scripts/skills/actives/legend_strafing_run_skill",
	Const = "LegendStrafingRun",
	Name = "Strafing Run",
});

::Legends.Active.LegendStealth <- null;
activesDefs.push({
	ID = "actives.legend_stealth",
	Script = "scripts/skills/actives/legend_stealth_skill",
	Const = "LegendStealth",
	Name = "Stealth",
});

::Legends.Active.LegendStollwurmMove <- null;
activesDefs.push({
	ID = "actives.legend_stollwurm_move",
	Script = "scripts/skills/actives/legend_stollwurm_move_skill",
	Const = "LegendStollwurmMove",
	Name = "Burrow",
});

::Legends.Active.LegendSummonStorm <- null;
activesDefs.push({
	ID = "actives.legend_summon_storm",
	Script = "scripts/skills/actives/legend_summon_storm_skill",
	Const = "LegendSummonStorm",
	Name = "Summon Storm",
});

::Legends.Active.LegendTackle <- null;
activesDefs.push({
	ID = "actives.legend_tackle",
	Script = "scripts/skills/actives/legend_tackle_skill",
	Const = "LegendTackle",
	Name = "Tackle",
});

::Legends.Active.LegendTransformIntoBoar <- null;
activesDefs.push({
	ID = "actives.legend_transform_into_boar",
	Script = "scripts/skills/actives/legend_transform_into_boar_skill",
	Const = "LegendTransformIntoBoar",
	Name = "Transform into Boar",
});

::Legends.Active.LegendTransformIntoRat <- null;
activesDefs.push({
	ID = "actives.legend_transform_into_rat",
	Script = "scripts/skills/actives/legend_transform_into_rat_skill",
	Const = "LegendTransformIntoRat",
	Name = "Transform into Rat",
});

::Legends.Active.LegendTransformIntoTree <- null;
activesDefs.push({
	ID = "actives.legend_transform_into_tree",
	Script = "scripts/skills/actives/legend_transform_into_tree_skill",
	Const = "LegendTransformIntoTree",
	Name = "Transform into Schrat",
});

::Legends.Active.LegendTransformIntoWolf <- null;
activesDefs.push({
	ID = "actives.legend_transform_into_wolf",
	Script = "scripts/skills/actives/legend_transform_into_wolf_skill",
	Const = "LegendTransformIntoWolf",
	Name = "Transform into Wolf",
});

::Legends.Active.LegendIntoTheFray <- null;
activesDefs.push({
	ID = "actives.legend_into_the_fray",
	Script = "scripts/skills/actives/legend_into_the_fray_skill",
	Const = "LegendIntoTheFray",
	Name = "Into The Fray",
});



::Legends.Active.LegendUnleashBear <- null;
activesDefs.push({
	ID = "actives.legend_unleash_bear",
	Script = "scripts/skills/actives/legend_unleash_bear_skill",
	Const = "LegendUnleashBear",
	Name = "Summon Bear",
});

::Legends.Active.LegendUnleashCatapult <- null;
activesDefs.push({
	ID = "actives.legend_unleash_catapult",
	Script = "scripts/skills/actives/legend_unleash_catapult_skill",
	Const = "LegendUnleashCatapult",
	Name = "Summon Catapult",
});

::Legends.Active.LegendUnleashCat <- null;
activesDefs.push({
	ID = "actives.legend_unleash_cat",
	Script = "scripts/skills/actives/legend_unleash_cat_skill",
	Const = "LegendUnleashCat",
	Name = "Summon Cat",
});

::Legends.Active.LegendUnleashHound <- null;
activesDefs.push({
	ID = "actives.legend_unleash_hound",
	Script = "scripts/skills/actives/legend_unleash_hound_skill",
	Const = "LegendUnleashHound",
	Name = "Summon Hound",
});

::Legends.Active.LegendUnleashWarbear <- null;
activesDefs.push({
	ID = "actives.legend_unleash_warbear",
	Script = "scripts/skills/actives/legend_unleash_warbear_skill",
	Const = "LegendUnleashWarbear",
	Name = "Unleash Warbear",
});

::Legends.Active.LegendUnleashWhiteWolf <- null;
activesDefs.push({
	ID = "actives.legend_unleash_white_wolf",
	Script = "scripts/skills/actives/legend_unleash_white_wolf_skill",
	Const = "LegendUnleashWhiteWolf",
	Name = "Unleash White Wolf",
});

::Legends.Active.LegendUnleashWolf <- null;
activesDefs.push({
	ID = "actives.legend_unleash_wolf",
	Script = "scripts/skills/actives/legend_unleash_wolf_skill",
	Const = "LegendUnleashWolf",
	Name = "Summon Wolf",
});

::Legends.Active.LegendUseCatapult <- null;
activesDefs.push({
	ID = "actives.legend_use_catapult",
	Script = "scripts/skills/actives/legend_use_catapult_skill",
	Const = "LegendUseCatapult",
	Name = "Catapult Boulder",
});

::Legends.Active.LegendViolentDecomposition <- null;
activesDefs.push({
	ID = "actives.legend_violent_decomposition",
	Script = "scripts/skills/actives/legend_violent_decomposition_skill",
	Const = "LegendViolentDecomposition",
	Name = "Violent Decomposition",
});

::Legends.Active.LegendWakeAllyAoe <- null;
activesDefs.push({
	ID = "actives.legend_wake_ally_aoe",
	Script = "scripts/skills/actives/legend_wake_ally_aoe_skill",
	Const = "LegendWakeAllyAoe",
	Name = "Wake Allies",
});

::Legends.Active.LegendWerewolfClaws <- null;
activesDefs.push({
	ID = "actives.legend_werewolf_claws",
	Script = "scripts/skills/actives/legend_werewolf_claws_skill",
	Const = "LegendWerewolfClaws",
	Name = "Direwolf Claws",
});

::Legends.Active.LegendWither <- null;
activesDefs.push({
	ID = "actives.legend_wither",
	Script = "scripts/skills/actives/legend_wither_skill",
	Const = "LegendWither",
	Name = "Wither",
});

::Legends.Active.LegendWoodenStakeStab <- null;
activesDefs.push({
	ID = "actives.legend_wooden_stake_stab",
	Script = "scripts/skills/actives/legend_wooden_stake_stab_skill",
	Const = "LegendWoodenStakeStab",
	Name = "Stab with Wooden Stake",
});

::Legends.Active.LegendLaunchAcidFlask <- null;
activesDefs.push({
	ID = "actives.legend_launch_acid_flask",
	Script = "scripts/skills/actives/legend_launch_acid_flask_skill",
	Const = "LegendLaunchAcidFlask",
	Name = "Launch Acid Flask",
});

::Legends.Active.LegendLaunchDazeBomb <- null;
activesDefs.push({
	ID = "actives.legend_launch_daze_bomb",
	Script = "scripts/skills/actives/legend_launch_daze_bomb_skill",
	Const = "LegendLaunchDazeBomb",
	Name = "Launch Daze Bomb",
});

::Legends.Active.LegendLaunchFireBomb <- null;
activesDefs.push({
	ID = "actives.legend_launch_fire_bomb",
	Script = "scripts/skills/actives/legend_launch_fire_bomb_skill",
	Const = "LegendLaunchFireBomb",
	Name = "Launch Fire Bomb",
});

::Legends.Active.LegendLaunchHolyWater <- null;
activesDefs.push({
	ID = "actives.legend_launch_holy_water",
	Script = "scripts/skills/actives/legend_launch_holy_water_skill",
	Const = "LegendLaunchHolyWater",
	Name = "Launch Blessed Water",
});

::Legends.Active.LegendLaunchSmokeBomb <- null;
activesDefs.push({
	ID = "actives.legend_launch_smoke_bomb",
	Script = "scripts/skills/actives/legend_launch_smoke_bomb_skill",
	Const = "LegendLaunchSmokeBomb",
	Name = "Launch Smoke Bomb",
});

::Legends.Active.LegendMartialMarch <- null;
activesDefs.push({
	ID = "actives.legend_martial_march",
	Script = "scripts/skills/actives/legend_martial_march_skill",
	Const = "LegendMartialMarch",
	Name = "Martial March",
});

::Legends.Active.LegendSecondWind <- null;
activesDefs.push({
	ID = "actives.legend_second_wind",
	Script = "scripts/skills/actives/legend_second_wind_skill",
	Const = "LegendSecondWind",
	Name = "Second Wind",
});

::Legends.Active.LegendSighthoundBite <- null;
activesDefs.push({
	ID = "actives.legend_sighthound_bite",
	Script = "scripts/skills/actives/legend_sighthound_bite_skill",
	Const = "LegendSighthoundBite",
	Name = "Sighthound Bite",
});

::Legends.Active.LegendUnleashSighthound <- null;
activesDefs.push({
	ID = "actives.legend_unleash_sighthound",
	Script = "scripts/skills/actives/legend_unleash_sighthound_skill",
	Const = "LegendUnleashSighthound",
	Name = "Legend Unleash Sighthound",
});




::Legends.Active.LegendWarforkDisarm <- null;
activesDefs.push({
	ID = "actives.legend_warfork_disarm",
	Script = "scripts/skills/actives/legend_warfork_disarm_skill",
	Const = "LegendWarforkDisarm",
	Name = "Disarm",
});

::Legends.Active.LegendPryArmor <- null;
activesDefs.push({
	ID = "actives.legend_pry_armor",
	Script = "scripts/skills/actives/legend_pry_armor_skill",
	Const = "LegendPryArmor",
	Name = "Pry Armor",
});












::Legends.Active.LegendLineThemUp <- null;
activesDefs.push({
	ID = "actives.legend_line_them_up",
	Script = "scripts/skills/actives/legend_line_them_up_skill",
	Const = "LegendLineThemUp",
	Name = "Line Them Up",
});



::Legends.Actives.addActiveDefObjects(activesDefs);
