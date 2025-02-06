if (!("Actives" in ::Legends))
	::Legends.Actives <- {};

if (!("Active" in ::Legends))
	::Legends.Active <- {};

::Legends.Actives.ActiveDefObjects <- [];

::Legends.Actives.addActiveDefObjects <- function( _activeDefObjects )
{
	local size = ::Legends.Actives.ActiveDefObjects.len();
	::Legends.Actives.ActiveDefObjects.extend(_activeDefObjects);
	foreach (i, activeDefObject in _activeDefObjects)
	{
		::Legends.Active[activeDefObject.Const] <- size + i;
	}
}

local activesDefs = [];
activesDefs.push({
	ID = "actives.split",
	Script = "scripts/skills/actives/split",
	Const = "Split",
	Name = "Split",
});
activesDefs.push({
	ID = "actives.split_axe",
	Script = "scripts/skills/actives/split_axe",
	Const = "SplitAxe",
	Name = "Split",
});
activesDefs.push({
	ID = "actives.ignite_firelance",
	Script = "scripts/skills/actives/ignite_firelance_skill",
	Const = "IgniteFirelance",
	Name = "Ignite",
});
activesDefs.push({
	ID = "actives.knock_out",
	Script = "scripts/skills/actives/knock_out",
	Const = "KnockOut",
	Name = "Knock Out",
});
activesDefs.push({
	ID = "actives.strike_down",
	Script = "scripts/skills/actives/strike_down_skill",
	Const = "StrikeDown",
	Name = "Strike Down",
});
activesDefs.push({
	ID = "actives.knock_over",
	Script = "scripts/skills/actives/knock_over_skill",
	Const = "KnockOver",
	Name = "Knock Over",
});
activesDefs.push({
	ID = "actives.charge",
	Script = "scripts/skills/actives/charge",
	Const = "Charge",
	Name = "Charge",
});
activesDefs.push({
	ID = "actives.disarm",
	Script = "scripts/skills/actives/disarm_skill",
	Const = "Disarm",
	Name = "Disarm",
});
activesDefs.push({
	ID = "actives.throw_golem",
	Script = "scripts/skills/actives/throw_golem_skill",
	Const = "ThrowGolem",
	Name = "Throw Living Sand",
});
activesDefs.push({
	ID = "actives.adrenaline",
	Script = "scripts/skills/actives/adrenaline_skill",
	Const = "Adrenaline",
	Name = "Adrenaline",
});
activesDefs.push({
	ID = "actives.alp_teleport",
	Script = "scripts/skills/actives/alp_teleport_skill",
	Const = "AlpTeleport",
	Name = "Fade",
});
activesDefs.push({
	ID = "actives.crack_the_whip",
	Script = "scripts/skills/actives/crack_the_whip_skill",
	Const = "CrackTheWhip",
	Name = "Crack the Whip",
});
activesDefs.push({
	ID = "actives.load_mortar",
	Script = "scripts/skills/actives/load_mortar_skill",
	Const = "LoadMortar",
	Name = "Load Mortar",
});
activesDefs.push({
	ID = "actives.explode",
	Script = "scripts/skills/actives/explode_skill",
	Const = "Explode",
	Name = "Explode",
});
activesDefs.push({
	ID = "actives.geomancy",
	Script = "scripts/skills/actives/geomancy_skill",
	Const = "Geomancy",
	Name = "Geomancy",
});
activesDefs.push({
	ID = "actives.raise_all_undead",
	Script = "scripts/skills/actives/raise_all_undead_skill",
	Const = "RaiseAllUndead",
	Name = "The Black Book",
});
activesDefs.push({
	ID = "actives.geomancy_once",
	Script = "scripts/skills/actives/geomancy_once_skill",
	Const = "GeomancyOnce",
	Name = "Geomancy",
});
activesDefs.push({
	ID = "actives.quick_shot",
	Script = "scripts/skills/actives/quick_shot",
	Const = "QuickShot",
	Name = "Quick Shot",
});
activesDefs.push({
	ID = "actives.aimed_shot",
	Script = "scripts/skills/actives/aimed_shot",
	Const = "AimedShot",
	Name = "Aimed Shot",
});
activesDefs.push({
	ID = "actives.shoot_bolt",
	Script = "scripts/skills/actives/shoot_bolt",
	Const = "ShootBolt",
	Name = "Shoot Bolt",
});
activesDefs.push({
	ID = "actives.shoot_stake",
	Script = "scripts/skills/actives/shoot_stake",
	Const = "ShootStake",
	Name = "Shoot Heavy Bolt",
});
activesDefs.push({
	ID = "actives.sling_stone",
	Script = "scripts/skills/actives/sling_stone_skill",
	Const = "SlingStone",
	Name = "Sling Stone",
});
activesDefs.push({
	ID = "actives.crush_armor",
	Script = "scripts/skills/actives/crush_armor",
	Const = "CrushArmor",
	Name = "Destroy Armor",
});
activesDefs.push({
	ID = "actives.demolish_armor",
	Script = "scripts/skills/actives/demolish_armor_skill",
	Const = "DemolishArmor",
	Name = "Demolish Armor",
});
activesDefs.push({
	ID = "actives.deathblow",
	Script = "scripts/skills/actives/deathblow_skill",
	Const = "Deathblow",
	Name = "Deathblow",
});
activesDefs.push({
	ID = "actives.decapitate",
	Script = "scripts/skills/actives/decapitate",
	Const = "Decapitate",
	Name = "Decapitate",
});
activesDefs.push({
	ID = "actives.hand_to_hand",
	Script = "scripts/skills/actives/hand_to_hand",
	Const = "HandToHand",
	Name = "Hand-to-Hand Attack",
});
activesDefs.push({
	ID = "actives.chop",
	Script = "scripts/skills/actives/chop",
	Const = "Chop",
	Name = "Chop",
});
activesDefs.push({
	ID = "actives.slash",
	Script = "scripts/skills/actives/slash",
	Const = "Slash",
	Name = "Slash",
});
activesDefs.push({
	ID = "actives.slash_lightning",
	Script = "scripts/skills/actives/slash_lightning",
	Const = "SlashLightning",
	Name = "Lightbringer",
});
activesDefs.push({
	ID = "actives.thrust",
	Script = "scripts/skills/actives/thrust",
	Const = "Thrust",
	Name = "Thrust",
});
activesDefs.push({
	ID = "actives.impale",
	Script = "scripts/skills/actives/impale",
	Const = "Impale",
	Name = "Impale",
});
activesDefs.push({
	ID = "actives.strike",
	Script = "scripts/skills/actives/strike_skill",
	Const = "Strike",
	Name = "Strike",
});
activesDefs.push({
	ID = "actives.rupture",
	Script = "scripts/skills/actives/rupture",
	Const = "Rupture",
	Name = "Rupture",
});
activesDefs.push({
	ID = "actives.crumble",
	Script = "scripts/skills/actives/crumble_skill",
	Const = "Crumble",
	Name = "Crumble",
});
activesDefs.push({
	ID = "actives.prong",
	Script = "scripts/skills/actives/prong_skill",
	Const = "Prong",
	Name = "Prong",
});
activesDefs.push({
	ID = "actives.stab",
	Script = "scripts/skills/actives/stab",
	Const = "Stab",
	Name = "Stab",
});
activesDefs.push({
	ID = "actives.bash",
	Script = "scripts/skills/actives/bash",
	Const = "Bash",
	Name = "Bash",
});
activesDefs.push({
	ID = "actives.cleave",
	Script = "scripts/skills/actives/cleave",
	Const = "Cleave",
	Name = "Cleave",
});
activesDefs.push({
	ID = "actives.hammer",
	Script = "scripts/skills/actives/hammer",
	Const = "Hammer",
	Name = "Batter",
});
activesDefs.push({
	ID = "actives.overhead_strike",
	Script = "scripts/skills/actives/overhead_strike",
	Const = "OverheadStrike",
	Name = "Overhead Strike",
});
activesDefs.push({
	ID = "actives.smite",
	Script = "scripts/skills/actives/smite_skill",
	Const = "Smite",
	Name = "Smite",
});
activesDefs.push({
	ID = "actives.cudgel",
	Script = "scripts/skills/actives/cudgel_skill",
	Const = "Cudgel",
	Name = "Cudgel",
});
activesDefs.push({
	ID = "actives.whip",
	Script = "scripts/skills/actives/whip_skill",
	Const = "Whip",
	Name = "Whip",
});
activesDefs.push({
	ID = "actives.zombie_bite",
	Script = "scripts/skills/actives/zombie_bite",
	Const = "ZombieBite",
	Name = "Bite",
});
activesDefs.push({
	ID = "actives.hyena_bite",
	Script = "scripts/skills/actives/hyena_bite_skill",
	Const = "HyenaBite",
	Name = "Hyena Bite",
});
activesDefs.push({
	ID = "actives.werewolf_bite",
	Script = "scripts/skills/actives/werewolf_bite",
	Const = "WerewolfBite",
	Name = "Direwolf Bite",
});
activesDefs.push({
	ID = "actives.ghoul_claws",
	Script = "scripts/skills/actives/ghoul_claws",
	Const = "GhoulClaws",
	Name = "Ghoul Claws",
});
activesDefs.push({
	ID = "actives.ghastly_touch",
	Script = "scripts/skills/actives/ghastly_touch",
	Const = "GhastlyTouch",
	Name = "Ghastly Touch",
});
activesDefs.push({
	ID = "actives.nightmare",
	Script = "scripts/skills/actives/nightmare_skill",
	Const = "Nightmare",
	Name = "Nightmare",
});
activesDefs.push({
	ID = "actives.flail",
	Script = "scripts/skills/actives/flail_skill",
	Const = "Flail",
	Name = "Flail",
});
activesDefs.push({
	ID = "actives.pound",
	Script = "scripts/skills/actives/pound",
	Const = "Pound",
	Name = "Pound",
});
activesDefs.push({
	ID = "actives.cascade",
	Script = "scripts/skills/actives/cascade_skill",
	Const = "Cascade",
	Name = "Cascade",
});
activesDefs.push({
	ID = "actives.split_man",
	Script = "scripts/skills/actives/split_man",
	Const = "SplitMan",
	Name = "Split Man",
});
activesDefs.push({
	ID = "actives.batter",
	Script = "scripts/skills/actives/batter_skill",
	Const = "Batter",
	Name = "Batter",
});
activesDefs.push({
	ID = "actives.throw_javelin",
	Script = "scripts/skills/actives/throw_javelin",
	Const = "ThrowJavelin",
	Name = "Throw Javelin",
});
activesDefs.push({
	ID = "actives.throw_axe",
	Script = "scripts/skills/actives/throw_axe",
	Const = "ThrowAxe",
	Name = "Throw Axe",
});
activesDefs.push({
	ID = "actives.throw_balls",
	Script = "scripts/skills/actives/throw_balls",
	Const = "ThrowBalls",
	Name = "Throw Bola",
});
activesDefs.push({
	ID = "actives.throw_spear",
	Script = "scripts/skills/actives/throw_spear_skill",
	Const = "ThrowSpear",
	Name = "Throw Spear",
});
activesDefs.push({
	ID = "actives.wardog_bite",
	Script = "scripts/skills/actives/wardog_bite",
	Const = "WardogBite",
	Name = "Bite",
});
activesDefs.push({
	ID = "actives.warhound_bite",
	Script = "scripts/skills/actives/warhound_bite",
	Const = "WarhoundBite",
	Name = "Bite",
});
activesDefs.push({
	ID = "actives.wolf_bite",
	Script = "scripts/skills/actives/wolf_bite",
	Const = "WolfBite",
	Name = "Bite",
});
activesDefs.push({
	ID = "actives.gorge",
	Script = "scripts/skills/actives/gorge_skill",
	Const = "Gorge",
	Name = "Gorge",
});
activesDefs.push({
	ID = "actives.spider_bite",
	Script = "scripts/skills/actives/spider_bite_skill",
	Const = "SpiderBite",
	Name = "Webknecht Bite",
});
activesDefs.push({
	ID = "actives.uproot_small",
	Script = "scripts/skills/actives/uproot_small_skill",
	Const = "UprootSmall",
	Name = "Uproot",
});
activesDefs.push({
	ID = "actives.kraken_bite",
	Script = "scripts/skills/actives/kraken_bite_skill",
	Const = "KrakenBite",
	Name = "Bite",
});
activesDefs.push({
	ID = "actives.kraken_devour",
	Script = "scripts/skills/actives/kraken_devour_skill",
	Const = "KrakenDevour",
	Name = "Devour",
});
activesDefs.push({
	ID = "actives.ghost_overhead_strike",
	Script = "scripts/skills/actives/ghost_overhead_strike",
	Const = "GhostOverheadStrike",
	Name = "Overhead Strike",
});
activesDefs.push({
	ID = "actives.headbutt",
	Script = "scripts/skills/actives/headbutt_skill",
	Const = "Headbutt",
	Name = "Headbutt",
});
activesDefs.push({
	ID = "actives.serpent_bite",
	Script = "scripts/skills/actives/serpent_bite_skill",
	Const = "SerpentBite",
	Name = "Serpent Bite",
});
activesDefs.push({
	ID = "actives.gash",
	Script = "scripts/skills/actives/gash_skill",
	Const = "Gash",
	Name = "Gash",
});
activesDefs.push({
	ID = "actives.fire_handgonne",
	Script = "scripts/skills/actives/fire_handgonne_skill",
	Const = "FireHandgonne",
	Name = "Fire Handgonne",
});
activesDefs.push({
	ID = "actives.lash",
	Script = "scripts/skills/actives/lash_skill",
	Const = "Lash",
	Name = "Lash",
});
activesDefs.push({
	ID = "actives.hail",
	Script = "scripts/skills/actives/hail_skill",
	Const = "Hail",
	Name = "Hail",
});
activesDefs.push({
	ID = "actives.puncture",
	Script = "scripts/skills/actives/puncture",
	Const = "Puncture",
	Name = "Puncture",
});
activesDefs.push({
	ID = "actives.reap",
	Script = "scripts/skills/actives/reap_skill",
	Const = "Reap",
	Name = "Reap",
});
activesDefs.push({
	ID = "actives.tail_slam_split",
	Script = "scripts/skills/actives/tail_slam_split_skill",
	Const = "TailSlamSplit",
	Name = "Tail Slam",
});
activesDefs.push({
	ID = "actives.uproot",
	Script = "scripts/skills/actives/uproot_skill",
	Const = "Uproot",
	Name = "Uproot",
});
activesDefs.push({
	ID = "actives.ghost_split",
	Script = "scripts/skills/actives/ghost_split_skill",
	Const = "GhostSplit",
	Name = "Split",
});
activesDefs.push({
	ID = "actives.split_shield",
	Script = "scripts/skills/actives/split_shield",
	Const = "SplitShield",
	Name = "Split Shield",
});
activesDefs.push({
	ID = "actives.swallow_whole",
	Script = "scripts/skills/actives/swallow_whole_skill",
	Const = "SwallowWhole",
	Name = "Swallow Whole",
});
activesDefs.push({
	ID = "actives.swing",
	Script = "scripts/skills/actives/swing",
	Const = "Swing",
	Name = "Swing",
});
activesDefs.push({
	ID = "actives.shatter",
	Script = "scripts/skills/actives/shatter_skill",
	Const = "Shatter",
	Name = "Shatter",
});
activesDefs.push({
	ID = "actives.tail_slam",
	Script = "scripts/skills/actives/tail_slam_skill",
	Const = "TailSlam",
	Name = "Tail Slam",
});
activesDefs.push({
	ID = "actives.sweep",
	Script = "scripts/skills/actives/sweep_skill",
	Const = "Sweep",
	Name = "Sweeping Strike",
});
activesDefs.push({
	ID = "actives.ghost_swing",
	Script = "scripts/skills/actives/ghost_swing_skill",
	Const = "GhostSwing",
	Name = "Swing",
});
activesDefs.push({
	ID = "actives.horrific_scream",
	Script = "scripts/skills/actives/horrific_scream",
	Const = "HorrificScream",
	Name = "Horrific Scream",
});
activesDefs.push({
	ID = "actives.thresh",
	Script = "scripts/skills/actives/thresh",
	Const = "Thresh",
	Name = "Thresh",
});
activesDefs.push({
	ID = "actives.round_swing",
	Script = "scripts/skills/actives/round_swing",
	Const = "RoundSwing",
	Name = "Round Swing",
});
activesDefs.push({
	ID = "actives.tail_slam_big",
	Script = "scripts/skills/actives/tail_slam_big_skill",
	Const = "TailSlamBig",
	Name = "Tail Slam",
});
activesDefs.push({
	ID = "actives.throw_net",
	Script = "scripts/skills/actives/throw_net",
	Const = "ThrowNet",
	Name = "Throw Net",
});
activesDefs.push({
	ID = "actives.web",
	Script = "scripts/skills/actives/web_skill",
	Const = "Web",
	Name = "Weave Web",
});
activesDefs.push({
	ID = "actives.kraken_ensnare",
	Script = "scripts/skills/actives/kraken_ensnare_skill",
	Const = "KrakenEnsnare",
	Name = "Ensnare",
});
activesDefs.push({
	ID = "actives.goblin_whip",
	Script = "scripts/skills/actives/goblin_whip",
	Const = "GoblinWhip",
	Name = "Whip",
});
activesDefs.push({
	ID = "actives.drums_of_war",
	Script = "scripts/skills/actives/drums_of_war_skill",
	Const = "DrumsOfWar",
	Name = "Drums of War",
});
activesDefs.push({
	ID = "actives.break_free",
	Script = "scripts/skills/actives/break_free_skill",
	Const = "BreakFree",
	Name = "Break Free",
});
activesDefs.push({
	ID = "actives.unstoppable_charge",
	Script = "scripts/skills/actives/unstoppable_charge_skill",
	Const = "UnstoppableCharge",
	Name = "Unstoppable Charge",
});
activesDefs.push({
	ID = "actives.charm",
	Script = "scripts/skills/actives/charm_skill",
	Const = "Charm",
	Name = "Charm",
});
activesDefs.push({
	ID = "actives.darkflight",
	Script = "scripts/skills/actives/darkflight",
	Const = "Darkflight",
	Name = "Darkflight",
});
activesDefs.push({
	ID = "actives.knock_back",
	Script = "scripts/skills/actives/knock_back",
	Const = "KnockBack",
	Name = "Knock Back",
});
activesDefs.push({
	ID = "actives.repel",
	Script = "scripts/skills/actives/repel",
	Const = "Repel",
	Name = "Repel",
});
activesDefs.push({
	ID = "actives.hook",
	Script = "scripts/skills/actives/hook",
	Const = "Hook",
	Name = "Hook",
});
activesDefs.push({
	ID = "actives.serpent_hook",
	Script = "scripts/skills/actives/serpent_hook_skill",
	Const = "SerpentHook",
	Name = "Drag",
});
activesDefs.push({
	ID = "actives.lunge",
	Script = "scripts/skills/actives/lunge_skill",
	Const = "Lunge",
	Name = "Lunge",
});
activesDefs.push({
	ID = "actives.riposte",
	Script = "scripts/skills/actives/riposte",
	Const = "Riposte",
	Name = "Riposte",
});
activesDefs.push({
	ID = "actives.return_favor",
	Script = "scripts/skills/actives/return_favor",
	Const = "ReturnFavor",
	Name = "Return Favor",
});
activesDefs.push({
	ID = "actives.rotation",
	Script = "scripts/skills/actives/rotation",
	Const = "Rotation",
	Name = "Rotation",
});
activesDefs.push({
	ID = "actives.barbarian_fury",
	Script = "scripts/skills/actives/barbarian_fury_skill",
	Const = "BarbarianFury",
	Name = "Barbarian Fury",
});
activesDefs.push({
	ID = "actives.shieldwall",
	Script = "scripts/skills/actives/shieldwall",
	Const = "Shieldwall",
	Name = "Shieldwall",
});
activesDefs.push({
	ID = "actives.grow_shield",
	Script = "scripts/skills/actives/grow_shield_skill",
	Const = "GrowShield",
	Name = "Grow Shield",
});
activesDefs.push({
	ID = "actives.spearwall",
	Script = "scripts/skills/actives/spearwall",
	Const = "Spearwall",
	Name = "Spearwall",
});
activesDefs.push({
	ID = "actives.footwork",
	Script = "scripts/skills/actives/footwork",
	Const = "Footwork",
	Name = "Footwork",
});
activesDefs.push({
	ID = "actives.throw_dirt",
	Script = "scripts/skills/actives/throw_dirt_skill",
	Const = "ThrowDirt",
	Name = "Throw Dirt",
});
activesDefs.push({
	ID = "actives.taunt",
	Script = "scripts/skills/actives/taunt",
	Const = "Taunt",
	Name = "Taunt",
});
activesDefs.push({
	ID = "actives.kraken_move_ensnared",
	Script = "scripts/skills/actives/kraken_move_ensnared_skill",
	Const = "KrakenMoveEnsnared",
	Name = "Drag",
});
activesDefs.push({
	ID = "actives.gore",
	Script = "scripts/skills/actives/gore_skill",
	Const = "Gore",
	Name = "Gore",
});
activesDefs.push({
	ID = "actives.miasma",
	Script = "scripts/skills/actives/miasma_skill",
	Const = "Miasma",
	Name = "Miasma",
});
activesDefs.push({
	ID = "actives.horror",
	Script = "scripts/skills/actives/horror_skill",
	Const = "Horror",
	Name = "Horror",
});
activesDefs.push({
	ID = "actives.root",
	Script = "scripts/skills/actives/root_skill",
	Const = "Root",
	Name = "Root",
});
activesDefs.push({
	ID = "actives.insects",
	Script = "scripts/skills/actives/insects_skill",
	Const = "Insects",
	Name = "Swarm of Insects",
});
activesDefs.push({
	ID = "actives.raise_undead",
	Script = "scripts/skills/actives/raise_undead",
	Const = "RaiseUndead",
	Name = "Raise Undead",
});
activesDefs.push({
	ID = "actives.flying_skulls",
	Script = "scripts/skills/actives/summon_flying_skulls_skill",
	Const = "FlyingSkulls",
	Name = "Raise Screaming Skulls",
});
activesDefs.push({
	ID = "actives.grant_night_vision",
	Script = "scripts/skills/actives/grant_night_vision_skill",
	Const = "GrantNightVision",
	Name = "Grant Night Vision",
});
activesDefs.push({
	ID = "actives.gruesome_feast",
	Script = "scripts/skills/actives/gruesome_feast",
	Const = "GruesomeFeast",
	Name = "Gruesome Feast",
});
activesDefs.push({
	ID = "actives.hex",
	Script = "scripts/skills/actives/hex_skill",
	Const = "Hex",
	Name = "Hex",
});
activesDefs.push({
	ID = "actives.indomitable",
	Script = "scripts/skills/actives/indomitable",
	Const = "Indomitable",
	Name = "Indomitable",
});
activesDefs.push({
	ID = "actives.lightning_storm",
	Script = "scripts/skills/actives/lightning_storm_skill",
	Const = "LightningStorm",
	Name = "Lightning Strike",
});
activesDefs.push({
	ID = "actives.line_breaker",
	Script = "scripts/skills/actives/line_breaker",
	Const = "LineBreaker",
	Name = "Line Breaker",
});
activesDefs.push({
	ID = "actives.fling_back",
	Script = "scripts/skills/actives/fling_back_skill",
	Const = "FlingBack",
	Name = "Fling Back",
});
activesDefs.push({
	ID = "actives.merge_golem",
	Script = "scripts/skills/actives/merge_golem_skill",
	Const = "MergeGolem",
	Name = "Merge Living Sands",
});
activesDefs.push({
	ID = "actives.mirror_image",
	Script = "scripts/skills/actives/summon_mirror_image_skill",
	Const = "MirrorImage",
	Name = "Mirror Image",
});
activesDefs.push({
	ID = "actives.fire_mortar",
	Script = "scripts/skills/actives/fire_mortar_skill",
	Const = "FireMortar",
	Name = "Fire Mortar",
});
activesDefs.push({
	ID = "actives.move_tail",
	Script = "scripts/skills/actives/move_tail_skill",
	Const = "MoveTail",
	Name = "Move Tail",
});
activesDefs.push({
	ID = "actives.kraken_move",
	Script = "scripts/skills/actives/kraken_move_skill",
	Const = "KrakenMove",
	Name = "Move Tentacle",
});
activesDefs.push({
	ID = "actives.possess_undead",
	Script = "scripts/skills/actives/possess_undead_skill",
	Const = "PossessUndead",
	Name = "Possess Undead",
});
activesDefs.push({
	ID = "actives.rally_the_troops",
	Script = "scripts/skills/actives/rally_the_troops",
	Const = "RallyTheTroops",
	Name = "Rally",
});
activesDefs.push({
	ID = "actives.recover",
	Script = "scripts/skills/actives/recover_skill",
	Const = "Recover",
	Name = "Recover",
});
activesDefs.push({
	ID = "actives.reload_bolt",
	Script = "scripts/skills/actives/reload_bolt",
	Const = "ReloadBolt",
	Name = "Reload",
});
activesDefs.push({
	ID = "actives.reload_handgonne",
	Script = "scripts/skills/actives/reload_handgonne_skill",
	Const = "ReloadHandgonne",
	Name = "Reload",
});
activesDefs.push({
	ID = "actives.sleep",
	Script = "scripts/skills/actives/sleep_skill",
	Const = "Sleep",
	Name = "Sleep",
});
activesDefs.push({
	ID = "actives.teleport",
	Script = "scripts/skills/actives/teleport_skill",
	Const = "Teleport",
	Name = "Spirit Walk",
});
activesDefs.push({
	ID = "actives.throw_daze_bomb",
	Script = "scripts/skills/actives/throw_daze_bomb_skill",
	Const = "ThrowDazeBomb",
	Name = "Throw Flash Pot",
});
activesDefs.push({
	ID = "actives.throw_fire_bomb",
	Script = "scripts/skills/actives/throw_fire_bomb_skill",
	Const = "ThrowFireBomb",
	Name = "Throw Fire Pot",
});
activesDefs.push({
	ID = "actives.throw_smoke_bomb",
	Script = "scripts/skills/actives/throw_smoke_bomb_skill",
	Const = "ThrowSmokeBomb",
	Name = "Throw Smoke Pot",
});
activesDefs.push({
	ID = "actives.fake_drink_night_vision",
	Script = "scripts/skills/actives/fake_drink_night_vision_skill",
	Const = "FakeDrinkNightVision",
	Name = "Drink Night Owl Elixir",
});
activesDefs.push({
	ID = "actives.wake_ally",
	Script = "scripts/skills/actives/wake_ally_skill",
	Const = "WakeAlly",
	Name = "Wake Ally",
});
activesDefs.push({
	ID = "actives.warcry",
	Script = "scripts/skills/actives/warcry",
	Const = "Warcry",
	Name = "Warcry",
});
activesDefs.push({
	ID = "actives.wither",
	Script = "scripts/skills/actives/wither_skill",
	Const = "Wither",
	Name = "Wither",
});
activesDefs.push({
	ID = "actives.bandage_ally",
	Script = "scripts/skills/actives/bandage_ally_skill",
	Const = "BandageAlly",
	Name = "Use Bandages",
});
activesDefs.push({
	ID = "actives.berserker_mushrooms",
	Script = "scripts/skills/actives/berserker_mushrooms_skill",
	Const = "BerserkerMushrooms",
	Name = "Eat or Give Strange Mushrooms",
});
activesDefs.push({
	ID = "actives.break_ally_free",
	Script = "scripts/skills/actives/break_ally_free_skill",
	Const = "BreakAllyFree",
	Name = "Free Ally",
});
activesDefs.push({
	ID = "actives.coat_with_poison",
	Script = "scripts/skills/actives/coat_with_poison_skill",
	Const = "CoatWithPoison",
	Name = "Use Poison",
});
activesDefs.push({
	ID = "actives.coat_with_spider_poison",
	Script = "scripts/skills/actives/coat_with_spider_poison_skill",
	Const = "CoatWithSpiderPoison",
	Name = "Use Poisoned Oil",
});
activesDefs.push({
	ID = "actives.debilitate",
	Script = "scripts/skills/actives/debilitate",
	Const = "Debilitate",
	Name = "Debilitate",
});
activesDefs.push({
	ID = "actives.drink_antidote",
	Script = "scripts/skills/actives/drink_antidote_skill",
	Const = "DrinkAntidote",
	Name = "Drink or Give Antidote",
});
activesDefs.push({
	ID = "actives.first_aid",
	Script = "scripts/skills/actives/first_aid_skill",
	Const = "FirstAid",
	Name = "First Aid",
});
activesDefs.push({
	ID = "actives.perfect_focus",
	Script = "scripts/skills/actives/perfect_focus",
	Const = "PerfectFocus",
	Name = "Perfect Focus",
});
activesDefs.push({
	ID = "actives.release_falcon",
	Script = "scripts/skills/actives/release_falcon_skill",
	Const = "ReleaseFalcon",
	Name = "Release Falcon",
});
activesDefs.push({
	ID = "actives.stealth",
	Script = "scripts/skills/actives/stealth_skill",
	Const = "Stealth",
	Name = "Stealth",
});
activesDefs.push({
	ID = "actives.sweep_zoc",
	Script = "scripts/skills/actives/sweep_zoc_skill",
	Const = "SweepZoc",
	Name = "Sweeping Strike",
});
activesDefs.push({
	ID = "actives.tail_slam_zoc",
	Script = "scripts/skills/actives/tail_slam_zoc_skill",
	Const = "TailSlamZoc",
	Name = "Tail Slam",
});
activesDefs.push({
	ID = "actives.throw_acid_flask",
	Script = "scripts/skills/actives/throw_acid_flask",
	Const = "ThrowAcidFlask",
	Name = "Throw Acid Flask",
});
activesDefs.push({
	ID = "actives.throw_holy_water",
	Script = "scripts/skills/actives/throw_holy_water",
	Const = "ThrowHolyWater",
	Name = "Throw Blessed Water",
});
activesDefs.push({
	ID = "actives.unleash_wardog",
	Script = "scripts/skills/actives/unleash_wardog",
	Const = "UnleashWardog",
	Name = "Unleash Wardog",
});
activesDefs.push({
	ID = "actives.unleash_wolf",
	Script = "scripts/skills/actives/unleash_wolf",
	Const = "UnleashWolf",
	Name = "Unleash Wardog",
});
activesDefs.push({
	ID = "actives.uproot_small_zoc",
	Script = "scripts/skills/actives/uproot_small_zoc_skill",
	Const = "UprootSmallZoc",
	Name = "Uproot",
});
activesDefs.push({
	ID = "actives.uproot_zoc",
	Script = "scripts/skills/actives/uproot_zoc_skill",
	Const = "UprootZoc",
	Name = "Uproot",
});
activesDefs.push({
	ID = "actives.voice_of_davkul",
	Script = "scripts/skills/actives/voice_of_davkul_skill",
	Const = "VoiceOfDavkul",
	Name = "Voice of Davkul",
});
activesDefs.push({
	ID = "actives.whip_slave",
	Script = "scripts/skills/actives/whip_slave_skill",
	Const = "WhipSlave",
	Name = "Crack the Whip",
});
activesDefs.push({
	ID = "actives.legend_transform_into_bear",
	Script = "scripts/skills/actives/legend_transform_into_bear_skill",
	Const = "LegendTransformIntoBear",
	Name = "Transform into Bear",
});
activesDefs.push({
	ID = "actives.legend_catapult_boulder",
	Script = "scripts/skills/actives/legend_catapult_boulder_skill",
	Const = "LegendCatapultBoulder",
	Name = "Catapult Boulder",
});
activesDefs.push({
	ID = "actives.legend_sling_heavy_stone",
	Script = "scripts/skills/actives/legend_sling_heavy_stone_skill",
	Const = "LegendSlingHeavyStone",
	Name = "Sling Heavy Stone",
});
activesDefs.push({
	ID = "actives.legend_shoot_dart",
	Script = "scripts/skills/actives/legend_shoot_dart_skill",
	Const = "LegendShootDart",
	Name = "Shoot Dart",
});
activesDefs.push({
	ID = "actives.legend_halberd_smite",
	Script = "scripts/skills/actives/legend_halberd_smite_skill",
	Const = "LegendHalberdSmite",
	Name = "Smite",
});
activesDefs.push({
	ID = "actives.legend_voulge_decapitate",
	Script = "scripts/skills/actives/legend_voulge_decapitate_skill",
	Const = "LegendVoulgeDecapitate",
	Name = "Decapitate",
});
activesDefs.push({
	ID = "actives.legend_cat_bite",
	Script = "scripts/skills/actives/legend_cat_bite_skill",
	Const = "LegendCatBite",
	Name = "Cat Bite",
});
activesDefs.push({
	ID = "actives.legend_skin_ghoul_claws",
	Script = "scripts/skills/actives/legend_skin_ghoul_claws",
	Const = "LegendSkinGhoulClaws",
	Name = "Skin Ghoul Claws",
});
activesDefs.push({
	ID = "actives.legend_white_wolf_bite",
	Script = "scripts/skills/actives/legend_white_wolf_bite_skill",
	Const = "LegendWhiteWolfBite",
	Name = "White Direwolf Bite",
});
activesDefs.push({
	ID = "actives.legend_redback_spider_bite",
	Script = "scripts/skills/actives/legend_redback_spider_bite_skill",
	Const = "LegendRedbackSpiderBite",
	Name = "Redback Webknecht Bite",
});
activesDefs.push({
	ID = "actives.legend_demon_hound_bite",
	Script = "scripts/skills/actives/legend_demon_hound_bite_skill",
	Const = "LegendDemonHoundBite",
	Name = "H÷llenhund Bite",
});
activesDefs.push({
	ID = "actives.legend_ranged_flail",
	Script = "scripts/skills/actives/legend_ranged_flail_skill",
	Const = "LegendRangedFlail",
	Name = "Flail",
});
activesDefs.push({
	ID = "actives.legend_voulge_cleave",
	Script = "scripts/skills/actives/legend_voulge_cleave_skill",
	Const = "LegendVoulgeCleave",
	Name = "Cleave",
});
activesDefs.push({
	ID = "actives.legend_horse_kick",
	Script = "scripts/skills/actives/legend_horse_kick_skill",
	Const = "LegendHorseKick",
	Name = "Horse Kick",
});
activesDefs.push({
	ID = "actives.legend_donkey_kick",
	Script = "scripts/skills/actives/legend_donkey_kick_skill",
	Const = "LegendDonkeyKick",
	Name = "Donkey Kick",
});
activesDefs.push({
	ID = "actives.legend_bear_bite",
	Script = "scripts/skills/actives/legend_bear_bite_skill",
	Const = "LegendBearBite",
	Name = "Bear Bite",
});
activesDefs.push({
	ID = "actives.legend_bear_claws",
	Script = "scripts/skills/actives/legend_bear_claws_skill",
	Const = "LegendBearClaws",
	Name = "Bear Claws",
});
activesDefs.push({
	ID = "actives.legend_flaggelate",
	Script = "scripts/skills/actives/legend_flaggelate_skill",
	Const = "LegendFlaggelate",
	Name = "Flaggelate",
});
activesDefs.push({
	ID = "actives.legend_boar_gore",
	Script = "scripts/skills/actives/legend_boar_gore_skill",
	Const = "LegendBoarGore",
	Name = "Boar Gore",
});
activesDefs.push({
	ID = "actives.legend_rat_claws",
	Script = "scripts/skills/actives/legend_rat_claws_skill",
	Const = "LegendRatClaws",
	Name = "Rat Claws",
});
activesDefs.push({
	ID = "actives.legend_rat_bite",
	Script = "scripts/skills/actives/legend_rat_bite_skill",
	Const = "LegendRatBite",
	Name = "Rat Bite",
});
activesDefs.push({
	ID = "actives.legend_en_garde",
	Script = "scripts/skills/actives/legend_en_garde_skill",
	Const = "LegendEnGarde",
	Name = "En Garde",
});
activesDefs.push({
	ID = "actives.legend_nightmare_touch",
	Script = "scripts/skills/actives/legend_nightmare_touch_skill",
	Const = "LegendNightmareTouch",
	Name = "Terror",
});
activesDefs.push({
	ID = "actives.legend_basilisk_peck",
	Script = "scripts/skills/actives/legend_basilisk_peck_skill",
	Const = "LegendBasiliskPeck",
	Name = "Peck",
});
activesDefs.push({
	ID = "actives.legend_basilisk_sentry_inject",
	Script = "scripts/skills/actives/legend_basilisk_sentry_inject_skill",
	Const = "LegendBasiliskSentryInject",
	Name = "Inject",
});
activesDefs.push({
	ID = "actives.legend_basilisk_sentry_fowleye",
	Script = "scripts/skills/actives/legend_basilisk_sentry_fowleye_skill",
	Const = "LegendBasiliskSentryFowleye",
	Name = "Fowl Eye",
});
activesDefs.push({
	ID = "actives.legend_grapple",
	Script = "scripts/skills/actives/legend_grapple_skill",
	Const = "LegendGrapple",
	Name = "Grapple",
});
activesDefs.push({
	ID = "actives.legend_buckler_bash",
	Script = "scripts/skills/actives/legend_buckler_bash_skill",
	Const = "LegendBucklerBash",
	Name = "Buckler Bash",
});
activesDefs.push({
	ID = "actives.legend_ninetails_disarm",
	Script = "scripts/skills/actives/legend_ninetails_disarm_skill",
	Const = "LegendNinetailsDisarm",
	Name = "Disarm",
});
activesDefs.push({
	ID = "actives.legend_ranged_lash",
	Script = "scripts/skills/actives/legend_ranged_lash_skill",
	Const = "LegendRangedLash",
	Name = "Lash",
});
activesDefs.push({
	ID = "actives.legend_puncture_parry_dagger",
	Script = "scripts/skills/actives/legend_puncture_parry_dagger_skill",
	Const = "LegendPunctureParryDagger",
	Name = "Offhand Puncture",
});
activesDefs.push({
	ID = "actives.legend_choke",
	Script = "scripts/skills/actives/legend_choke_skill",
	Const = "LegendChoke",
	Name = "Choke",
});
activesDefs.push({
	ID = "actives.legend_skin_ghoul_swallow_whole",
	Script = "scripts/skills/actives/legend_skin_ghoul_swallow_whole_skill",
	Const = "LegendSkinGhoulSwallowWhole",
	Name = "Swallow Whole",
});
activesDefs.push({
	ID = "actives.legend_banshee_scream",
	Script = "scripts/skills/actives/legend_banshee_scream",
	Const = "LegendBansheeScream",
	Name = "Banshee Scream",
});
activesDefs.push({
	ID = "actives.legend_horrific_scream",
	Script = "scripts/skills/actives/legend_horrific_scream",
	Const = "LegendHorrificScream",
	Name = "Horrific Scream",
});
activesDefs.push({
	ID = "actives.legend_daze",
	Script = "scripts/skills/actives/legend_daze_skill",
	Const = "LegendDaze",
	Name = "Daze",
});
activesDefs.push({
	ID = "actives.legend_drums_of_life",
	Script = "scripts/skills/actives/legend_drums_of_life_skill",
	Const = "LegendDrumsOfLife",
	Name = "Song of Life",
});
activesDefs.push({
	ID = "actives.legend_drums_of_war",
	Script = "scripts/skills/actives/legend_drums_of_war_skill",
	Const = "LegendDrumsOfWar",
	Name = "War Chant",
});
activesDefs.push({
	ID = "actives.legend_push_forward",
	Script = "scripts/skills/actives/legend_push_forward_skill",
	Const = "LegendPushForward",
	Name = "Push Forward",
});
activesDefs.push({
	ID = "actives.legend_hold_the_line",
	Script = "scripts/skills/actives/legend_hold_the_line",
	Const = "LegendHoldTheLine",
	Name = "Hold the line",
});
activesDefs.push({
	ID = "actives.legend_horse_charge",
	Script = "scripts/skills/actives/legend_horse_charge_skill",
	Const = "LegendHorseCharge",
	Name = "Horse Charge",
});
activesDefs.push({
	ID = "actives.legend_intensely_charm",
	Script = "scripts/skills/actives/legend_intensely_charm_skill",
	Const = "LegendIntenselyCharm",
	Name = "Infatuate",
});
activesDefs.push({
	ID = "actives.legend_teleport",
	Script = "scripts/skills/actives/legend_teleport_skill",
	Const = "LegendTeleport",
	Name = "Teleport",
});
activesDefs.push({
	ID = "actives.legend_revolt",
	Script = "scripts/skills/actives/legend_revolt_skill",
	Const = "LegendRevolt",
	Name = "Revolt",
});
activesDefs.push({
	ID = "actives.legend_push",
	Script = "scripts/skills/actives/legend_push_skill",
	Const = "LegendPush",
	Name = "Revolt",
});
activesDefs.push({
	ID = "actives.legend_staff_riposte",
	Script = "scripts/skills/actives/legend_staff_riposte_skill",
	Const = "LegendStaffRiposte",
	Name = "Riposte",
});
activesDefs.push({
	ID = "actives.legend_horse_pirouette",
	Script = "scripts/skills/actives/legend_horse_pirouette_skill",
	Const = "LegendHorsePirouette",
	Name = "Pirouette",
});
activesDefs.push({
	ID = "actives.legend_magic_missile",
	Script = "scripts/skills/actives/legend_magic_missile_skill",
	Const = "LegendMagicMissile",
	Name = "Missile",
});
activesDefs.push({
	ID = "actives.legend_shoot_stone",
	Script = "scripts/skills/actives/legend_shoot_stone_skill",
	Const = "LegendShootStone",
	Name = "Loose Stone",
});
activesDefs.push({
	ID = "actives.legend_shoot_precise_stone",
	Script = "scripts/skills/actives/legend_shoot_precise_stone_skill",
	Const = "LegendShootPreciseStone",
	Name = "Precise Shot",
});
activesDefs.push({
	ID = "actives.legend_boar_charge",
	Script = "scripts/skills/actives/legend_boar_charge_skill",
	Const = "LegendBoarCharge",
	Name = "Boar Charge",
});
activesDefs.push({
	ID = "actives.legend_stollwurm_move_tail",
	Script = "scripts/skills/actives/legend_stollwurm_move_tail_skill",
	Const = "LegendStollwurmMoveTail",
	Name = "Burrow Tail",
});
activesDefs.push({
	ID = "actives.legend_citrinitas_trance",
	Script = "scripts/skills/actives/legend_citrinitas_trance_skill",
	Const = "LegendCitrinitasTrance",
	Name = "Citrinitas (Trance)",
});
activesDefs.push({
	ID = "actives.legend_mark_target",
	Script = "scripts/skills/actives/legend_mark_target_skill",
	Const = "LegendMarkTarget",
	Name = "Mark Target",
});
activesDefs.push({
	ID = "actives.legend_throw_knife",
	Script = "scripts/skills/actives/legend_throw_knife_skill",
	Const = "LegendThrowKnife",
	Name = "Throw Knife",
});
activesDefs.push({
	ID = "actives.legend_ai_rotation",
	Script = "scripts/skills/actives/legend_ai_rotation_skill",
	Const = "LegendAiRotation",
	Name = "Rotation",
});
activesDefs.push({
	ID = "actives.legend_alp_summon_nightmare",
	Script = "scripts/skills/actives/legend_alp_summon_nightmare_skill",
	Const = "LegendAlpSummonNightmare",
	Name = "Conjure Nightmare",
});
activesDefs.push({
	ID = "actives.legend_alp_nightmare_manifestation",
	Script = "scripts/skills/actives/legend_alp_nightmare_manifestation_skill",
	Const = "LegendAlpNightmareManifestation",
	Name = "Conjure Nightmare",
});
activesDefs.push({
	ID = "actives.legend_alp_realm_of_shadow",
	Script = "scripts/skills/actives/legend_alp_realm_of_shadow_skill",
	Const = "LegendAlpRealmOfShadow",
	Name = "Shadow Mist",
});
activesDefs.push({
	ID = "actives.legend_werewolf_howl",
	Script = "scripts/skills/actives/legend_werewolf_howl_skill",
	Const = "LegendWerewolfHowl",
	Name = "Howl",
});
activesDefs.push({
	ID = "actives.legend_white_wolf_howl",
	Script = "scripts/skills/actives/legend_white_wolf_howl_skill",
	Const = "LegendWhiteWolfHowl",
	Name = "White Wolf Howl",
});
activesDefs.push({
	ID = "actives.legend_shadows",
	Script = "scripts/skills/actives/legend_shadows_skill",
	Const = "LegendShadows",
	Name = "Realm of Nightmares",
});
activesDefs.push({
	ID = "actives.legend_vala_warden_pale_touch",
	Script = "scripts/skills/actives/legend_vala_warden_pale_touch_skill",
	Const = "LegendValaWardenPaleTouch",
	Name = "Pale Touch",
});
activesDefs.push({
	ID = "actives.legend_vala_warden_wail",
	Script = "scripts/skills/actives/legend_vala_warden_wail_skill",
	Const = "LegendValaWardenWail",
	Name = "Wail",
});
activesDefs.push({
	ID = "actives.legend_albedo",
	Script = "scripts/skills/actives/legend_albedo_skill",
	Const = "LegendAlbedo",
	Name = "Albedo",
});
activesDefs.push({
	ID = "actives.legend_apothecary_mushrooms",
	Script = "scripts/skills/actives/legend_apothecary_mushrooms_skill",
	Const = "LegendApothecaryMushrooms",
	Name = "Eat or Give Strange Mushrooms",
});
activesDefs.push({
	ID = "actives.legend_attack_target",
	Script = "scripts/skills/actives/legend_attack_target_skill",
	Const = "LegendAttackTarget",
	Name = "Chopper sick balls!",
});
activesDefs.push({
	ID = "actives.legend_protect_target",
	Script = "scripts/skills/actives/legend_protect_target_skill",
	Const = "LegendProtectTarget",
	Name = "Defend! Good boy!",
});
activesDefs.push({
	ID = "actives.legend_bandage",
	Script = "scripts/skills/actives/legend_bandage_skill",
	Const = "LegendBandage",
	Name = "Use Bandages",
});
activesDefs.push({
	ID = "actives.legend_bribe",
	Script = "scripts/skills/actives/legend_bribe_skill",
	Const = "LegendBribe",
	Name = "Bribe",
});
activesDefs.push({
	ID = "actives.legend_call_lightning",
	Script = "scripts/skills/actives/legend_call_lightning_skill",
	Const = "LegendCallLightning",
	Name = "Call Lightning",
});
activesDefs.push({
	ID = "actives.legend_cascade",
	Script = "scripts/skills/actives/legend_cascade_skill",
	Const = "LegendCascade",
	Name = "Cascade Strike",
});
activesDefs.push({
	ID = "actives.legend_chain_lightning",
	Script = "scripts/skills/actives/legend_chain_lightning_skill",
	Const = "LegendChainLightning",
	Name = "Chain Lightning",
});
activesDefs.push({
	ID = "actives.legend_charge",
	Script = "scripts/skills/actives/legend_charge_skill",
	Const = "LegendCharge",
	Name = "Charge",
});
activesDefs.push({
	ID = "actives.legend_cheer_on",
	Script = "scripts/skills/actives/legend_cheer_on_skill",
	Const = "LegendCheerOn",
	Name = "Cheer On",
});
activesDefs.push({
	ID = "actives.legend_climb",
	Script = "scripts/skills/actives/legend_climb_skill",
	Const = "LegendClimb",
	Name = "Climb",
});
activesDefs.push({
	ID = "actives.legend_coordinated_volleys",
	Script = "scripts/skills/actives/legend_coordinated_volleys_skill",
	Const = "LegendCoordinatedVolleys",
	Name = "Coordinated Volleys",
});
activesDefs.push({
	ID = "actives.legend_curseofyears",
	Script = "scripts/skills/actives/legend_curseofyears_skill",
	Const = "LegendCurseofyears",
	Name = "Decrepify",
});
activesDefs.push({
	ID = "actives.legend_danger_pay",
	Script = "scripts/skills/actives/legend_danger_pay_skill",
	Const = "LegendDangerPay",
	Name = "Danger Pay",
});
activesDefs.push({
	ID = "actives.legend_darkflight",
	Script = "scripts/skills/actives/legend_darkflight_skill",
	Const = "LegendDarkflight",
	Name = "Darkflight",
});
activesDefs.push({
	ID = "actives.legend_deathtouch",
	Script = "scripts/skills/actives/legend_deathtouch_skill",
	Const = "LegendDeathtouch",
	Name = "Death Touch",
});
activesDefs.push({
	ID = "actives.legend_demon_shadows",
	Script = "scripts/skills/actives/legend_demon_shadows_skill",
	Const = "LegendDemonShadows",
	Name = "Realm of Burning Nightmares",
});
activesDefs.push({
	ID = "actives.legend_dog_handling",
	Script = "scripts/skills/actives/legend_dog_handling_skill",
	Const = "LegendDogHandling",
	Name = "Dog Handling",
});
activesDefs.push({
	ID = "actives.legend_dog_master",
	Script = "scripts/skills/actives/legend_dog_master_skill",
	Const = "LegendDogMaster",
	Name = "Dog Master",
});
activesDefs.push({
	ID = "actives.legend_drain",
	Script = "scripts/skills/actives/legend_drain_skill",
	Const = "LegendDrain",
	Name = "Drain Life",
});
activesDefs.push({
	ID = "actives.legend_drink_beer",
	Script = "scripts/skills/actives/legend_drink_beer_skill",
	Const = "LegendDrinkBeer",
	Name = "Drink or Give Beer",
});
activesDefs.push({
	ID = "actives.legend_drink_cat",
	Script = "scripts/skills/actives/legend_drink_cat_skill",
	Const = "LegendDrinkCat",
	Name = "Drink or Give Cat Potion",
});
activesDefs.push({
	ID = "actives.legend_drink_heartwood_sap",
	Script = "scripts/skills/actives/legend_drink_heartwood_sap_skill",
	Const = "LegendDrinkHeartwoodSap",
	Name = "Drink or Give Heartwood Sap",
});
activesDefs.push({
	ID = "actives.legend_drink_hexe_ichor_potion",
	Script = "scripts/skills/actives/legend_drink_hexe_ichor_potion_skill",
	Const = "LegendDrinkHexeIchorPotion",
	Name = "Drink or Give Hexe Ichor Potion",
});
activesDefs.push({
	ID = "actives.legend_drink_iron_will",
	Script = "scripts/skills/actives/legend_drink_iron_will_skill",
	Const = "LegendDrinkIronWill",
	Name = "Drink or Give Iron Will Potion",
});
activesDefs.push({
	ID = "actives.legend_drink_lionheart",
	Script = "scripts/skills/actives/legend_drink_lionheart_skill",
	Const = "LegendDrinkLionheart",
	Name = "Drink or Give Lionheart Potion",
});
activesDefs.push({
	ID = "actives.legend_drink_liquor",
	Script = "scripts/skills/actives/legend_drink_liquor_skill",
	Const = "LegendDrinkLiquor",
	Name = "Drink or Give Liquor",
});
activesDefs.push({
	ID = "actives.legend_drink_mead",
	Script = "scripts/skills/actives/legend_drink_mead_skill",
	Const = "LegendDrinkMead",
	Name = "Drink or Give Mead",
});
activesDefs.push({
	ID = "actives.legend_drink_night_vision",
	Script = "scripts/skills/actives/legend_drink_night_vision_skill",
	Const = "LegendDrinkNightVision",
	Name = "Drink or Give Night Owl Elixir",
});
activesDefs.push({
	ID = "actives.legend_drink_recovery_potion",
	Script = "scripts/skills/actives/legend_drink_recovery_potion_skill",
	Const = "LegendDrinkRecoveryPotion",
	Name = "Drink or Give Second Wind Potion",
});
activesDefs.push({
	ID = "actives.legend_drink_skin_ghoul_blood",
	Script = "scripts/skills/actives/legend_drink_skin_ghoul_blood_skill",
	Const = "LegendDrinkSkinGhoulBlood",
	Name = "Drink or Give Skin Ghoul Blood",
});
activesDefs.push({
	ID = "actives.legend_drink_stollwurm_blood",
	Script = "scripts/skills/actives/legend_drink_stollwurm_blood_skill",
	Const = "LegendDrinkStollwurmBlood",
	Name = "Drink or Give Stollwurm Blood",
});
activesDefs.push({
	ID = "actives.legend_drink_therianthropy_potion",
	Script = "scripts/skills/actives/legend_drink_therianthropy_potion_skill",
	Const = "LegendDrinkTherianthropyPotion",
	Name = "Drink or Give Therianthropic Potion",
});
activesDefs.push({
	ID = "actives.legend_drink_wine",
	Script = "scripts/skills/actives/legend_drink_wine_skill",
	Const = "LegendDrinkWine",
	Name = "Drink or Give Wine",
});
activesDefs.push({
	ID = "actives.legend_eat_pie",
	Script = "scripts/skills/actives/legend_eat_pie_skill",
	Const = "LegendEatPie",
	Name = "Eat or Give Pie",
});
activesDefs.push({
	ID = "actives.legend_eat_porridge",
	Script = "scripts/skills/actives/legend_eat_porridge_skill",
	Const = "LegendEatPorridge",
	Name = "Eat or Give Porridge",
});
activesDefs.push({
	ID = "actives.legend_eat_pudding",
	Script = "scripts/skills/actives/legend_eat_pudding_skill",
	Const = "LegendEatPudding",
	Name = "Eat or Give Pudding",
});
activesDefs.push({
	ID = "actives.legend_eat_rations",
	Script = "scripts/skills/actives/legend_eat_rations_skill",
	Const = "LegendEatRations",
	Name = "Eat or Give Food",
});
activesDefs.push({
	ID = "actives.legend_enthrall",
	Script = "scripts/skills/actives/legend_enthrall_skill",
	Const = "LegendEnthrall",
	Name = "Enthrall",
});
activesDefs.push({
	ID = "actives.legend_entice",
	Script = "scripts/skills/actives/legend_entice_skill",
	Const = "LegendEntice",
	Name = "Entice",
});
activesDefs.push({
	ID = "actives.legend_evasion",
	Script = "scripts/skills/actives/legend_evasion_skill",
	Const = "LegendEvasion",
	Name = "Evasion",
});
activesDefs.push({
	ID = "actives.legend_falcon",
	Script = "scripts/skills/actives/legend_falcon_skill",
	Const = "LegendFalcon",
	Name = "Unleash Falcon",
});
activesDefs.push({
	ID = "actives.legend_field_repairs",
	Script = "scripts/skills/actives/legend_field_repairs_skill",
	Const = "LegendFieldRepairs",
	Name = "Field Repairs",
});
activesDefs.push({
	ID = "actives.legend_field_treats",
	Script = "scripts/skills/actives/legend_field_treats_skill",
	Const = "LegendFieldTreats",
	Name = "Field Treats",
});
activesDefs.push({
	ID = "actives.legend_field_triage",
	Script = "scripts/skills/actives/legend_field_triage_skill",
	Const = "LegendFieldTriage",
	Name = "Field Triage",
});
activesDefs.push({
	ID = "actives.legend_firefield",
	Script = "scripts/skills/actives/legend_firefield_skill",
	Const = "LegendFirefield",
	Name = "Fire Pot",
});
activesDefs.push({
	ID = "actives.legend_flogging",
	Script = "scripts/skills/actives/legend_flogging_skill",
	Const = "LegendFlogging",
	Name = "Flogging",
});
activesDefs.push({
	ID = "actives.legend_fortify",
	Script = "scripts/skills/actives/legend_fortify_skill",
	Const = "LegendFortify",
	Name = "Fortify",
});
activesDefs.push({
	ID = "actives.legend_grow_greenwood_shield",
	Script = "scripts/skills/actives/legend_grow_greenwood_shield_skill",
	Const = "LegendGrowGreenwoodShield",
	Name = "Grow Greenwood Shield",
});
activesDefs.push({
	ID = "actives.legend_gruesome_feast",
	Script = "scripts/skills/actives/legend_gruesome_feast_skill",
	Const = "LegendGruesomeFeast",
	Name = "Gruesome Feast",
});
activesDefs.push({
	ID = "actives.legend_guide_steps",
	Script = "scripts/skills/actives/legend_guide_steps_skill",
	Const = "LegendGuideSteps",
	Name = "Guide steps",
});
activesDefs.push({
	ID = "actives.legend_harvest_bush",
	Script = "scripts/skills/actives/legend_harvest_bush_skill",
	Const = "LegendHarvestBush",
	Name = "Harvest Bush",
});
activesDefs.push({
	ID = "actives.legend_harvest_rock",
	Script = "scripts/skills/actives/legend_harvest_rock_skill",
	Const = "LegendHarvestRock",
	Name = "Crush Rock",
});
activesDefs.push({
	ID = "actives.legend_harvest_tree",
	Script = "scripts/skills/actives/legend_harvest_tree_skill",
	Const = "LegendHarvestTree",
	Name = "Harvest Tree",
});
activesDefs.push({
	ID = "actives.legend_hex",
	Script = "scripts/skills/actives/legend_hex_skill",
	Const = "LegendHex",
	Name = "Hex",
});
activesDefs.push({
	ID = "actives.legend_hidden",
	Script = "scripts/skills/actives/legend_hidden_skill",
	Const = "LegendHidden",
	Name = "Hide",
});
activesDefs.push({
	ID = "actives.legend_holyflame",
	Script = "scripts/skills/actives/legend_holyflame_skill",
	Const = "LegendHolyflame",
	Name = "Holy Flame",
});
activesDefs.push({
	ID = "actives.legend_horrify",
	Script = "scripts/skills/actives/legend_horrify_old_skill",
	Const = "LegendHorrify",
	Name = "Horrify",
});
activesDefs.push({
	ID = "actives.legend_incoming",
	Script = "scripts/skills/actives/legend_incoming_skill",
	Const = "LegendIncoming",
	Name = "Incoming!",
});
activesDefs.push({
	ID = "actives.legend_inspire",
	Script = "scripts/skills/actives/legend_inspire_skill",
	Const = "LegendInspire",
	Name = "Inspire",
});
activesDefs.push({
	ID = "actives.legend_kick",
	Script = "scripts/skills/actives/legend_kick_skill",
	Const = "LegendKick",
	Name = "Kick",
});
activesDefs.push({
	ID = "actives.legend_leap",
	Script = "scripts/skills/actives/legend_leap_skill",
	Const = "LegendLeap",
	Name = "Leap",
});
activesDefs.push({
	ID = "actives.legend_levitate_person",
	Script = "scripts/skills/actives/legend_levitate_person_skill",
	Const = "LegendLevitatePerson",
	Name = "Levitate Person",
});
activesDefs.push({
	ID = "actives.legend_magic_burning_hands",
	Script = "scripts/skills/actives/legend_magic_burning_hands",
	Const = "LegendMagicBurningHands",
	Name = "Burning Hands",
});
activesDefs.push({
	ID = "actives.legend_magic_chain_lightning",
	Script = "scripts/skills/actives/legend_magic_chain_lightning_skill",
	Const = "LegendMagicChainLightning",
	Name = "Chain Lightning",
});
activesDefs.push({
	ID = "actives.legend_magic_circle_of_protection",
	Script = "scripts/skills/actives/legend_magic_circle_of_protection_skill",
	Const = "LegendMagicCircleOfProtection",
	Name = "Magic Circle of Protection",
});
activesDefs.push({
	ID = "actives.legend_magic_daze",
	Script = "scripts/skills/actives/legend_magic_daze_skill",
	Const = "LegendMagicDaze",
	Name = "Daze",
});
activesDefs.push({
	ID = "actives.legend_magic_hailstone",
	Script = "scripts/skills/actives/legend_magic_hailstone_skill",
	Const = "LegendMagicHailstone",
	Name = "Hailstone",
});
activesDefs.push({
	ID = "actives.legend_magic_healing_wind",
	Script = "scripts/skills/actives/legend_magic_healing_wind_skill",
	Const = "LegendMagicHealingWind",
	Name = "Healing Mist",
});
activesDefs.push({
	ID = "actives.legend_magic_imbue",
	Script = "scripts/skills/actives/legend_magic_imbue_skill",
	Const = "LegendMagicImbue",
	Name = "Imbue",
});
activesDefs.push({
	ID = "actives.legend_magic_levitate",
	Script = "scripts/skills/actives/legend_magic_levitate_skill",
	Const = "LegendMagicLevitate",
	Name = "Levitate Person",
});
activesDefs.push({
	ID = "actives.legend_magic_psybeam",
	Script = "scripts/skills/actives/legend_magic_psybeam_skill",
	Const = "LegendMagicPsybeam",
	Name = "Psybeam",
});
activesDefs.push({
	ID = "actives.legend_magic_sleep",
	Script = "scripts/skills/actives/legend_magic_sleep_skill",
	Const = "LegendMagicSleep",
	Name = "Sleep",
});
activesDefs.push({
	ID = "actives.legend_magic_soothing_wind",
	Script = "scripts/skills/actives/legend_magic_soothing_wind_skill",
	Const = "LegendMagicSoothingWind",
	Name = "Soothing Wind",
});
activesDefs.push({
	ID = "actives.legend_stun",
	Script = "scripts/skills/actives/legend_magic_stun_skill",
	Const = "LegendStun",
	Name = "Stun",
});
activesDefs.push({
	ID = "actives.legend_magic_teleport",
	Script = "scripts/skills/actives/legend_magic_teleport_skill",
	Const = "LegendMagicTeleport",
	Name = "Teleport",
});
activesDefs.push({
	ID = "actives.legend_magic_web_bolt",
	Script = "scripts/skills/actives/legend_magic_web_bolt_skill",
	Const = "LegendMagicWebBolt",
	Name = "Web Bolt",
});
activesDefs.push({
	ID = "actives.legend_miasma",
	Script = "scripts/skills/actives/legend_miasma_skill",
	Const = "LegendMiasma",
	Name = "Miasma",
});
activesDefs.push({
	ID = "actives.legend_minor_sleep",
	Script = "scripts/skills/actives/legend_minor_sleep_skill",
	Const = "LegendMinorSleep",
	Name = "Minor Sleep",
});
activesDefs.push({
	ID = "actives.legend_nightmare_aoe",
	Script = "scripts/skills/actives/legend_nightmare_aoe_skill",
	Const = "LegendNightmareAoe",
	Name = "Nightmare",
});
activesDefs.push({
	ID = "actives.legend_nightmare_touch_zoc",
	Script = "scripts/skills/actives/legend_nightmare_touch_zoc_skill",
	Const = "LegendNightmareTouchZoc",
	Name = "Terror",
});
activesDefs.push({
	ID = "actives.legend_nightvision",
	Script = "scripts/skills/actives/legend_nightvision_skill",
	Const = "LegendNightvision",
	Name = "Nightvision",
});
activesDefs.push({
	ID = "actives.legend_nigredo",
	Script = "scripts/skills/actives/legend_nigredo_skill",
	Const = "LegendNigredo",
	Name = "Nigredo",
});
activesDefs.push({
	ID = "actives.legend_oms_amphora",
	Script = "scripts/skills/actives/legend_oms_amphora_skill",
	Const = "LegendOmsAmphora",
	Name = "Drink from Amphora",
});
activesDefs.push({
	ID = "actives.legend_pass",
	Script = "scripts/skills/actives/legend_pass_skill",
	Const = "LegendPass",
	Name = "Pass Item",
});
activesDefs.push({
	ID = "actives.legend_piercing_bolt",
	Script = "scripts/skills/actives/legend_piercing_bolt_skill",
	Const = "LegendPiercingBolt",
	Name = "Piercing Bolt",
});
activesDefs.push({
	ID = "actives.legend_piercing_shot",
	Script = "scripts/skills/actives/legend_piercing_shot_skill",
	Const = "LegendPiercingShot",
	Name = "Piercing Shot",
});
activesDefs.push({
	ID = "actives.legend_poison_weapon",
	Script = "scripts/skills/actives/legend_poison_weapon_skill",
	Const = "LegendPoisonWeapon",
	Name = "Use Poison",
});
activesDefs.push({
	ID = "actives.legend_possession",
	Script = "scripts/skills/actives/legend_possession_skill",
	Const = "LegendPossession",
	Name = "Possess Undead",
});
activesDefs.push({
	ID = "actives.legend_prayer_of_faith",
	Script = "scripts/skills/actives/legend_prayer_of_faith_skill",
	Const = "LegendPrayerOfFaith",
	Name = "Prayer of Faith",
});
activesDefs.push({
	ID = "actives.legend_prayer_of_life",
	Script = "scripts/skills/actives/legend_prayer_of_life_skill",
	Const = "LegendPrayerOfLife",
	Name = "Prayer of Hope",
});
activesDefs.push({
	ID = "actives.legend_prepare_bleed",
	Script = "scripts/skills/actives/legend_prepare_bleed_skill",
	Const = "LegendPrepareBleed",
	Name = "Prepare to Bleed",
});
activesDefs.push({
	ID = "actives.legend_prepare_graze",
	Script = "scripts/skills/actives/legend_prepare_graze_skill",
	Const = "LegendPrepareGraze",
	Name = "Prepare to Graze",
});
activesDefs.push({
	ID = "actives.legend_prepare_knockdown",
	Script = "scripts/skills/actives/legend_prepare_knockback_skill",
	Const = "LegendPrepareKnockdown",
	Name = "Wind Up",
});
activesDefs.push({
	ID = "actives.legend_quick_step",
	Script = "scripts/skills/actives/legend_quick_step_skill",
	Const = "LegendQuickStep",
	Name = "Quick Step",
});
activesDefs.push({
	ID = "actives.legend_raise_undead",
	Script = "scripts/skills/actives/legend_raise_undead_skill",
	Const = "LegendRaiseUndead",
	Name = "Conduct Seance",
});
activesDefs.push({
	ID = "actives.legend_read_omens_trance",
	Script = "scripts/skills/actives/legend_read_omens_trance_skill",
	Const = "LegendReadOmensTrance",
	Name = "Read Omens (Trance)",
});
activesDefs.push({
	ID = "actives.legend_redback_puncture",
	Script = "scripts/skills/actives/legend_redback_puncture_skill",
	Const = "LegendRedbackPuncture",
	Name = "Redback Poison Puncture",
});
activesDefs.push({
	ID = "actives.legend_relax",
	Script = "scripts/skills/actives/legend_relax_skill",
	Const = "LegendRelax",
	Name = "Relax",
});
activesDefs.push({
	ID = "actives.legend_root",
	Script = "scripts/skills/actives/legend_root_skill",
	Const = "LegendRoot",
	Name = "Root",
});
activesDefs.push({
	ID = "actives.legend_rust",
	Script = "scripts/skills/actives/legend_rust_skill",
	Const = "LegendRust",
	Name = "Rust",
});
activesDefs.push({
	ID = "actives.legend_safeguard",
	Script = "scripts/skills/actives/legend_safeguard_skill",
	Const = "LegendSafeguard",
	Name = "Safeguard",
});
activesDefs.push({
	ID = "actives.legend_scry",
	Script = "scripts/skills/actives/legend_scry_skill",
	Const = "LegendScry",
	Name = "Scry",
});
activesDefs.push({
	ID = "actives.legend_scry_trance",
	Script = "scripts/skills/actives/legend_scry_trance_skill",
	Const = "LegendScryTrance",
	Name = "Scry Area (Trance)",
});
activesDefs.push({
	ID = "actives.legend_siphon",
	Script = "scripts/skills/actives/legend_siphon_skill",
	Const = "LegendSiphon",
	Name = "Life Siphon",
});
activesDefs.push({
	ID = "actives.legend_sleep",
	Script = "scripts/skills/actives/legend_sleep_skill",
	Const = "LegendSleep",
	Name = "Sleep",
});
activesDefs.push({
	ID = "actives.legend_slingstaff_bash",
	Script = "scripts/skills/actives/legend_slingstaff_bash_skill",
	Const = "LegendSlingstaffBash",
	Name = "Slingstaff Bash",
});
activesDefs.push({
	ID = "actives.legend_spawn_skeleton_high_archer",
	Script = "scripts/skills/actives/legend_spawn_skeleton_high_archer_skill",
	Const = "LegendSpawnSkeletonHighArcher",
	Name = "Summon Heavy Archer Skeleton",
});
activesDefs.push({
	ID = "actives.legend_spawn_skeleton_high",
	Script = "scripts/skills/actives/legend_spawn_skeleton_high_skill",
	Const = "LegendSpawnSkeletonHigh",
	Name = "Summon Heavy Skeleton",
});
activesDefs.push({
	ID = "actives.legend_spawn_skeleton_low_archer",
	Script = "scripts/skills/actives/legend_spawn_skeleton_low_archer_skill",
	Const = "LegendSpawnSkeletonLowArcher",
	Name = "Summon Light Archer Skeleton",
});
activesDefs.push({
	ID = "actives.legend_spawn_skeleton_low",
	Script = "scripts/skills/actives/legend_spawn_skeleton_low_skill",
	Const = "LegendSpawnSkeletonLow",
	Name = "Summon Light Skeleton",
});
activesDefs.push({
	ID = "actives.legend_spawn_skeleton_med_archer",
	Script = "scripts/skills/actives/legend_spawn_skeleton_med_archer_skill",
	Const = "LegendSpawnSkeletonMedArcher",
	Name = "Summon Medium Archer Skeleton",
});
activesDefs.push({
	ID = "actives.legend_spawn_skeleton_med",
	Script = "scripts/skills/actives/legend_spawn_skeleton_med_skill",
	Const = "LegendSpawnSkeletonMed",
	Name = "Summon Medium Skeleton",
});
activesDefs.push({
	ID = "actives.legend_spawn_zombie_high",
	Script = "scripts/skills/actives/legend_spawn_zombie_high_skill",
	Const = "LegendSpawnZombieHigh",
	Name = "Summon Heavy Zombie",
});
activesDefs.push({
	ID = "actives.legend_spawn_zombie_high_xbow",
	Script = "scripts/skills/actives/legend_spawn_zombie_high_xbow_skill",
	Const = "LegendSpawnZombieHighXbow",
	Name = "Summon Heavy Xbow Zombie",
});
activesDefs.push({
	ID = "actives.legend_spawn_zombie_low",
	Script = "scripts/skills/actives/legend_spawn_zombie_low_skill",
	Const = "LegendSpawnZombieLow",
	Name = "Summon Light Zombie",
});
activesDefs.push({
	ID = "actives.legend_spawn_zombie_low_xbow",
	Script = "scripts/skills/actives/legend_spawn_zombie_low_xbow_skill",
	Const = "LegendSpawnZombieLowXbow",
	Name = "Summon Light Xbow Zombie",
});
activesDefs.push({
	ID = "actives.legend_spawn_zombie_med",
	Script = "scripts/skills/actives/legend_spawn_zombie_med_skill",
	Const = "LegendSpawnZombieMed",
	Name = "Summon Medium Zombie",
});
activesDefs.push({
	ID = "actives.legend_spawn_zombie_med_xbow",
	Script = "scripts/skills/actives/legend_spawn_zombie_med_xbow_skill",
	Const = "LegendSpawnZombieMedXbow",
	Name = "Summon Medium Xbow Zombie",
});
activesDefs.push({
	ID = "actives.legend_sprint",
	Script = "scripts/skills/actives/legend_sprint_skill",
	Const = "LegendSprint",
	Name = "Sprint",
});
activesDefs.push({
	ID = "actives.legend_staffwall",
	Script = "scripts/skills/actives/legend_staffwall_skill",
	Const = "LegendStaffwall",
	Name = "Spearwall",
});
activesDefs.push({
	ID = "actives.legend_staff_lunge",
	Script = "scripts/skills/actives/legend_staff_lunge_skill",
	Const = "LegendStaffLunge",
	Name = "Lunge",
});
activesDefs.push({
	ID = "actives.legend_staff_thrust",
	Script = "scripts/skills/actives/legend_staff_thrust_skill",
	Const = "LegendStaffThrust",
	Name = "Thrust",
});
activesDefs.push({
	ID = "actives.legend_stealth",
	Script = "scripts/skills/actives/legend_stealth_skill",
	Const = "LegendStealth",
	Name = "Stealth",
});
activesDefs.push({
	ID = "actives.legend_stollwurm_move",
	Script = "scripts/skills/actives/legend_stollwurm_move_skill",
	Const = "LegendStollwurmMove",
	Name = "Burrow",
});
activesDefs.push({
	ID = "actives.legend_summon_storm",
	Script = "scripts/skills/actives/legend_summon_storm_skill",
	Const = "LegendSummonStorm",
	Name = "Summon Storm",
});
activesDefs.push({
	ID = "actives.legend_tackle",
	Script = "scripts/skills/actives/legend_tackle_skill",
	Const = "LegendTackle",
	Name = "Tackle",
});
activesDefs.push({
	ID = "actives.legend_transform_into_boar",
	Script = "scripts/skills/actives/legend_transform_into_boar_skill",
	Const = "LegendTransformIntoBoar",
	Name = "Transform into Boar",
});
activesDefs.push({
	ID = "actives.legend_transform_into_rat",
	Script = "scripts/skills/actives/legend_transform_into_rat_skill",
	Const = "LegendTransformIntoRat",
	Name = "Transform into Rat",
});
activesDefs.push({
	ID = "actives.legend_transform_into_tree",
	Script = "scripts/skills/actives/legend_transform_into_tree_skill",
	Const = "LegendTransformIntoTree",
	Name = "Transform into Schrat",
});
activesDefs.push({
	ID = "actives.legend_transform_into_wolf",
	Script = "scripts/skills/actives/legend_transform_into_wolf_skill",
	Const = "LegendTransformIntoWolf",
	Name = "Transform into Wolf",
});
activesDefs.push({
	ID = "actives.legend_tumble",
	Script = "scripts/skills/actives/legend_tumble_skill",
	Const = "LegendTumble",
	Name = "Tumble",
});
activesDefs.push({
	ID = "actives.legend_unarmed_lunge",
	Script = "scripts/skills/actives/legend_unarmed_lunge_skill",
	Const = "LegendUnarmedLunge",
	Name = "Jump Attack",
});
activesDefs.push({
	ID = "actives.legend_unleash_bear",
	Script = "scripts/skills/actives/legend_unleash_bear_skill",
	Const = "LegendUnleashBear",
	Name = "Summon Bear",
});
activesDefs.push({
	ID = "actives.legend_unleash_catapult",
	Script = "scripts/skills/actives/legend_unleash_catapult_skill",
	Const = "LegendUnleashCatapult",
	Name = "Summon Catapult",
});
activesDefs.push({
	ID = "actives.legend_unleash_cat",
	Script = "scripts/skills/actives/legend_unleash_cat_skill",
	Const = "LegendUnleashCat",
	Name = "Summon Cat",
});
activesDefs.push({
	ID = "actives.legend_unleash_hound",
	Script = "scripts/skills/actives/legend_unleash_hound_skill",
	Const = "LegendUnleashHound",
	Name = "Summon Hound",
});
activesDefs.push({
	ID = "actives.legend_unleash_warbear",
	Script = "scripts/skills/actives/legend_unleash_warbear_skill",
	Const = "LegendUnleashWarbear",
	Name = "Unleash Warbear",
});
activesDefs.push({
	ID = "actives.legend_unleash_white_wolf",
	Script = "scripts/skills/actives/legend_unleash_white_wolf_skill",
	Const = "LegendUnleashWhiteWolf",
	Name = "Unleash White Wolf",
});
activesDefs.push({
	ID = "actives.legend_unleash_wolf",
	Script = "scripts/skills/actives/legend_unleash_wolf_skill",
	Const = "LegendUnleashWolf",
	Name = "Summon Wolf",
});
activesDefs.push({
	ID = "actives.legend_use_catapult",
	Script = "scripts/skills/actives/legend_use_catapult_skill",
	Const = "LegendUseCatapult",
	Name = "Catapult Boulder",
});
activesDefs.push({
	ID = "actives.legend_violent_decomposition",
	Script = "scripts/skills/actives/legend_violent_decomposition_skill",
	Const = "LegendViolentDecomposition",
	Name = "Violent Decomposition",
});
activesDefs.push({
	ID = "actives.wake_ally_aoe",
	Script = "scripts/skills/actives/legend_wake_ally_aoe_skill",
	Const = "WakeAllyAoe",
	Name = "Wake Allies",
});
activesDefs.push({
	ID = "actives.legend_werewolf_claws",
	Script = "scripts/skills/actives/legend_werewolf_claws_skill",
	Const = "LegendWerewolfClaws",
	Name = "Direwolf Claws",
});
activesDefs.push({
	ID = "actives.legend_wither",
	Script = "scripts/skills/actives/legend_wither_skill",
	Const = "LegendWither",
	Name = "Wither",
});
activesDefs.push({
	ID = "actives.legend_wooden_stake_stab",
	Script = "scripts/skills/actives/legend_wooden_stake_stab_skill",
	Const = "LegendWoodenStakeStab",
	Name = "Stab with Wooden Stake",
});

::Legends.Actives.addActiveDefObjects(activesDefs);
