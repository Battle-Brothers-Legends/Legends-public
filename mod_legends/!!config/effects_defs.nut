if (!("Effects" in ::Legends)) {
	::Legends.Effects <- {};
}

if (!("Effect" in ::Legends)) {
	::Legends.Effect <- {};
}

::Legends.Effects.createEffectDef <- function (_def, _type) {
	::Legends.Effect[_def.Const] <- null;
	local snakeCase = ::Legends.DefsHelpers.convertToSnakeCase(_def.Const);
	if (!("ID" in _def)) {
		_def.ID <- (_type == "effects_world" ? "effects" : _type) + "." + snakeCase;
	}

	if (!("Script" in _def)) {
		_def.Script <- "scripts/skills/" + _type + "/" + snakeCase + "_effect";
	}

	if (!("Name" in _def)) {
		_def.Name <- ::Legends.DefsHelpers.convertToDisplayName(_def.Const);
	}

	if (!("Icon" in _def)) {
		_def.Icon <- "skills/" + snakeCase + "_effect.png";
	}

	if (!("IconMini" in _def)) {
		_def.IconMini <- snakeCase + "_effect_mini";
	}

	if (!("Overlay" in _def)) {
		_def.Overlay <- snakeCase + "_effect";
	}

	return _def;
};

::Legends.Effects.EffectDefObjects <- [];

::Legends.Effects.addEffectDefObjects <- function (_effectDefObjects, _type = "effects") {
	local size = ::Legends.Effects.EffectDefObjects.len();
	local i = 0;
	foreach (constName, def in _effectDefObjects) {
		def.Const <- constName;
		::Legends.Effects.EffectDefObjects.push(::Legends.Effects.createEffectDef(def, _type));
		if (def.Const in ::Legends.Effect) {
			::Legends.Effect[def.Const] = size + i;
		} else {
			::Legends.Effect[def.Const] <- size + i;
		}
		i++;
	}
}

local effectDefs = {
	// be advised that only a few hooks are using onCreate
	Acid = {
		Name = "Sprayed with Acid",
		Icon = "skills/status_effect_78.png",
		IconMini = "status_effect_78_mini",
		Overlay = ""
	},
	Adrenaline = {
		Icon = "ui/perks/perk_37.png",
		IconMini = "perk_37_mini",
		Overlay = "perk_37"
	},
	AlpPotion = {
		Name = "Enhanced Eye Rods",
		Icon = "skills/status_effect_147.png",
		IconMini = "status_effect_147_mini",
		Overlay = "status_effect_147"
	},
	AncientPriestPotion = {
		Name = "Synapse Blockage",
		Icon = "skills/status_effect_134.png",
		IconMini = "status_effect_134_mini",
		Overlay = "status_effect_134"
	},
	ApotheosisPotion = {
		Name = "Apotheosis"
		Icon = "skills/status_effect_158.png",
		IconMini = "",
		Overlay = "status_effect_158"
	},
	BattleStandard = {
		Name = "For the company!",
		Icon = "ui/perks/perk_28.png",
		IconMini = "perk_28_mini",
		Overlay = ""
	},
	BerserkerMushrooms = {
		Name = "RAGE!!!",
		Icon = "skills/status_effect_67.png",
		IconMini = "status_effect_67_mini",
		Overlay = ""
	},
	BerserkerRage = {
		Name = "Rage",
		Icon = "skills/status_effect_34.png",
		IconMini = "status_effect_34_mini",
		Overlay = "status_effect_34"
	},
	Bleeding = {
		Icon = "skills/status_effect_01.png",
		IconMini = "status_effect_01_mini",
		Overlay = "status_effect_01"
	},
	Captain = {
		Name = "Inspired by a nearby Leader",
		Icon = "ui/perks/perk_26.png",
		IconMini = "perk_26_mini",
		Overlay = ""
	},
	CatPotion = {
		Name = "Heightened Reflexes",
		Icon = "skills/status_effect_93.png",
		IconMini = "status_effect_93_mini",
		Overlay = "status_effect_93"
	},
	Charmed = {
		Icon = "skills/status_effect_85.png",
		IconMini = "status_effect_85_mini",
		Overlay = "status_effect_85"
	},
	Chilled = {
		Icon = "skills/status_effect_109.png",
		IconMini = "status_effect_109_mini",
		Overlay = "status_effect_109"
	},
	Dazed = {
		Icon = "skills/status_effect_87.png",
		IconMini = "status_effect_87_mini",
		Overlay = "status_effect_87"
	},
	DebilitatingAttack = {
		Icon = "ui/perks/perk_34.png",
		IconMini = "perk_34_mini",
		Overlay = "perk_34"
	},
	Debilitated = {
		Icon = "ui/perks/perk_34.png",
		IconMini = "perk_34_mini",
		Overlay = "perk_34"
	},
	DirewolfPotion = {
		Name = "Elasticized Sinew",
		Icon = "skills/status_effect_139.png",
		IconMini = "",
		Overlay = "status_effect_139"
	},
	Disarmed = {
		Icon = "skills/status_effect_111.png",
		IconMini = "status_effect_111_mini",
		Overlay = "status_effect_111"
	},
	Distracted = {
		Icon = "skills/status_effect_122.png",
		IconMini = "status_effect_122_mini",
		Overlay = "status_effect_122"
	},
	Dodge = {
		Icon = "ui/perks/perk_01.png",
		IconMini = "perk_01_mini",
		Overlay = ""
	},
	DoubleStrike = {
		Name = "Flux!",
		Overlay = ""
	},
	DrumsOfWar = {
		Icon = "skills/status_effect_105.png",
		IconMini = "",
		Overlay = "status_effect_105"
	},
	FakeCharmed = {
		Name = "Charmed",
		Icon = "skills/status_effect_85.png",
		IconMini = "status_effect_85_mini",
		Overlay = "status_effect_85"
	},
	FallenHeroPotion = {
		Name = "Reactive Muscle Tissue",
		Icon = "skills/status_effect_136.png",
		IconMini = "",
		Overlay = "status_effect_136"
	},
	GeistPotion = {
		Name = "Kinetic Coating",
		Icon = "skills/status_effect_137.png",
		IconMini = "",
		Overlay = "status_effect_137"
	},
	GoblinGruntPotion = {
		Name = "Reactive Leg Muscles",
		Icon = "skills/status_effect_124.png",
		IconMini = "",
		Overlay = "status_effect_124"
	},
	GoblinOverseerPotion = {
		Name = "Mutated Cornea",
		Icon = "skills/status_effect_126.png",
		IconMini = "",
		Overlay = "status_effect_126"
	},
	GoblinPoison = {
		Name = "Poisoned (goblin)",
		Icon = "skills/status_effect_54.png",
		IconMini = "status_effect_54_mini",
		Overlay = ""
	},
	GoblinShamanPotion = {
		Name = "Hyperactive Sweat Glands",
		Icon = "skills/status_effect_125.png",
		IconMini = "status_effect_125_mini",
		Overlay = "status_effect_125"
	},
	GrandDivinerPotion = {
		Name = "Cursed Sight",
		Icon = "skills/status_effect_152.png",
		IconMini = "",
		Overlay = "status_effect_152"
	},
	GreaterFleshGolemPotion = {
		Name = "Mutated Glands",
		Icon = "skills/status_effect_156.png",
		IconMini = "",
		Overlay = "status_effect_156"
	},
	GruesomeFeast = {
		Name = "Feasted",
		Icon = "skills/status_effect_10.png",
		IconMini = "status_effect_10_mini",
		Overlay = ""
	},
	HexMaster = {
		Name = "Protected by a Hex",
		Icon = "skills/status_effect_84.png",
		IconMini = "status_effect_84_mini",
		Overlay = ""
	},
	HexSlave = {
		Name = "Hex",
		Icon = "skills/status_effect_84.png",
		IconMini = "status_effect_84_mini",
		Overlay = ""
	},
	HexePotion = {
		Name = "Sympathetic Call",
		Icon = "skills/status_effect_148.png",
		IconMini = "status_effect_148_mini",
		Overlay = "status_effect_148"
	},
	HolyWater = {
		Name = "Sprayed with Blessed Water",
		Icon = "skills/status_effect_68.png",
		IconMini = "status_effect_68_mini",
		Overlay = "status_effect_68"
	},
	HonorGuardPotion = {
		Name = "Subdermal Stitching",
		Icon = "skills/status_effect_132.png",
		IconMini = "status_effect_132_mini",
		Overlay = "status_effect_132"
	},
	Horrified = {
		Icon = "skills/status_effect_70.png",
		IconMini = "status_effect_70_mini",
		Overlay = "status_effect_70"
	},
	HyenaPotion = {
		Name = "Subdermal Clotting",
		Icon = "skills/status_effect_143.png",
		IconMini = "",
		Overlay = "status_effect_143"
	},
	ImmuneToPoison = {
		Script = "scripts/skills/effects/antidote_effect",
		Icon = "skills/status_effect_118.png",
		IconMini = "status_effect_118_mini",
		Overlay = "status_effect_118"
	},
	IfritPotion = {
		Name = "Stone Skin",
		Icon = "skills/status_effect_141.png",
		IconMini = "status_effect_141_mini",
		Overlay = "status_effect_141"
	},
	IjirokPotion = {
		Name = "Auspice of the Mad God",
		Icon = "skills/status_effect_150.png",
		IconMini = "status_effect_150_mini",
		Overlay = "status_effect_150"
	},
	Indomitable = {
		Icon = "ui/perks/perk_30.png",
		IconMini = "perk_30_mini",
		Overlay = "perk_30"
	},
	InsectSwarm = {
		Name = "Swarm of Insects",
		Icon = "skills/status_effect_57.png",
		IconMini = "status_effect_57_mini",
		Overlay = "status_effect_57"
	},
	IronWill = {
		Icon = "skills/status_effect_92.png",
		IconMini = "status_effect_92_mini",
		Overlay = "status_effect_92"
	},
	KillingFrenzy = {
		Name = "Killing Frenzy!",
		Icon = "ui/perks/perk_36.png",
		IconMini = "perk_36_mini",
		Overlay = "perk_36"
	},
	KrakenEnsnare = {
		Name = "Entangled",
		Icon = "skills/status_effect_95.png",
		IconMini = "status_effect_95_mini",
		Overlay = "status_effect_95"
	},
	KrakenPotion = {
		Name = "Ascendant Flesh",
		Icon = "skills/status_effect_154.png",
		IconMini = "",
		Overlay = "status_effect_154"
	},
	LesserFleshGolemPotion = {
		Name = "Bizarre Steroid",
		Icon = "skills/status_effect_155.png",
		IconMini = "",
		Overlay = "status_effect_155"
	},
	LindwurmAcid = {
		Name = "Sprayed with Acid",
		Icon = "skills/status_effect_78.png",
		IconMini = "status_effect_78_mini",
		Overlay = ""
	},
	LindwurmPotion = {
		Name = "Acidic blood",
		Icon = "skills/status_effect_140.png",
		IconMini = "status_effect_140_mini",
		Overlay = "status_effect_140"
	},
	LionheartPotion = {
		Name = "Enhanced Bravery",
		Icon = "skills/status_effect_90.png",
		IconMini = "status_effect_90_mini",
		Overlay = "status_effect_90"
	}
	LoneWolf = {
		Icon = "ui/perks/perk_61.png",
		IconMini = "perk_61_mini",
		Overlay = ""
	},
	LorekeeperPotion = {
		Name = "Lorekeeper\'s Rib Bone",
		Icon = "skills/status_effect_151.png",
		IconMini = "status_effect_151_mini",
		Overlay = "status_effect_151"
	},
	NachzehrerPotion = {
		Name = "Hyperactive Tissue Growth",
		Icon = "skills/status_effect_149.png",
		IconMini = "",
		Overlay = "status_effect_149"
	},
	NecromancerPotion = {
		Name = "Visions",
		Icon = "skills/status_effect_138.png",
		IconMini = "",
		Overlay = "status_effect_138"
	},
	NecrosavantPotion = {
		Name = "Parasitic Blood",
		Icon = "skills/status_effect_133.png",
		IconMini = "status_effect_133_mini",
		Overlay = "status_effect_133"
	},
	Net = {
		Name = "Trapped in Net",
		Icon = "skills/status_effect_58.png",
		IconMini = "status_effect_58_mini",
		Overlay = "status_effect_58"
	},
	Nightmare = {
		Name = "Nightmares",
		Icon = "skills/status_effect_81.png",
		IconMini = "status_effect_81_mini",
		Overlay = "status_effect_81"
	},
	NightVision = {
		Icon = "skills/status_effect_98.png",
		IconMini = "status_effect_98_mini",
		Overlay = "status_effect_98"
	},
	NineLives = {
		Icon = "ui/perks/perk_07.png",
		IconMini = "", // why do we clear these?
		Overlay = ""
	},
	OrcBerserkerPotion = {
		Name = "Berserker Rage",
		Icon = "skills/status_effect_129.png",
		IconMini = "status_effect_129_mini",
		Overlay = "status_effect_129"
	},
	OrcWarlordPotion = {
		Name = "Font of Strength",
		Icon = "skills/status_effect_130.png",
		IconMini = "",
		Overlay = "status_effect_130"
	},
	OrcWarriorPotion = {
		Name = "Sensory Redundancy",
		Icon = "skills/status_effect_128.png",
		IconMini = "status_effect_128_mini",
		Overlay = "status_effect_128"
	},
	OrcYoungPotion = {
		Name = "Kinetic Blows",
		Icon = "skills/status_effect_127.png",
		IconMini = "",
		Overlay = "status_effect_127"
	},
	Overwhelmed = {
		Icon = "skills/status_effect_74.png",
		IconMini = "status_effect_74_mini",
		Overlay = "status_effect_74"
	},
	PoisonCoat = {
		Name = "Weapon Coated with Poison",
		Icon = "skills/status_effect_66.png",
		IconMini = "status_effect_66_mini",
		Overlay = ""
	},
	PossessedUndead = {
		Name = "Possessed",
		Icon = "skills/status_effect_69.png",
		IconMini = "status_effect_69_mini",
		Overlay = "status_effect_69"
	},
	PossessingUndead = {
		Icon = "skills/status_effect_69.png",
		IconMini = "status_effect_69_mini",
		Overlay = "status_effect_69"
	},
	RachegeistPotion = {
		Name = "Ghastly Aura",
		Icon = "skills/status_effect_153.png",
		IconMini = "status_effect_153_mini",
		Overlay = "status_effect_153"
	},
	Rallied = {
		Icon = "skills/status_effect_56.png",
		IconMini = "status_effect_56_mini",
		Overlay = ""
	},
	RecoveryPotion = {
		Name = "Enhanced Stamina",
		Icon = "skills/status_effect_89.png",
		IconMini = "status_effect_89_mini",
		Overlay = "status_effect_89"
	},
	Reforming = {
		Icon = "skills/status_effect_05.png",
		IconMini = "status_effect_05_mini",
		Overlay = "status_effect_05"
	},
	Riposte = {
		Name = "Riposting",
		Icon = "skills/status_effect_33.png",
		IconMini = "status_effect_33_mini",
		Overlay = "status_effect_33"
	},
	Rooted = {
		Name = "Trapped in Vines",
		Icon = "skills/status_effect_55.png",
		IconMini = "status_effect_55_mini",
		Overlay = "status_effect_55"
	},
	SchratPotion = {
		Name = "Flexile Ligaments",
		Icon = "skills/status_effect_146.png",
		IconMini = "status_effect_146_mini",
		Overlay = "status_effect_146"
	},
	SerpentEnsnare = {
		Name = "Entangled",
		Icon = "skills/status_effect_113.png",
		IconMini = "status_effect_113_mini",
		Overlay = "status_effect_113"
	},
	SerpentPotion = {
		Name = "Enhanced Opportunism",
		Icon = "skills/status_effect_142.png",
		IconMini = "",
		Overlay = "status_effect_142"
	},
	Shellshocked = {
		Icon = "skills/status_effect_119.png",
		IconMini = "status_effect_119_mini",
		Overlay = "status_effect_119"
	},
	Shieldwall = {
		Icon = "skills/status_effect_03.png",
		IconMini = "status_effect_03_mini",
		Overlay = "status_effect_03"
	},
	SkeletonWarriorPotion = {
		Name = "Locking Joints",
		Icon = "skills/status_effect_131.png",
		IconMini = "",
		Overlay = "status_effect_131"
	},
	Sleeping = {
		Icon = "skills/status_effect_82.png",
		IconMini = "status_effect_82_mini",
		Overlay = "status_effect_82"
	},
	Smoke = {
		Name = "Covered by Smoke",
		Icon = "skills/status_effect_117.png",
		IconMini = "status_effect_117_mini",
		Overlay = "status_effect_117"
	},
	Stealth = {
		Name = "Stealthed",
		Icon = "skills/status_effect_03.png",
		IconMini = "status_effect_03_mini",
		Overlay = "status_effect_03"
	},
	Spearwall = {
		Icon = "skills/status_effect_04.png",
		IconMini = "status_effect_04_mini",
		Overlay = "status_effect_04"
	},
	SpiderPoisonCoat = {
		Name = "Weapon Coated with Poison",
		Icon = "skills/status_effect_88.png",
		IconMini = "status_effect_88_mini",
		Overlay = ""
	},
	SpiderPoison = {
		Name = "Poisoned (spider)"
		Icon = "skills/status_effect_54.png",
		IconMini = "status_effect_54_mini",
		Overlay = ""
	},
	Staggered = {
		Icon = "skills/status_effect_65.png",
		IconMini = "status_effect_65_mini",
		Overlay = "" // why do we clear this?
	},
	Stunned = {
		Icon = "skills/status_effect_05.png",
		IconMini = "status_effect_05_mini",
		Overlay = "status_effect_05"
	},
	SwallowedWhole = {
		Name = "Devour",
		Icon = "skills/status_effect_72.png",
		IconMini = "status_effect_72_mini",
		Overlay = "status_effect_72"
	},
	Taunt = {
		Name = "Taunting", // nerfed pretty hard from vanilla?
		Icon = "ui/perks/perk_38.png",
		IconMini = "perk_38_mini",
		Overlay = ""
	},
	Taunted = {
		Icon = "ui/perks/perk_38.png",
		IconMini = "perk_38_mini",
		Overlay = "perk_38"
	},
	UnholdPotion = {
		Name = "Hyperactive Cell Growth",
		Icon = "skills/status_effect_145.png",
		IconMini = "",
		Overlay = "status_effect_145"
	},
	VoiceOfDavkul = {
		Icon = "skills/status_effect_112.png",
		IconMini = "status_effect_112_mini",
		Overlay = "status_effect_112"
	},
	Web = {
		Name = "Trapped in Web",
		Icon = "skills/status_effect_80.png",
		IconMini = "status_effect_80_mini",
		Overlay = "status_effect_80"
	},
	WebknechtPotion = {
		Name = "Mutated Circulatory System",
		Icon = "skills/status_effect_144.png",
		IconMini = "status_effect_144_mini",
		Overlay = "status_effect_144"
	},
	Whipped = {
		Icon = "skills/status_effect_121.png",
		IconMini = "status_effect_121_mini",
		Overlay = "status_effect_121"
	},
	WiedergangerPotion = {
		Name = "Subdermal Reactivity",
		Icon = "skills/status_effect_135.png",
		IconMini = "",
		Overlay = "status_effect_135"
	},
	Withered = {
		Icon = "skills/status_effect_123.png",
		IconMini = "status_effect_123_mini",
		Overlay = "status_effect_123"
	},
	LegendAlpRealmOfShadow = {
		Name = "Engulfed By Darkness",
		Icon = "skills/status_effect_81.png",
		IconMini = "status_effect_81_mini",
		Overlay = "status_effect_81"
	},
	LegendApothecaryMushrooms = {
		Name = "Purple Haze",
		Icon = "skills/status_effect_67.png",
		IconMini = "status_effect_67_mini",
		Overlay = ""
	},
	//LegendArmorTracking = {}, tbd, tracking all armor bonuses in one tooltip
	LegendBaffled = {},
	LegendBasiliskPoison = {
		Name = "Poisoned (basilisk)",
		Icon = "skills/status_effect_54.png",
		IconMini = "status_effect_54_mini",
		Overlay = ""
	},
	LegendBeerBuzz = {
		// to be remade?
		Name = "Buzzed",
		Icon = "skills/status_effect_92.png",
		IconMini = "status_effect_92_mini",
		Overlay = "status_effect_92"
	},
	LegendBerserkerRage = {
		Name = "Rage",
	},
	LegendBleedPrepared = {
		Name = "Prepared to Inflict Bleeding",
		Icon = "skills/bleed_circle.png",
		IconMini = "mini_bleed_circle",
		Overlay = ""
	},
	LegendBlooddrinker = {
		Icon = "",
		IconMini = "",
		Overlay = ""
	},
	LegendBonePlating = {},
	LegendBucklerDefense = {
		Icon = "ui/perks/perk_02.png",
		IconMini = "" //"perk_02_mini",
		Overlay = ""
	},
	LegendCheeredOn = {},
	LegendChoked = {},
	LegendCommanded = {},
	LegendCompromisedArmor = {},
	LegendConquerorPotion = {
		Name = "Thick Skin",
		Icon = "skills/status_effect_132.png",
		IconMini = "",
		Overlay = "status_effect_132"
	},
	LegendConsecrated = {},
	LegendConstrained = {
		// could use new icons, these ones are acid eating chain mail
		Icon = "skills/status_effect_78.png",
		MiniIcon = "",
		Overlay = "status_effect_78"
	},
	LegendCurseOfTheMummy = {},
	LegendDemonAlpPotion = {
		Name = "The Third Eye",
		Icon = "skills/status_effect_147.png",
		IconMini = "",
		Overlay = "status_effect_147"
	},
	LegendDemonHoundAura = {
		Name = "Sluggish",
		IconMini = "",
		Overlay = ""
	},
	LegendDemonHoundBite = {
		Name = "Höllenhund Curse"
	},
	LegendDemonHoundPotion = {
		Name = "Death Inducement",
		Icon = "skills/status_effect_137.png",
		IconMini = "",
		Overlay = "status_effect_137"
	},
	LegendDisintegrating = {
		Icon = "skills/status_effect_01.png",
		IconMini = "status_effect_01_mini",
		Overlay = "status_effect_01"
	},
	LegendBracingForImpact = {
		Overlay = ""
	},
	LegendBrothersInChains = {
		Icon = "ui/settlement_status/settlement_effect_40.png",
		IconMini = "",
		Overlay = ""
	},
	LegendDualWielding = {
		Icon = "skills/status_effect_75.png",
		IconMini = "",
		Overlay = ""
	},
	LegendEnragedHyenaBite = {
		Name = "Locked in Jaws"
	},
	LegendEnragedHyenaGrip = {
		Name = "Predatory Grip",
		Icon = "skills/legend_enraged_hyena_bite_effect.png", // uses bite icons
		IconMini = "legend_enraged_hyena_bite_effect_mini",
		Overlay = "legend_enraged_hyena_bite_effect"
	},
	LegendEvasion = {
		// marked for changes, can be LegendEvading if it stays
		Name = "Evading",
		Icon = "skills/evasion.png",
		IconMini = "",
		Overlay = "evasion"
	},
	LegendFallenBetrayerPotion = {
		Name = "Serum of Resentment",
		Icon = "skills/status_effect_136.png",
		IconMini = "",
		Overlay = "status_effect_136"
	},
	LegendFlourish = {
		Icon = "ui/perks/perk_41.png",
		Overlay = ""
	},
	LegendFreedomOfMovement = {
		Overlay = ""
	},
	LegendGrappled = {},
	LegendGravedigging = {
		IconMini = "", //"shovel_01_mini.png";
	},
	LegendGrazed = {
		Name = "Bleeding from Grazes"
	},
	LegendHeartwoodFocus = {},
	LegendGreenwoodSchratPotion = {
		Name = "Mutated Muscles",
		Icon = "skills/status_effect_146.png",
		IconMini = "",
		Overlay = "status_effect_146"
	}
	LegendHexeIchor = {},
	LegendHexeLeaderPotion = {
		Name = "Uplifting Touch",
		Icon = "skills/status_effect_148.png",
		IconMini = "",
		Overlay = "status_effect_148"
	},
	LegendHiddenKobold = {
		// purposefully left because kobolds are dead but the effect is cool
		Name = "Hidden",
		Icon = "skills/status_effect_08.png",
		IconMini = "status_effect_08_mini",
		Overlay = ""
	},
	LegendHoldingTheLine = {
		Overlay = ""
	},
	LegendInspired = {
		Icon = "ui/perks/perk_28.png",
		IconMini = "perk_28_mini",
		Overlay = "perk_28"
	},
	LegendInfatuated = {
		Icon = "skills/status_effect_85.png",
		IconMini = "status_effect_85_mini",
		Overlay = "status_effect_85"
	},
	LegendKnockbackPrepared = {
		Name = "Prepared to Inflict Knockback",
		Overlay = ""
	},
	LegendKnockedOver = {},
	LegendLiquorBurn = {
		// to be remade/removed
		Icon = "skills/status_effect_92.png",
		IconMini = "status_effect_92_mini",
		Overlay = "status_effect_92"
	},
	LegendLurking = {
		Overlay = ""
	},
	LegendBandOfBrothers = {
		Overlay = ""
	},
	LegendMarked = {
		Overlay = ""
	},
	LegendMartialMarch = {},
	LegendMeadWarmth = {
		// to be remade/removed
		Icon = "skills/status_effect_92.png",
		IconMini = "status_effect_92_mini",
		Overlay = "status_effect_92"
	},
	LegendNamedAxe = {
		Icon = "",
		IconMini = "",
		Overlay = ""
	},
	LegendNamedEstoc = {
		Icon = "",
		IconMini = "",
		Overlay = ""
	},
	LegendNamedFencingSword = {
		Icon = "",
		IconMini = "",
		Overlay = ""
	},
	LegendNamedFlail = {
		Icon = "",
		IconMini = "",
		Overlay = ""
	},
	LegendNamedHammerStun = {
		Icon = "",
		IconMini = "",
		Overlay = ""
	},
	LegendNamedMaceStagger = {
		Icon = "",
		IconMini = "",
		Overlay = ""
	},
	LegendNamedShamshir = {
		Icon = "",
		IconMini = "",
		Overlay = ""
	},
	LegendNamedWhipBleed = {
		Icon = "",
		IconMini = "",
		Overlay = ""
	},
	LegendNamedWhipFeint = {
		Icon = "",
		IconMini = "",
		Overlay = ""
	},
	LegendNecrosavantLordPotion = {
		Name = "Dustmourn Coating",
		Icon = "skills/status_effect_133.png",
		IconMini = "",
		Overlay = "status_effect_133"
	},
	LegendOrcBehemothPotion = {
		Name = "Unchained Fury",
		Icon = "skills/status_effect_129.png",
		IconMini = "status_effect_129_mini",
		Overlay = "status_effect_129"
	},
	LegendOrcElitePotion = {
		Name = "Brutal Savage",
		Icon = "skills/status_effect_130.png",
		IconMini = "",
		Overlay = "status_effect_130"
	},
	LegendParried = {},
	LegendPatientHunter = {},
	LegendPeacefulReassured = {
		Name = "Reassured",
		IconMini = "",
		Overlay = ""
	},
	LegendPerfectFocus = {},
	LegendPossessed = {
		Icon = "skills/status_effect_69.png",
		IconMini = "status_effect_69_mini",
		Overlay = "status_effect_69"
	},
	LegendPrayerOfFaith = {},
	LegendPrayerOfHope = {},
	LegendPrepareBullet = {},
	LegendPushingForward = {},
	LegendRamHammer = {
		// is this used? if so, needs icons
		Icon = "ui/perks/perk_53.png",
		IconMini = "mini_smackdown_circle",
		Overlay = "active_89"
	},
	LegendRealmOfNightmares = {
		// should be removed? no effect and is forced onto every player character automatically onInit?
		Icon = "skills/status_effect_102.png",
		IconMini = "status_effect_102_mini",
		Overlay = "status_effect_102"
	},
	LegendRedbackPoisonCoat = {
		Name = "Weapon coated with poison",
		Overlay = ""
	},
	LegendRedbackPotion = {
		Name = "Hyper-Mutated Circulatory System",
		Icon = "skills/status_effect_144.png",
		IconMini = "",
		Overlay = "status_effect_144"
	},
	LegendRedbackSpiderPoison = {
		Name = "Poisoned (redback)",
		Icon = "skills/status_effect_54.png",
		IconMini = "status_effect_54_mini",
		Overlay = ""
	},
	LegendReturnFavor = {
		Icon = "ui/perks/perk_31.png",
		IconMini = "perk_31_mini",
		Overlay = "perk_31"
	},
	LegendRockUnholdPotion = {
		Name = "Titan's Power",
		Icon = "skills/status_effect_145.png",
		IconMini = "",
		Overlay = "status_effect_145"
	},
	LegendSafeguarded = {
		Overlay = ""
	},
	LegendSafeguarding = {
		Icon = "skills/legend_safeguarded_effect.png",
		IconMini = "legend_safeguarded_effect_mini",
		Overlay = ""
	},
	LegendSanctified = {
		Icon = "skills/legend_consecrated_effect.png",
		IconMini = "legend_consecrated_effect_mini",
		Overlay = "legend_consecrated_effect"
	},
	LegendSecondWind = {},
	LegendSkinGhoulBlood = {},
	LegendSkinGhoulPotion = {
		Name = "Malice Unguis",
		Icon = "skills/status_effect_149.png",
		IconMini = "",
		Overlay = "status_effect_149"
	},
	LegendSongOfLife = {
		IconMini = ""
	},
	LegendStollwurmPotion = {
		Name = "Thorny Dragonhide",
		Icon = "skills/status_effect_140.png",
		IconMini = "",
		Overlay = "status_effect_140"
	},
	LegendStollwurmVigor = {},
	LegendStupefied = {},
	LegendSummonedBear = {
		Name = "Summoned a Bear"
	},
	LegendSummonedFalcon = {
		Name = "Summoned a Falcon"
	},
	LegendSummonedHound = {
		Name = "Summoned a Hound"
	},
	LegendSummonedSighthound = {
		Name = "Summoned a Sighthound"
	},
	LegendSummonedWolf = {
		Name = "Summoned a Wolf"
	},
	LegendThrewSand = {},
	// these 3 vala chant effects have a weird system of setting and resetting icons in effects themselves, we should fix that when changing them eventually
	LegendValaChantDisharmony = {
		Name = "Disharmony",
		Icon = "skills/status_effect_65.png", // uses Staggered, may need a new icon
		IconMini = "status_effect_65_mini",
		Overlay = "status_effect_65"
	},
	LegendValaChantFury = {
		Name = "Fury",
		Icon = "ui/perks/perk_36.png", // uses Killing Frenzy, may need a new icon
		IconMini = "perk_36_mini",
		Overlay = "perk_36",
	},
	LegendValaChantSenses = {
		Name = "Heightened Senses",
		Icon = "skills/status_effect_73.png", // uses Inspire, may need a new icon
		IconMini = "status_effect_73_mini",
		Overlay = "status_effect_73"
	},
	LegendValaCurrentlyChanting = {
		Name = "Currently Chanting",
		Icon = "ui/perks/perk_28.png", // uses Inspiring Presence, may need a new icon
		IconMini = "perk_28_mini",
		Overlay = "perk_28"
	},
	LegendValaInTrance = {
		Name = "In Trance",
		Icon = "skills/status_effect_53.png",
		IconMini = "status_effect_53_mini",
		Overlay = "status_effect_53"
	},
	LegendValaSpiritualBond = {
		Name = "Spiritual Bond",
		Icon = "skills/status_effect_87.png", // uses Dazed, may need a new icon
		IconMini = "status_effect_87_mini",
		Overlay = "status_effect_87"
	},
	LegendValaThreads = {
		Name = "Threads of Fate",
		Icon = "skills/status_effect_78.png", // uses Lindwurm Acid effect, may need a new icon
		IconMini = "status_effect_78_mini",
		Overlay = "status_effect_78"
	},
	LegendValaTranceMalevolent = {
		Icon = "skills/status_effect_52.png", // uses Afraid effect, may need a new icon
		IconMini = "status_effect_52_mini",
		Overlay = "status_effect_52"
	},
	LegendVengeance = {
		Name = "Vengeance!",
		Overlay = ""
	},
	LegendViolentDecomposition = {
		Icon = "skills/status_effect_78.png", // lindwurm acid again...
		IconMini = "status_effect_78_mini",
		Overlay = ""
	},
	LegendWarChant = {},
	LegendWebAtStart = {
		// what is the point of this? can't we just grant regular web?
		Name = "Start Combat Trapped in Web",
		Icon = "skills/status_effect_80.png",
		IconMini = "status_effect_80_mini",
		Overlay = "status_effect_80"
	},
	LegendWhiteDirewolfPotion = {
		Name = "Unflagging Energy"
		Icon = "skills/status_effect_139.png",
		IconMini = "",
		Overlay = "status_effect_139"
	},
	LegendWineTipsy = {
		// to be remade/removed
		Icon = "skills/status_effect_92.png",
		IconMini = "status_effect_92_mini",
		verlay = "status_effect_92"
	},
	LegendZombiePoison = {
		Name = "Infected",
		Icon = "skills/status_effect_54.png",
		IconMini = "status_effect_54_mini",
		Overlay = ""
	}
};

::Legends.Effects.addEffectDefObjects(effectDefs);

local worldEffectDefs = {
	Afraid = {
		Icon = "skills/status_effect_52.png",
		IconMini = "status_effect_52_mini",
		Overlay = ""
	},
	Drunk = {
		Icon = "skills/status_effect_61.png",
		IconMini = "",
		Overlay = ""
	},
	Exhausted = {
		Icon = "skills/status_effect_53.png",
		IconMini = "status_effect_53_mini",
		Overlay = ""
	},
	Hangover = {
		Icon = "skills/status_effect_62.png",
		IconMini = "",
		Overlay = ""
	},
	KnowledgePotion = {
		Name = "Enhanced Learning",
		Icon = "skills/status_effect_94.png",
		IconMini = "",
		Overlay = ""
	},
	Trained = {
		Script = "scripts/skills/effects_world/new_trained_effect",
		Name = "Training Experience",
		Icon = "skills/status_effect_62.png",
		IconMini = "",
		Overlay = ""
	},
	LegendHeadache = {
		Icon = "skills/status_effect_62.png",
		IconMini = "",
		Overlay = ""
	},
	LegendIrritable = {
		Icon = "skills/status_effect_62.png",
		IconMini = "",
		Overlay = ""
	},
	LegendWellTended = {
		IconMini = "",
		Overlay = ""
	}
};

::Legends.Effects.addEffectDefObjects(worldEffectDefs, "effects_world");

local specialEffectDefs = {
	BagFatigue = {
		Script = "scripts/skills/special/bag_fatigue",
		Icon = "",
		IconMini = "",
		Overlay = ""
	},
	DoubleGrip = {
		Script = "scripts/skills/special/double_grip",
		Icon = "skills/passive_07.png",
		IconMini = "passive_07_mini",
		Overlay = ""
	},
	MoodCheck = {
		Script = "scripts/skills/special/mood_check",
		Icon = "skills/status_effect_02.png",
		IconMini = "",
		Overlay = ""
	},
	MoraleCheck = {
		Script = "scripts/skills/special/morale_check",
		Icon = "skills/status_effect_02.png",
		IconMini = "status_effect_02_mini",
		Overlay = ""
	},
	Night = {
		Name = "Nighttime",
		Icon = "skills/status_effect_35.png",
		IconMini = "status_effect_35_mini",
		Overlay = ""
	},
	NoAmmoWarning = {
		Script = "scripts/skills/special/no_ammo_warning",
		Name = "No Ammunition!",
		Icon = "skills/status_effect_63.png",
		IconMini = "status_effect_63_mini",
		Overlay = ""
	},
	OathOfFortificationWarning = {
		Script = "scripts/skills/special/oath_of_fortification_warning",
		Name = "Fortifying!",
		Icon = "skills/status_effect_159.png",
		IconMini = "status_effect_159_mini",
		Overlay = "status_effect_159"
	},
	OathOfHonorWarning = {
		Script = "scripts/skills/special/oath_of_honor_warning",
		Name = "Honorable Combat!",
		Icon = "skills/status_effect_160.png",
		IconMini = "status_effect_160_mini",
		Overlay = ""
	},
	StatsCollector = {
		Script = "scripts/skills/special/stats_collector",
		Icon = "",
		IconMini = "",
		Overlay = ""
	},
	WeaponBreakingWarning = {
		Script = "scripts/skills/special/weapon_breaking_warning",
		Name = "Weapon in poor condition!",
		Icon = "skills/status_effect_59.png",
		IconMini = "status_effect_59_mini",
		Overlay = ""
	},
	LegendRain = {
		Name = "Raining",
		IconMini = "status_effect_35_mini",
		Overlay = ""
	},
	// unused
	LegendRelationshipCheck = {
		Icon = "skills/status_effect_01.png",
		IconMini = "",
		Overlay = ""
	},
	LegendHorserider = {
		Icon = "",
		IconMini = "",
		Overlay = ""
	}
};

::Legends.Effects.addEffectDefObjects(specialEffectDefs, "special");

local runeSigilEffectDefs = {
	LegendRsaEndurance = {},
	LegendRsaResilience = {},
	LegendRsaSafety = {},
	LegendRshBravery = {},
	LegendRshClarity = {},
	LegendRshLuck = {},
	LegendRshPatience = {},
	LegendRssDefense = {},
	LegendRssDurability = {},
	LegendRssRadiance = {},
	LegendRssRadianceBlind = {
		Name = "Blinded",
		Icon = "skills/status_effect_52.png",
		IconMini = "status_effect_52_mini",
		Overlay = "status_effect_52"
	},
	LegendRswAccuracy = {},
	LegendRswBlazing = {},
	LegendRswBleeding = {},
	LegendRswBleedingBleed = {
		Name = "Bleeding",
		Icon = "skills/status_effect_01.png",
		IconMini = "status_effect_01_mini",
		Overlay = "status_effect_01"
	},
	LegendRswFeeding = {},
	LegendRswPoison = {},
	LegendRswPoisonPoison = {
		Name = "Poisoned (rune)",
		Icon = "skills/status_effect_54.png",
		IconMini = "status_effect_54_mini",
		Overlay = "status_effect_54"
	},
	LegendRswPower = {},
	LegendRswUnbreaking = {}
};

foreach (constName, def in runeSigilEffectDefs) {
	if (!("Name" in def)) {
		def.Name <- "Rune Sigil: " + (@(_string) _string.slice((function (_string) {
			for (local i = _string.len() - 1; i >= 0; i--) {
				if (_string[i] >= 65 && _string[i] <= 90) {
					return i;
				}
			}
			return 0;
		})(_string)))(constName);
	}

	if (!("Icon" in def)) {
		def.Icon <- "ui/rune_sigils/legend_rune_sigil.png";
	}

	if (!("IconMini" in def)) {
		def.IconMini <- "";
	}

	if (!("Overlay" in def)) {
		def.Overlay <- "";
	}
}

::Legends.Effects.addEffectDefObjects(runeSigilEffectDefs, "rune_sigils");
