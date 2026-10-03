/**
 * This file contains definitions and helper function for perks used in Legends.
 *
 * To add new perk, add definition to perkDefObjects:
 * perkDefObjects.push({
 *		ID = "perk.legend_ballistics", 									<- by convention, use legend_ prefix for your perk name or use your own if that's submod
 *		Script = "scripts/skills/perks/perk_legend_ballistics", 		<- same here
 *		Name = ::Const.Strings.PerkName.LegendBallistics,   			<- Name and Tooltip should be defined in perk_strings.nut
 *		Tooltip = ::Const.Strings.PerkDescription.LegendBallistics,
 *		Icon = "ui/perks/ballistics56_circle.png",						<- provide both icons, that will be used on perk screen, here's perk granted version
 *		IconDisabled = "ui/perks/ballistics56_circle_bw.png",			<- perk not granted version
 *		Const = "LegendBallistics" 										<- constant name this definition will be available at ::Const.Perks.PerkDefs, by convention, use Legend prefix for your perk or use your own if that's submod
 *	});
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

if (!("Perk" in ::Legends)) {
	::Legends.Perk <- {};
}

::Const.Perks.createPerkDef <- function (_def) {
	::Legends.Perk[_def.Const] <- null;
	local snakeCase = ::Legends.DefsHelpers.convertToSnakeCase(_def.Const);
	if (!("ID" in _def)) {
		_def.ID <- "perk." + snakeCase;
	}

	if (!("Script" in _def)) {
		_def.Script <- "scripts/skills/perks/perk_" + snakeCase;
	}

	if (!("Name" in _def)) {
		_def.Name <- ::Legends.DefsHelpers.convertToDisplayName(_def.Const);

	}

	_def.Tooltip <- ::Const.Strings.PerkDescription[_def.Const];

	if (!("Icon" in _def)) {
		_def.Icon <- "ui/perks/" + snakeCase + ".png";
	}

	if (!("IconDisabled" in _def)) {
		_def.IconDisabled <- "ui/perks/" + snakeCase + "_bw.png";
	}

	return _def;
};

::Const.Perks.PerkDefObjects <- [];
::Const.Perks.PerkDefs <- {};

/**
 * @param _perkDefObjects is an array of perk definitions
 * @param _container is namespace where ids will reside, you can use your own in submods
 */

::Const.Perks.addPerkDefObjects <- function (_perkDefObjects, _container = ::Legends.Perk) {
	local size = ::Const.Perks.PerkDefObjects.len();
	local i = 0;
	foreach (constName, def in _perkDefObjects) {
		def.Const <- constName;
		::Const.Perks.PerkDefObjects.push(::Const.Perks.createPerkDef(def));
		if (def.Const in _container) {
			_container[def.Const] = size + i;
		} else {
			_container[def.Const] <- size + i;
		}
		::Const.Perks.PerkDefs[def.Const] <- size + i;
		::Const.Perks.LookupMap[def.ID] <- def;
		i++;
	}
}

local perkDefObjects = {
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
	BattleFlow = {
		Icon = "ui/perks/battle_flow56_circle.png",
		IconDisabled = "ui/perks/battle_flow56_circle_bw.png"
	},
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
	Steadfast = {
		Icon = "ui/perks/steadfast_circle.png",
		IconDisabled = "ui/perks/steadfast_circle_bw.png"
	},
	SteelBrow = {
		Icon = "ui/perks/perk_09.png",
		IconDisabled = "ui/perks/perk_09_sw.png"
	},
	Student = {
		Icon = "ui/perks/perk_21.png",
		IconDisabled = "ui/perks/perk_21_sw.png"
	},
	SunderingStrikes = {
		Icon = "ui/perks/sunderingstrikes_circle.png",
		IconDisabled = "ui/perks/sunderingstrikes_circle_bw.png"
	},
	Underdog = {
		Icon = "ui/perks/perk_60.png",
		IconDisabled = "ui/perks/perk_60_sw.png"
	},
	Taunt = {
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
	LegendBruiser = {
		Icon = "ui/perks/perk_40.png",
		IconDisabled = "ui/perks/perk_40_sw.png"
	},
	LegendCacophony = {
		Icon = "ui/perks/legend_stupefy.png",
		IconDisabled = "ui/perks/legend_stupefy_bw.png"
	},
	LegendCarnage = {},
	LegendChainLightning = {},
	LegendCheerOn = {},
	LegendClarity = {},
	LegendComposure = {},
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
	LegendForcefulSwing = {},
	LegendFreedomOfMovement = {},
	LegendGrappler = {},
	LegendGruesomeFeast = {},
	LegendHairSplitter = {},
	LegendHeightenedReflexes = {},
	LegendHammerTheGap = {},
	LegendHimshaw = {},
	LegendHoldTheLine = {},
	LegendHolyFlame = {},
	LegendHorrify = {},
	LegendImmovableObject = {},
	LegendHolyFlame = {
		Icon = "ui/perks/horrify56_circle.png",
		IconDisabled = "ui/perks/horrify56_circle_bw.png"
	},
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
	LegendLionheart = {},
	LegendLithe = {},
	LegendLurker = {},
	LegendMagicMissile = {},
	LegendMagicMissileFocus = {},
	LegendSlumber = {
		Icon = "ui/perks/sleep_56.png",
		IconDisabled = "ui/perks/sleep_56_bw.png"
	},
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
	LegendParalyze = {
		Icon = "ui/perks/stun56_circle.png",
		IconDisabled = "ui/perks/stun56_circle_bw.png"
	},
	LegendPatientHunter = {},
	LegendPeaceful = {},
	LegendPenance = {},
	LegendPerfectFit = {
		HasUnactivatedPerkTooltipHints = true
	},
	LegendPerfectFocus = {},
	LegendPointBlank = {},
	LegendPoisoner = {},
	LegendPoisonImmunity = {},
	LegendPossession = {
		Icon = "ui/perks/possession_circle_56.png",
		IconDisabled = "ui/perks/possession_circle_56_bw.png"
	},
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
	LegendTasteThePain = {
		Icon = "ui/perks/twirl_circle.png", // todo icons?
		IconDisabled = "ui/perks/twirl_circle_bw.png"
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
	// removed soon
	LegendSpecBandage = {
		ID = "perk.legend_mastery_bandage",
		Script = "scripts/skills/perks/perk_legend_mastery_bandage",
		Name = "Bandage Mastery",
		Icon = "ui/perks/bandage_circle.png",
		IconDisabled = "ui/perks/bandage_circle_bw.png",
	},
	// removed soon
	LegendFieldTriage = {
		Icon = "ui/perks/MaxMedsT2.png",
		IconDisabled = "ui/perks/MaxMedsT2_bw.png"
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
	LegendThrustMaster = {
		Icon = "ui/perks/spearthrust_mastery.png",
		IconDisabled = "ui/perks/spearthrust_mastery_bw.png"
	},
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
		Name = "Horse Movement"
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

::Const.Perks.addPerkDefObjects(perkDefObjects);
