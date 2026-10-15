/**
 * This file contains definitions and helper function for perks used in Legends.
 *
 *	In perk implementation create() method it's encouraged to use helper function to set defined fields automatically by using
 *  ::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBallistics);
 *  Use your name, this will ensure there's not mismatch or typos in ID, Icons etc.
 *  If your perk is an effect or requires to show different icons when used as a skill or whatever other reason, you can still set values you need regardless what helper sets.
 *
 * 	If you need to reference perk in other place, it's best to use reference to the ID instead of raw string literal.
 *  For example, instead of using:
 *  	bro.getSkills().hasSkill("perk.legend_ballistics")
 *  Use:
 *  	bro.getSkills().hasPerk(::Legends.Perk.LegendBallistics)
 */

if (!("Perks" in ::Const)) {
	::Const.Perks <- {};
}
::Const.Perks.PerkDefObjects <- {};
::Const.Perks.PerkDefs <- {};

::Const.Perks.defaultDef <- function (_def) {
	local snakeCase = ::Legends.DefsHelpers.convertToSnakeCase(_def.Const);
	return {
		Const = _def.Const,
		ID = ::format("perk.%s", snakeCase),
		Script = ::format("scripts/skills/perks/perk_%s", snakeCase),
		Name = ::Legends.DefsHelpers.convertToDisplayName(_def.Const),
		Tooltip = ::Const.Strings.PerkDescription[_def.Const],
		Icon = ::format("ui/perks/%s.png", snakeCase)
		IconDisabled = ::format("ui/perks/%s_bw.png", snakeCase),
		HasUnactivatedPerkTooltipHints = false
	}
}

/**
* Overwrites default def with non-standard fields defined here
* @param _def table with field overwrites
*/
::Const.Perks.transformDef <- function (_def) {
	local defaultDef = ::Const.Perks.defaultDef(_def);
	foreach (key, value in _def) {
		if (key in defaultDef) {
			defaultDef[key] = value; // overwrite
		} else {
			// here's weird situation, we have a slot that was not defined in default, which most likely means bug
			defaultDef[key] <- value;
			::logWarning(::format("perk '%s' defines unknown field '%s' in perk_defs", defaultDef.ID, key));
		}
	}
	return defaultDef;
};

/**
 * @param _perkDefObjects is an array of perk definitions
 * @param _container is namespace where ids will reside, you can use your own in submods, default is ::Legends.Perk
 */
::Const.Perks.addPerkDefObjects <- function (_perkDefObjects, _container = null) {
	if (_container == null) {
		_container = ::Legends.Perk;
	}

	foreach (constName, def in _perkDefObjects) {
		def.Const <- constName;
		def = ::Const.Perks.transformDef(def);
		local hash = ::IO.scriptHashByFilename(def.Script);
		if (hash == null) {
			::logError(::format("%s: hash is null for '%s'", def.Const, def.Script));
		}
		::Const.Perks.PerkDefObjects[hash] <- def;
		if (def.Const in _container) {
			_container[def.Const] = hash;
		} else {
			_container[def.Const] <- hash;
		}
		::Const.Perks.PerkDefs[def.Const] <- hash;
		::Const.Perks.LookupMap[def.ID] <- def;
	}
}

::Const.Perks.validate <- function (_defs) {
	local scripts = ::IO.enumerateFiles("scripts/skills/perks/");
	local icons = ::IO.enumerateFiles("gfx/").map(@(_f) _f + ".png");

	foreach (key, value in _defs) {
		if (scripts.find(::Const.Perks.PerkDefObjects[value].Script) == null) {
			::logError(::format("%s: script `%s` is missing", key, ::Const.Perks.PerkDefObjects[value].Script));
		}
		if (icons.find("gfx/" + ::Const.Perks.PerkDefObjects[value].Icon) == null) {
			::logError(::format("%s: icon `%s` is missing", key, ::Const.Perks.PerkDefObjects[value].Icon));
		}
		if (icons.find("gfx/" + ::Const.Perks.PerkDefObjects[value].IconDisabled) == null) {
			::logError(::format("%s: icon disabled `%s` is missing", key, ::Const.Perks.PerkDefObjects[value].IconDisabled));
		}
	}
}

/**
* Provide non-standard slot overwrites here
* Defs get overwritten by int index at runtime.
*/
::Legends.Perk <- {
	// Vanilla defined perks
	Adrenaline = {
		Script = "scripts/skills/perks/perk_adrenalin",
		Icon = "ui/perks/perk_37.png",
		IconDisabled = "ui/perks/perk_37_sw.png"
	},
	Anticipation = {
		Icon = "ui/perks/perk_10.png",
		IconDisabled = "ui/perks/perk_10_sw.png"
	},
	Backstabber = {
		Icon = "ui/perks/perk_59.png",
		IconDisabled = "ui/perks/perk_59_sw.png"
	},
	BagsAndBelts = {
		Icon = "ui/perks/perk_20.png",
		IconDisabled = "ui/perks/perk_20_sw.png"
	},
	BatteringRam = {
		Icon = "skills/passive_03.png",
		IconDisabled = "skills/passive_03_sw.png"
	},
	BattleFlow = {},
	BattleForged = {
		Icon = "ui/perks/perk_03.png",
		IconDisabled = "ui/perks/perk_03_sw.png"
	},
	Berserk = {
		Icon = "ui/perks/perk_35.png",
		IconDisabled = "ui/perks/perk_35_sw.png"
	},
	Brawny = {
		Icon = "ui/perks/perk_40.png",
		IconDisabled = "ui/perks/perk_40_sw.png"
	},
	Bullseye = {
		Icon = "ui/perks/perk_17.png",
		IconDisabled = "ui/perks/perk_17_sw.png"
	},
	Captain = {
		Name = ::Const.Strings.PerkName.Captain,
		Icon = "ui/perks/perk_26.png",
		IconDisabled = "ui/perks/perk_26_sw.png"
	},
	Colossus = {
		Icon = "ui/perks/perk_06.png",
		IconDisabled = "ui/perks/perk_06_sw.png"
	},
	CoupDeGrace = {
		Name = ::Const.Strings.PerkName.CoupDeGrace,
		Icon = "ui/perks/perk_16.png",
		IconDisabled = "ui/perks/perk_16_sw.png"
	},
	CripplingStrikes = {
		Icon = "ui/perks/perk_57.png",
		IconDisabled = "ui/perks/perk_57_sw.png",
	},
	DevastatingStrikes = {},
	Dodge = {
		Icon = "ui/perks/perk_01.png",
		IconDisabled = "ui/perks/perk_01_sw.png"
	},
	Duelist = {
		Icon = "ui/perks/perk_41.png",
		IconDisabled = "ui/perks/perk_41_sw.png"
	},
	FastAdaption = {
		Icon = "ui/perks/perk_33.png",
		IconDisabled = "ui/perks/perk_33_sw.png"
	},
	Fearsome = {
		Icon = "ui/perks/perk_27.png",
		IconDisabled = "ui/perks/perk_27_sw.png"
	},
	Footwork = {
		Icon = "ui/perks/perk_25.png",
		IconDisabled = "ui/perks/perk_25_sw.png"
	},
	FortifiedMind = {
		Icon = "ui/perks/perk_08.png",
		IconDisabled = "ui/perks/perk_08_sw.png"
	},
	Gifted = {
		Icon = "ui/perks/perk_56.png",
		IconDisabled = "ui/perks/perk_56_sw.png"
	},
	HeadHunter = {
		Icon = "ui/perks/perk_15.png",
		IconDisabled = "ui/perks/perk_15_sw.png"
	},
	HoldOut = {
		Name = ::Const.Strings.PerkName.HoldOut,
		Icon = "ui/perks/perk_04.png",
		IconDisabled = "ui/perks/perk_04_sw.png"
	},
	Indomitable = {
		Icon = "ui/perks/perk_30.png",
		IconDisabled = "ui/perks/perk_30_sw.png"
	},
	InspiringPresence = {
		Icon = "ui/perks/perk_28.png",
		IconDisabled = "ui/perks/perk_28_sw.png"
	},
	KillingFrenzy = {
		Icon = "ui/perks/perk_36.png",
		IconDisabled = "ui/perks/perk_36_sw.png"
	},
	LoneWolf = {
		Icon = "ui/perks/perk_61.png",
		IconDisabled = "ui/perks/perk_61_sw.png"
	},
	Nimble = {
		Icon = "ui/perks/perk_29.png",
		IconDisabled = "ui/perks/perk_29_sw.png"
	},
	NineLives = {
		Icon = "ui/perks/perk_07.png",
		IconDisabled = "ui/perks/perk_07_sw.png"
	},
	Overwhelm = {
		Icon = "ui/perks/perk_62.png",
		IconDisabled = "ui/perks/perk_62_sw.png"
	},
	Pathfinder = {
		Icon = "ui/perks/perk_23.png",
		IconDisabled = "ui/perks/perk_23_sw.png"
	},
	QuickHands = {
		Icon = "ui/perks/perk_39.png",
		IconDisabled = "ui/perks/perk_39_sw.png"
	},
	RallyTheTroops = {
		Icon = "ui/perks/perk_42.png",
		IconDisabled = "ui/perks/perk_42_sw.png"
	},
	ReachAdvantage = {
		Icon = "ui/perks/perk_19.png",
		IconDisabled = "ui/perks/perk_19_sw.png"
	},
	Recover = {
		Icon = "ui/perks/perk_54.png",
		IconDisabled = "ui/perks/perk_54_sw.png"
	},
	Relentless = {
		Icon = "ui/perks/perk_26.png",
		IconDisabled = "ui/perks/perk_26_sw.png"
	},
	Rotation = {
		Icon = "ui/perks/perk_11.png",
		IconDisabled = "ui/perks/perk_11_sw.png"
	},
	ShieldBash = {
		Icon = "ui/perks/perk_22.png",
		IconDisabled = "ui/perks/perk_22_sw.png"
	},
	ShieldExpert = {
		Icon = "ui/perks/perk_05.png",
		IconDisabled = "ui/perks/perk_05_sw.png"
	},
	SpecAxe = {
		ID = "perk.mastery.axe",
		Script = "scripts/skills/perks/perk_mastery_axe",
		Name = ::Const.Strings.PerkName.SpecAxe,
		Icon = "ui/perks/perk_44.png",
		IconDisabled = "ui/perks/perk_44_sw.png",
	},
	SpecBow = {
		ID = "perk.mastery.bow",
		Script = "scripts/skills/perks/perk_mastery_bow",
		Name = ::Const.Strings.PerkName.SpecBow,
		Icon = "ui/perks/perk_49.png",
		IconDisabled = "ui/perks/perk_49_sw.png",
	},
	SpecCleaver = {
		ID = "perk.mastery.cleaver",
		Script = "scripts/skills/perks/perk_mastery_cleaver",
		Name = ::Const.Strings.PerkName.SpecCleaver,
		Icon = "ui/perks/perk_52.png",
		IconDisabled = "ui/perks/perk_52_sw.png"
	},
	SpecCrossbow = {
		ID = "perk.mastery.crossbow",
		Script = "scripts/skills/perks/perk_mastery_crossbow",
		Name = ::Const.Strings.PerkName.SpecCrossbow,
		Icon = "ui/perks/perk_48.png",
		IconDisabled = "ui/perks/perk_48_sw.png"
	},
	SpecDagger = {
		ID = "perk.mastery.dagger",
		Script = "scripts/skills/perks/perk_mastery_dagger",
		Name = ::Const.Strings.PerkName.SpecDagger,
		Icon = "ui/perks/perk_51.png",
		IconDisabled = "ui/perks/perk_51_sw.png"
	},
	SpecFlail = {
		ID = "perk.mastery.flail",
		Script = "scripts/skills/perks/perk_mastery_flail",
		Name = ::Const.Strings.PerkName.SpecFlail,
		Icon = "ui/perks/perk_47.png",
		IconDisabled = "ui/perks/perk_47_sw.png"
	},
	SpecHammer = {
		ID = "perk.mastery.hammer",
		Script = "scripts/skills/perks/perk_mastery_hammer",
		Name = ::Const.Strings.PerkName.SpecHammer,
		Icon = "ui/perks/perk_53.png",
		IconDisabled = "ui/perks/perk_53_sw.png"
	},
	SpecMace = {
		ID = "perk.mastery.mace",
		Script = "scripts/skills/perks/perk_mastery_mace",
		Name = ::Const.Strings.PerkName.SpecMace,
		Icon = "ui/perks/perk_43.png",
		IconDisabled = "ui/perks/perk_43_sw.png"
	},
	SpecPolearm = {
		ID = "perk.mastery.polearm",
		Script = "scripts/skills/perks/perk_mastery_polearm",
		Name = ::Const.Strings.PerkName.SpecPolearm,
		Icon = "ui/perks/perk_58.png",
		IconDisabled = "ui/perks/perk_58_sw.png"
	},
	SpecSpear = {
		ID = "perk.mastery.spear",
		Script = "scripts/skills/perks/perk_mastery_spear",
		Name = ::Const.Strings.PerkName.SpecSpear,
		Icon = "ui/perks/perk_45.png",
		IconDisabled = "ui/perks/perk_45_sw.png"
	},
	SpecSword = {
		ID = "perk.mastery.sword",
		Script = "scripts/skills/perks/perk_mastery_sword",
		Name = ::Const.Strings.PerkName.SpecSword,
		Icon = "ui/perks/perk_46.png",
		IconDisabled = "ui/perks/perk_46_sw.png"
	},
	SpecThrowing = {
		ID = "perk.mastery.throwing",
		Script = "scripts/skills/perks/perk_mastery_throwing",
		Name = ::Const.Strings.PerkName.SpecThrowing,
		Icon = "ui/perks/perk_50.png",
		IconDisabled = "ui/perks/perk_50_sw.png"
	},
	Stalwart = {},
	Steadfast = {},
	SteelBrow = {
		Icon = "ui/perks/perk_09.png",
		IconDisabled = "ui/perks/perk_09_sw.png"
	},
	Student = {
		Icon = "ui/perks/perk_21.png",
		IconDisabled = "ui/perks/perk_21_sw.png"
	},
	SunderingStrikes = {},
	Underdog = {
		Icon = "ui/perks/perk_60.png",
		IconDisabled = "ui/perks/perk_60_sw.png"
	},
	Taunt = {
		Name = "Battlefield Control",
		Icon = "ui/perks/perk_38.png",
		IconDisabled = "ui/perks/perk_38_sw.png"
	},
	// Legends starts here
	LegendAlert = {},
	LegendAmbidextrous = {},
	LegendAnchor = {},
	LegendAssassinate = {},
	LegendAssuredConquest = {},
	LegendAthlete = {},
	LegendBackflip = {},
	LegendBackToBasics = {},
	LegendBackswing = {},
	LegendBalance = {},
	LegendBallistics = {},
	LegendBarrage = {},
	LegendBattleheart = {},
	LegendBerserkerRage = {},
	LegendBigGameHunter = {},
	LegendBlendIn = {},
	LegendBloodbath = {},
	LegendBloodyHarvest = {},
	LegendBoneBreaker = {},
	LegendCacophony = {
		Icon = "ui/perks/legend_stupefy.png",
		IconDisabled = "ui/perks/legend_stupefy_bw.png"
	},
	LegendCarnage = {},
	LegendChainLightning = {},
	LegendCheerOn = {},
	LegendClarity = {},
	LegendCoordinatedVolleys = {},
	LegendDarkflight = {},
	LegendDeathTouch = {},
	LegendDedication = {},
	LegendDeflection = {},
	LegendDogHandling = {},
	LegendDogWhisperer = {},
	LegendDrainingTouch = {},
	LegendExtendedAura = {},
	LegendEscapeArtist = {},
	LegendEvasion = {},
	LegendFavouredEnemyBeast = {
		Name = "Favoured Enemy - Beasts",
		HasUnactivatedPerkTooltipHints = true
	},
	LegendFavouredEnemyCivilization = {
		Name = "Favoured Enemy - Civilization",
		HasUnactivatedPerkTooltipHints = true
	},
	LegendFavouredEnemyGreenskin = {
		Name = "Favoured Enemy - Greenskin",
		HasUnactivatedPerkTooltipHints = true
	},
	LegendFavouredEnemyOccult = {
		Name = "Favoured Enemy - Occult",
		HasUnactivatedPerkTooltipHints = true
	},
	LegendFavouredEnemyOutlaw = {
		Name = "Favoured Enemy - Outlaw",
		HasUnactivatedPerkTooltipHints = true
	},
	LegendFavouredEnemySwordmaster = {
		Name = "Favoured Enemy - Sword Master",
		HasUnactivatedPerkTooltipHints = true
	},
	LegendFavouredEnemyUndead = {
		Name = "Favoured Enemy - Undead",
		HasUnactivatedPerkTooltipHints = true
	},
	LegendFashionable = {},
	LegendFashionBody = {},
	LegendFeint = {},
	LegendFirefield = {},
	LegendFirstBlood = {},
	LegendFlux = {},
	LegendFreedomOfMovement = {},
	LegendGrappler = {},
	LegendGruesomeFeast = {},
	LegendHairSplitter = {},
	LegendHeightenedReflexes = {},
	LegendHammerTheGap = {},
	LegendHimshaw = {},
	LegendHoldTheLine = {},
	LegendHolyFlame = {},
	LegendImmovableObject = {},
	LegendIncoming = {
		Name = "Incoming!"
	},
	LegendInsectSwarm = {},
	LegendInspire = {},
	LegendInTheZone = {},
	LegendKeenEyesight = {},
	LegendLacerate = {},
	LegendLastStand = {},
	LegendLeap = {},
	LegendLevitate = {},
	LegendLionheart = {},
	LegendLithe = {},
	LegendLurker = {},
	LegendMagicMissile = {},
	LegendMagicMissileFocus = {},
	LegendManipulative = {},
	LegendMasteryMagicMissile = {
		Name = "Magic Missile Mastery"
	},
	LegendMasteryMusic = {
		Name = "Music Mastery"
	},
	LegendMasteryNets = {
		Name = "Net Mastery"
	},
	LegendMasteryShields = {
		Name = "Shield Mastery",
		Icon = "ui/perks/perk_05.png",
		IconDisabled = "ui/perks/perk_05_sw.png",
	},
	LegendMasterySlings = {
		Name = "Sling Mastery"
	},
	LegendMasteryMagicStaff = {
		Name = "Magic Staff Mastery"
	},
	LegendMasteryUnarmed = {
		Name = "Unarmed Mastery"
	},
	LegendMeistersanger = {
		Name = "Meistersänger"
	},
	LegendMindOverBody = {
		HasUnactivatedPerkTooltipHints = true
	},
	LegendMinnesanger = {
		Name = "Minnesänger"
	},
	LegendMoldCarrion = {},
	LegendMuscularity = {
		HasUnactivatedPerkTooltipHints = true
	},
	LegendNearDeathExperience = {},
	LegendNetCasting = {},
	LegendNightvision = {},
	LegendNightRaider = {},
	LegendOnslaught = {},
	LegendOpportunist = {},
	LegendPackLeader = {},
	LegendParalyze = {},
	LegendPatientHunter = {},
	LegendPeaceful = {},
	LegendPenance = {},
	LegendPerfectFit = {
		HasUnactivatedPerkTooltipHints = true
	},
	LegendPerfectFocus = {},
	LegendPointBlank = {},
	LegendPoisoner = {},
	LegendPossession = {},
	LegendPrayerOfFaith = {},
	LegendPrayerOfHope = {},
	LegendPrepared = {},
	LegendPromisedPotential = {},
	LegendPugilist = {},
	LegendPummelIntoSubmission = {},
	LegendPushForward = {},
	LegendPushTheAdvantage = {
		Icon = "ui/perks/perk_32.png", // todo is that correct icon?
		IconDisabled = "ui/perks/perk_32_sw.png",
	},
	LegendQuickStep = {},
	LegendRaiseUndead = {},
	LegendRebound = {},
	LegendRecuperation = {},
	LegendRemakeMan = {},
	LegendReturnFavor = {},
	LegendRoots = {},
	LegendScry = {},
	LegendSecondWind = {},
	LegendShieldsUp = {
		Name = "Shields Up!"
	},
	LegendSlaughterer = {},
	LegendSleightOfHand = {},
	LegendSlumber = {},
	LegendSmackdown = {},
	LegendSmashingShields = {},
	LegendSpearwaller = {},
	LegendSpecialistBlacksmith = {
		Name = "Blacksmiths Technique"
	},
	LegendSpecialistBodyguard = {
		Name = "Schwertkampfer"
	},
	LegendSpecialistButcher = {
		Name = "Butchers Fillet"
	},
	LegendSpecialistClub = {
		Name = "Browbeater\'s Bludgeon"
	},
	LegendSpecialistCultist = {
		Name = "Scourging"
	},
	LegendSpecialistFarmhand = {
		Name = "Hay Baling"
	},
	LegendSpecialistGravedigger = {
		Name = "Gravesman"
	},
	LegendSpecialistHerbalist = {
		Name = "Harvest Twist"
	},
	LegendSpecialistInquisition = {
		Name = "Trial for Witchcraft"
	},
	LegendSpecialistInventor = {
		Name = "Inventor\'s Armaments"
	},
	LegendSpecialistMilitia = {
		Name = "Militia Practice"
	},
	LegendSpecialistMiner = {
		Name = "Miners Strikes"
	},
	LegendSpecialistMusician = {
		Name = "Entrancing Song"
	},
	LegendSpecialistPoacher = {
		Name = "Poachers Arm"
	},
	LegendSpecialistPrisoner = {
		Name = "Prisoners Rush"
	},
	LegendSpecialistRaider = {
		Name = "Marauder\'s Edge"
	},
	LegendSpecialistReaper = {
		Name = "Harvest Swathes"
	},
	LegendSpecialistSharpshooter = {
		Name = "Death from Above"
	},
	LegendSpecialistShepherd = {
		Name = "Shepherd\'s Signature"
	},
	LegendSpecialistSpearfisher = {
		Name = "Tip of the Fisherman"
	},
	LegendSpecialistWoodsman = {
		Name = "Woodsman\'s Cuts"
	},
	LegendStaffSpins = {},
	LegendStrengthInNumbers = {},
	LegendStupefy = {},
	LegendSummonBear = {},
	LegendSummonFalcon = {},
	LegendSummonFamiliar = {},
	LegendSummonHound = {},
	LegendSummonStorm = {},
	LegendSummonWolf = {},
	LegendSwagger = {
		HasUnactivatedPerkTooltipHints = true
	},
	LegendTacticalManeuvers = {
		Icon = "ui/perks/perk_11.png",
		IconDisabled = "ui/perks/perk_11_sw.png"
	},
	LegendTerrifyingVisage = {},
	LegendThrowSand = {},
	LegendTrueBeliever = {},
	LegendTwirl = {},
	LegendTumble = {},
	LegendUnburdened = {},
	LegendValaChantDisharmony = {
		Name = "Disharmony (Chant)"
	},
	LegendValaChantFury = {
		Name = "Fury (Chant)"
	},
	LegendValaChantMastery = {
		Name = "Chanting Mastery"
	},
	LegendValaChantSenses = {
		Name = "Heightened Senses (Chant)"
	},
	LegendValaPremonition = {
		Name = "Premonition"
	},
	LegendValaSpiritualBond = {
		Name = "Spiritual Bond"
	},
	LegendValaThreads = {
		Name = "Threads of Fate"
	},
	LegendValaTranceMalevolent = {
		Name = "Malevolent Spirits (Trance)"
	},
	LegendValaTranceMastery = {
		Name = "Trance Mastery"
	},
	LegendValaWarden = {
		Name = "Warden"
	},
	LegendVengeance = {},
	LegendVersatile = {},
	LegendViolentDecomposition = {},
	LegendWideSwings = {
		Icon = "ui/perks/legend_feint.png", //todo
		IconDisabled = "ui/perks/legend_feint_bw.png",
	}
	LegendWindReader = {},
	LegendWither = {},
	LegendZombieBite = {
		Icon = "ui/perks/legend_mold_carrion.png", //todo
		IconDisabled = "ui/perks/legend_mold_carrion_bw.png",
	},
	//purgatory, stuff left to do
	// necro, to be decided
	LegendRust = {
		Icon = "ui/perks/rust56_circle.png",
		IconDisabled = "ui/perks/rust56_circle_bw.png",
	},
	// necro, to be decided
	LegendMiasma = {
		Icon = "ui/perks/miasma_circle.png",
		IconDisabled = "ui/perks/miasma_circle_bw.png",
	},
	// to be added
	LegendIronside = {},
	// unused other than donkeys, to be deleted but might be harvested for the effect before?
	LegendPacifist = {
		Icon = "ui/perks/pacifist_circle.png",
		IconDisabled = "ui/perks/pacifist_circle_bw.png"
	},
	//to be deleted once its merged into summon mastery
	LegendChanneledPower = {
		Icon = "ui/perks/channeled_power_circle.png",
		IconDisabled = "ui/perks/channeled_power_circle_bw.png"
	},
	//to be moved into necro professions
	LegendReclamation = {
		Icon = "ui/perks/reclamation_circle.png",
		IconDisabled = "ui/perks/reclamation_circle_bw.png"
	},
	//to be moved into necro professions
	LegendConservation = {
		Icon = "ui/perks/conservation_circle.png",
		IconDisabled = "ui/perks/conservation_circle_bw.png"
	},
	// slightly weird implementation as its looking at all PIERCING DMG TYPE skills which aren't coming from daggers, are we sure its ok?
	LegendThrustMaster = {},
	// could be made into a profession, but it will be hard to find a tree for it
	LegendNetRepair = {
		Icon = "ui/perks/net_repair.png",
		IconDisabled = "ui/perks/net_repair_bw.png"
	},
	// Horses below
	LegendHorseCharge = {
		Name = "Mounted Charge"
	},
	LegendHorsePirouette = {
		Name = "Pirouette"
	},
	LegendHorseBitting = {
		Name = "Bitting"
	},
	LegendHorseDesensitization = {
		Name = "Desensitization"
	},
	LegendHorseImpulsion = {
		Name = "Impulsion"
	},
	LegendHorseLeadChange = {
		Name = "Lead Change",
		Icon = "ui/perks/perk_23.png",
		IconDisabled = "ui/perks/perk_23_sw.png"
	},
	LegendHorseLegControl = {
		Name = "Leg Control"
	},
	LegendHorseLiberty = {
		Name = "Liberty"
	},
	LegendHorseLongeing = {
		Name = "Longeing"
	},
	LegendHorseParthianShot = {
		Name = "Parthian Shot"
	},
	LegendHorsePiaffe = {
		Name = "Piaffe"
	},
	LegendHorseTempiChange = {
		Name = "Tempi Change",
		Icon = "ui/perks/perk_23.png",
		IconDisabled = "ui/perks/perk_23_sw.png"
	},
	LegendHorseMovement = {
		Name = "Horse Movement",
		Icon = "ui/perks/legend_horse_charge.png",
		IconDisabled = "ui/perks/legend_horse_charge_bw.png"
	},
	LegendHorseCollection = {
		Name = "Collection"
	},
	LegendHorseFlyingChange = {
		Name = "Flying Change",
		Icon = "ui/perks/perk_23.png",
		IconDisabled = "ui/perks/perk_23_sw.png"
	},
	LegendHorsePassage = {
		Name = "Passage",
		Icon = "ui/perks/legend_horse_charge.png",
		IconDisabled = "ui/perks/legend_horse_charge_bw.png"
	}
};

::Const.Perks.addPerkDefObjects(clone ::Legends.Perk);

::Const.Perks.validate(::Legends.Perk);
