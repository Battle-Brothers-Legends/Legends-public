if (!("Actives" in ::Legends)) {
	::Legends.Actives <- {};
}

if (!("Active" in ::Legends)) {
	::Legends.Active <- {};
}

::Legends.Actives.createActiveDef <- function (_def) {
	::Legends.Active[_def.Const] <- null;
	local snakeCase = ::Legends.DefsHelpers.convertToSnakeCase(_def.Const);
	if (!("ID" in _def)) {
		_def.ID <- "actives." + snakeCase;
	}

	if (!("Script" in _def)) {
		_def.Script <- "scripts/skills/actives/" + snakeCase + "_skill";
	}

	if (!("Name" in _def)) {
		_def.Name <- ::Legends.DefsHelpers.convertToDisplayName(_def.Const);
	}

	if (!("Icon" in _def)) {
		_def.Icon <- "skills/" + snakeCase + ".png";
	}

	if (!("IconDisabled" in _def)) {
		_def.IconDisabled <- "skills/" + snakeCase + "_bw.png";
	}

	if (!("Overlay" in _def)) {
		_def.Overlay <- "active_" + snakeCase;
	}

	return _def;
};

::Legends.Actives.ActiveDefObjects <- [];

::Legends.Actives.addActiveDefObjects <- function (_activeDefObjects) {
	local size = ::Legends.Actives.ActiveDefObjects.len();
	local count = 0;
	foreach (constName, def in _activeDefObjects) {
		def.Const <- constName;
		::Legends.Actives.ActiveDefObjects.push(::Legends.Actives.createActiveDef(def));
		local i = size + count;
		if (def.Const in ::Legends.Active) {
			::Legends.Active[def.Const] = size + i;
		} else {
			::Legends.Active[def.Const] <- size + i;
		}
		count++;
	}
}

local activesDefs = {
	Adrenaline = {
		Icon = "ui/perks/perk_37_active.png",
		IconDisabled = "ui/perks/perk_37_active_sw.png",
		Overlay = "perk_37_active"
	},
	AimedShot = {
		Script = "scripts/skills/actives/aimed_shot",
		Icon = "skills/active_18.png",
		IconDisabled = "skills/active_18_sw.png",
		Overlay = "active_18"
	},
	AlpTeleport = {
		Name = "Fade",
		Icon = "",
		IconDisabled = "",
		Overlay = ""
	},
	Assault = {
		Icon = "skills/active_240.png",
		IconDisabled = "skills/active_240_sw.png",
		Overlay = "active_240"
	},
	BandageAlly = {
		Name = "Use Bandages"
		Icon = "skills/active_105.png",
		IconDisabled = "skills/active_105_sw.png",
		Overlay = "active_105"
	},
	BarbarianFury = {
		Icon = "ui/skills/active_175.png",
		IconDisabled = "ui/skills/active_175.png",
		Overlay = "active_175"
	},
	Bash = {
		Script = "scripts/skills/actives/bash",
		Icon = "skills/active_02.png",
		IconDisabled = "skills/active_02_sw.png",
		Overlay = "active_02"
	},
	Batter = {
		Icon = "skills/active_136.png",
		IconDisabled = "skills/active_136_sw.png",
		Overlay = "active_136"
	},
	BerserkerMushrooms = {
		Name = "Eat or Give Strange Mushrooms",
		Icon = "skills/active_98.png",
		IconDisabled = "skills/active_98_sw.png",
		Overlay = "active_98"
	},
	BreakAllyFree = {
		Name = "Free Ally",
		Icon = "skills/active_151.png",
		IconDisabled = "skills/active_151_sw.png",
		Overlay = "active_151"
	},
	BreakFree = {
		Icon = "skills/active_15.png",
		IconDisabled = "skills/active_15_sw.png",
		Overlay = "active_15"
	},
	Cascade = {
		Icon = "skills/active_125.png",
		IconDisabled = "skills/active_125_sw.png",
		Overlay = "active_125"
	},
	CenserCastigate = {
		Name = "Castigate",
		Icon = "skills/active_231.png",
		IconDisabled = "skills/active_231_sw.png",
		Overlay = "active_231"
	},
	CenserStrike = {
		Script = "scripts/skills/actives/censer_strike",
		Icon = "skills/active_228.png",
		IconDisabled = "skills/active_228_sw.png",
		Overlay = "active_228"
	},
	Charge = {
		Script = "scripts/skills/actives/charge",
		Icon = "skills/active_52.png",
		IconDisabled = "skills/active_52_sw.png",
		Overlay = "active_52"
	},
	Charm = {
		Icon = "skills/active_120.png",
		IconDisabled = "skills/active_120.png",
		Overlay = "active_120"
	},
	Chop = {
		Script = "scripts/skills/actives/chop",
		Icon = "skills/active_25.png",
		IconDisabled = "skills/active_25_sw.png",
		Overlay = "active_25"
	},
	Cleave = {
		Script = "scripts/skills/actives/cleave",
		Icon = "skills/active_19.png",
		IconDisabled = "skills/active_19_sw.png",
		Overlay = "active_19"
	},
	CoatWithPoison = {
		Name = "Use Poison",
		Icon = "skills/active_95.png",
		IconDisabled = "skills/active_95_sw.png",
		Overlay = "active_95"
	},
	CoatWithSpiderPoison = {
		Name = "Use Poisoned Oil",
		Icon = "skills/active_139.png",
		IconDisabled = "skills/active_139_sw.png",
		Overlay = "active_139"
	},
	CorpseExplosion = {
		Icon = "skills/active_234.png",
		IconDisabled = "skills/active_234.png",
		Overlay = "active_234"
	},
	CorpseHurl = {
		ID = "actives.corpse_hurl_skill"
		Icon = "skills/active_233.png",
		IconDisabled = "skills/active_233.png",
		Overlay = "active_233"
	},
	CrackTheWhip = {
		Icon = "skills/active_162.png",
		IconDisabled = "skills/active_162.png",
		Overlay = "active_162"
	},
	Crumble = {
		Icon = "skills/active_205.png",
		IconDisabled = "skills/active_205_sw.png",
		Overlay = "active_205"
	},
	CrushArmor = {
		Script = "scripts/skills/actives/crush_armor",
		Name = "Destroy Armor",
		Icon = "skills/active_36.png",
		IconDisabled = "skills/active_36_sw.png",
		Overlay = "active_36"
	},
	Cudgel = {
		Icon = "skills/active_133.png",
		IconDisabled = "skills/active_133_sw.png",
		Overlay = "active_133"
	},
	Darkflight = {
		Script = "scripts/skills/actives/darkflight",
		Overlay = "active_28"
	},
	Deathblow = {
		Icon = "skills/active_199.png",
		IconDisabled = "skills/active_199_sw.png",
		Overlay = "active_199"
	},
	Debilitate = {
		// vanilla implementation - activate and next strike debilitates / shelved
		Script = "scripts/skills/actives/debilitate",
		Icon = "ui/perks/perk_34_active.png",
		IconDisabled = "ui/perks/perk_34_active_sw.png",
		Overlay = "perk_34_active"
	},
	Decapitate = {
		Script = "scripts/skills/actives/decapitate",
		Icon = "skills/active_34.png",
		IconDisabled = "skills/active_34_sw.png",
		Overlay = "active_34"
	},
	DemolishArmor = {
		Icon = "skills/active_137.png",
		IconDisabled = "skills/active_137_sw.png",
		Overlay = "active_137"
	},
	Disarm = {
		Icon = "skills/active_170.png",
		IconDisabled = "skills/active_170_sw.png",
		Overlay = "active_170"
	},
	DrinkAntidote = {
		Name = "Drink or Give Antidote",
		Icon = "skills/active_96.png",
		IconDisabled = "skills/active_96_sw.png",
		Overlay = "active_96"
	},
	DrumsOfWar = {
		Icon = "skills/active_163.png",
		IconDisabled = "skills/active_163.png",
		Overlay = "active_163"
	},
	EstocStab = {
		Name = "Stab",
		Icon = "skills/active_236.png",
		IconDisabled = "skills/active_236_sw.png",
		Overlay = "active_236"
	},
	Execute = {
		Icon = "skills/active_239.png",
		IconDisabled = "skills/active_239_sw.png",
		Overlay = "active_239"
	},
	ExeSwordDecapitate = {
		ID = "actives.exesword_decapitate",
		Script = "scripts/skills/actives/exesword_decapitate",
		Name = "Decapitate",
		Icon = "skills/active_34.png",
		IconDisabled = "skills/active_34_sw.png",
		Overlay = "active_34"
	},
	Explode = {
		Icon = "skills/active_221.png",
		IconDisabled = "skills/active_221.png",
		Overlay = "active_221"
	},
	FakeDrinkNightVision = {
		Name = "Drink Night Owl Elixir",
		Icon = "skills/active_142.png",
		IconDisabled = "skills/active_142_sw.png",
		Overlay = "active_142"
	},
	FireHandgonne = {
		Icon = "skills/active_203.png",
		IconDisabled = "skills/active_203_sw.png",
		Overlay = "active_203"
	},
	FireMortar = {
		Icon = "skills/active_211.png",
		IconDisabled = "skills/active_211.png",
		Overlay = "active_211"
	},
	FirstAid = {
		Icon = "ui/perks/perk_55_active.png",
		IconDisabled = "ui/perks/perk_55_active_sw.png",
		Overlay = "perk_55_active"
	},
	Flail = {
		Icon = "skills/active_39.png",
		IconDisabled = "skills/active_39_sw.png",
		Overlay = "active_39"
	},
	FleshPull = {
		Icon = "skills/active_235.png",
		IconDisabled = "skills/active_235.png",
		Overlay = "active_235"
	},
	FlingBack = {
		Icon = "skills/active_111.png",
		IconDisabled = "skills/active_111.png",
		Overlay = "active_111"
	},
	Flurry = {
		ID = "actives.flurry_skill",
		Icon = "skills/active_229.png",
		IconDisabled = "skills/active_229.png",
		Overlay = "active_229"
	},
	Footwork = {
		Script = "scripts/skills/actives/footwork",
		Icon = "ui/perks/perk_25_active.png",
		IconDisabled = "ui/perks/perk_25_active_sw.png",
		Overlay = "perk_25_active"
	},
	Gash = {
		Icon = "skills/active_189.png",
		IconDisabled = "skills/active_189_sw.png",
		Overlay = "active_189"
	},
	GeomancyOnce = {
		Name = "Geomancy",
		Icon = "skills/active_220.png",
		IconDisabled = "skills/active_220.png",
		Overlay = "active_220"
	},
	Geomancy = {
		Icon = "skills/active_220.png",
		IconDisabled = "skills/active_220.png",
		Overlay = "active_220"
	},
	GhastlyTouch = {
		Script = "scripts/skills/actives/ghastly_touch",
		Icon = "skills/active_42.png",
		IconDisabled = "skills/active_42.png",
		Overlay = "active_42"
	},
	GhostOverheadStrike = {
		Script = "scripts/skills/actives/ghost_overhead_strike",
		Name = "Overhead Strike",
		Icon = "skills/active_152.png",
		IconDisabled = "skills/active_152.png",
		Overlay = "active_152"
	},
	GhostSplit = {
		Name = "Split",
		Icon = "skills/active_153.png",
		IconDisabled = "skills/active_153.png",
		Overlay = "active_153"
	},
	GhostSwing = {
		Name = "Swing",
		Icon = "skills/active_154.png",
		IconDisabled = "skills/active_154_sw.png",
		Overlay = "active_154"
	},
	GhoulClaws = {
		Script = "scripts/skills/actives/ghoul_claws",
		Icon = "skills/active_21.png",
		IconDisabled = "skills/active_21_sw.png",
		Overlay = "active_21"
	},
	GoblinWhip = {
		Script = "scripts/skills/actives/goblin_whip",
		Name = "Whip",
		Icon = "skills/active_72.png",
		IconDisabled = "skills/active_72_sw.png",
		Overlay = "active_72"
	},
	GolemGrapple = {
		Name = "Grapple",
		Icon = "skills/active_232.png",
		IconDisabled = "skills/active_232.png",
		Overlay = "active_232"
	},
	Gore = {
		Icon = "skills/active_166.png",
		IconDisabled = "skills/active_166.png",
		Overlay = "active_166"
	},
	Gorge = {
		Icon = "skills/active_107.png",
		IconDisabled = "skills/active_107.png",
		Overlay = "active_107"
	},
	GrantNightVision = {
		Icon = "skills/active_156.png",
		IconDisabled = "skills/active_156.png",
		Overlay = "active_156"
	},
	GreaterFleshGolemAttack = {
		Name = "Clout",
		Icon = "skills/active_227.png",
		IconDisabled = "skills/active_227.png",
		Overlay = "active_227"
	},
	GrowShield = {
		Icon = "skills/active_121.png",
		IconDisabled = "skills/active_121.png",
		Overlay = "active_121"
	},
	GruesomeFeast = {
		Script = "scripts/skills/actives/gruesome_feast",
		Icon = "skills/active_40.png",
		IconDisabled = "skills/active_40.png",
		Overlay = "active_40",
	},
	Hail = {
		Icon = "skills/active_126.png",
		IconDisabled = "skills/active_126_sw.png",
		Overlay = "active_126"
	},
	Hammer = {
		Script = "scripts/skills/actives/hammer",
		Name = "Batter",
		Icon = "skills/active_35.png",
		IconDisabled = "skills/active_35_sw.png",
		Overlay = "active_35"
	},
	HandToHand = {
		Script = "scripts/skills/actives/hand_to_hand",
		Name = "Hand-to-Hand Attack",
		Icon = "skills/active_08.png",
		IconDisabled = "skills/active_08_sw.png",
		Overlay = "active_08"
	},
	Headbutt = {
		Icon = "skills/active_195.png",
		IconDisabled = "skills/active_195.png",
		Overlay = "active_195"
	},
	Hex = {
		Icon = "skills/active_119.png",
		IconDisabled = "skills/active_119.png",
		Overlay = "active_119"
	},
	Hook = {
		Script = "scripts/skills/actives/hook",
		Icon = "skills/active_31.png",
		IconDisabled = "skills/active_31_sw.png",
		Overlay = "active_31"
	},
	HorrificScream = {
		Script = "scripts/skills/actives/horrific_scream",
		Icon = "skills/active_41.png",
		IconDisabled = "skills/active_41.png",
		Overlay = "active_41"
	},
	Horror = {
		Icon = "skills/active_102.png",
		IconDisabled = "skills/active_102.png",
		Overlay = "active_102"
	},
	HyenaBite = {
		Icon = "skills/active_197.png",
		IconDisabled = "skills/active_197.png",
		Overlay = "active_197"
	},
	IgniteFirelance = {
		Name = "Ignite",
		Icon = "skills/active_202.png",
		IconDisabled = "skills/active_202_sw.png",
		Overlay = "active_202"
	},
	Impale = {
		Script = "scripts/skills/actives/impale",
		Icon = "skills/active_30.png",
		IconDisabled = "skills/active_30_sw.png",
		Overlay = "active_30"
	},
	Indomitable = {
		Script = "scripts/skills/actives/indomitable",
		Icon = "ui/perks/perk_30_active.png",
		IconDisabled = "ui/perks/perk_30_active_sw.png",
		Overlay = "perk_30_active"
	},
	Insects = {
		Name = "Swarm of Insects",
		Icon = "skills/active_69.png",
		IconDisabled = "skills/active_69_sw.png",
		Overlay = "active_69"
	},
	KnockBack = {
		Script = "scripts/skills/actives/knock_back",
		Icon = "skills/active_10.png",
		IconDisabled = "skills/active_10_sw.png",
		Overlay = "active_10"
	},
	KnockOut = {
		Script = "scripts/skills/actives/knock_out",
		Icon = "skills/active_32.png",
		IconDisabled = "skills/active_32_sw.png",
		Overlay = "active_32"
	},
	KnockOver = {
		Icon = "skills/active_206.png",
		IconDisabled = "skills/active_206_sw.png",
		Overlay = "active_206"
	},
	KrakenBite = {
		Name = "Bite",
		Icon = "skills/active_146.png",
		IconDisabled = "skills/active_146_sw.png",
		Overlay = "active_146"
	},
	KrakenDevour = {
		Name = "Devour",
		Icon = "skills/active_150.png",
		IconDisabled = "skills/active_150.png",
		Overlay = "active_150"
	},
	KrakenEnsnare = {
		Name = "Ensnare",
		Icon = "skills/active_147.png",
		IconDisabled = "skills/active_147_sw.png",
		Overlay = "active_147"
	},
	KrakenMoveEnsnared = {
		Name = "Drag",
		Icon = "skills/active_147.png",
		IconDisabled = "skills/active_147_sw.png",
		Overlay = "active_147"
	},
	KrakenMove = {
		Name = "Move Tentacle",
		Icon = "skills/active_149.png",
		IconDisabled = "skills/active_149_sw.png",
		Overlay = "active_149"
	},
	Lash = {
		Icon = "skills/active_91.png",
		IconDisabled = "skills/active_91_sw.png",
		Overlay = "active_91"
	},
	LesserFleshGolemAttack = {
		Name = "Smack",
		Icon = "skills/active_227.png",
		IconDisabled = "skills/active_227.png",
		Overlay = "active_227"
	},
	LightningStorm = {
		Name = "Lightning Strike",
		Icon = "skills/active_216.png",
		IconDisabled = "skills/active_216.png",
		Overlay = "active_216"
	},
	LineBreaker = {
		Script = "scripts/skills/actives/line_breaker",
		Icon = "skills/active_53.png",
		IconDisabled = "skills/active_53.png",
		Overlay = "active_53"
	},
	LoadMortar = {
		Icon = "skills/active_212.png",
		IconDisabled = "skills/active_212.png",
		Overlay = "active_212"
	},
	Lunge = {
		Icon = "skills/active_135.png",
		IconDisabled = "skills/active_135_sw.png",
		Overlay = "active_135"
	},
	MergeGolem = {
		Name = "Merge Living Sands",
		Icon = "skills/active_194.png",
		IconDisabled = "skills/active_194.png",
		Overlay = "active_194"
	},
	Miasma = {
		Icon = "skills/active_101.png",
		IconDisabled = "skills/active_101.png",
		Overlay = "active_101"
	},
	MoveTail = {
		Icon = "skills/active_109.png",
		IconDisabled = "skills/active_109.png",
		Overlay = "active_109"
	},
	Nightmare = {
		Icon = "skills/active_117.png",
		IconDisabled = "skills/active_117.png",
		Overlay = "active_117"
	},
	OverheadStrike = {
		Script = "scripts/skills/actives/overhead_strike",
		Icon = "skills/active_20.png",
		IconDisabled = "skills/active_20_sw.png",
		Overlay = "active_20"
	},
	PerfectFocus = {
		Script = "scripts/skills/actives/perfect_focus",
		Icon = "ui/perks/perk_37_active.png",
		IconDisabled = "ui/perks/perk_37_active_sw.png",
		Overlay = "perk_37_active"
	},
	Perforate = {
		Icon = "skills/active_237.png",
		IconDisabled = "skills/active_237_sw.png",
		Overlay = "active_237"
	},
	PossessUndead = {
		Icon = "skills/active_99.png",
		IconDisabled = "skills/active_99.png",
		Overlay = "active_99"
	},
	Pound = {
		Script = "scripts/skills/actives/pound",
		Icon = "skills/active_50.png",
		IconDisabled = "skills/active_50_sw.png",
		Overlay = "active_50"
	},
	Prong = {
		Icon = "skills/active_123.png",
		IconDisabled = "skills/active_123_sw.png",
		Overlay = "active_123"
	},
	Puncture = {
		Script = "scripts/skills/actives/puncture",
		Icon = "skills/active_27.png",
		IconDisabled = "skills/active_27_sw.png",
		Overlay = "active_27"
	},
	QuickShot = {
		Script = "scripts/skills/actives/quick_shot",
		Icon = "skills/active_05.png",
		IconDisabled = "skills/active_05_sw.png",
		Overlay = "active_05"
	},
	RaiseAllUndead = {
		Name = "The Black Book",
		Icon = "skills/active_213.png",
		IconDisabled = "skills/active_213.png",
		Overlay = "active_213"
	},
	RaiseUndead = {
		Script = "scripts/skills/actives/raise_undead",
		Icon = "skills/raisedead2.png",
		IconDisabled = "skills/raisedead2_bw.png",
		Overlay = "active_26"
	},
	RallyTheTroops = {
		Script = "scripts/skills/actives/rally_the_troops",
		Name = "Rally",
		Icon = "ui/perks/perk_42_active.png",
		IconDisabled = "ui/perks/perk_42_active_sw.png",
		Overlay = "perk_42_active"
	},
	Reap = {
		Icon = "skills/active_100.png",
		IconDisabled = "skills/active_100_sw.png",
		Overlay = "active_100"
	},
	Recover = {
		Icon = "ui/perks/perk_54_active.png",
		IconDisabled = "ui/perks/perk_54_active_sw.png",
		Overlay = "perk_54_active"
	},
	ReleaseFalcon = {
		Icon = "skills/active_104.png",
		IconDisabled = "skills/active_104_sw.png",
		Overlay = "active_104"
	},
	ReloadBolt = {
		Script = "scripts/skills/actives/reload_bolt",
		Name = "Reload",
		Icon = "skills/active_16.png",
		IconDisabled = "skills/active_16_sw.png",
		Overlay = "active_16"
	},
	ReloadHandgonne = {
		Name = "Reload",
		Icon = "skills/active_204.png",
		IconDisabled = "skills/active_204_sw.png",
		Overlay = "active_204"
	},
	Repel = {
		Script = "scripts/skills/actives/repel",
		Icon = "skills/active_55.png",
		IconDisabled = "skills/active_55_sw.png",
		Overlay = "active_55"
	},
	ReturnFavor = {
		Script = "scripts/skills/actives/return_favor",
		Icon = "ui/perks/perk_31_active.png",
		IconDisabled = "ui/perks/perk_31_active_sw.png",
		Overlay = "perk_31_active"
	},
	Riposte = {
		Script = "scripts/skills/actives/riposte",
		Icon = "skills/active_33.png",
		IconDisabled = "skills/active_33_sw.png",
		Overlay = "active_33"
	},
	Root = {
		Icon = "skills/roots_square.png",
		IconDisabled = "skills/roots_square_bw.png"
		Overlay = "active_70"
	},
	Rotation = {
		Script = "scripts/skills/actives/rotation",
		Icon = "ui/perks/perk_11_active.png",
		IconDisabled = "ui/perks/perk_11_active_sw.png",
		Overlay = "perk_11_active"
	},
	RoundSwing = {
		Script = "scripts/skills/actives/round_swing",
		Icon = "skills/active_48.png",
		IconDisabled = "skills/active_48_sw.png",
		Overlay = "active_48"
	},
	Rupture = {
		Script = "scripts/skills/actives/rupture",
		Icon = "skills/active_80.png",
		IconDisabled = "skills/active_80_sw.png",
		Overlay = "active_80"
	},
	SerpentBite = {
		Icon = "skills/active_196.png",
		IconDisabled = "skills/active_196_sw.png",
		Overlay = "active_196"
	},
	SerpentHook = {
		Name = "Drag",
		Icon = "skills/active_192.png",
		IconDisabled = "skills/active_192_sw.png",
		Overlay = "active_192"
	},
	Shatter = {
		Icon = "skills/active_90.png",
		IconDisabled = "skills/active_90_sw.png",
		Overlay = "active_90"
	},
	Shieldwall = {
		Script = "scripts/skills/actives/shieldwall",
		Icon = "skills/active_15.png",
		IconDisabled = "skills/active_15_sw.png",
		Overlay = "active_15"
	},
	ShootBolt = {
		Script = "scripts/skills/actives/shoot_bolt",
		Icon = "skills/active_17.png",
		IconDisabled = "skills/active_17_sw.png",
		Overlay = "active_17"
	},
	ShootStake = {
		Script = "scripts/skills/actives/shoot_stake",
		Name = "Shoot Heavy Bolt",
		Icon = "skills/active_81.png",
		IconDisabled = "skills/active_81_sw.png",
		Overlay = "active_81"
	},
	Skewer = {
		Icon = "skills/active_238.png",
		IconDisabled = "skills/active_238_sw.png",
		Overlay = "active_238"
	},
	Slash = {
		Script = "scripts/skills/actives/slash",
		Icon = "skills/active_01.png",
		IconDisabled = "skills/active_01_sw.png",
		Overlay = "active_01"
	},
	SlashLightning = {
		Script = "scripts/skills/actives/slash_lightning",
		Name = "Lightbringer",
		Icon = "skills/active_155.png",
		IconDisabled = "skills/active_155_sw.png",
		Overlay = "active_155"
	},
	Sleep = {
		Icon = "skills/active_116.png",
		IconDisabled = "skills/active_116.png",
		Overlay = "active_116"
	},
	SlingStone = {
		Icon = "skills/active_12.png",
		IconDisabled = "skills/active_12_sw.png",
		Overlay = "active_12"
	},
	Smite = {
		Icon = "skills/active_89.png",
		IconDisabled = "skills/active_89_sw.png",
		Overlay = "active_89"
	},
	Spearwall = {
		Script = "scripts/skills/actives/spearwall"
		Icon = "skills/active_23.png",
		IconDisabled = "skills/active_23_sw.png",
		Overlay = "active_23"
	},
	SpiderBite = {
		Name = "Webknecht Bite",
		Icon = "skills/active_115.png",
		IconDisabled = "skills/active_115_sw.png",
		Overlay = "active_115"
	},
	Spike = {
		ID = "actives.spike_skill",
		Icon = "skills/active_230.png",
		IconDisabled = "skills/active_230.png",
		Overlay = "active_230"
	},
	Split = {
		Script = "scripts/skills/actives/split",
		Icon = "skills/active_07.png",
		IconDisabled = "skills/active_07_sw.png",
		Overlay = "active_07"
	},
	SplitAxe = {
		Script = "scripts/skills/actives/split_axe",
		Name = "Split",
		Icon = "skills/active_169.png",
		IconDisabled = "skills/active_169_sw.png",
		Overlay = "active_169"
	},
	SplitMan = {
		Script = "scripts/skills/actives/split_man",
		Icon = "skills/active_09.png",
		IconDisabled = "skills/active_09_sw.png",
		Overlay = "active_09"
	},
	SplitShield = {
		Script = "scripts/skills/actives/split_shield",
		Icon = "skills/active_09.png",
		IconDisabled = "skills/active_09_sw.png",
		Overlay = "active_09"
	},
	Stab = {
		Script = "scripts/skills/actives/stab",
		Icon = "skills/active_03.png",
		IconDisabled = "skills/active_03_sw.png",
		Overlay = "active_03"
	},
	Stealth = {
		Icon = "skills/active_15.png",
		IconDisabled = "skills/active_15_sw.png",
		Overlay = "active_15"
	},
	StrikeDown = {
		Icon = "skills/active_134.png",
		IconDisabled = "skills/active_134_sw.png",
		Overlay = "active_134"
	},
	Strike = {
		Icon = "skills/active_66.png",
		IconDisabled = "skills/active_66_sw.png",
		Overlay = "active_66"
	},
	SummonFlyingSkulls = {
		ID = "actives.flying_skulls",
		Name = "Raise Screaming Skulls",
		Icon = "skills/active_219.png",
		IconDisabled = "skills/active_219.png",
		Overlay = "active_219"
	},
	SummonMirrorImage = {
		ID = "actives.mirror_image",
		Name = "Mirror Image",
		Icon = "skills/active_218.png",
		IconDisabled = "skills/active_218.png",
		Overlay = "active_218"
	},
	SwallowWhole = {
		Icon = "skills/active_103.png",
		IconDisabled = "skills/active_103.png",
		Overlay = "active_103"
	},
	Sweep = {
		Name = "Sweeping Strike",
		Icon = "skills/active_112.png",
		IconDisabled = "skills/active_112.png",
		Overlay = "active_112"
	},
	SweepZoc = {
		Name = "Sweeping Strike",
		Icon = "skills/active_112.png",
		IconDisabled = "skills/active_112.png",
		Overlay = "active_112"
	},
	Swing = {
		Script = "scripts/skills/actives/swing",
		Icon = "skills/active_06.png",
		IconDisabled = "skills/active_06_sw.png",
		Overlay = "active_06"
	},
	TailSlamBig = {
		Name = "Tail Slam",
		Icon = "skills/active_108.png",
		IconDisabled = "skills/active_108.png",
		Overlay = "active_108"
	},
	TailSlam = {
		Icon = "skills/active_108.png",
		IconDisabled = "skills/active_108.png",
		Overlay = "active_108"
	},
	TailSlamSplit = {
		Name = "Tail Slam",
		Icon = "skills/active_108.png",
		IconDisabled = "skills/active_108.png",
		Overlay = "active_108"
	},
	TailSlamZoc = {
		Name = "Tail Slam",
		Icon = "skills/active_108.png",
		IconDisabled = "skills/active_108.png",
		Overlay = "active_108"
	},
	Taunt = {
		Script = "scripts/skills/actives/taunt",
		Icon = "ui/perks/perk_38_active.png",
		IconDisabled = "ui/perks/perk_38_active_sw.png",
		Overlay = "perk_38_active"
	},
	Teleport = {
		Name = "Spirit Walk",
		Icon = "skills/active_167.png",
		IconDisabled = "skills/active_167.png",
		Overlay = "active_167"
	},
	Thresh = {
		Script = "scripts/skills/actives/thresh",
		Icon = "skills/active_46.png",
		IconDisabled = "skills/active_46_sw.png",
		Overlay = "active_46"
	},
	ThrowAcidFlask = {
		Script = "scripts/skills/actives/throw_acid_flask",
		Icon = "skills/active_106.png",
		IconDisabled = "skills/active_106_sw.png",
		Overlay = "active_106"
	},
	ThrowAxe = {
		Script = "scripts/skills/actives/throw_axe",
		Icon = "skills/active_87.png",
		IconDisabled = "skills/active_87_sw.png",
		Overlay = "active_87"
	},
	ThrowBalls = {
		Script = "scripts/skills/actives/throw_balls",
		Name = "Throw Bola",
		Icon = "skills/active_82.png",
		IconDisabled = "skills/active_82_sw.png",
		Overlay = "active_82"
	},
	ThrowDazeBomb = {
		Name = "Throw Flash Pot",
		Icon = "skills/active_207.png",
		IconDisabled = "skills/active_207_sw.png",
		Overlay = "active_207"
	},
	ThrowDirt = {
		Icon = "skills/active_215.png",
		IconDisabled = "skills/active_215.png",
		Overlay = "active_215"
	},
	ThrowFireBomb = {
		Name = "Throw Fire Pot",
		Icon = "skills/active_209.png",
		IconDisabled = "skills/active_209_sw.png",
		Overlay = "active_209"
	},
	ThrowGolem = {
		Name = "Throw Living Sand",
		Icon = "skills/active_193.png",
		IconDisabled = "skills/active_193.png",
		Overlay = "active_193"
	},
	ThrowHolyWater = {
		Script = "scripts/skills/actives/throw_holy_water",
		Name = "Throw Blessed Water",
		Icon = "skills/active_97.png",
		IconDisabled = "skills/active_97_sw.png",
		Overlay = "active_97"
	},
	ThrowJavelin = {
		Script = "scripts/skills/actives/throw_javelin",
		Icon = "skills/active_43.png",
		IconDisabled = "skills/active_43_sw.png",
		Overlay = "active_43"
	},
	ThrowNet = {
		Script = "scripts/skills/actives/throw_net",
		Icon = "skills/active_73.png",
		IconDisabled = "skills/active_73_sw.png",
		Overlay = "active_73"
	},
	ThrowSmokeBomb = {
		Name = "Throw Smoke Pot",
		Icon = "skills/active_208.png",
		IconDisabled = "skills/active_208_sw.png",
		Overlay = "active_208"
	},
	ThrowSpear = {
		Icon = "skills/active_138.png",
		IconDisabled = "skills/active_138_sw.png",
		Overlay = "active_138"
	},
	Thrust = {
		Script = "scripts/skills/actives/thrust",
		Icon = "skills/active_04.png",
		IconDisabled = "skills/active_04_sw.png",
		Overlay = "active_04"
	},
	UnleashWardog = {
		Script = "scripts/skills/actives/unleash_wardog",
		Icon = "skills/active_83.png",
		IconDisabled = "skills/active_83_sw.png",
		Overlay = "active_83"
	},
	UnleashWolf = {
		Script = "scripts/skills/actives/unleash_wolf",
		Name = "Unleash Wardog",
		Icon = "skills/active_83.png",
		IconDisabled = "skills/active_83_sw.png",
		Overlay = "active_83"
	},
	UnstoppableCharge = {
		Icon = "skills/active_110.png",
		IconDisabled = "skills/active_110.png",
		Overlay = "active_110"
	},
	Uproot = {
		Icon = "skills/active_122.png",
		IconDisabled = "skills/active_122.png",
		Overlay = "active_122"
	},
	UprootSmall = {
		Name = "Uproot",
		Icon = "skills/active_122.png",
		IconDisabled = "skills/active_122.png",
		Overlay = "active_122"
	},
	UprootSmallZoc = {
		Name = "Uproot",
		Icon = "skills/active_122.png",
		IconDisabled = "skills/active_122.png",
		Overlay = "active_122"
	},
	UprootZoc = {
		Name = "Uproot",
		Icon = "skills/active_122.png",
		IconDisabled = "skills/active_122.png",
		Overlay = "active_122"
	},
	VoiceOfDavkul = {
		Icon = "skills/active_176.png",
		IconDisabled = "skills/active_176_sw.png",
		Overlay = "active_176"
	},
	WakeAlly = {
		Icon = "skills/active_118.png",
		IconDisabled = "skills/active_118_sw.png",
		Overlay = "active_118"
	},
	Warcry = {
		Script = "scripts/skills/actives/warcry",
		Icon = "skills/active_41.png",
		IconDisabled = "skills/active_41.png",
		Overlay = "active_49"
	},
	WardogBite = {
		Script = "scripts/skills/actives/wardog_bite",
		Name = "Bite",
		Icon = "skills/active_84.png",
		IconDisabled = "skills/active_84_sw.png",
		Overlay = "active_84"
	},
	WarhoundBite = {
		Script = "scripts/skills/actives/warhound_bite",
		Name = "Bite",
		Icon = "skills/active_164.png",
		IconDisabled = "skills/active_164_sw.png",
		Overlay = "active_164"
	},
	Web = {
		Name = "Weave Web",
		Icon = "skills/active_114.png",
		IconDisabled = "skills/active_114_sw.png",
		Overlay = "active_114"
	},
	WerewolfBite = {
		Script = "scripts/skills/actives/werewolf_bite",
		Name = "Direwolf Bite",
		Icon = "skills/active_71.png",
		IconDisabled = "skills/active_71_sw.png",
		Overlay = "active_71"
	},
	Whip = {
		Icon = "skills/active_161.png",
		IconDisabled = "skills/active_161_sw.png",
		Overlay = "active_161"
	},
	WhipSlave = {
		Name = "Crack the Whip",
		Icon = "skills/active_214.png",
		IconDisabled = "skills/active_214_sw.png",
		Overlay = "active_214"
	},
	Wither = {
		Icon = "skills/active_217.png",
		IconDisabled = "skills/active_217_sw.png",
	},
	WolfBite = {
		Script = "scripts/skills/actives/wolf_bite",
		Name = "Bite",
		Icon = "skills/active_71.png",
		IconDisabled = "skills/active_71_sw.png",
		Overlay = "active_71"
	},
	ZombieBite = {
		Script = "scripts/skills/actives/zombie_bite",
		Name = "Bite",
		Icon = "skills/active_24.png",
		IconDisabled = "skills/active_24_sw.png",
		Overlay = "active_24"
	},
	LegendAlpSummonNightmare = {
		Name = "Conjure Nightmare",
		Icon = "skills/active_160.png",
		IconDisabled = "skills/active_160.png",
		Overlay = "active_160"
	},
	LegendAlpNightmareManifestation = {
		Name = "Conjure Nightmare",
		Icon = "skills/active_160.png",
		IconDisabled = "skills/active_160.png",
		Overlay = "active_160"
	},
	LegendAlpRealmOfShadow = {
		Name = "Shadow Mist",
		Icon = "skills/nightvision_square.png",
		IconDisabled = "skills/nightvision_square.png",
		Overlay = "bust_nightmare"
	},
	LegendApothecaryMushrooms = {
		Name = "Eat or Give Strange Mushrooms",
		Icon = "skills/active_98.png",
		IconDisabled = "skills/active_98_sw.png",
		Overlay = "active_98"
	},
	LegendBackstab = {
		Name = "Backstab",
		Icon = "skills/active_03.png",
		IconDisabled = "skills/active_03_sw.png",
		Overlay = "active_03"
	},
	LegendBandage = {
		Name = "Use Bandages",
		Icon = "skills/active_105.png",
		IconDisabled = "skills/active_105_sw.png",
		Overlay = "active_105"
	},
	LegendBansheeScream = {
		Name = "Banshee Scream",
		Icon = "skills/active_41.png",
		IconDisabled = "skills/active_41.png",
		Overlay = "active_41"
	},
	LegendBasiliskPeck = {
		Name = "Peck",
	},
	LegendBasiliskSentryFowleye = {
		Name = "Fowl Eye"
	},
	LegendBasiliskSentryInject = {
		Name = "Inject"
	},
	LegendBearBite = {
		Icon = "skills/active_71.png",
		IconDisabled = "skills/active_71_bw.png",
		Overlay = "active_71"
	},
	LegendBearClaws = {
		Icon = "skills/active_21.png",
		IconDisabled = "skills/active_21_bw.png",
		Overlay = "active_21"
	},
	LegendBreach = {
		Icon = "skills/active_01.png",
		IconDisabled = "skills/active_01_sw.png",
		Overlay = "active_01"
	},
	LegendBucklerBash = {},
	LegendCacophony = {
		Icon = "skills/legend_stupefy.png",
		IconDisabled = "skills/legend_stupefy_bw.png",
		Overlay = "legend_stupefy"
	},
	LegendCatBite = {},
	LegendCatapultBoulder = {
		Icon = "skills/active_12.png",
		IconDisabled = "skills/active_12_sw.png",
		Overlay = "active_12"
	},
	LegendChainLightning = {},
	LegendCheerOn = {},
	LegendChoke = {},
	LegendClimb = {},
	LegendCoatWithRedbackPoison = {
		Name = "Use Redback Poison"
	},
	LegendCommandLegionary = {},
	LegendCoordinatedVolleys = {},
	LegendDeathTouch = {},
	LegendDebilitate = {
		Icon = "ui/perks/perk_34_active.png",
		IconDisabled = "ui/perks/perk_34_active_sw.png",
		Overlay = "perk_34_active"
	},
	LegendDemonHoundBite = {
		Name = "Höllenhund Bite"
	},
	LegendDonkeyKick = {},
	LegendDoubleSwing = {},
	LegendDrainingTouch = {},
	LegendDrinkBeer = {
		// to be redone/deleted
		Name = "Drink or Give Beer",
		Icon = "skills/beer_square.png",
		IconDisabled = "skills/beer_square_bw.png",
		Overlay = "active_144"
	},
	LegendDrinkHeartwoodSap = {
		Name = "Drink or Give Heartwood Sap",
		Overlay = "active_144"
	},
	LegendDrinkHexeIchorPotion = {
		Name = "Drink or Give Hexe Ichor Potion",
		Overlay = "active_140"
	},
	LegendDrinkLiquor = {
		// to be redone/deleted
		Name = "Drink or Give Liquor",
		Icon = "skills/mead_square.png",
		IconDisabled = "skills/mead_square_bw.png",
		Overlay = "active_144"
	},
	LegendDrinkMead = {
		// to be redone/deleted
		Name = "Drink or Give Mead",
		Icon = "skills/mead_square.png",
		IconDisabled = "skills/mead_square_bw.png",
		Overlay = "active_144"
	},
	LegendDrinkSkinGhoulBlood = {
		Name = "Drink or Give Skin Ghoul Blood",
		Overlay = "active_144"
	},
	LegendDrinkStollwurmBlood = {
		Name = "Drink or Give Stollwurm Blood",
		Overlay = "active_144"
	},
	LegendDrinkWine = {
		Name = "Drink or Give Wine",
		Icon = "skills/wine_square.png",
		IconDisabled = "skills/wine_square_bw.png",
		Overlay = "active_144"
	},
	LegendEnragedHyenaBite = {
		Icon = "skills/active_197.png",
		IconDisabled = "skills/active_197_sw.png",
		Overlay = "active_197"
	},
	LegendEntice = {},
	LegendEvasion = {},
	LegendFalcon = {
		Name = "Unleash Falcon",
		Icon = "skills/active_104.png",
		IconDisabled = "skills/active_104_sw.png",
		Overlay = "active_104"
	},
	LegendFieldTriage = {
		// to be redone/removed
		Icon = "skills/triage_square.png",
		IconDisabled = "skills/triage_square_bw.png",
		Overlay = "active_41"
	},
	LegendFirefield = {},
	LegendFlagellate = {},
	LegendFlogging = {},
	LegendFlourish = {
		Icon = "ui/perks/perk_41_active.png",
		IconDisabled = "ui/perks/perk_41_active_bw.png",
		Overlay = "perk_41_active"
	},
	LegendFlowingSlash = {
		Icon = "skills/active_172.png",
		IconDisabled = "skills/active_172_sw.png",
		Overlay = "active_172"
	},
	LegendFullDraw = {},
	LegendGrapple = {},
	LegendGrowGreenwoodShield = {
		Icon = "skills/active_121.png",
		IconDisabled = "skills/active_121.png",
		Overlay = "active_121"
	},
	LegendGruesomeFeast = {},
	LegendGut = {
		Icon = "skills/active_237.png",
		IconDisabled = "skills/active_237_sw.png",
		Overlay = "active_237"
	},
	LegendHaftstrike = {},
	LegendHalberdSmite = {
		Name = "Smite"
	},
	LegendHalfsword = {},
	LegendHarvest = {
		Icon = "skills/active_06.png",
		IconDisabled = "skills/active_06_sw.png",
		Overlay = "active_06"
	},
	LegendHeartseeker = {},
	LegendHew = {
		Icon = "skills/active_210.png",
		IconDisabled = "skills/active_210_sw.png",
		Overlay = "active_210"
	},
	LegendHoldTheLine = {},
	LegendHolyFlame = {},
	LegendIncoming = {
		Name = "Incoming!"
	},
	LegendInfatuate = {
		Icon = "skills/active_120.png",
		IconDisabled = "skills/active_120.png",
		Overlay = "active_120"
	},
	LegendInspire = {
		Overlay = "perk_28_active"
	},
	LegendIntoTheFray = {
		Icon = "skills/unarmed_lunge_square.png", // needs icons
		IconDisabled = "skills/unarmed_lunge_square_bw.png",
		Overlay = "unarmed_lunge_square"
	},
	LegendKick = {},
	LegendLaunchAcidFlask = {
		Icon = "skills/active_106.png",
		IconDisabled = "skills/active_106_sw.png",
		Overlay = "active_106"
	},
	LegendLaunchDazeBomb = {
		Icon = "skills/active_207.png",
		IconDisabled = "skills/active_207_sw.png",
		Overlay = "active_207"
	},
	LegendLaunchFireBomb = {
		Icon = "skills/active_209.png",
		IconDisabled = "skills/active_209_sw.png",
		Overlay = "active_209"
	},
	LegendLaunchHolyWater = {
		Name = "Launch Blessed Water",
		Icon = "skills/active_97.png",
		IconDisabled = "skills/active_97_sw.png",
		Overlay = "active_97"
	},
	LegendLaunchSmokeBomb = {
		Icon = "skills/active_208.png",
		IconDisabled = "skills/active_208_sw.png",
		Overlay = "active_208"
	},
	LegendLeap = {},
	LegendLineThemUp = {
		Icon = "skills/active_203.png",
		IconDisabled = "skills/active_203_sw.png",
		Overlay = "active_203"
	},
	LegendMagicMissile = {},
	LegendMarkTarget = {},
	LegendMartialMarch = {},
	LegendMiasma = {},
	LegendNightmareTouch = {
		Name = "Terror",
		Icon = "skills/active_117.png",
		IconDisabled = "skills/active_117_sw.png",
		Overlay = "active_117"
	},
	LegendNightmareTouchZoc = {
		Name = "Terror",
		Icon = "skills/active_117.png",
		IconDisabled = "skills/active_117_sw.png",
		Overlay = "active_117"
	},
	LegendNightvision = {},
	LegendNinetailsDisarm = {
		Name = "Disarm"
	},
	LegendObliterate = {
		Icon = "skills/active_89.png",
		IconDisabled = "skills/active_89_sw.png",
		Overlay = "active_89"
	},
	LegendOmsAmphora = {
		Name = "Drink from Amphora"
	},
	LegendParalyze = {},
	LegendPiercingBolt = {},
	LegendPiercingJavelin = {
		Icon = "skills/legend_piercing_bolt.png",
		IconDisabled = "skills/legend_piercing_bolt.png",
		Overlay = "legend_piercing_bolt"
	},
	LegendPossessUndead = {},
	LegendPrayerOfFaith = {},
	LegendPrayerOfHope = {},
	LegendPryArmor = {},
	LegendPushForward = {},
	LegendQuickStep = {
		Icon = "skills/unarmed_lunge_square.png", // needs icons
		IconDisabled = "skills/unarmed_lunge_square_bw.png",
		Overlay = "unarmed_lunge_square"
	},
	LegendRedbackSpiderBite = {
		Icon = "skills/active_115.png",
		IconDisabled = "skills/active_115.png",
		Overlay = "active_115"
	},
	LegendRevolt = {},
	LegendRoot = {
		Overlay = "active_70"
	},
	LegendRunThrough = {
		Icon = "skills/active_55.png",
		IconDisabled = "skills/active_55_sw.png",
		Overlay = "active_55"
	},
	LegendRust = {},
	LegendSafeguard = {},
	LegendScry = {},
	LegendScryTrance = {
		Name = "Scry Area (Trance)",
		Icon = "skills/legend_scry.png",
		IconDisabled = "skills/legend_scry_bw.png",
		Overlay = "legend_scry"
	},
	LegendSecondWind = {
		Overlay = "perk_54_active"
	},
	LegendShootPreciseStone = {
		Name = "Precise Shot"
	},
	LegendShootStone = {
		Name = "Loose Stone" // weird
	},
	LegendSighthoundBite = {},
	LegendSlumber = {
		Icon = "skills/active_116.png",
		IconDisabled = "skills/active_116_bw.png",
		Overlay = "active_116"
	},
	LegendSkinGhoulClaws = {
		Icon = "skills/active_21.png",
		IconDisabled = "skills/active_21_sw.png",
		Overlay = "active_21"
	},
	LegendSkinGhoulSwallowWhole = {
		Name = "Swallow Whole",
		Icon = "skills/active_103.png",
		IconDisabled = "skills/active_103.png",
		Overlay = "active_103"
	},
	LegendSlingHeavyStone = {
		Icon = "skills/active_12.png",
		IconDisabled = "skills/active_12_sw.png",
		Overlay = "active_12"
	},
	LegendSongOfLife = {},
	LegendSpawnZombieHigh = {
		//to be remade
		Name = "Summon Heavy Zombie",
		Icon = "skills/remake_man.png",
		IconDisabled = "skills/remake_man_bw.png",
		Overlay = "remake_man"
	},
	LegendSpawnZombieLow = {
		//to be remade
		Name = "Summon Light Zombie",
		Icon = "skills/mold_carrion.png",
		IconDisabled = "skills/mold_carrion_bw.png",
		Overlay = "mold_carrion"
	},
	LegendSpawnZombieMed = {
		//to be remade
		Name = "Summon Medium Zombie",
		Icon = "skills/fashion_body.png",
		IconDisabled = "skills/fashion_body_bw.png",
		Overlay = "fashion_body"
	},
	LegendStollwurmMove = {
		Name = "Burrow",
		Icon = "skills/active_109.png",
		IconDisabled = "skills/active_109.png",
		Overlay = "active_109"
	},
	LegendStollwurmMoveTail = {
		Name = "Burrow Tail",
		Icon = "skills/active_109.png",
		IconDisabled = "skills/active_109.png",
		Overlay = "active_109"
	},
	LegendStrafingRun = {},
	LegendStupefy = {},
	LegendSummonFamiliar = {},
	LegendSummonStorm = {},
	LegendTackle = {},
	LegendThrowKnife = {
		Icon = "skills/legend_throw_knife.png",
		IconDisabled = "skills/legend_throw_knife_bw.png",
		Overlay = "legend_throw_knife"
	},
	LegendThrowBackupAxe = {
		Icon = "skills/active_87.png",
		IconDisabled = "skills/active_87_sw.png",
		Overlay = "active_87"
	},
	LegendThrowBackupSpear = {
		Icon = "skills/active_43.png",
		IconDisabled = "skills/active_43_sw.png",
		Overlay = "active_43"
	},
	LegendUnleashBear = {
		Overlay = "active_165"
	},
	LegendUnleashHound = {
		// perk summoning, to be remade?
		Name = "Summon Hound",
		Icon = "skills/active_165.png",
		IconDisabled = "skills/active_165_sw.png",
		Overlay = "active_165"
	},
	LegendUnleashSighthound = {},
	LegendUnleashWarbear = {
		Overlay = "active_165"
	},
	LegendUnleashWhiteWolf = {
		Overlay = "active_83"
	},
	LegendUnleashWolf = {
		// perk summoning, to be remade?
		Name = "Summon Wolf",
		Overlay = "active_165"
	},
	LegendValaWardenPaleTouch = {
		Name = "Pale Touch",
		Icon = "skills/active_42.png",
		IconDisabled = "skills/active_42.png",
		Overlay = "active_42"
	},
	LegendValaWardenWail = {
		Name = "Wail",
		Icon = "skills/active_41.png",
		IconDisabled = "skills/active_41.png",
		Overlay = "active_41"
	},
	LegendViolentDecomposition = {},
	LegendVolley = {},
	LegendWarChant = {},
	LegendWarforkDisarm = {},
	LegendWerewolfClaws = {
		Name = "Direwolf Claws",
		Icon = "skills/active_21.png",
		IconDisabled = "skills/active_21_bw.png",
		Overlay = "active_21"
	},
	LegendWerewolfHowl = {
		Name = "Howl",
		Icon = "skills/active_22.png",
		IconDisabled = "skills/active_22_sw.png",
		Overlay = "active_22"
	},
	LegendWhipDebilitate = {
		Name = "Debilitate",
		Icon = "ui/perks/perk_34_active.png",
		IconDisabled = "ui/perks/perk_34_active_sw.png",
		Overlay = "perk_34_active"
	},
	LegendWhiteWolfBite = {
		Icon = "skills/active_71.png",
		IconDisabled = "skills/active_71.png",
		Overlay = "active_71"
	},
	LegendWhiteWolfHowl = {
		Icon = "skills/active_22.png",
		IconDisabled = "skills/active_22_sw.png",
		Overlay = "active_22"
	},
	LegendWindUp = {
		Icon = "skills/active_10.png",
		IconDisabled = "skills/active_10_sw.png",
		Overlay = "mini_smackdown_circle"
	},
	// horses
	LegendHorseCharge = {},
	LegendHorseKick = {
		Icon = "skills/legend_donkey_kick.png",
		IconDisabled = "skills/legend_donkey_kick_bw.png",
		Overlay = "legend_donkey_kick"
	},
	LegendHorsePirouette = {
		Name = "Pirouette"
	}
};

::Legends.Actives.addActiveDefObjects(activesDefs);
