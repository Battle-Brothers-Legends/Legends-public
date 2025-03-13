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
		if (activeDefObject.Const in ::Legends.Active)
			::Legends.Active[activeDefObject.Const] = size + i;
		else
			::Legends.Active[activeDefObject.Const] <- size + i;
	}
}

local activesDefs = [];


::Legends.Active.Split <- null;
activesDefs.push({
	ID = "actives.split",
	Script = "scripts/skills/actives/split",
	Const = "Split",
	Name = "Split",
});

::Legends.Active.SplitAxe <- null;
activesDefs.push({
	ID = "actives.split_axe",
	Script = "scripts/skills/actives/split_axe",
	Const = "SplitAxe",
	Name = "Split",
});

::Legends.Active.IgniteFirelance <- null;
activesDefs.push({
	ID = "actives.ignite_firelance",
	Script = "scripts/skills/actives/ignite_firelance_skill",
	Const = "IgniteFirelance",
	Name = "Ignite",
});

::Legends.Active.KnockOut <- null;
activesDefs.push({
	ID = "actives.knock_out",
	Script = "scripts/skills/actives/knock_out",
	Const = "KnockOut",
	Name = "Knock Out",
});

::Legends.Active.StrikeDown <- null;
activesDefs.push({
	ID = "actives.strike_down",
	Script = "scripts/skills/actives/strike_down_skill",
	Const = "StrikeDown",
	Name = "Strike Down",
});

::Legends.Active.KnockOver <- null;
activesDefs.push({
	ID = "actives.knock_over",
	Script = "scripts/skills/actives/knock_over_skill",
	Const = "KnockOver",
	Name = "Knock Over",
});

::Legends.Active.Charge <- null;
activesDefs.push({
	ID = "actives.charge",
	Script = "scripts/skills/actives/charge",
	Const = "Charge",
	Name = "Charge",
});

::Legends.Active.Disarm <- null;
activesDefs.push({
	ID = "actives.disarm",
	Script = "scripts/skills/actives/disarm_skill",
	Const = "Disarm",
	Name = "Disarm",
});

::Legends.Active.ThrowGolem <- null;
activesDefs.push({
	ID = "actives.throw_golem",
	Script = "scripts/skills/actives/throw_golem_skill",
	Const = "ThrowGolem",
	Name = "Throw Living Sand",
});

::Legends.Active.Adrenaline <- null;
activesDefs.push({
	ID = "actives.adrenaline",
	Script = "scripts/skills/actives/adrenaline_skill",
	Const = "Adrenaline",
	Name = "Adrenaline",
});

::Legends.Active.AlpTeleport <- null;
activesDefs.push({
	ID = "actives.alp_teleport",
	Script = "scripts/skills/actives/alp_teleport_skill",
	Const = "AlpTeleport",
	Name = "Fade",
});

::Legends.Active.CrackTheWhip <- null;
activesDefs.push({
	ID = "actives.crack_the_whip",
	Script = "scripts/skills/actives/crack_the_whip_skill",
	Const = "CrackTheWhip",
	Name = "Crack the Whip",
});

::Legends.Active.LoadMortar <- null;
activesDefs.push({
	ID = "actives.load_mortar",
	Script = "scripts/skills/actives/load_mortar_skill",
	Const = "LoadMortar",
	Name = "Load Mortar",
});

::Legends.Active.Explode <- null;
activesDefs.push({
	ID = "actives.explode",
	Script = "scripts/skills/actives/explode_skill",
	Const = "Explode",
	Name = "Explode",
});

::Legends.Active.Geomancy <- null;
activesDefs.push({
	ID = "actives.geomancy",
	Script = "scripts/skills/actives/geomancy_skill",
	Const = "Geomancy",
	Name = "Geomancy",
});

::Legends.Active.RaiseAllUndead <- null;
activesDefs.push({
	ID = "actives.raise_all_undead",
	Script = "scripts/skills/actives/raise_all_undead_skill",
	Const = "RaiseAllUndead",
	Name = "The Black Book",
});

::Legends.Active.GeomancyOnce <- null;
activesDefs.push({
	ID = "actives.geomancy_once",
	Script = "scripts/skills/actives/geomancy_once_skill",
	Const = "GeomancyOnce",
	Name = "Geomancy",
});

::Legends.Active.QuickShot <- null;
activesDefs.push({
	ID = "actives.quick_shot",
	Script = "scripts/skills/actives/quick_shot",
	Const = "QuickShot",
	Name = "Quick Shot",
});

::Legends.Active.AimedShot <- null;
activesDefs.push({
	ID = "actives.aimed_shot",
	Script = "scripts/skills/actives/aimed_shot",
	Const = "AimedShot",
	Name = "Aimed Shot",
});

::Legends.Active.ShootBolt <- null;
activesDefs.push({
	ID = "actives.shoot_bolt",
	Script = "scripts/skills/actives/shoot_bolt",
	Const = "ShootBolt",
	Name = "Shoot Bolt",
});

::Legends.Active.ShootStake <- null;
activesDefs.push({
	ID = "actives.shoot_stake",
	Script = "scripts/skills/actives/shoot_stake",
	Const = "ShootStake",
	Name = "Shoot Heavy Bolt",
});

::Legends.Active.SlingStone <- null;
activesDefs.push({
	ID = "actives.sling_stone",
	Script = "scripts/skills/actives/sling_stone_skill",
	Const = "SlingStone",
	Name = "Sling Stone",
});

::Legends.Active.CrushArmor <- null;
activesDefs.push({
	ID = "actives.crush_armor",
	Script = "scripts/skills/actives/crush_armor",
	Const = "CrushArmor",
	Name = "Destroy Armor",
});

::Legends.Active.DemolishArmor <- null;
activesDefs.push({
	ID = "actives.demolish_armor",
	Script = "scripts/skills/actives/demolish_armor_skill",
	Const = "DemolishArmor",
	Name = "Demolish Armor",
});

::Legends.Active.Deathblow <- null;
activesDefs.push({
	ID = "actives.deathblow",
	Script = "scripts/skills/actives/deathblow_skill",
	Const = "Deathblow",
	Name = "Deathblow",
});

::Legends.Active.Decapitate <- null;
activesDefs.push({
	ID = "actives.decapitate",
	Script = "scripts/skills/actives/decapitate",
	Const = "Decapitate",
	Name = "Decapitate",
});

::Legends.Active.HandToHand <- null;
activesDefs.push({
	ID = "actives.hand_to_hand",
	Script = "scripts/skills/actives/hand_to_hand",
	Const = "HandToHand",
	Name = "Hand-to-Hand Attack",
});

::Legends.Active.Chop <- null;
activesDefs.push({
	ID = "actives.chop",
	Script = "scripts/skills/actives/chop",
	Const = "Chop",
	Name = "Chop",
});

::Legends.Active.Slash <- null;
activesDefs.push({
	ID = "actives.slash",
	Script = "scripts/skills/actives/slash",
	Const = "Slash",
	Name = "Slash",
});

::Legends.Active.SlashLightning <- null;
activesDefs.push({
	ID = "actives.slash_lightning",
	Script = "scripts/skills/actives/slash_lightning",
	Const = "SlashLightning",
	Name = "Lightbringer",
});

::Legends.Active.Thrust <- null;
activesDefs.push({
	ID = "actives.thrust",
	Script = "scripts/skills/actives/thrust",
	Const = "Thrust",
	Name = "Thrust",
});

::Legends.Active.Impale <- null;
activesDefs.push({
	ID = "actives.impale",
	Script = "scripts/skills/actives/impale",
	Const = "Impale",
	Name = "Impale",
});

::Legends.Active.Strike <- null;
activesDefs.push({
	ID = "actives.strike",
	Script = "scripts/skills/actives/strike_skill",
	Const = "Strike",
	Name = "Strike",
});

::Legends.Active.Rupture <- null;
activesDefs.push({
	ID = "actives.rupture",
	Script = "scripts/skills/actives/rupture",
	Const = "Rupture",
	Name = "Rupture",
});

::Legends.Active.Crumble <- null;
activesDefs.push({
	ID = "actives.crumble",
	Script = "scripts/skills/actives/crumble_skill",
	Const = "Crumble",
	Name = "Crumble",
});

::Legends.Active.Prong <- null;
activesDefs.push({
	ID = "actives.prong",
	Script = "scripts/skills/actives/prong_skill",
	Const = "Prong",
	Name = "Prong",
});

::Legends.Active.Stab <- null;
activesDefs.push({
	ID = "actives.stab",
	Script = "scripts/skills/actives/stab",
	Const = "Stab",
	Name = "Stab",
});

::Legends.Active.Bash <- null;
activesDefs.push({
	ID = "actives.bash",
	Script = "scripts/skills/actives/bash",
	Const = "Bash",
	Name = "Bash",
});

::Legends.Active.Cleave <- null;
activesDefs.push({
	ID = "actives.cleave",
	Script = "scripts/skills/actives/cleave",
	Const = "Cleave",
	Name = "Cleave",
});

::Legends.Active.Hammer <- null;
activesDefs.push({
	ID = "actives.hammer",
	Script = "scripts/skills/actives/hammer",
	Const = "Hammer",
	Name = "Batter",
});

::Legends.Active.OverheadStrike <- null;
activesDefs.push({
	ID = "actives.overhead_strike",
	Script = "scripts/skills/actives/overhead_strike",
	Const = "OverheadStrike",
	Name = "Overhead Strike",
});

::Legends.Active.Smite <- null;
activesDefs.push({
	ID = "actives.smite",
	Script = "scripts/skills/actives/smite_skill",
	Const = "Smite",
	Name = "Smite",
});

::Legends.Active.Cudgel <- null;
activesDefs.push({
	ID = "actives.cudgel",
	Script = "scripts/skills/actives/cudgel_skill",
	Const = "Cudgel",
	Name = "Cudgel",
});

::Legends.Active.Whip <- null;
activesDefs.push({
	ID = "actives.whip",
	Script = "scripts/skills/actives/whip_skill",
	Const = "Whip",
	Name = "Whip",
});

::Legends.Active.ZombieBite <- null;
activesDefs.push({
	ID = "actives.zombie_bite",
	Script = "scripts/skills/actives/zombie_bite",
	Const = "ZombieBite",
	Name = "Bite",
});

::Legends.Active.HyenaBite <- null;
activesDefs.push({
	ID = "actives.hyena_bite",
	Script = "scripts/skills/actives/hyena_bite_skill",
	Const = "HyenaBite",
	Name = "Hyena Bite",
});

::Legends.Active.WerewolfBite <- null;
activesDefs.push({
	ID = "actives.werewolf_bite",
	Script = "scripts/skills/actives/werewolf_bite",
	Const = "WerewolfBite",
	Name = "Direwolf Bite",
});

::Legends.Active.GhoulClaws <- null;
activesDefs.push({
	ID = "actives.ghoul_claws",
	Script = "scripts/skills/actives/ghoul_claws",
	Const = "GhoulClaws",
	Name = "Ghoul Claws",
});

::Legends.Active.GhastlyTouch <- null;
activesDefs.push({
	ID = "actives.ghastly_touch",
	Script = "scripts/skills/actives/ghastly_touch",
	Const = "GhastlyTouch",
	Name = "Ghastly Touch",
});

::Legends.Active.Nightmare <- null;
activesDefs.push({
	ID = "actives.nightmare",
	Script = "scripts/skills/actives/nightmare_skill",
	Const = "Nightmare",
	Name = "Nightmare",
});

::Legends.Active.Flail <- null;
activesDefs.push({
	ID = "actives.flail",
	Script = "scripts/skills/actives/flail_skill",
	Const = "Flail",
	Name = "Flail",
});

::Legends.Active.Pound <- null;
activesDefs.push({
	ID = "actives.pound",
	Script = "scripts/skills/actives/pound",
	Const = "Pound",
	Name = "Pound",
});

::Legends.Active.Cascade <- null;
activesDefs.push({
	ID = "actives.cascade",
	Script = "scripts/skills/actives/cascade_skill",
	Const = "Cascade",
	Name = "Cascade",
});

::Legends.Active.SplitMan <- null;
activesDefs.push({
	ID = "actives.split_man",
	Script = "scripts/skills/actives/split_man",
	Const = "SplitMan",
	Name = "Split Man",
});

::Legends.Active.Batter <- null;
activesDefs.push({
	ID = "actives.batter",
	Script = "scripts/skills/actives/batter_skill",
	Const = "Batter",
	Name = "Batter",
});

::Legends.Active.ThrowJavelin <- null;
activesDefs.push({
	ID = "actives.throw_javelin",
	Script = "scripts/skills/actives/throw_javelin",
	Const = "ThrowJavelin",
	Name = "Throw Javelin",
});

::Legends.Active.ThrowAxe <- null;
activesDefs.push({
	ID = "actives.throw_axe",
	Script = "scripts/skills/actives/throw_axe",
	Const = "ThrowAxe",
	Name = "Throw Axe",
});

::Legends.Active.ThrowBalls <- null;
activesDefs.push({
	ID = "actives.throw_balls",
	Script = "scripts/skills/actives/throw_balls",
	Const = "ThrowBalls",
	Name = "Throw Bola",
});

::Legends.Active.ThrowSpear <- null;
activesDefs.push({
	ID = "actives.throw_spear",
	Script = "scripts/skills/actives/throw_spear_skill",
	Const = "ThrowSpear",
	Name = "Throw Spear",
});

::Legends.Active.WardogBite <- null;
activesDefs.push({
	ID = "actives.wardog_bite",
	Script = "scripts/skills/actives/wardog_bite",
	Const = "WardogBite",
	Name = "Bite",
});

::Legends.Active.WarhoundBite <- null;
activesDefs.push({
	ID = "actives.warhound_bite",
	Script = "scripts/skills/actives/warhound_bite",
	Const = "WarhoundBite",
	Name = "Bite",
});

::Legends.Active.WolfBite <- null;
activesDefs.push({
	ID = "actives.wolf_bite",
	Script = "scripts/skills/actives/wolf_bite",
	Const = "WolfBite",
	Name = "Bite",
});

::Legends.Active.Gorge <- null;
activesDefs.push({
	ID = "actives.gorge",
	Script = "scripts/skills/actives/gorge_skill",
	Const = "Gorge",
	Name = "Gorge",
});

::Legends.Active.SpiderBite <- null;
activesDefs.push({
	ID = "actives.spider_bite",
	Script = "scripts/skills/actives/spider_bite_skill",
	Const = "SpiderBite",
	Name = "Webknecht Bite",
});

::Legends.Active.UprootSmall <- null;
activesDefs.push({
	ID = "actives.uproot_small",
	Script = "scripts/skills/actives/uproot_small_skill",
	Const = "UprootSmall",
	Name = "Uproot",
});

::Legends.Active.KrakenBite <- null;
activesDefs.push({
	ID = "actives.kraken_bite",
	Script = "scripts/skills/actives/kraken_bite_skill",
	Const = "KrakenBite",
	Name = "Bite",
});

::Legends.Active.KrakenDevour <- null;
activesDefs.push({
	ID = "actives.kraken_devour",
	Script = "scripts/skills/actives/kraken_devour_skill",
	Const = "KrakenDevour",
	Name = "Devour",
});

::Legends.Active.GhostOverheadStrike <- null;
activesDefs.push({
	ID = "actives.ghost_overhead_strike",
	Script = "scripts/skills/actives/ghost_overhead_strike",
	Const = "GhostOverheadStrike",
	Name = "Overhead Strike",
});

::Legends.Active.Headbutt <- null;
activesDefs.push({
	ID = "actives.headbutt",
	Script = "scripts/skills/actives/headbutt_skill",
	Const = "Headbutt",
	Name = "Headbutt",
});

::Legends.Active.SerpentBite <- null;
activesDefs.push({
	ID = "actives.serpent_bite",
	Script = "scripts/skills/actives/serpent_bite_skill",
	Const = "SerpentBite",
	Name = "Serpent Bite",
});

::Legends.Active.Gash <- null;
activesDefs.push({
	ID = "actives.gash",
	Script = "scripts/skills/actives/gash_skill",
	Const = "Gash",
	Name = "Gash",
});

::Legends.Active.FireHandgonne <- null;
activesDefs.push({
	ID = "actives.fire_handgonne",
	Script = "scripts/skills/actives/fire_handgonne_skill",
	Const = "FireHandgonne",
	Name = "Fire Handgonne",
});

::Legends.Active.Lash <- null;
activesDefs.push({
	ID = "actives.lash",
	Script = "scripts/skills/actives/lash_skill",
	Const = "Lash",
	Name = "Lash",
});

::Legends.Active.Hail <- null;
activesDefs.push({
	ID = "actives.hail",
	Script = "scripts/skills/actives/hail_skill",
	Const = "Hail",
	Name = "Hail",
});

::Legends.Active.Puncture <- null;
activesDefs.push({
	ID = "actives.puncture",
	Script = "scripts/skills/actives/puncture",
	Const = "Puncture",
	Name = "Puncture",
});

::Legends.Active.Reap <- null;
activesDefs.push({
	ID = "actives.reap",
	Script = "scripts/skills/actives/reap_skill",
	Const = "Reap",
	Name = "Reap",
});

::Legends.Active.TailSlamSplit <- null;
activesDefs.push({
	ID = "actives.tail_slam_split",
	Script = "scripts/skills/actives/tail_slam_split_skill",
	Const = "TailSlamSplit",
	Name = "Tail Slam",
});

::Legends.Active.Uproot <- null;
activesDefs.push({
	ID = "actives.uproot",
	Script = "scripts/skills/actives/uproot_skill",
	Const = "Uproot",
	Name = "Uproot",
});

::Legends.Active.GhostSplit <- null;
activesDefs.push({
	ID = "actives.ghost_split",
	Script = "scripts/skills/actives/ghost_split_skill",
	Const = "GhostSplit",
	Name = "Split",
});

::Legends.Active.SplitShield <- null;
activesDefs.push({
	ID = "actives.split_shield",
	Script = "scripts/skills/actives/split_shield",
	Const = "SplitShield",
	Name = "Split Shield",
});

::Legends.Active.SwallowWhole <- null;
activesDefs.push({
	ID = "actives.swallow_whole",
	Script = "scripts/skills/actives/swallow_whole_skill",
	Const = "SwallowWhole",
	Name = "Swallow Whole",
});

::Legends.Active.Swing <- null;
activesDefs.push({
	ID = "actives.swing",
	Script = "scripts/skills/actives/swing",
	Const = "Swing",
	Name = "Swing",
});

::Legends.Active.Shatter <- null;
activesDefs.push({
	ID = "actives.shatter",
	Script = "scripts/skills/actives/shatter_skill",
	Const = "Shatter",
	Name = "Shatter",
});

::Legends.Active.TailSlam <- null;
activesDefs.push({
	ID = "actives.tail_slam",
	Script = "scripts/skills/actives/tail_slam_skill",
	Const = "TailSlam",
	Name = "Tail Slam",
});

::Legends.Active.Sweep <- null;
activesDefs.push({
	ID = "actives.sweep",
	Script = "scripts/skills/actives/sweep_skill",
	Const = "Sweep",
	Name = "Sweeping Strike",
});

::Legends.Active.GhostSwing <- null;
activesDefs.push({
	ID = "actives.ghost_swing",
	Script = "scripts/skills/actives/ghost_swing_skill",
	Const = "GhostSwing",
	Name = "Swing",
});

::Legends.Active.HorrificScream <- null;
activesDefs.push({
	ID = "actives.horrific_scream",
	Script = "scripts/skills/actives/horrific_scream",
	Const = "HorrificScream",
	Name = "Horrific Scream",
});

::Legends.Active.Thresh <- null;
activesDefs.push({
	ID = "actives.thresh",
	Script = "scripts/skills/actives/thresh",
	Const = "Thresh",
	Name = "Thresh",
});

::Legends.Active.RoundSwing <- null;
activesDefs.push({
	ID = "actives.round_swing",
	Script = "scripts/skills/actives/round_swing",
	Const = "RoundSwing",
	Name = "Round Swing",
});

::Legends.Active.TailSlamBig <- null;
activesDefs.push({
	ID = "actives.tail_slam_big",
	Script = "scripts/skills/actives/tail_slam_big_skill",
	Const = "TailSlamBig",
	Name = "Tail Slam",
});

::Legends.Active.ThrowNet <- null;
activesDefs.push({
	ID = "actives.throw_net",
	Script = "scripts/skills/actives/throw_net",
	Const = "ThrowNet",
	Name = "Throw Net",
});

::Legends.Active.Web <- null;
activesDefs.push({
	ID = "actives.web",
	Script = "scripts/skills/actives/web_skill",
	Const = "Web",
	Name = "Weave Web",
});

::Legends.Active.KrakenEnsnare <- null;
activesDefs.push({
	ID = "actives.kraken_ensnare",
	Script = "scripts/skills/actives/kraken_ensnare_skill",
	Const = "KrakenEnsnare",
	Name = "Ensnare",
});

::Legends.Active.GoblinWhip <- null;
activesDefs.push({
	ID = "actives.goblin_whip",
	Script = "scripts/skills/actives/goblin_whip",
	Const = "GoblinWhip",
	Name = "Whip",
});

::Legends.Active.DrumsOfWar <- null;
activesDefs.push({
	ID = "actives.drums_of_war",
	Script = "scripts/skills/actives/drums_of_war_skill",
	Const = "DrumsOfWar",
	Name = "Drums of War",
});

::Legends.Active.BreakFree <- null;
activesDefs.push({
	ID = "actives.break_free",
	Script = "scripts/skills/actives/break_free_skill",
	Const = "BreakFree",
	Name = "Break Free",
});

::Legends.Active.UnstoppableCharge <- null;
activesDefs.push({
	ID = "actives.unstoppable_charge",
	Script = "scripts/skills/actives/unstoppable_charge_skill",
	Const = "UnstoppableCharge",
	Name = "Unstoppable Charge",
});

::Legends.Active.Charm <- null;
activesDefs.push({
	ID = "actives.charm",
	Script = "scripts/skills/actives/charm_skill",
	Const = "Charm",
	Name = "Charm",
});

::Legends.Active.Darkflight <- null;
activesDefs.push({
	ID = "actives.darkflight",
	Script = "scripts/skills/actives/darkflight",
	Const = "Darkflight",
	Name = "Darkflight",
});

::Legends.Active.KnockBack <- null;
activesDefs.push({
	ID = "actives.knock_back",
	Script = "scripts/skills/actives/knock_back",
	Const = "KnockBack",
	Name = "Knock Back",
});

::Legends.Active.Repel <- null;
activesDefs.push({
	ID = "actives.repel",
	Script = "scripts/skills/actives/repel",
	Const = "Repel",
	Name = "Repel",
});

::Legends.Active.Hook <- null;
activesDefs.push({
	ID = "actives.hook",
	Script = "scripts/skills/actives/hook",
	Const = "Hook",
	Name = "Hook",
});

::Legends.Active.SerpentHook <- null;
activesDefs.push({
	ID = "actives.serpent_hook",
	Script = "scripts/skills/actives/serpent_hook_skill",
	Const = "SerpentHook",
	Name = "Drag",
});

::Legends.Active.Lunge <- null;
activesDefs.push({
	ID = "actives.lunge",
	Script = "scripts/skills/actives/lunge_skill",
	Const = "Lunge",
	Name = "Lunge",
});

::Legends.Active.Riposte <- null;
activesDefs.push({
	ID = "actives.riposte",
	Script = "scripts/skills/actives/riposte",
	Const = "Riposte",
	Name = "Riposte",
});

::Legends.Active.ReturnFavor <- null;
activesDefs.push({
	ID = "actives.return_favor",
	Script = "scripts/skills/actives/return_favor",
	Const = "ReturnFavor",
	Name = "Return Favor",
});

::Legends.Active.Rotation <- null;
activesDefs.push({
	ID = "actives.rotation",
	Script = "scripts/skills/actives/rotation",
	Const = "Rotation",
	Name = "Rotation",
});

::Legends.Active.BarbarianFury <- null;
activesDefs.push({
	ID = "actives.barbarian_fury",
	Script = "scripts/skills/actives/barbarian_fury_skill",
	Const = "BarbarianFury",
	Name = "Barbarian Fury",
});

::Legends.Active.Shieldwall <- null;
activesDefs.push({
	ID = "actives.shieldwall",
	Script = "scripts/skills/actives/shieldwall",
	Const = "Shieldwall",
	Name = "Shieldwall",
});

::Legends.Active.GrowShield <- null;
activesDefs.push({
	ID = "actives.grow_shield",
	Script = "scripts/skills/actives/grow_shield_skill",
	Const = "GrowShield",
	Name = "Grow Shield",
});

::Legends.Active.Spearwall <- null;
activesDefs.push({
	ID = "actives.spearwall",
	Script = "scripts/skills/actives/spearwall",
	Const = "Spearwall",
	Name = "Spearwall",
});

::Legends.Active.Footwork <- null;
activesDefs.push({
	ID = "actives.footwork",
	Script = "scripts/skills/actives/footwork",
	Const = "Footwork",
	Name = "Footwork",
});

::Legends.Active.ThrowDirt <- null;
activesDefs.push({
	ID = "actives.throw_dirt",
	Script = "scripts/skills/actives/throw_dirt_skill",
	Const = "ThrowDirt",
	Name = "Throw Dirt",
});

::Legends.Active.Taunt <- null;
activesDefs.push({
	ID = "actives.taunt",
	Script = "scripts/skills/actives/taunt",
	Const = "Taunt",
	Name = "Taunt",
});

::Legends.Active.KrakenMoveEnsnared <- null;
activesDefs.push({
	ID = "actives.kraken_move_ensnared",
	Script = "scripts/skills/actives/kraken_move_ensnared_skill",
	Const = "KrakenMoveEnsnared",
	Name = "Drag",
});

::Legends.Active.Gore <- null;
activesDefs.push({
	ID = "actives.gore",
	Script = "scripts/skills/actives/gore_skill",
	Const = "Gore",
	Name = "Gore",
});

::Legends.Active.Miasma <- null;
activesDefs.push({
	ID = "actives.miasma",
	Script = "scripts/skills/actives/miasma_skill",
	Const = "Miasma",
	Name = "Miasma",
});

::Legends.Active.Horror <- null;
activesDefs.push({
	ID = "actives.horror",
	Script = "scripts/skills/actives/horror_skill",
	Const = "Horror",
	Name = "Horror",
});

::Legends.Active.Root <- null;
activesDefs.push({
	ID = "actives.root",
	Script = "scripts/skills/actives/root_skill",
	Const = "Root",
	Name = "Root",
});

::Legends.Active.Insects <- null;
activesDefs.push({
	ID = "actives.insects",
	Script = "scripts/skills/actives/insects_skill",
	Const = "Insects",
	Name = "Swarm of Insects",
});

::Legends.Active.RaiseUndead <- null;
activesDefs.push({
	ID = "actives.raise_undead",
	Script = "scripts/skills/actives/raise_undead",
	Const = "RaiseUndead",
	Name = "Raise Undead",
});

::Legends.Active.FlyingSkulls <- null;
activesDefs.push({
	ID = "actives.flying_skulls",
	Script = "scripts/skills/actives/summon_flying_skulls_skill",
	Const = "FlyingSkulls",
	Name = "Raise Screaming Skulls",
});

::Legends.Active.GrantNightVision <- null;
activesDefs.push({
	ID = "actives.grant_night_vision",
	Script = "scripts/skills/actives/grant_night_vision_skill",
	Const = "GrantNightVision",
	Name = "Grant Night Vision",
});

::Legends.Active.GruesomeFeast <- null;
activesDefs.push({
	ID = "actives.gruesome_feast",
	Script = "scripts/skills/actives/gruesome_feast",
	Const = "GruesomeFeast",
	Name = "Gruesome Feast",
});

::Legends.Active.Hex <- null;
activesDefs.push({
	ID = "actives.hex",
	Script = "scripts/skills/actives/hex_skill",
	Const = "Hex",
	Name = "Hex",
});

::Legends.Active.Indomitable <- null;
activesDefs.push({
	ID = "actives.indomitable",
	Script = "scripts/skills/actives/indomitable",
	Const = "Indomitable",
	Name = "Indomitable",
});

::Legends.Active.LightningStorm <- null;
activesDefs.push({
	ID = "actives.lightning_storm",
	Script = "scripts/skills/actives/lightning_storm_skill",
	Const = "LightningStorm",
	Name = "Lightning Strike",
});

::Legends.Active.LineBreaker <- null;
activesDefs.push({
	ID = "actives.line_breaker",
	Script = "scripts/skills/actives/line_breaker",
	Const = "LineBreaker",
	Name = "Line Breaker",
});

::Legends.Active.FlingBack <- null;
activesDefs.push({
	ID = "actives.fling_back",
	Script = "scripts/skills/actives/fling_back_skill",
	Const = "FlingBack",
	Name = "Fling Back",
});

::Legends.Active.MergeGolem <- null;
activesDefs.push({
	ID = "actives.merge_golem",
	Script = "scripts/skills/actives/merge_golem_skill",
	Const = "MergeGolem",
	Name = "Merge Living Sands",
});

::Legends.Active.MirrorImage <- null;
activesDefs.push({
	ID = "actives.mirror_image",
	Script = "scripts/skills/actives/summon_mirror_image_skill",
	Const = "MirrorImage",
	Name = "Mirror Image",
});

::Legends.Active.FireMortar <- null;
activesDefs.push({
	ID = "actives.fire_mortar",
	Script = "scripts/skills/actives/fire_mortar_skill",
	Const = "FireMortar",
	Name = "Fire Mortar",
});

::Legends.Active.MoveTail <- null;
activesDefs.push({
	ID = "actives.move_tail",
	Script = "scripts/skills/actives/move_tail_skill",
	Const = "MoveTail",
	Name = "Move Tail",
});

::Legends.Active.KrakenMove <- null;
activesDefs.push({
	ID = "actives.kraken_move",
	Script = "scripts/skills/actives/kraken_move_skill",
	Const = "KrakenMove",
	Name = "Move Tentacle",
});

::Legends.Active.PossessUndead <- null;
activesDefs.push({
	ID = "actives.possess_undead",
	Script = "scripts/skills/actives/possess_undead_skill",
	Const = "PossessUndead",
	Name = "Possess Undead",
});

::Legends.Active.RallyTheTroops <- null;
activesDefs.push({
	ID = "actives.rally_the_troops",
	Script = "scripts/skills/actives/rally_the_troops",
	Const = "RallyTheTroops",
	Name = "Rally",
});

::Legends.Active.Recover <- null;
activesDefs.push({
	ID = "actives.recover",
	Script = "scripts/skills/actives/recover_skill",
	Const = "Recover",
	Name = "Recover",
});

::Legends.Active.ReloadBolt <- null;
activesDefs.push({
	ID = "actives.reload_bolt",
	Script = "scripts/skills/actives/reload_bolt",
	Const = "ReloadBolt",
	Name = "Reload",
});

::Legends.Active.ReloadHandgonne <- null;
activesDefs.push({
	ID = "actives.reload_handgonne",
	Script = "scripts/skills/actives/reload_handgonne_skill",
	Const = "ReloadHandgonne",
	Name = "Reload",
});

::Legends.Active.Sleep <- null;
activesDefs.push({
	ID = "actives.sleep",
	Script = "scripts/skills/actives/sleep_skill",
	Const = "Sleep",
	Name = "Sleep",
});

::Legends.Active.Teleport <- null;
activesDefs.push({
	ID = "actives.teleport",
	Script = "scripts/skills/actives/teleport_skill",
	Const = "Teleport",
	Name = "Spirit Walk",
});

::Legends.Active.ThrowDazeBomb <- null;
activesDefs.push({
	ID = "actives.throw_daze_bomb",
	Script = "scripts/skills/actives/throw_daze_bomb_skill",
	Const = "ThrowDazeBomb",
	Name = "Throw Flash Pot",
});

::Legends.Active.ThrowFireBomb <- null;
activesDefs.push({
	ID = "actives.throw_fire_bomb",
	Script = "scripts/skills/actives/throw_fire_bomb_skill",
	Const = "ThrowFireBomb",
	Name = "Throw Fire Pot",
});

::Legends.Active.ThrowSmokeBomb <- null;
activesDefs.push({
	ID = "actives.throw_smoke_bomb",
	Script = "scripts/skills/actives/throw_smoke_bomb_skill",
	Const = "ThrowSmokeBomb",
	Name = "Throw Smoke Pot",
});

::Legends.Active.FakeDrinkNightVision <- null;
activesDefs.push({
	ID = "actives.fake_drink_night_vision",
	Script = "scripts/skills/actives/fake_drink_night_vision_skill",
	Const = "FakeDrinkNightVision",
	Name = "Drink Night Owl Elixir",
});

::Legends.Active.WakeAlly <- null;
activesDefs.push({
	ID = "actives.wake_ally",
	Script = "scripts/skills/actives/wake_ally_skill",
	Const = "WakeAlly",
	Name = "Wake Ally",
});

::Legends.Active.Warcry <- null;
activesDefs.push({
	ID = "actives.warcry",
	Script = "scripts/skills/actives/warcry",
	Const = "Warcry",
	Name = "Warcry",
});

::Legends.Active.Wither <- null;
activesDefs.push({
	ID = "actives.wither",
	Script = "scripts/skills/actives/wither_skill",
	Const = "Wither",
	Name = "Wither",
});

::Legends.Active.BandageAlly <- null;
activesDefs.push({
	ID = "actives.bandage_ally",
	Script = "scripts/skills/actives/bandage_ally_skill",
	Const = "BandageAlly",
	Name = "Use Bandages",
});

::Legends.Active.BerserkerMushrooms <- null;
activesDefs.push({
	ID = "actives.berserker_mushrooms",
	Script = "scripts/skills/actives/berserker_mushrooms_skill",
	Const = "BerserkerMushrooms",
	Name = "Eat or Give Strange Mushrooms",
});

::Legends.Active.BreakAllyFree <- null;
activesDefs.push({
	ID = "actives.break_ally_free",
	Script = "scripts/skills/actives/break_ally_free_skill",
	Const = "BreakAllyFree",
	Name = "Free Ally",
});

::Legends.Active.CoatWithPoison <- null;
activesDefs.push({
	ID = "actives.coat_with_poison",
	Script = "scripts/skills/actives/coat_with_poison_skill",
	Const = "CoatWithPoison",
	Name = "Use Poison",
});

::Legends.Active.CoatWithSpiderPoison <- null;
activesDefs.push({
	ID = "actives.coat_with_spider_poison",
	Script = "scripts/skills/actives/coat_with_spider_poison_skill",
	Const = "CoatWithSpiderPoison",
	Name = "Use Poisoned Oil",
});

::Legends.Active.Debilitate <- null;
activesDefs.push({
	ID = "actives.debilitate",
	Script = "scripts/skills/actives/debilitate",
	Const = "Debilitate",
	Name = "Debilitate",
});

::Legends.Active.DrinkAntidote <- null;
activesDefs.push({
	ID = "actives.drink_antidote",
	Script = "scripts/skills/actives/drink_antidote_skill",
	Const = "DrinkAntidote",
	Name = "Drink or Give Antidote",
});

::Legends.Active.FirstAid <- null;
activesDefs.push({
	ID = "actives.first_aid",
	Script = "scripts/skills/actives/first_aid_skill",
	Const = "FirstAid",
	Name = "First Aid",
});

::Legends.Active.PerfectFocus <- null;
activesDefs.push({
	ID = "actives.perfect_focus",
	Script = "scripts/skills/actives/perfect_focus",
	Const = "PerfectFocus",
	Name = "Perfect Focus",
});

::Legends.Active.ReleaseFalcon <- null;
activesDefs.push({
	ID = "actives.release_falcon",
	Script = "scripts/skills/actives/release_falcon_skill",
	Const = "ReleaseFalcon",
	Name = "Release Falcon",
});

::Legends.Active.Stealth <- null;
activesDefs.push({
	ID = "actives.stealth",
	Script = "scripts/skills/actives/stealth_skill",
	Const = "Stealth",
	Name = "Stealth",
});

::Legends.Active.SweepZoc <- null;
activesDefs.push({
	ID = "actives.sweep_zoc",
	Script = "scripts/skills/actives/sweep_zoc_skill",
	Const = "SweepZoc",
	Name = "Sweeping Strike",
});

::Legends.Active.TailSlamZoc <- null;
activesDefs.push({
	ID = "actives.tail_slam_zoc",
	Script = "scripts/skills/actives/tail_slam_zoc_skill",
	Const = "TailSlamZoc",
	Name = "Tail Slam",
});

::Legends.Active.ThrowAcidFlask <- null;
activesDefs.push({
	ID = "actives.throw_acid_flask",
	Script = "scripts/skills/actives/throw_acid_flask",
	Const = "ThrowAcidFlask",
	Name = "Throw Acid Flask",
});

::Legends.Active.ThrowHolyWater <- null;
activesDefs.push({
	ID = "actives.throw_holy_water",
	Script = "scripts/skills/actives/throw_holy_water",
	Const = "ThrowHolyWater",
	Name = "Throw Blessed Water",
});

::Legends.Active.UnleashWardog <- null;
activesDefs.push({
	ID = "actives.unleash_wardog",
	Script = "scripts/skills/actives/unleash_wardog",
	Const = "UnleashWardog",
	Name = "Unleash Wardog",
});

::Legends.Active.UnleashWolf <- null;
activesDefs.push({
	ID = "actives.unleash_wolf",
	Script = "scripts/skills/actives/unleash_wolf",
	Const = "UnleashWolf",
	Name = "Unleash Wardog",
});

::Legends.Active.UprootSmallZoc <- null;
activesDefs.push({
	ID = "actives.uproot_small_zoc",
	Script = "scripts/skills/actives/uproot_small_zoc_skill",
	Const = "UprootSmallZoc",
	Name = "Uproot",
});

::Legends.Active.UprootZoc <- null;
activesDefs.push({
	ID = "actives.uproot_zoc",
	Script = "scripts/skills/actives/uproot_zoc_skill",
	Const = "UprootZoc",
	Name = "Uproot",
});

::Legends.Active.VoiceOfDavkul <- null;
activesDefs.push({
	ID = "actives.voice_of_davkul",
	Script = "scripts/skills/actives/voice_of_davkul_skill",
	Const = "VoiceOfDavkul",
	Name = "Voice of Davkul",
});

::Legends.Active.WhipSlave <- null;
activesDefs.push({
	ID = "actives.whip_slave",
	Script = "scripts/skills/actives/whip_slave_skill",
	Const = "WhipSlave",
	Name = "Crack the Whip",
});

::Legends.Active.LegendTransformIntoBear <- null;
activesDefs.push({
	ID = "actives.legend_transform_into_bear",
	Script = "scripts/skills/actives/legend_transform_into_bear_skill",
	Const = "LegendTransformIntoBear",
	Name = "Transform into Bear",
});

::Legends.Active.LegendCatapultBoulder <- null;
activesDefs.push({
	ID = "actives.legend_catapult_boulder",
	Script = "scripts/skills/actives/legend_catapult_boulder_skill",
	Const = "LegendCatapultBoulder",
	Name = "Catapult Boulder",
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

::Legends.Active.LegendHalberdSmite <- null;
activesDefs.push({
	ID = "actives.legend_halberd_smite",
	Script = "scripts/skills/actives/legend_halberd_smite_skill",
	Const = "LegendHalberdSmite",
	Name = "Smite",
});

::Legends.Active.LegendSkewer <- null;
activesDefs.push({
	ID = "actives.legend_skewer",
	Script = "scripts/skills/actives/legend_skewer_skill",
	Const = "LegendSkewer",
	Name = "Skewer",
});

::Legends.Active.LegendCatBite <- null;
activesDefs.push({
	ID = "actives.legend_cat_bite",
	Script = "scripts/skills/actives/legend_cat_bite_skill",
	Const = "LegendCatBite",
	Name = "Cat Bite",
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

::Legends.Active.LegendDemonHoundBite <- null;
activesDefs.push({
	ID = "actives.legend_demon_hound_bite",
	Script = "scripts/skills/actives/legend_demon_hound_bite_skill",
	Const = "LegendDemonHoundBite",
	Name = "H÷llenhund Bite",
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

::Legends.Active.LegendDonkeyKick <- null;
activesDefs.push({
	ID = "actives.legend_donkey_kick",
	Script = "scripts/skills/actives/legend_donkey_kick_skill",
	Const = "LegendDonkeyKick",
	Name = "Donkey Kick",
});

::Legends.Active.LegendBearBite <- null;
activesDefs.push({
	ID = "actives.legend_bear_bite",
	Script = "scripts/skills/actives/legend_bear_bite_skill",
	Const = "LegendBearBite",
	Name = "Bear Bite",
});

::Legends.Active.LegendBearClaws <- null;
activesDefs.push({
	ID = "actives.legend_bear_claws",
	Script = "scripts/skills/actives/legend_bear_claws_skill",
	Const = "LegendBearClaws",
	Name = "Bear Claws",
});

::Legends.Active.LegendFlagellate <- null;
activesDefs.push({
	ID = "actives.legend_flagellate",
	Script = "scripts/skills/actives/legend_flagellate_skill",
	Const = "LegendFlagellate",
	Name = "Flagellate",
});

::Legends.Active.LegendBoarGore <- null;
activesDefs.push({
	ID = "actives.legend_boar_gore",
	Script = "scripts/skills/actives/legend_boar_gore_skill",
	Const = "LegendBoarGore",
	Name = "Boar Gore",
});

::Legends.Active.LegendRatClaws <- null;
activesDefs.push({
	ID = "actives.legend_rat_claws",
	Script = "scripts/skills/actives/legend_rat_claws_skill",
	Const = "LegendRatClaws",
	Name = "Rat Claws",
});

::Legends.Active.LegendRatBite <- null;
activesDefs.push({
	ID = "actives.legend_rat_bite",
	Script = "scripts/skills/actives/legend_rat_bite_skill",
	Const = "LegendRatBite",
	Name = "Rat Bite",
});

::Legends.Active.LegendEnGarde <- null;
activesDefs.push({
	ID = "actives.legend_en_garde",
	Script = "scripts/skills/actives/legend_en_garde_skill",
	Const = "LegendEnGarde",
	Name = "En Garde",
});

::Legends.Active.LegendNightmareTouch <- null;
activesDefs.push({
	ID = "actives.legend_nightmare_touch",
	Script = "scripts/skills/actives/legend_nightmare_touch_skill",
	Const = "LegendNightmareTouch",
	Name = "Terror",
});

::Legends.Active.LegendBasiliskPeck <- null;
activesDefs.push({
	ID = "actives.legend_basilisk_peck",
	Script = "scripts/skills/actives/legend_basilisk_peck_skill",
	Const = "LegendBasiliskPeck",
	Name = "Peck",
});

::Legends.Active.LegendBasiliskSentryInject <- null;
activesDefs.push({
	ID = "actives.legend_basilisk_sentry_inject",
	Script = "scripts/skills/actives/legend_basilisk_sentry_inject_skill",
	Const = "LegendBasiliskSentryInject",
	Name = "Inject",
});

::Legends.Active.LegendBasiliskSentryFowleye <- null;
activesDefs.push({
	ID = "actives.legend_basilisk_sentry_fowleye",
	Script = "scripts/skills/actives/legend_basilisk_sentry_fowleye_skill",
	Const = "LegendBasiliskSentryFowleye",
	Name = "Fowl Eye",
});

::Legends.Active.LegendGrapple <- null;
activesDefs.push({
	ID = "actives.legend_grapple",
	Script = "scripts/skills/actives/legend_grapple_skill",
	Const = "LegendGrapple",
	Name = "Grapple",
});

::Legends.Active.LegendBucklerBash <- null;
activesDefs.push({
	ID = "actives.legend_buckler_bash",
	Script = "scripts/skills/actives/legend_buckler_bash_skill",
	Const = "LegendBucklerBash",
	Name = "Buckler Bash",
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

::Legends.Active.LegendPunctureParryDagger <- null;
activesDefs.push({
	ID = "actives.legend_puncture_parry_dagger",
	Script = "scripts/skills/actives/legend_puncture_parry_dagger_skill",
	Const = "LegendPunctureParryDagger",
	Name = "Offhand Puncture",
});

::Legends.Active.LegendChoke <- null;
activesDefs.push({
	ID = "actives.legend_choke",
	Script = "scripts/skills/actives/legend_choke_skill",
	Const = "LegendChoke",
	Name = "Choke",
});

::Legends.Active.LegendSkinGhoulSwallowWhole <- null;
activesDefs.push({
	ID = "actives.legend_skin_ghoul_swallow_whole",
	Script = "scripts/skills/actives/legend_skin_ghoul_swallow_whole_skill",
	Const = "LegendSkinGhoulSwallowWhole",
	Name = "Swallow Whole",
});

::Legends.Active.LegendBansheeScream <- null;
activesDefs.push({
	ID = "actives.legend_banshee_scream",
	Script = "scripts/skills/actives/legend_banshee_scream",
	Const = "LegendBansheeScream",
	Name = "Banshee Scream",
});

::Legends.Active.LegendHorrificScream <- null;
activesDefs.push({
	ID = "actives.legend_horrific_scream",
	Script = "scripts/skills/actives/legend_horrific_scream",
	Const = "LegendHorrificScream",
	Name = "Horrific Scream",
});

::Legends.Active.LegendDaze <- null;
activesDefs.push({
	ID = "actives.legend_daze",
	Script = "scripts/skills/actives/legend_daze_skill",
	Const = "LegendDaze",
	Name = "Daze",
});

::Legends.Active.LegendDrumsOfLife <- null;
activesDefs.push({
	ID = "actives.legend_drums_of_life",
	Script = "scripts/skills/actives/legend_drums_of_life_skill",
	Const = "LegendDrumsOfLife",
	Name = "Song of Life",
});

::Legends.Active.LegendDrumsOfWar <- null;
activesDefs.push({
	ID = "actives.legend_drums_of_war",
	Script = "scripts/skills/actives/legend_drums_of_war_skill",
	Const = "LegendDrumsOfWar",
	Name = "War Chant",
});

::Legends.Active.LegendPushForward <- null;
activesDefs.push({
	ID = "actives.legend_push_forward",
	Script = "scripts/skills/actives/legend_push_forward_skill",
	Const = "LegendPushForward",
	Name = "Push Forward",
});

::Legends.Active.LegendHoldTheLine <- null;
activesDefs.push({
	ID = "actives.legend_hold_the_line",
	Script = "scripts/skills/actives/legend_hold_the_line",
	Const = "LegendHoldTheLine",
	Name = "Hold the line",
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

::Legends.Active.LegendCitrinitasTrance <- null;
activesDefs.push({
	ID = "actives.legend_citrinitas_trance",
	Script = "scripts/skills/actives/legend_citrinitas_trance_skill",
	Const = "LegendCitrinitasTrance",
	Name = "Citrinitas (Trance)",
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

::Legends.Active.LegendAiRotation <- null;
activesDefs.push({
	ID = "actives.legend_ai_rotation",
	Script = "scripts/skills/actives/legend_ai_rotation_skill",
	Const = "LegendAiRotation",
	Name = "AI Rotation",
});

::Legends.Active.LegendAlpSummonNightmare <- null;
activesDefs.push({
	ID = "actives.legend_alp_summon_nightmare",
	Script = "scripts/skills/actives/legend_alp_summon_nightmare_skill",
	Const = "LegendAlpSummonNightmare",
	Name = "Conjure Nightmare",
});

::Legends.Active.LegendAlpNightmareManifestation <- null;
activesDefs.push({
	ID = "actives.legend_alp_nightmare_manifestation",
	Script = "scripts/skills/actives/legend_alp_nightmare_manifestation_skill",
	Const = "LegendAlpNightmareManifestation",
	Name = "Conjure Nightmare",
});

::Legends.Active.LegendAlpRealmOfShadow <- null;
activesDefs.push({
	ID = "actives.legend_alp_realm_of_shadow",
	Script = "scripts/skills/actives/legend_alp_realm_of_shadow_skill",
	Const = "LegendAlpRealmOfShadow",
	Name = "Shadow Mist",
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

::Legends.Active.LegendAlbedo <- null;
activesDefs.push({
	ID = "actives.legend_albedo",
	Script = "scripts/skills/actives/legend_albedo_skill",
	Const = "LegendAlbedo",
	Name = "Albedo",
});

::Legends.Active.LegendApothecaryMushrooms <- null;
activesDefs.push({
	ID = "actives.legend_apothecary_mushrooms",
	Script = "scripts/skills/actives/legend_apothecary_mushrooms_skill",
	Const = "LegendApothecaryMushrooms",
	Name = "Eat or Give Strange Mushrooms",
});

::Legends.Active.LegendAttackTarget <- null;
activesDefs.push({
	ID = "actives.legend_attack_target",
	Script = "scripts/skills/actives/legend_attack_target_skill",
	Const = "LegendAttackTarget",
	Name = "Chopper sick balls!",
});

::Legends.Active.LegendProtectTarget <- null;
activesDefs.push({
	ID = "actives.legend_protect_target",
	Script = "scripts/skills/actives/legend_protect_target_skill",
	Const = "LegendProtectTarget",
	Name = "Defend! Good boy!",
});

::Legends.Active.LegendBandage <- null;
activesDefs.push({
	ID = "actives.legend_bandage",
	Script = "scripts/skills/actives/legend_bandage_skill",
	Const = "LegendBandage",
	Name = "Use Bandages",
});

::Legends.Active.LegendBribe <- null;
activesDefs.push({
	ID = "actives.legend_bribe",
	Script = "scripts/skills/actives/legend_bribe_skill",
	Const = "LegendBribe",
	Name = "Bribe",
});

::Legends.Active.LegendCallLightning <- null;
activesDefs.push({
	ID = "actives.legend_call_lightning",
	Script = "scripts/skills/actives/legend_call_lightning_skill",
	Const = "LegendCallLightning",
	Name = "Call Lightning",
});

::Legends.Active.LegendCascade <- null;
activesDefs.push({
	ID = "actives.legend_cascade",
	Script = "scripts/skills/actives/legend_cascade_skill",
	Const = "LegendCascade",
	Name = "Cascade Strike",
});

::Legends.Active.LegendChainLightning <- null;
activesDefs.push({
	ID = "actives.legend_chain_lightning",
	Script = "scripts/skills/actives/legend_chain_lightning_skill",
	Const = "LegendChainLightning",
	Name = "Chain Lightning",
});

::Legends.Active.LegendCharge <- null;
activesDefs.push({
	ID = "actives.legend_charge",
	Script = "scripts/skills/actives/legend_charge_skill",
	Const = "LegendCharge",
	Name = "Charge",
});

::Legends.Active.LegendCheerOn <- null;
activesDefs.push({
	ID = "actives.legend_cheer_on",
	Script = "scripts/skills/actives/legend_cheer_on_skill",
	Const = "LegendCheerOn",
	Name = "Cheer On",
});

::Legends.Active.LegendClimb <- null;
activesDefs.push({
	ID = "actives.legend_climb",
	Script = "scripts/skills/actives/legend_climb_skill",
	Const = "LegendClimb",
	Name = "Climb",
});

::Legends.Active.LegendCoordinatedVolleys <- null;
activesDefs.push({
	ID = "actives.legend_coordinated_volleys",
	Script = "scripts/skills/actives/legend_coordinated_volleys_skill",
	Const = "LegendCoordinatedVolleys",
	Name = "Coordinated Volleys",
});

::Legends.Active.LegendCurseofyears <- null;
activesDefs.push({
	ID = "actives.legend_curseofyears",
	Script = "scripts/skills/actives/legend_curseofyears_skill",
	Const = "LegendCurseofyears",
	Name = "Decrepify",
});

::Legends.Active.LegendDangerPay <- null;
activesDefs.push({
	ID = "actives.legend_danger_pay",
	Script = "scripts/skills/actives/legend_danger_pay_skill",
	Const = "LegendDangerPay",
	Name = "Danger Pay",
});

::Legends.Active.LegendDarkflight <- null;
activesDefs.push({
	ID = "actives.legend_darkflight",
	Script = "scripts/skills/actives/legend_darkflight_skill",
	Const = "LegendDarkflight",
	Name = "Darkflight",
});

::Legends.Active.LegendDeathtouch <- null;
activesDefs.push({
	ID = "actives.legend_deathtouch",
	Script = "scripts/skills/actives/legend_deathtouch_skill",
	Const = "LegendDeathtouch",
	Name = "Death Touch",
});

::Legends.Active.LegendDemonShadows <- null;
activesDefs.push({
	ID = "actives.legend_demon_shadows",
	Script = "scripts/skills/actives/legend_demon_shadows_skill",
	Const = "LegendDemonShadows",
	Name = "Realm of Burning Nightmares",
});

::Legends.Active.LegendDogHandling <- null;
activesDefs.push({
	ID = "actives.legend_dog_handling",
	Script = "scripts/skills/actives/legend_dog_handling_skill",
	Const = "LegendDogHandling",
	Name = "Dog Handling",
});

::Legends.Active.LegendDogMaster <- null;
activesDefs.push({
	ID = "actives.legend_dog_master",
	Script = "scripts/skills/actives/legend_dog_master_skill",
	Const = "LegendDogMaster",
	Name = "Dog Master",
});

::Legends.Active.LegendDrain <- null;
activesDefs.push({
	ID = "actives.legend_drain",
	Script = "scripts/skills/actives/legend_drain_skill",
	Const = "LegendDrain",
	Name = "Drain Life",
});

::Legends.Active.LegendDrinkBeer <- null;
activesDefs.push({
	ID = "actives.legend_drink_beer",
	Script = "scripts/skills/actives/legend_drink_beer_skill",
	Const = "LegendDrinkBeer",
	Name = "Drink or Give Beer",
});

::Legends.Active.LegendDrinkCat <- null;
activesDefs.push({
	ID = "actives.legend_drink_cat",
	Script = "scripts/skills/actives/legend_drink_cat_skill",
	Const = "LegendDrinkCat",
	Name = "Drink or Give Cat Potion",
});

::Legends.Active.LegendDrinkHeartwoodSap <- null;
activesDefs.push({
	ID = "actives.legend_drink_heartwood_sap",
	Script = "scripts/skills/actives/legend_drink_heartwood_sap_skill",
	Const = "LegendDrinkHeartwoodSap",
	Name = "Drink or Give Heartwood Sap",
});

::Legends.Active.LegendDrinkHexeIchorPotion <- null;
activesDefs.push({
	ID = "actives.legend_drink_hexe_ichor_potion",
	Script = "scripts/skills/actives/legend_drink_hexe_ichor_potion_skill",
	Const = "LegendDrinkHexeIchorPotion",
	Name = "Drink or Give Hexe Ichor Potion",
});

::Legends.Active.LegendDrinkIronWill <- null;
activesDefs.push({
	ID = "actives.legend_drink_iron_will",
	Script = "scripts/skills/actives/legend_drink_iron_will_skill",
	Const = "LegendDrinkIronWill",
	Name = "Drink or Give Iron Will Potion",
});

::Legends.Active.LegendDrinkLionheart <- null;
activesDefs.push({
	ID = "actives.legend_drink_lionheart",
	Script = "scripts/skills/actives/legend_drink_lionheart_skill",
	Const = "LegendDrinkLionheart",
	Name = "Drink or Give Lionheart Potion",
});

::Legends.Active.LegendDrinkLiquor <- null;
activesDefs.push({
	ID = "actives.legend_drink_liquor",
	Script = "scripts/skills/actives/legend_drink_liquor_skill",
	Const = "LegendDrinkLiquor",
	Name = "Drink or Give Liquor",
});

::Legends.Active.LegendDrinkMead <- null;
activesDefs.push({
	ID = "actives.legend_drink_mead",
	Script = "scripts/skills/actives/legend_drink_mead_skill",
	Const = "LegendDrinkMead",
	Name = "Drink or Give Mead",
});

::Legends.Active.LegendDrinkNightVision <- null;
activesDefs.push({
	ID = "actives.legend_drink_night_vision",
	Script = "scripts/skills/actives/legend_drink_night_vision_skill",
	Const = "LegendDrinkNightVision",
	Name = "Drink or Give Night Owl Elixir",
});

::Legends.Active.LegendDrinkRecoveryPotion <- null;
activesDefs.push({
	ID = "actives.legend_drink_recovery_potion",
	Script = "scripts/skills/actives/legend_drink_recovery_potion_skill",
	Const = "LegendDrinkRecoveryPotion",
	Name = "Drink or Give Second Wind Potion",
});

::Legends.Active.LegendDrinkSkinGhoulBlood <- null;
activesDefs.push({
	ID = "actives.legend_drink_skin_ghoul_blood",
	Script = "scripts/skills/actives/legend_drink_skin_ghoul_blood_skill",
	Const = "LegendDrinkSkinGhoulBlood",
	Name = "Drink or Give Skin Ghoul Blood",
});

::Legends.Active.LegendDrinkStollwurmBlood <- null;
activesDefs.push({
	ID = "actives.legend_drink_stollwurm_blood",
	Script = "scripts/skills/actives/legend_drink_stollwurm_blood_skill",
	Const = "LegendDrinkStollwurmBlood",
	Name = "Drink or Give Stollwurm Blood",
});

::Legends.Active.LegendDrinkTherianthropyPotion <- null;
activesDefs.push({
	ID = "actives.legend_drink_therianthropy_potion",
	Script = "scripts/skills/actives/legend_drink_therianthropy_potion_skill",
	Const = "LegendDrinkTherianthropyPotion",
	Name = "Drink or Give Therianthropic Potion",
});

::Legends.Active.LegendDrinkWine <- null;
activesDefs.push({
	ID = "actives.legend_drink_wine",
	Script = "scripts/skills/actives/legend_drink_wine_skill",
	Const = "LegendDrinkWine",
	Name = "Drink or Give Wine",
});

::Legends.Active.LegendEatPie <- null;
activesDefs.push({
	ID = "actives.legend_eat_pie",
	Script = "scripts/skills/actives/legend_eat_pie_skill",
	Const = "LegendEatPie",
	Name = "Eat or Give Pie",
});

::Legends.Active.LegendEatPorridge <- null;
activesDefs.push({
	ID = "actives.legend_eat_porridge",
	Script = "scripts/skills/actives/legend_eat_porridge_skill",
	Const = "LegendEatPorridge",
	Name = "Eat or Give Porridge",
});

::Legends.Active.LegendEatPudding <- null;
activesDefs.push({
	ID = "actives.legend_eat_pudding",
	Script = "scripts/skills/actives/legend_eat_pudding_skill",
	Const = "LegendEatPudding",
	Name = "Eat or Give Pudding",
});

::Legends.Active.LegendEatRations <- null;
activesDefs.push({
	ID = "actives.legend_eat_rations",
	Script = "scripts/skills/actives/legend_eat_rations_skill",
	Const = "LegendEatRations",
	Name = "Eat or Give Food",
});

::Legends.Active.LegendEnthrall <- null;
activesDefs.push({
	ID = "actives.legend_enthrall",
	Script = "scripts/skills/actives/legend_enthrall_skill",
	Const = "LegendEnthrall",
	Name = "Enthrall",
});

::Legends.Active.LegendEntice <- null;
activesDefs.push({
	ID = "actives.legend_entice",
	Script = "scripts/skills/actives/legend_entice_skill",
	Const = "LegendEntice",
	Name = "Entice",
});

::Legends.Active.LegendEvasion <- null;
activesDefs.push({
	ID = "actives.legend_evasion",
	Script = "scripts/skills/actives/legend_evasion_skill",
	Const = "LegendEvasion",
	Name = "Evasion",
});

::Legends.Active.LegendFalcon <- null;
activesDefs.push({
	ID = "actives.legend_falcon",
	Script = "scripts/skills/actives/legend_falcon_skill",
	Const = "LegendFalcon",
	Name = "Unleash Falcon",
});

::Legends.Active.LegendFieldRepairs <- null;
activesDefs.push({
	ID = "actives.legend_field_repairs",
	Script = "scripts/skills/actives/legend_field_repairs_skill",
	Const = "LegendFieldRepairs",
	Name = "Field Repairs",
});

::Legends.Active.LegendFieldTreats <- null;
activesDefs.push({
	ID = "actives.legend_field_treats",
	Script = "scripts/skills/actives/legend_field_treats_skill",
	Const = "LegendFieldTreats",
	Name = "Field Treats",
});

::Legends.Active.LegendFieldTriage <- null;
activesDefs.push({
	ID = "actives.legend_field_triage",
	Script = "scripts/skills/actives/legend_field_triage_skill",
	Const = "LegendFieldTriage",
	Name = "Field Triage",
});

::Legends.Active.LegendFirefield <- null;
activesDefs.push({
	ID = "actives.legend_firefield",
	Script = "scripts/skills/actives/legend_firefield_skill",
	Const = "LegendFirefield",
	Name = "Fire Pot",
});

::Legends.Active.LegendFlogging <- null;
activesDefs.push({
	ID = "actives.legend_flogging",
	Script = "scripts/skills/actives/legend_flogging_skill",
	Const = "LegendFlogging",
	Name = "Flogging",
});

::Legends.Active.LegendFortify <- null;
activesDefs.push({
	ID = "actives.legend_fortify",
	Script = "scripts/skills/actives/legend_fortify_skill",
	Const = "LegendFortify",
	Name = "Fortify",
});

::Legends.Active.LegendGrowGreenwoodShield <- null;
activesDefs.push({
	ID = "actives.legend_grow_greenwood_shield",
	Script = "scripts/skills/actives/legend_grow_greenwood_shield_skill",
	Const = "LegendGrowGreenwoodShield",
	Name = "Grow Greenwood Shield",
});

::Legends.Active.LegendGruesomeFeast <- null;
activesDefs.push({
	ID = "actives.legend_gruesome_feast",
	Script = "scripts/skills/actives/legend_gruesome_feast_skill",
	Const = "LegendGruesomeFeast",
	Name = "Gruesome Feast",
});

::Legends.Active.LegendGuideSteps <- null;
activesDefs.push({
	ID = "actives.legend_guide_steps",
	Script = "scripts/skills/actives/legend_guide_steps_skill",
	Const = "LegendGuideSteps",
	Name = "Guide steps",
});

::Legends.Active.LegendHarvestBush <- null;
activesDefs.push({
	ID = "actives.legend_harvest_bush",
	Script = "scripts/skills/actives/legend_harvest_bush_skill",
	Const = "LegendHarvestBush",
	Name = "Harvest Bush",
});

::Legends.Active.LegendHarvestRock <- null;
activesDefs.push({
	ID = "actives.legend_harvest_rock",
	Script = "scripts/skills/actives/legend_harvest_rock_skill",
	Const = "LegendHarvestRock",
	Name = "Crush Rock",
});

::Legends.Active.LegendHarvestTree <- null;
activesDefs.push({
	ID = "actives.legend_harvest_tree",
	Script = "scripts/skills/actives/legend_harvest_tree_skill",
	Const = "LegendHarvestTree",
	Name = "Harvest Tree",
});

::Legends.Active.LegendHex <- null;
activesDefs.push({
	ID = "actives.legend_hex",
	Script = "scripts/skills/actives/legend_hex_skill",
	Const = "LegendHex",
	Name = "Hex",
});

::Legends.Active.LegendHidden <- null;
activesDefs.push({
	ID = "actives.legend_hidden",
	Script = "scripts/skills/actives/legend_hidden_skill",
	Const = "LegendHidden",
	Name = "Hide",
});

::Legends.Active.LegendHolyflame <- null;
activesDefs.push({
	ID = "actives.legend_holyflame",
	Script = "scripts/skills/actives/legend_holyflame_skill",
	Const = "LegendHolyflame",
	Name = "Holy Flame",
});

::Legends.Active.LegendHorrify <- null;
activesDefs.push({
	ID = "actives.legend_horrify",
	Script = "scripts/skills/actives/legend_horrify_old_skill",
	Const = "LegendHorrify",
	Name = "Horrify",
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
	Name = "Daze",
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

::Legends.Active.LegendNigredo <- null;
activesDefs.push({
	ID = "actives.legend_nigredo",
	Script = "scripts/skills/actives/legend_nigredo_skill",
	Const = "LegendNigredo",
	Name = "Nigredo",
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

::Legends.Active.LegendPiercingBolt <- null;
activesDefs.push({
	ID = "actives.legend_piercing_bolt",
	Script = "scripts/skills/actives/legend_piercing_bolt_skill",
	Const = "LegendPiercingBolt",
	Name = "Piercing Bolt",
});

::Legends.Active.LegendPiercingShot <- null;
activesDefs.push({
	ID = "actives.legend_piercing_shot",
	Script = "scripts/skills/actives/legend_piercing_shot_skill",
	Const = "LegendPiercingShot",
	Name = "Piercing Shot",
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

::Legends.Active.LegendPrepareKnockdown <- null;
activesDefs.push({
	ID = "actives.legend_prepare_knockdown",
	Script = "scripts/skills/actives/legend_prepare_knockback_skill",
	Const = "LegendPrepareKnockdown",
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

::Legends.Active.LegendSprint <- null;
activesDefs.push({
	ID = "actives.legend_sprint",
	Script = "scripts/skills/actives/legend_sprint_skill",
	Const = "LegendSprint",
	Name = "Sprint",
});

::Legends.Active.LegendStaffwall <- null;
activesDefs.push({
	ID = "actives.legend_staffwall",
	Script = "scripts/skills/actives/legend_staffwall_skill",
	Const = "LegendStaffwall",
	Name = "Spearwall",
});

::Legends.Active.LegendStaffLunge <- null;
activesDefs.push({
	ID = "actives.legend_staff_lunge",
	Script = "scripts/skills/actives/legend_staff_lunge_skill",
	Const = "LegendStaffLunge",
	Name = "Lunge",
});

::Legends.Active.LegendStaffThrust <- null;
activesDefs.push({
	ID = "actives.legend_staff_thrust",
	Script = "scripts/skills/actives/legend_staff_thrust_skill",
	Const = "LegendStaffThrust",
	Name = "Thrust",
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

::Legends.Active.LegendTumble <- null;
activesDefs.push({
	ID = "actives.legend_tumble",
	Script = "scripts/skills/actives/legend_tumble_skill",
	Const = "LegendTumble",
	Name = "Tumble",
});

::Legends.Active.LegendUnarmedLunge <- null;
activesDefs.push({
	ID = "actives.legend_unarmed_lunge",
	Script = "scripts/skills/actives/legend_unarmed_lunge_skill",
	Const = "LegendUnarmedLunge",
	Name = "Jump Attack",
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

::Legends.Active.WakeAllyAoe <- null;
activesDefs.push({
	ID = "actives.wake_ally_aoe",
	Script = "scripts/skills/actives/legend_wake_ally_aoe_skill",
	Const = "WakeAllyAoe",
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

::Legends.Actives.addActiveDefObjects(activesDefs);
