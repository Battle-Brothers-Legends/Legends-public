local colors = [
	["rune",  ::Const.UI.Color.RuneColor],
	["passive",  ::Const.UI.Color.Passive],
	["active",  ::Const.UI.Color.Active],
	["oneTimeEffect",  ::Const.UI.Color.OneTimeEffect],
	["status",  ::Const.UI.Color.Status],
	["skill",  ::Const.UI.Color.Skill],
	["perk",  ::Const.UI.Color.Perk],
	["positive", ::Const.UI.Color.PositiveValue],
	["negative", ::Const.UI.Color.NegativeValue],
	["damage", ::Const.UI.Color.DamageValue]
];

::Legends.tooltip <- function (_text, _vars = [])  {
	_vars.extend(colors);
	return ::buildTextFromTemplate(::strip(_text), _vars);
}

// perk names introduced in legends
::Const.Strings.PerkName.LegendAnchor <- "Anchor";
::Const.Strings.PerkName.LegendFirstBlood <- "First Blood";
::Const.Strings.PerkName.LegendBallistics <- "Ballistics";
::Const.Strings.PerkName.LegendBackswing <- "Backswing";
::Const.Strings.PerkName.LegendDebilitate <- "Debilitate";
::Const.Strings.PerkName.LegendPointBlank <- "Point Blank";
::Const.Strings.PerkName.LegendSlaughterer <- "Slaughterer";
::Const.Strings.PerkName.LegendBetweenTheEyes <- "Between the Eyes";
::Const.Strings.PerkName.LegendSkillfulStacking <- "Skillful Stacking";
::Const.Strings.PerkName.LegendEfficientPacking <- "Efficient Packing";
::Const.Strings.PerkName.LegendAmmoBinding <- "Ammunition Binding";
::Const.Strings.PerkName.LegendAmmoBundles <- "Ammunition Bundles";
::Const.Strings.PerkName.LegendMedPackages <- "Medicine Packages";
::Const.Strings.PerkName.LegendMedIngredients <- "Medicine Ingredients";
::Const.Strings.PerkName.LegendToolsDrawers <- "Tools Drawers";
::Const.Strings.PerkName.LegendToolsSpares <- "Spare Parts";
::Const.Strings.PerkName.LegendBarterConvincing <- "Convincing Proposals";
::Const.Strings.PerkName.LegendBarterTrustworthy <- "Trustworthy Demeanour";
::Const.Strings.PerkName.LegendBribe <- "Bribe";
::Const.Strings.PerkName.LegendOffBookDeal <- "Off-Book Deal";
::Const.Strings.PerkName.LegendRebound <- "Rebound";
::Const.Strings.PerkName.LegendFeint <- "Feint";
::Const.Strings.PerkName.LegendLookout <- "Lookout";
::Const.Strings.PerkName.LegendBoondockBlade <- "Boondock Blade";
::Const.Strings.PerkName.LegendVengeance <- "Vengeance";
::Const.Strings.PerkName.LegendDoubleStrike <- "Double Strike";
::Const.Strings.PerkName.LegendImmovableObject <- "Immovable Object";
::Const.Strings.PerkName.LegendBloodyHarvest <- "Bloody Harvest";
::Const.Strings.PerkName.LegendPerfectFocus <- "Perfect Focus";
::Const.Strings.PerkName.LegendReturnFavor <- "Return Favor";
::Const.Strings.PerkName.LegendSprint <- "Sprint";
::Const.Strings.PerkName.LegendInspire <- "Inspire";
::Const.Strings.PerkName.LegendAthlete <- "Athlete";
::Const.Strings.PerkName.LegendQuickStep <- "Quick Step";
::Const.Strings.PerkName.LegendCascade <- "Cascade strikes";
::Const.Strings.PerkName.LegendEvasion <- "Evasion";
::Const.Strings.PerkName.LegendHoldTheLine <- "Hold the line";
::Const.Strings.PerkName.LegendCoordinatedVolleys <- "Coordinated Volleys";
::Const.Strings.PerkName.LegendForwardPush <- "Push Forward";
::Const.Strings.PerkName.LegendComposure <- "Composure";
::Const.Strings.PerkName.LegendNightvision <- "Nightvision";
::Const.Strings.PerkName.LegendRelax <- "Relax";
::Const.Strings.PerkName.LegendUberNimble <- "Nudist";
::Const.Strings.PerkName.LegendMuscularity <- "Muscularity";
::Const.Strings.PerkName.LegendBattleheart <- "Battleheart";
::Const.Strings.PerkName.LegendTrueBeliever <- "True Believer";
::Const.Strings.PerkName.LegendPoisonImmunity <- "Poison Immunity";
::Const.Strings.PerkName.LegendInventorAnatomy <- "Anatomical Studies";
::Const.Strings.PerkName.LegendBerserkerRage <- "Berserker Rage";
::Const.Strings.PerkName.LegendAssuredConquest <- "Assured Conquest";
::Const.Strings.PerkName.LegendBigGameHunter <- "Big Game Hunter";
::Const.Strings.PerkName.LegendSecondWind <- "Second Wind";
::Const.Strings.PerkName.LegendMarkTarget <- "Mark Target";
::Const.Strings.PerkName.LegendFieldTriage <- "Field Triage";
::Const.Strings.PerkName.LegendFieldRepairs <- "Field Repairs";
::Const.Strings.PerkName.LegendDangerPay <- "Danger Pay";
::Const.Strings.PerkName.LegendPiercingShot <- "Piercing Shot";
::Const.Strings.PerkName.LegendTeacher <- "Teacher";
::Const.Strings.PerkName.LegendForcefulSwing <- "Forceful Swing";
::Const.Strings.PerkName.LegendSpecSpearWall <- "Spearwaller";
::Const.Strings.PerkName.LegendThrustMaster <- "Thrust Master";
::Const.Strings.PerkName.LegendBalance <- "Balance";
::Const.Strings.PerkName.LegendPerfectFit <- "Perfect Fit";
::Const.Strings.PerkName.LegendLithe <- "Lithe";
::Const.Strings.PerkName.LegendInTheZone <- "In the Zone";
::Const.Strings.PerkName.LegendHidden <- "Camouflage";
::Const.Strings.PerkName.LegendBlendIn <- "Blend in";
::Const.Strings.PerkName.LegendDrumsOfWar <- "War Chant";
::Const.Strings.PerkName.LegendSpecStaffStun <- "Staff Spins";
::Const.Strings.PerkName.LegendPugilist <- "Pugilist";
::Const.Strings.PerkName.LegendGrappler <- "Grappler";
::Const.Strings.PerkName.LegendAmbidextrous <- "Ambidextrous";
::Const.Strings.PerkName.LegendPummelIntoSubmission <- "Pummel into Submission";
::Const.Strings.PerkName.LegendFieldTreats <- "Field Treats";
::Const.Strings.PerkName.LegendSmashingShields <- "Smashing Shields";
::Const.Strings.PerkName.LegendSmackdown <- "Smackdown";
::Const.Strings.PerkName.LegendBoneBreaker <- "Bone Breaker";
::Const.Strings.PerkName.LegendClarity <- "Clarity";
::Const.Strings.PerkName.LegendAlert <- "Alert";
::Const.Strings.PerkName.LegendBloodbath <- "Bloodbath";
::Const.Strings.PerkName.LegendFreedomOfMovement <- "Freedom of Movement";
::Const.Strings.PerkName.LegendOnslaught <- "Onslaught";
::Const.Strings.PerkName.LegendBackToBasics <- "Back to Basics";
::Const.Strings.PerkName.LegendPushTheAdvantage <- "Push The Advantage";
::Const.Strings.PerkName.LegendMindOverBody <- "Mind over Body";
::Const.Strings.PerkName.LegendEscapeArtist <- "Escape Artist";
::Const.Strings.PerkName.LegendGatherer <- "Gatherer";
::Const.Strings.PerkName.LegendPotionBrewer <- "Potion Brewer";
::Const.Strings.PerkName.LegendPrepareBleed <- "Exsanguination";
::Const.Strings.PerkName.LegendPrepareGraze <- "Evisceration";
::Const.Strings.PerkName.LegendCarnage <- "Carnage";
::Const.Strings.PerkName.LegendUntouchable <- "Untouchable";
::Const.Strings.PerkName.LegendAssassinate <- "Assassinate";
::Const.Strings.PerkName.LegendMealPreperation <- "Meal Preparation";
::Const.Strings.PerkName.LegendAlcoholBrewing <- "Alcohol Brewing";
::Const.Strings.PerkName.LegendDrumsOfLife <- "Song of Life";
::Const.Strings.PerkName.LegendLacerate <- "Lacerate";
::Const.Strings.PerkName.LegendPeaceful <- "Peaceable";
::Const.Strings.PerkName.LegendNetRepair <- "Net Repair";
::Const.Strings.PerkName.LegendNetCasting <- "Net Casting";
::Const.Strings.PerkName.LegendPacifist <- "Pacifist";
::Const.Strings.PerkName.LegendCampCook <- "Camp Cooking";
::Const.Strings.PerkName.LegendPackleader <- "Pack Leader";
::Const.Strings.PerkName.LegendDogWhisperer <- "Dog Whisperer";
::Const.Strings.PerkName.LegendDogBreeder <- "Dog Breeder";
::Const.Strings.PerkName.LegendDogHandling <- "Dog Handling";
::Const.Strings.PerkName.LegendDogMaster <- "Dog Master";
::Const.Strings.PerkName.LegendHeightenedReflexes <- "Heightened Reflexes";
::Const.Strings.PerkName.LegendWindReader <- "Wind Reader";
::Const.Strings.PerkName.LegendPaymaster <- "Paymaster";
::Const.Strings.PerkName.LegendQuartermaster <- "Quartermaster";
::Const.Strings.PerkName.LegendBarterGreed <- "Greed";
::Const.Strings.PerkName.LegendPrayerOfLife <- "Prayer of Hope";
::Const.Strings.PerkName.LegendPrayerOfFaith <- "Prayer of Faith";
::Const.Strings.PerkName.LegendHolyFlame <- "Holy Flame";
::Const.Strings.PerkName.LegendShieldsUp <- "Shields Up!";
::Const.Strings.PerkName.LegendIncoming <- "Incoming!";
::Const.Strings.PerkName.LegendZombieBite <- "Zombie bite";
::Const.Strings.PerkName.LegendCheerOn <- "Cheer On";
::Const.Strings.PerkName.LegendLeap <- "Leap";
::Const.Strings.PerkName.LegendTumble <- "Tumble";
::Const.Strings.PerkName.LegendBackflip <- "Backflip";
::Const.Strings.PerkName.LegendTwirl <- "Twirl";
::Const.Strings.PerkName.LegendHairSplitter <- "Hair Splitter";
::Const.Strings.PerkName.LegendScrollIngredients <- "Interpretation";
::Const.Strings.PerkName.LegendScholar <- "Scholar";
::Const.Strings.PerkName.LegendHerbcraft <- "Herbcraft";
::Const.Strings.PerkName.LegendWoodworking <- "Woodworking";
::Const.Strings.PerkName.LegendOreHunter <- "Ore Hunter";
::Const.Strings.PerkName.LegendThrowSand <- "Throw Sand";
::Const.Strings.PerkName.LegendLastStand <- "Last Stand";
::Const.Strings.PerkName.LegendGuideSteps <- "Guide Steps";
::Const.Strings.PerkName.LegendTasteThePain <- "Taste the Pain";
::Const.Strings.PerkName.LegendKnifeplay <- "Knifeplay";
::Const.Strings.PerkName.LegendOpportunist <- "Opportunist";
::Const.Strings.PerkName.LegendPrepared <- "Prepared";
::Const.Strings.PerkName.LegendLurker <- "Lurker";
::Const.Strings.PerkName.LegendNightRaider <- "Night Raider";
::Const.Strings.PerkName.LegendAdaptive <- "Adaptive";
::Const.Strings.PerkName.LegendRecuperation <- "Recuperation";
::Const.Strings.PerkName.LegendClimb <- "Climb";
::Const.Strings.PerkName.LegendFashionable <- "Fashionable";
::Const.Strings.PerkName.LegendHelpful <- "Helpful";
::Const.Strings.PerkName.LegendLionheart <- "Lionheart";
::Const.Strings.PerkName.LegendStrengthInNumbers <- "Strength in Numbers";
::Const.Strings.PerkName.LegendPatientHunter <- "The Patient Hunter";
::Const.Strings.PerkName.LegendBarrage <- "Barrage";
::Const.Strings.PerkName.LegendStaffBlock <- "Staff Block";
::Const.Strings.PerkName.LegendMinnesanger <- "Minnesänger";
::Const.Strings.PerkName.LegendMeistersanger <- "Meistersänger";
::Const.Strings.PerkName.LegendHimshaw <- "Himshaw";
::Const.Strings.PerkName.LegendSwagger <- "Swagger";
::Const.Strings.PerkName.LegendKeenEyesight <- "Keen Eyesight";
::Const.Strings.PerkName.LegendSleightOfHand <- "Sleight of Hand";
::Const.Strings.PerkName.LegendPromisedPotential <- "Promised Potential";
::Const.Strings.PerkName.LegendWheelMaintenance <- "Wheel Maintenance";
::Const.Strings.PerkName.LegendMasterTrainer <- "Master Trainer";
::Const.Strings.PerkName.LegendWhipThemInShape <- "Whip them in Shape";
::Const.Strings.PerkName.LegendTacticalManeuvers <- "Tactical Maneuvers";
::Const.Strings.PerkName.LegendVersatile <- "Versatile";

//MASTERIES - skills that have a unified effect on their weapon class
::Const.Strings.PerkName.LegendSpecPoison <- "Poison Mastery";
::Const.Strings.PerkName.LegendSpecBandage <- "Bandage Mastery";
::Const.Strings.PerkName.LegendMasteryStaves <- "Magic Staff Mastery";
::Const.Strings.PerkName.LegendMasteryMusic <- "Music Mastery";
::Const.Strings.PerkName.LegendMasteryNets <- "Net Mastery";
::Const.Strings.PerkName.LegendMasterySlings <- "Sling Mastery";
::Const.Strings.PerkName.LegendSpecUnarmed <- "Unarmed Mastery";

//VALA SKILLS - skills used only be the Vala
//todo, had to uncomment it, otherwise it crashes - chopeks
::Const.Strings.PerkName.LegendValaInscriptionMastery <- "Inscription Mastery";
::Const.Strings.PerkName.LegendValaInscribeWeapon <- "Rune Sigils: Weapons";
::Const.Strings.PerkName.LegendValaInscribeHelmet <- "Rune Sigils: Helmets";
::Const.Strings.PerkName.LegendValaInscribeArmor <- "Rune Sigils: Armors";
::Const.Strings.PerkName.LegendValaInscribeShield <- "Rune Sigils: Shields";
//todo end
::Const.Strings.PerkName.LegendValaChantMastery <- "Chanting Mastery";
::Const.Strings.PerkName.LegendValaChantDisharmony <- "Disharmony (Chant)";
::Const.Strings.PerkName.LegendValaChantFury <- "Fury (Chant)";
::Const.Strings.PerkName.LegendValaChantSenses <- "Heightened Senses (Chant)";
::Const.Strings.PerkName.LegendValaTranceMastery <- "Trance Mastery";
::Const.Strings.PerkName.LegendValaTrancePerspective <- "Incorporeal Perspective (Trance)";
::Const.Strings.PerkName.LegendValaTranceMalevolent <- "Malevolent Spirits (Trance)";
::Const.Strings.PerkName.LegendValaWarden <- "Warden";
::Const.Strings.PerkName.LegendValaSpiritualBond <- "Spiritual Bond";
::Const.Strings.PerkName.LegendValaThreads <- "Threads of Fate";
::Const.Strings.PerkName.LegendValaPremonition <- "Premonition";

//SPECIALIST SKILLS - skills that utilise more basic equipment or playstyles for bigger bonuses.
::Const.Strings.PerkName.LegendSpecialistButcher <- "Butchers Fillet";
::Const.Strings.PerkName.LegendSpecialistBlacksmith <- "Blacksmiths Technique";
::Const.Strings.PerkName.LegendSpecialistPrisoner <- "Prisoners Rush";
::Const.Strings.PerkName.LegendSpecialistMusician <- "Entrancing Song";
::Const.Strings.PerkName.LegendSpecialistMilitia <- "Militia Practice";
::Const.Strings.PerkName.LegendSpecialistMiner <- "Miners Strikes";
::Const.Strings.PerkName.LegendSpecialistFarmhand <- "Hay Baling";
::Const.Strings.PerkName.LegendSpecialistPoacher <- "Poachers Arm";
::Const.Strings.PerkName.LegendSpecialistGravedigger <- "Gravesman";
::Const.Strings.PerkName.LegendSpecialistWoodsman <- "Woodsman\'s Cuts";
::Const.Strings.PerkName.LegendSpecialistHerbalist <- "Harvest Twist";
::Const.Strings.PerkName.LegendSpecialistShepherd <- "Shepherd\'s Signature";
::Const.Strings.PerkName.LegendSpecialistCultist <- "Scourging";
::Const.Strings.PerkName.LegendSpecialistReaper <- "Harvest Swathes";
::Const.Strings.PerkName.LegendSpecialistSelfdefense <- "Stick Fighting";
::Const.Strings.PerkName.LegendSpecialistShieldSkill <- "Born With a Board";
::Const.Strings.PerkName.LegendSpecialistShieldPush <- "Push it";
::Const.Strings.PerkName.LegendSpecialistInventor <- "Inventor\'s Armaments";
::Const.Strings.PerkName.LegendSpecialistBodyguard <- "Schwertkampfer";
::Const.Strings.PerkName.LegendSpecialistInquisition <- "Trial for Witchcraft";
::Const.Strings.PerkName.LegendSpecialistClub <- "Browbeater\'s Bludgeon";
::Const.Strings.PerkName.LegendSpecialistRaider <- "Marauder\'s Edge";
::Const.Strings.PerkName.LegendSpecialistSpearfisher <- "Tip of the Fisherman";
::Const.Strings.PerkName.LegendSpecialistSharpshooter <- "Death from Above";
::Const.Strings.PerkName.LegendSpecCultHood <- "Dedication";
::Const.Strings.PerkName.LegendSpecCultArmor <- "Penance";

//FAVOURED ENEMY - skills that grant bonuses to specfic enemy types
::Const.Strings.PerkName.LegendFavouredEnemyGhoul <- "Favoured Enemy - Nachzehrer";
::Const.Strings.PerkName.LegendFavouredEnemyHexen <- "Favoured Enemy - Hexen";
::Const.Strings.PerkName.LegendFavouredEnemyAlps <- "Favoured Enemy - Alp";
::Const.Strings.PerkName.LegendFavouredEnemyUnhold <- "Favoured Enemy - Unhold";
::Const.Strings.PerkName.LegendFavouredEnemyLindwurm <- "Favoured Enemy - Lindwurm";
::Const.Strings.PerkName.LegendFavouredEnemyDirewolf <- "Favoured Enemy - Direwolf";
::Const.Strings.PerkName.LegendFavouredEnemySpider <- "Favoured Enemy - Spider";
::Const.Strings.PerkName.LegendFavouredEnemySchrat <- "Favoured Enemy - Schrat";
::Const.Strings.PerkName.LegendFavouredEnemyOrk <- "Favoured Enemy - Orc";
::Const.Strings.PerkName.LegendFavouredEnemyGoblin <- "Favoured Enemy - Goblin";
::Const.Strings.PerkName.LegendFavouredEnemyVampire <- "Favoured Enemy - Greater Dead";
::Const.Strings.PerkName.LegendFavouredEnemySkeleton <- "Favoured Enemy - Ancient Dead";
::Const.Strings.PerkName.LegendFavouredEnemyZombie <- "Favoured Enemy - Wiedergänger";
::Const.Strings.PerkName.LegendFavouredEnemyNoble <- "Favoured Enemy - Noble";
::Const.Strings.PerkName.LegendFavouredEnemyBandit <- "Favoured Enemy - Brigand";
::Const.Strings.PerkName.LegendFavouredEnemyBarbarian <- "Favoured Enemy - Barbarian";
::Const.Strings.PerkName.LegendFavouredEnemyArcher <- "Favoured Enemy - Archer";
::Const.Strings.PerkName.LegendFavouredEnemySwordmaster <- "Favoured Enemy - Sword Master";
::Const.Strings.PerkName.LegendFavouredEnemyMercenary <- "Favoured Enemy - Mercenary";
::Const.Strings.PerkName.LegendFavouredEnemyCaravan <- "Favoured Enemy - Peasantry";
::Const.Strings.PerkName.LegendFavouredEnemySoutherner <- "Favoured Enemy - Southerner";
::Const.Strings.PerkName.LegendFavouredEnemyNomad <- "Favoured Enemy - Nomad";

//MAGIC - skills that have a magical or mystical element to them.
::Const.Strings.PerkName.LegendMagicBurningHands <- "Burning Hands";
::Const.Strings.PerkName.LegendMagicChainLightning <- "Chain Lightning";
::Const.Strings.PerkName.LegendMagicCircleOfProtection <- "Circle of Protection";
::Const.Strings.PerkName.LegendMagicDaze <- "Daze";
::Const.Strings.PerkName.LegendMagicHailstone <- "Hailstone";
::Const.Strings.PerkName.LegendMagicHealingWind <- "Healing Wind";
::Const.Strings.PerkName.LegendMagicImbue <- "Imbue";
::Const.Strings.PerkName.LegendMagicLevitate <- "Levitate";
::Const.Strings.PerkName.LegendMagicMissile <- "Magic Missile";
::Const.Strings.PerkName.LegendMagicPsybeam <- "Psybeam";
::Const.Strings.PerkName.LegendMagicSleep <- "Sleep";
::Const.Strings.PerkName.LegendMagicSoothingWind <- "Soothing Wind";
::Const.Strings.PerkName.LegendMagicTeleport <- "Teleport";
::Const.Strings.PerkName.LegendMagicWebBolt <- "Web Bolt";
::Const.Strings.PerkName.LegendMasteryBurningHands <- "Intense Flames";
::Const.Strings.PerkName.LegendMasteryChainLightning <- "Polarized";
::Const.Strings.PerkName.LegendMasteryHailstone <- "Dense Ice";
::Const.Strings.PerkName.LegendMagicMissileFocus <- "Magic Missile Focus";
::Const.Strings.PerkName.LegendMagicMissileMastery <- "Magic Missile Mastery";
::Const.Strings.PerkName.LegendRoots <- "Roots";
::Const.Strings.PerkName.LegendSummonStorm <- "Summon Storm";
::Const.Strings.PerkName.LegendCallLightning <- "Call Lightning";
::Const.Strings.PerkName.LegendScryTrance <- "Scry Area (Trance)";
::Const.Strings.PerkName.LegendReadOmensTrance <- "Read Omens (Trance)";
::Const.Strings.PerkName.LegendDistantVisions <- "Distant Visions";
::Const.Strings.PerkName.LegendSummonHound <- "Summon Hound";
::Const.Strings.PerkName.LegendSummonWolf <- "Summon Wolf";
::Const.Strings.PerkName.LegendSummonFalcon <- "Summon Falcon";
::Const.Strings.PerkName.LegendSummonBear <- "Bear Taming";
::Const.Strings.PerkName.LegendRust <- "Rust";
::Const.Strings.PerkName.LegendWither <- "Wither";
::Const.Strings.PerkName.LegendDeathtouch <- "Death Touch";
::Const.Strings.PerkName.LegendHex <- "Hex";
::Const.Strings.PerkName.LegendMiasma <- "Miasma";
::Const.Strings.PerkName.LegendDarkflight <- "Darkflight";
::Const.Strings.PerkName.LegendDaze <- "Daze";
::Const.Strings.PerkName.LegendStun <- "Stun";
::Const.Strings.PerkName.LegendHorrify <- "Horrify";
::Const.Strings.PerkName.LegendPush <- "Revolt";
::Const.Strings.PerkName.LegendEntice <- "Entice";
::Const.Strings.PerkName.LegendSleep <- "Sleep";
::Const.Strings.PerkName.LegendFirefield <- "Firefield";
::Const.Strings.PerkName.LegendPossessUndead <- "Possess Undead";
::Const.Strings.PerkName.LegendInsects <- "Insect Swarm";
::Const.Strings.PerkName.LegendChainLightning <- "Chain Lightning";
::Const.Strings.PerkName.LegendRaiseUndead <- "Raise the Dead";
::Const.Strings.PerkName.LegendSummonCat <- "Summon Familiar";
::Const.Strings.PerkName.LegendSpawnZombieLow <- "Mold Carrion";
::Const.Strings.PerkName.LegendSpawnZombieMed <- "Fashion Body";
::Const.Strings.PerkName.LegendSpawnZombieHigh <- "Remake Man";
::Const.Strings.PerkName.LegendSpawnSkeletonLow <- "Arrange Bones";
::Const.Strings.PerkName.LegendSpawnSkeletonMed <- "Align Joints";
::Const.Strings.PerkName.LegendSpawnSkeletonHigh <- "Rebuild Skeleton";
::Const.Strings.PerkName.LegendExtendendAura <- "Extended Aura";
::Const.Strings.PerkName.LegendChanneledPower <- "Channeled Power";
::Const.Strings.PerkName.LegendReclamation <- "Reclamation";
::Const.Strings.PerkName.LegendConservation <- "Conservation";
::Const.Strings.PerkName.LegendEnthrall <- "Enthrall";
::Const.Strings.PerkName.LegendViolentDecomposition <- "Violent Decomposition";
::Const.Strings.PerkName.LegendPossession <- "Possession";
::Const.Strings.PerkName.LegendSiphon <- "Siphon";
::Const.Strings.PerkName.LegendGruesomeFeast <- "Gruesome Feast";
::Const.Strings.PerkName.LegendResurrectionist <- "Resurrectionist";
::Const.Strings.PerkName.LegendScry <- "Scry";
::Const.Strings.PerkName.LegendLevitate <- "Levitate";
::Const.Strings.PerkName.LegendTeleport <- "Teleport";
::Const.Strings.PerkName.LegendTerrifyingVisage <- "Terrifying Visage";
::Const.Strings.PerkName.LegendMagicMissile <- "Magic Missile";
::Const.Strings.PerkName.LegendBrinkOfDeath <- "Brink of Death"; //66% chance to return a fallen bro as a zombie, needs functionality check.

//ANIMAL FORMS - animal forms from older builds. Mostly defunct.
::Const.Strings.PerkName.LegendSurpressUrges <- "Suppress Urges";
::Const.Strings.PerkName.LegendControlInstincts <- "Control Instincts";
::Const.Strings.PerkName.LegendMasterAnger <- "Master Anger";
::Const.Strings.PerkName.LegendWolfform <- "Wolf Form";
::Const.Strings.PerkName.LegendTrueForm <- "True Form";
::Const.Strings.PerkName.LegendBearform <- "Bear Form";
::Const.Strings.PerkName.LegendInfectiousRage <- "Infectious Rage";

//HORSES - skills for horses, currently unused and/or missing files
::Const.Strings.PerkName.LegendHorseCharge <- "Mounted Charge";
::Const.Strings.PerkName.LegendHorsePirouette <- "Pirouette";
::Const.Strings.PerkName.LegendHorseBitting <- "Bitting";
::Const.Strings.PerkName.LegendHorseDesensitization <- "Desensitization";
::Const.Strings.PerkName.LegendHippology <- "Hippology";
::Const.Strings.PerkName.LegendHorseImpulsion <- "Impulsion";
::Const.Strings.PerkName.LegendHorseLeadChange <- "Lead Change";
::Const.Strings.PerkName.LegendHorseLegControl <- "Leg Control";
::Const.Strings.PerkName.LegendHorseLiberty <- "Liberty";
::Const.Strings.PerkName.LegendHorseLongeing <- "Longeing";
::Const.Strings.PerkName.LegendHorseParthianShot <- "Parthian Shot";
::Const.Strings.PerkName.LegendHorsePiaffe <- "Piaffe";
::Const.Strings.PerkName.LegendHorseTempiChange <- "Tempi Change";
::Const.Strings.PerkName.LegendHorseMovement <- "Horse Movement";
::Const.Strings.PerkName.LegendHorseCollection <- "Collection";
::Const.Strings.PerkName.LegendHorseFlyingChange <- "Flying Change";
::Const.Strings.PerkName.LegendHorsePassage <- "Passage";

//AI SKILLS - skills used by AI specfically
::Const.Strings.PerkName.LegendBruiser <- "Bruiser"; //increases armour penetration by 10%, is an AI skill
::Const.Strings.PerkName.BatteringRam <- "Battering Ram"; //gives orcs stun immunity, similar to composure skill

//UNUSED - skills otherwise defunct or missing files/functionality
::Const.Strings.PerkName.LegendRoster <- "The Apprentice"; //REMOVE
::Const.Strings.PerkName.LegendRoster1 <- "The Apprentice"; //REMOVE
::Const.Strings.PerkName.LegendRoster2 <- "The Bodyguards"; //REMOVE
::Const.Strings.PerkName.LegendRoster3 <- "The Team"; //REMOVE
::Const.Strings.PerkName.LegendRoster4 <- "The Squad"; //REMOVE
::Const.Strings.PerkName.LegendRoster5 <- "The Section"; //REMOVE
::Const.Strings.PerkName.LegendRoster6 <- "The Platoon"; //REMOVE
::Const.Strings.PerkName.LegendRoster7 <- "The Company"; //REMOVE
::Const.Strings.PerkName.LegendCrusher <- "Crusher"; //exists but has no data to provide any affect
::Const.Strings.PerkName.LegendDeflect <- "Deflect"; //exists but has no data to provide any affect
::Const.Strings.PerkName.LegendIronside <- "Ironside"; //gives damage reduction based on number of adj. enemies
::Const.Strings.PerkName.LegendBecomeBerserker <- "Become Berserker"; //converts a background to a berserker, unknown use.
::Const.Strings.PerkName.LegendPreparedForAnything <- "Prepare For Anything"; //gives bags and belts for some reason...?
::Const.Strings.PerkName.LegendStrictSermons <- "Strict Sermons"; //gives fortified mind for crusader origin. Can probably be removed.
::Const.Strings.PerkName.LegendCitrinitas <- "Citrinitas (Trance)"; //alchemist skill, currently not working/implemented
::Const.Strings.PerkName.LegendAlbedo <- "Albedo"; //alchemist skill, currently not working/implemented
::Const.Strings.PerkName.LegendNigredo <- "Nigredo"; //alchemist skill, currently not working/implemented
::Const.Strings.PerkName.LegendSummonCatapult <- "Summon Catapult"; //pulled due to issues with deployment, could work in the future.

::Const.Strings.PerkDescription.LegendAnchor <- ::Legends.tooltip(@"
Hold your ground!

[color=%passive%][u]Passive:[/u][/color]
• Gain a stacking [color=%positive%]+5[/color] Melee Skill, Ranged Skill and Melee Defense as long as you have not moved during your turn. You will start combat with 1 stack.

• If you were to receive [color=%status%]Stagger[/color] instead remove a stack.
");

::Const.Strings.PerkDescription.LegendFirstBlood <- ::Legends.tooltip(@"
Early bird gets the worm!

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]20%[/color] Damage and [color=%positive%]+50%[/color] Threshold to inflict injury on enemies with full hitpoints.
");

::Const.Strings.PerkDescription.LegendBallistics <- ::Legends.tooltip(@"
Through familiarity and training with your weapon, you know just how your projectiles will fly.

[color=%passive%][u]Passive:[/u][/color]
• Up to [color=%positive%]+20%[/color] of any damage ignores armor depending on the distance to the target, with the highest bonus in melee and lowest at maximum range for [color=%skill%]Shoot Bolt[/color]. For [color=%skill%]Shoot Heavy Bolt[/color] and [color=%skill%]Shoot Stake[/color] the bonus goes up to [color=%positive%]+30%[/color] instead.

• The range penalty to hitchance is reduced by [color=%negative%]-2[/color] per tile.
");

::Const.Strings.PerkDescription.LegendBackswing <- ::Legends.tooltip(@"
Use your built up inertia to wreak havoc on the second swing.

[color=%passive%][u]Passive:[/u][/color]
• After performing [color=%skill%]Round Swing[/color], [color=%skill%]Swing[/color], [color=%skill%]Thresh[/color], [color=%skill%]Reap[/color], [color=%skill%]Castigate[/color] and [color=%skill%]Shatter[/color] you can perform a followup for [color=%negative%]-50%[/color] Fatigue and Action Points. [color=%skill%]Swing[/color] Damage is reduced by [color=%negative%]-25%[/color] and for the rest of the skills by [color=%negative%]-50%[/color].

• Moving, ending your turn or waiting will all remove this effect.
");

::Const.Strings.PerkDescription.LegendDebilitate <- ::Legends.tooltip(@"
Ankles, hands, elbows and knees, you've learned how to fight dirty to secure victory.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Debilitate[/color] skill which can prime your next attack to [color=%status%]Cripple[/color] a target for three turns, reducing their ability to inflict damage by [color=%negative%]-25%[/color] and increasing the damage they take by [color=%positive%]+15%[/color].

• Costs [color=%negative%]3[/color] AP and [color=%negative%]10[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendReturnFavor <- ::Legends.tooltip(@"
Strike back with interest!

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Return Favor[/color] skill which when activated has a [color=%positive%]75%[/color] chance to [color=%status%]Stun[/color] any opponent missing a melee attack against this character in retaliation.

• Immunities and resistances against being [color=%status%]Stunned[/color] still apply.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]30[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendPerfectFocus <- ::Legends.tooltip(@"
Take a deep breath, then get to work.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Perfect Focus[/color] skill which allows the use of all other skills at [color=%negative%]half[/color] the normal Action Point cost (rounded down), but increases Fatigue cost by [color=%positive%]+75%[/color] for one round.

• Costs [color=%negative%]1[/color] AP and [color=%negative%]10[/color] Fatigue.
");

// ::Const.Strings.PerkDescription.Furor <- ::Legends.tooltip(@"
//[color=%active%][u]Active:[/u][/color]
//• Unlocks the [color=%skill%]Furor[/color] skill which allows for an unlimited number of other skill uses for a single turn until the character is completely Fatigued.
//
//	• Costs [color=%negative%]5[/color] AP and [color=%negative%]25[/color] Fatigue.
//	");

::Const.Strings.PerkDescription.LegendBloodyHarvest <- ::Legends.tooltip(@"
There's wolves, bears, nachzehrers, and you. All beings of vicious slaughter.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+10%[/color] chance to hit and damage for all Melee area of effect attacks.
");

::Const.Strings.PerkDescription.LegendImmovableObject <- ::Legends.tooltip(@"
Heavy armor, a trusty shield and your heels dug into the ground and you can weather any storm.

[color=%passive%][u]Passive:[/u][/color]
• For every 10 points of gear weight from all slot gain [color=%positive%]1[/color] Resolve and [color=%negative%]1%[/color] less damage ignoring armor.

• If you have at least 50 gear weight become immune to stuns.

• If you have at least 80 gear weight and [color=%perk%]Steel Brow[/color] become immune to knockback and grab.
");

::Const.Strings.PerkDescription.LegendDoubleStrike <- ::Legends.tooltip(@"
Master the art of following up for devastating effects.

[color=%passive%][u]Passive:[/u][/color]
• After landing a hit, the next attack this turn does [color=%positive%]+25%[/color] overall damage and it costs [color=%negative%]-20%[/color] less Fatigue than normal.

• If the attack misses, the effect is lost.
");

::Const.Strings.PerkDescription.LegendVengeance <- ::Legends.tooltip(@"
'You've done it now!'

[color=%passive%][u]Passive:[/u][/color]
• After receiving a blow, the next attack this character attempts will inflict [color=%positive%]+100%[/color] damage to both Hitpoints and armor.

• If the attack misses the effect is wasted. Does not work from friendly fire or any self inflicted damage.

• Additionally a party member or pet dying will trigger the effect.
");

::Const.Strings.PerkDescription.LegendBruiser <- ::Legends.tooltip(@"
Your muscles are an unstoppable force, shattering armor with every strike!

[color=%passive%][u]Passive:[/u][/color]
• Effectiveness vs. Armor is increased by [color=%positive%]+10%[/color] for any weapon used.
");

::Const.Strings.PerkDescription.LegendCrusher <- ::Legends.tooltip(@"
Put full force in your every blow!

[color=%passive%][u]Passive:[/u][/color]
• Shield damage is increased by [color=%positive%]+50%[/color] when using the Split Shield skill.
");

::Const.Strings.PerkDescription.LegendPointBlank <- ::Legends.tooltip(@"
If you can see the white in your enemy's eyes, aim for it!

[color=%passive%][u]Passive:[/u][/color]
• When using a ranged weapon against a target 4 or less tiles away, inflict additional damage, scaling based on [color=%positive%]20%[/color] of Ranged Defense.

• When using Throwing Weapons inflict additional damage, scaling based on [color=%positive%]30%[/color] of Melee Skill or [color=%positive%]50%[/color] of Ranged Defense, whichever stat is highest, but maximum range is reduced to 3.

• Allows you to use Throwing Weapons in melee.
");

::Const.Strings.PerkDescription.LegendSlaughterer <- ::Legends.tooltip(@"
'I powdered my pigeon for the ribcage slaughter!!!'

[color=%passive%][u]Passive:[/u][/color]
• Melee kills are always fatalities (if the weapon allows).

• Fatalities have a [color=%negative%]-5[/color] penalty to enemy Resolve checks.

• Having the 'Bloodthirsty' trait allows you to trigger an additional positive morale check when killing an enemy.
");

::Const.Strings.PerkDescription.LegendBetweenTheEyes <- ::Legends.tooltip(@"
Blows to the head hurt!

[color=%passive%][u]Passive:[/u][/color]The chance to hit the head for critical damage is increased by [color=%positive%]+10%[/color] for all attacks.

[color=%passive%][u]Passive:[/u][/color]
");

::Const.Strings.PerkDescription.LegendDeflect <- ::Legends.tooltip(@"
Learn to better deflect hits to the side instead of blocking them head on.

[color=%passive%][u]Passive:[/u][/color]
• Shield damage received is reduced by [color=%negative%]-50%[/color] to a minimum of [color=%damage%]1[/color].
");

::Const.Strings.PerkDescription.LegendLastStand <- ::Legends.tooltip(@"
When pushed to the brink, unleash unmatched resilience and determination.

[color=%passive%][u]Passive:[/u][/color]
• For every [color=%negative%]2%[/color] of missing Hitpoints below [color=%negative%]66%[/color] total Hitpoints, gain [color=%positive%]1[/color] additional Melee and Ranged Defense.

• When below [color=%negative%]33%[/color] total Hitpoints, this character becomes immune to the effects of fresh [color=%status%]Injuries[/color] and does not lose morale when losing Hitpoints.
");

::Const.Strings.PerkDescription.LegendIronside <- ::Legends.tooltip(@"
All damage received is reduced.

[color=%passive%][u]Passive:[/u][/color]
• Reduced by [color=%negative%]-5%[/color] for every opponent adjacent and in melee range.

• Up to a [color=%negative%]-30%[/color] total damage reduction.
");

::Const.Strings.PerkDescription.LegendRebound <- ::Legends.tooltip(@"
Surpass your limits!

[color=%passive%][u]Passive:[/u][/color]
• Fatigue regeneration is increased by [color=%positive%]10%[/color] of your currently accumulated Fatigue rounded up.
");

::Const.Strings.PerkDescription.LegendFeint <- ::Legends.tooltip(@"
A well placed feint can leave your enemy Vulnerable!

[color=%passive%][u]Passive:[/u][/color]
• If an attack misses, it costs [color=%negative%]-20%[/color] less Fatigue than normal.

• After missing an attack you leave your opponent [color=%status%]Parried[/color], lowering their defenses by [color=%negative%]10[/color].
");

::Const.Strings.PerkDescription.LegendLookout <- ::Legends.tooltip(@"
Learn to find your enemies before they find you.

[color=%passive%][u]Passive:[/u][/color]
• This Character's Vision is increased by [color=%positive%]+1[/color].

• While on duty in the scout tent they grant [color=%positive%]+10%[/color] scouting.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Mark Target[/color] skill.

• Costs [color=%negative%]2[/color] AP and [color=%negative%]15[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendBoondockBlade <- ::Legends.tooltip(@"
Catch your enemies by suprise

[color=%passive%][u]Passive:[/u][/color]
• When in a hiding place, such as high grass, gain a bonus of [color=%positive%]+10[/color] to Melee Skill, Ranged Skill, and Melee and Ranged Defense.
");

::Const.Strings.PerkDescription.LegendArtfulDodger <- ::Legends.tooltip(@"
Zone of Control is ignored when moving away from enemy combatants in melee.

[color=%passive%][u]Passive:[/u][/color]
");

::Const.Strings.PerkDescription.LegendInspire <- ::Legends.tooltip(@"
Push your allies beyond their limits!

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Inspire[/color] skill which allows you to target any ally within four tiles, and grant them [color=%positive%]4[/color] Action Points.

• Costs [color=%negative%]8[/color] AP and [color=%negative%]30[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendSprint <- ::Legends.tooltip(@"
Burst forth like a bolt of lightning, leaving all in your wake.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Sprint[/color] skill which allows you to quickly cover 4 tiles in a straight line
• does not work across rough terrain or through enemy zones of control.

• Costs [color=%negative%]5[/color] AP and [color=%negative%]25[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendQuickStep <- ::Legends.tooltip(@"
Exert yourself to move one tile at an unusually quick speed.

[color=%active%][u]Active:[/u][/color]
• Unlock the [color=%skill%]Quick Step[/color] skill which allows you to move one tile for only [color=%negative%]1[/color] AP and [color=%negative%]7[/color] Fatigue.

• Only can be used once per turn.
");

::Const.Strings.PerkDescription.LegendAthlete <- ::Legends.tooltip(@"
You're a well-rounded athlete!

[color=%passive%][u]Passive:[/u][/color]
• Reduce the Fatigue cost of all your skills by a scaling percentage based on [color=%negative%]20%[/color] of your maximum usable Fatigue. Maximum usable fatigue is your fatigue after gear weight is accounted for.
");

::Const.Strings.PerkDescription.LegendSpecPoison <- ::Legends.tooltip(@"
Unlock the deadly art of poisoning and be able to lick your poisoned weapon without dying.

[color=%passive%][u]Passive:[/u][/color]
• Renders the character immune to poison.

• Unlocks the [color=%skill%]Use Poison[/color] skill which allows you to coat your weapons with poison for your next four attacks.

• [color=%status%]Poisoned[/color] enemies have their AP and Vision reduced by [color=%negative%]1[/color] per turns left on the status effect. It also lowers Initiative by [color=%negative%]10[/color] per turns left on the status effect.

• Base [color=%status%]Poison[/color] duration is three turns.

• AP cost is reduced to [color=%negative%]0[/color] on first round of combat.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]15[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendCascade <- ::Legends.tooltip(@"
Let loose a cascade of three striking heads on your opponent striking over or around shield cover.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Cascade Strike[/color] skill which deals [color=%negative%]1/2[/color] of your weapon damage [color=%positive%]3[/color] times.

• This skill ignores defense bonuses from shields.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]13[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendEvasion <- ::Legends.tooltip(@"
'Excuse me'

[color=%active%][u]Active:[/u][/color]
• Enables the character to move swiftly and safely through any Zone of Control one turn. The first attack against you will be an automatic miss. Can only be used if your total armor weight is 30 or less.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]20[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendRust <- ::Legends.tooltip(@"
Corrode enemy armor with arcane rust, weakening their defenses.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Rust[/color] skill which inflicts damage to armor based on the caster's current Initiative. Additionally, it deals [color=%damage%]10[/color] damage to Hitpoints, bypassing armor.

• Hitchance is based on Ranged Skill and has a range of three tiles.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]10[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendWither <- ::Legends.tooltip(@"
Unleash a spell that ages with a touch, causing withering decay upon your target

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Wither[/color] skill which ages a target for three turns, reducing their Damage, Initiative and Fatigue by [color=%negative%]-30%[/color].

• This effect is reduced by [color=%negative%]10%[/color] each turn.

• Costs [color=%negative%]5[/color] AP and [color=%negative%]15[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendDeathtouch <- ::Legends.tooltip(@"
Your fingers turn ghostly and pass through steel and flesh, tearing at the soul of your victim.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Death Touch[/color] skill which uses your Melee Skill to hit.

• Damage scales with current Initiative and ignores armor.

• Costs [color=%negative%]5[/color] AP and [color=%negative%]20[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendHex <- ::Legends.tooltip(@"
You tie your soul to your enemy, your pain becomes their pain.

[color=%active%][u]Active:[/u][/color]
• Unlocks [color=%skill%]Hex[/color] skill
• Costs [color=%negative%]3[/color] AP and [color=%negative%]10[/color] Fatigue
");

::Const.Strings.PerkDescription.LegendMiasma <- ::Legends.tooltip(@"
Release a cloud of noxious gasses that are harmful to any living being.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Miasma[/color] skill which targets an enemy imbuing the surrounding tiles with noxious ground.

• Noxious ground lasts for four turns proccing when an enemy ends their turn in the miasma, dealing [color=%damage%]5-10[/color] damage per turn.

• Costs [color=%negative%]8[/color] AP and [color=%negative%]40[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendDarkflight <- ::Legends.tooltip(@"
Disapparate from your current location and reappear on the other side of the battlefield

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Darkflight[/color] skill which lets you teleport up to six tiles away.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]40[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendDaze <- ::Legends.tooltip(@"
Assault the senses of your target with a flurry of colorful movement and sounds.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Daze[/color] skill which applies the [color=%status%]Bewildered[/color] effect on hit.

• Chance to hit is based on Ranged Skill and has a range of six tiles.

• [color=%status%]Bewildered[/color] enemies have their Initiative, Fatigue, and damage reduced by [color=%negative%]-50%[/color].

• If you have the [color=%perk%]Taunt[/color] perk, chance to hit is [color=%positive%]doubled[/color].

• Costs [color=%negative%]5[/color] AP and [color=%negative%]20[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendStun <- ::Legends.tooltip(@"
Unleash a brilliant flash of white light aimed directly at the eyes of your target in an attempt to blind and incapacitate.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%status%]Stun[/color] skill which has a [color=%positive%]100%[/color] chance to [color=%status%]Stun[/color] on hit.

• Costs [color=%negative%]6[/color] AP and [color=%negative%]25[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendHorrify <- ::Legends.tooltip(@"
Blare out a piercing, unworldly sound that is more than likely to distress anyone unfortunate enough to hear it.

[color=%active%][u]Active:[/u][/color]
• Unlocks [color=%skill%]Horrify[/color] skill which has a [color=%positive%]100%[/color] chance to Horrify on hit.

• Horrified enemies are unable to act next turn.

• Costs [color=%negative%]6[/color] AP and [color=%negative%]15[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendPush <- ::Legends.tooltip(@"
Concoct a mixture of smells so fetid and noxious, you force your target to retreat just so they can breathe.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Revolt[/color] skill which knocks the target back a tile and inflicts [color=%positive%]10[/color] Fatigue.

• Chance to hit is based on Ranged Skill and has a range of six tiles.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]30[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendEntice <- ::Legends.tooltip(@"
With a trick of the light, captivate your target in such a way that they can't help but approach you.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Entice[/color] skill which pulls your target one tile towards you with a [color=%positive%]100%[/color] chance to [color=%status%]Stagger[/color] on hit.

• Chance to hit is based on Ranged Skill and has a range of nine tiles.

• Costs [color=%negative%]6[/color] AP and [color=%negative%]10[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendSleep <- ::Legends.tooltip(@"
Enshroud the area with thick smoke that draws the vigor out of your foes. Those that breathe in too much are forced into a light sleep.

[color=%active%][u]Active:[/u][/color]
• Unlocks [color=%skill%]Sleep[/color] skill.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]5[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendFirefield <- ::Legends.tooltip(@"
Unleash a raging inferno at the target location that explodes and then sets the ground alight.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Firefield[/color] skill which inflicts [color=%damage%]10[/color] - [color=%damage%]20[/color] damage twice and set the area ablaze.

• Anyone ending their turn inside the burning area will catch fire for two turns and take damage - friend and foe alike. Requires a staff.

• Costs [color=%negative%]5[/color] AP and [color=%negative%]50[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendPossessUndead <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]Allows you to boost the attacks of an undead minion.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]10[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendSprint <- ::Legends.tooltip(@"
Run as fast as you can!

[color=%active%][u]Active:[/u][/color]
• For the remainder of this turn, the Action Point cost for movement is reduced by [color=%positive%]1[/color] for each tile, but the Fatigue cost is doubled.
");

::Const.Strings.PerkDescription.LegendRoster <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• Increase roster size.
");

::Const.Strings.PerkDescription.LegendSpecBandage <- ::Legends.tooltip(@"
Master the art of bandaging mid battle using any cloth available.

[color=%passive%][u]Passive:[/u][/color]
• Unlocks the [color=%skill%]Bandage[/color] skill which allows you to bandage allies without a bandage.

• Can bandage while in a zone of control.

• Costs [color=%negative%]6[/color] AP and [color=%negative%]5[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendHoldTheLine <- ::Legends.tooltip(@"
'DON'T LET THEM BREAK THROUGH!'

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Hold the Line[/color] skill which allows you to direct your troops to stand their ground, granting [color=%positive%]+10[/color] Melee Defense, reducing damage taken by [color=%negative%]10%[/color] to all allies within four tiles for one turn.

• Costs [color=%negative%]5[/color] AP and [color=%negative%]20[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendCoordinatedVolleys <- ::Legends.tooltip(@"
'Archers HOLD!'

[color=%active%][u]Active:[/u][/color]
• Grants the [color=%skill%]Coordinated Volleys[/color] skill which grants[color=%positive%]+10[/color] ranged attack to all allies within [color=%positive%]4[/color] tiles for one turn.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]20[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendRaiseUndead <- ::Legends.tooltip(@"
Raise the dead, and turn them into your own personal army.

[color=%passive%][u]Passive:[/u][/color]
• Unlocks [color=%skill%]Conduct Seance[/color] skill which allows you to summon zombies from dead enemies.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]20[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendRoster1 <- ::Legends.tooltip(@"
Direct your attention to guiding an apprentice into the mercenary world.

[color=%passive%][u]Passive:[/u][/color]
• Increase the company roster size by [color=%positive%]1[/color].
");

::Const.Strings.PerkDescription.LegendRoster2 <- ::Legends.tooltip(@"
Spend time training bodyguards to work together.

[color=%passive%][u]Passive:[/u][/color]
• increases company roster size by [color=%positive%]2[/color].
");

::Const.Strings.PerkDescription.LegendRoster3 <- ::Legends.tooltip(@"
Set up team planning, with task lists and prioritisation.

[color=%passive%][u]Passive:[/u][/color]
• Increases the company roster size by [color=%positive%]3[/color].
");

::Const.Strings.PerkDescription.LegendRoster4 <- ::Legends.tooltip(@"
Create a squad regime, with weekly schedules and drills.

[color=%passive%][u]Passive:[/u][/color]
• Increases the company roster size by [color=%positive%]4[/color].
");

::Const.Strings.PerkDescription.LegendRoster5 <- ::Legends.tooltip(@"
Oversee the section's financial administration processes, managing pay disputes, disbursements, withholdings and loans.

[color=%passive%][u]Passive:[/u][/color]
• Increases the company roster size by [color=%positive%]5[/color].
");

::Const.Strings.PerkDescription.LegendRoster6 <- ::Legends.tooltip(@"
Manage the company logistics. Supply rationing, camp structure and waste disposal.

[color=%passive%][u]Passive:[/u][/color]
• Increases the company roster size by [color=%positive%]6[/color].
");

::Const.Strings.PerkDescription.LegendRoster7 <- ::Legends.tooltip(@"
Implement platoon organisation techniques. Balancing interteam dynamics, clarifying role responsibilities, creating conflict resolution processes and creating strategic plans.

[color=%passive%][u]Passive:[/u][/color]
• Increases the company roster size by [color=%positive%]7[/color].
");

::Const.Strings.PerkDescription.LegendInsects <- ::Legends.tooltip(@"
Unleash a horde of insects on your enemy!

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Insect Swarm[/color] skill which reduces the targets Melee Skill, Melee Defense, Ranged Skill, Ranged Defense and Initiative by [color=%negative%]50%[/color] for three turns.

• Has a range of seven tiles

• Costs [color=%negative%]6[/color] AP and [color=%negative%]15[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendForwardPush <- ::Legends.tooltip(@"
'PUSH NOW! FINISH THEM!'

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Forward Push[/color] and [color=%skill%]Coordinated Volleys[/color] skills.

• [color=%skill%]Forward Push[/color] grants [color=%positive%]+10[/color] Melee Skill, [color=%positive%]+5[/color] Resolve and [color=%positive%]+3[/color] Melee Defense to all allies within four tiles for one turn.

• [color=%skill%]Coordinated Volleys[/color] grants [color=%positive%]+10[/color] ranged attack and [color=%positive%]5%[/color] Ranged Damage Bonus to all allies within [color=%positive%]4[/color] tiles for one turn.

• Costs [color=%negative%]5[/color] AP and [color=%negative%]20[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendChainLightning <- ::Legends.tooltip(@"
Unleash an arcing barrage of lightning!

[color=%active%][u]Active:[/u][/color]
• Unlocks [color=%skill%]Chain Lightning[/color] skill which inflicts damage to up to 3 enemies, dealing [color=%damage%]15-40[/color] damage which ignores armor.

• Requires a staff.

• Costs [color=%negative%]8[/color] AP and [color=%negative%]50[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendComposure <- ::Legends.tooltip(@"
Train to keep your cool, under even the most challenging circumstances.

[color=%passive%][u]Passive:[/u][/color]
• Makes you immune to [color=%status%]Stuns[/color]
");

::Const.Strings.PerkDescription.LegendNightvision <- ::Legends.tooltip(@"
Use your superior vision and training to spot targets in the gloom, and grant that vision to your allies.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Night Vision[/color] skill which removes nighttime penalties to vision for all allies within four tiles.

• Costs [color=%negative%]6[/color] AP and [color=%negative%]20[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendMasteryStaves <- ::Legends.tooltip(@"
Learn to channel your energy through staves and deliver powerful spells.

[color=%passive%][u]Passive:[/u][/color]
• Build up [color=%negative%]25%[/color] less Fatigue when using [color=%skill%]Chain Lightning[/color], [color=%skill%]Firefield[/color], [color=%skill%]Magic Missile[/color] or [color=%skill%]Root[/color].

• Reduces AP cost of [color=%skill%]Chain Lightning[/color], [color=%skill%]Firefield[/color], [color=%skill%]Magic Missile[/color] or [color=%skill%]Root[/color] by [color=%negative%]1[/color].

• Increases the maximum range of [color=%skill%]Magic Missile[/color] by [color=%negative%]1[/color].
");

::Const.Strings.PerkDescription.LegendMasteryMusic <- ::Legends.tooltip(@"
Properly tuned with the endurance to play it.

[color=%passive%][u]Passive:[/u][/color]
• Build up [color=%negative%]25%[/color] less Fatigue when using songs and reduce their AP cost by [color=%negative%]1[/color].

• [color=%skill%]Revolt[/color] and [color=%skill%]Entice[/color] build up [color=%negative%]25%[/color] less Fatigue when using songs and reduce their AP cost by [color=%negative%]1[/color]. Additionally [color=%skill%]Revolt[/color] will no longer have a penalty to hit chance when used in melee.

• Increases the effects of [color=%skill%]Song of Life[/color] and [color=%skill%]War Chant[/color] by [color=%positive%]3[/color] Hitpoints and [color=%positive%]2[/color] Fatigue, respectively.
");

::Const.Strings.PerkDescription.LegendGruesomeFeast <- ::Legends.tooltip(@"
Taste of the forbidden flesh.

[color=%active%][u]Active:[/u][/color]
• Unlocks [color=%skill%]Gruesome Feast[/color] skill which allows you to devour a recently departed corpse to gain strength and restore your own Hitpoints by [color=%positive%]50[/color].

• Costs [color=%negative%]7[/color] AP and [color=%negative%]40[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendRelax <- ::Legends.tooltip(@"
Sooth an ally, halving their Fatigue.

[color=%active%][u]Active:[/u][/color]
• Unlocks [color=%skill%]Relax[/color] skill which reduces accumlated Fatigue by [color=%negative%]50%[/color] for any ally within three tiles.

• Costs [color=%negative%]9[/color] AP and [color=%negative%]30[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendUberNimble <- ::Legends.tooltip(@"
Real berserkers don't need pants.

[color=%passive%][u]Passive:[/u][/color]
• Gain another stack of nimble when wearing no armor and helmet.
");

::Const.Strings.PerkDescription.LegendMuscularity <- ::Legends.tooltip(@"
Put your full weight into every blow!

[color=%passive%][u]Passive:[/u][/color]
• When using Melee Weapons, Unarmed, Throwing and Bows inflict additional damage, scaling based on [color=%positive%]10%[/color] of your current Hitpoints and [color=%positive%]15%[/color] of current Fatigue.

• However, when below [color=%negative%]50%[/color] Hitpoints or Fatigue all damage inflicted will be increased by [color=%positive%]5%[/color] of maximum Hitpoints or [color=%positive%]7.5%[/color] of maximum Fatigue, instead.

• Fatigue calculations are done after gear and values might change in combat.
");

::Const.Strings.PerkDescription.LegendBattleheart <- ::Legends.tooltip(@"
Wade into the thick of battle, dodging blades from behind and above, aware of all around you at the heart of the battle.

[color=%passive%][u]Passive:[/u][/color]
• Being surrounded no longer affects this character's defences at all.

• Upgraded version of [color=%perk%]Underdog[/color], immune to [color=%perk%]Strength In Numbers[/color].
");

::Const.Strings.PerkDescription.LegendTrueBeliever <- ::Legends.tooltip(@"
Lesser men may cower and flee, but you are unassuageable in your commitment.

[color=%passive%][u]Passive:[/u][/color]
• Allies [color=%status%]Fleeing[/color] or dying no longer lowers this character's morale.

• This character gains [color=%positive%]+5%[/color] Resolve for every [color=%status%]Fleeing[/color] character on the field, friend or foe.

• Taking this perk also removes the superstitious, insecure, craven, and dastard traits.
");

::Const.Strings.PerkDescription.LegendPoisonImmunity <- ::Legends.tooltip(@"
With a well developed immune system and incredible fitness, a warrior's system can shrug off even powerful toxins.

[color=%passive%][u]Passive:[/u][/color]
• This character becomes immune to all poisons.
");

::Const.Strings.PerkDescription.LegendSummonCat <- ::Legends.tooltip(@"
Summon feline familiar to your aide. Don't worry, this particular cat has nine times a million lives.

[color=%active%][u]Active:[/u][/color]
• Summons a feline familiar to your side in battle.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]15[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendSpawnZombieLow <- ::Legends.tooltip(@"
Raise a half-formed thrall from a pile of mismatched dead flesh. Though lacking in strength or bodily integrity, it shall obey.

[color=%active%][u]Active:[/u][/color]
• Requires [color=%negative%]15[/color] Hitpoints to summon and [color=%negative%]1[/color] human carrion.

• Taking this perk grants [color=%positive%]+20[/color] Hitpoints.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]10[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendSpawnZombieMed <- ::Legends.tooltip(@"
Organize the remains before you raise it so that your creation is better suited to the work it is given. Sturdier in both form and function.

[color=%active%][u]Active:[/u][/color]
• Requires [color=%negative%]20[/color] Hitpoints to summon and [color=%negative%]1[/color] human carrion.

• Taking this perk adds [color=%positive%]+30[/color] medicine to your stash and increases total medicine by [color=%positive%]+30[/color].

• Costs [color=%negative%]4[/color] AP and [color=%negative%]20[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendSpawnZombieHigh <- ::Legends.tooltip(@"
Stitch the body together with such precision so that, once raised, it could pass as alive. A magnum opus of flesh, unsurpassed in power.

[color=%active%][u]Active:[/u][/color]
• Requires [color=%negative%]30[/color] Hitpoints to summon and [color=%negative%]1[/color] human carrion.

• Costs [color=%negative%]6[/color] AP and [color=%negative%]25[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendSpawnSkeletonLow <- ::Legends.tooltip(@"
Raise a ramshackle thrall from some bones only barely ordered. Though lacking in strength or bodily integrity, it shall obey.

[color=%active%][u]Active:[/u][/color]
• Requires a small flesh sacrifice to perform the ritual.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]10[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendSpawnSkeletonMed <- ::Legends.tooltip(@"
Place the bones where they belong before you raise them so that it's less liable to fall apart. Sturdier in both form and function.

[color=%active%][u]Active:[/u][/color]
• Requires a minor flesh sacrifice to perform the ritual.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]15[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendSpawnSkeletonHigh <- ::Legends.tooltip(@"
Painstakingly reorganize each bone such that, once raised, no tarsus is out of place. A magnum opus of bone, unsurpassed in power.

[color=%active%][u]Active:[/u][/color]
• Requires a moderate flesh sacrifice to perform the ritual.

• Costs [color=%negative%]5[/color] AP and [color=%negative%]20[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendExtendendAura <- ::Legends.tooltip(@"
Yield to the dark power, let it ooze from your pores. With the fell energy now unrestrained, you can further project your art of rousing the dead.

[color=%passive%][u]Passive:[/u][/color]
• Increases range of all skills that raise dead by one tile.
");

::Const.Strings.PerkDescription.LegendChanneledPower <- ::Legends.tooltip(@"
Learn to better focus your art so it is less draining on your body.

[color=%passive%][u]Passive:[/u][/color]
• All skills that raise dead build up [color=%negative%]30%[/color] less Fatigue.
");

::Const.Strings.PerkDescription.LegendReclamation <- ::Legends.tooltip(@"
Weave a bit of your magic through the waste of a corpse so more means may be salvaged.

[color=%passive%][u]Passive:[/u][/color]
• Increases how frequently you gain Human Carrion and Human Bones as loot.
");

::Const.Strings.PerkDescription.LegendConservation <- ::Legends.tooltip(@"
Conduct profane rituals meant to stave off the passage of time, further preserving the means of your craft.

[color=%passive%][u]Passive:[/u][/color]
• Reduces the daily medicine cost of maintaining Human Corpses, Bones, and other Carrion by [color=%negative%]50%[/color].
");

::Const.Strings.PerkDescription.LegendEnthrall <- ::Legends.tooltip(@"
Pull at the strings of a single creation, compelling them to linger among you as an obedient guardian.

[color=%active%][u]Active:[/u][/color]
• Enthralled dead act defensively and attempt to protect you from threats.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]15[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendViolentDecomposition <- ::Legends.tooltip(@"
Corrupt the force sustaining one of your fashioned thralls

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Violent Decomposition[/color] skill which causes a thrall to detonate destructively after the corruption has time to build. Affected dead explode at the end of their turn next round, dealing damage in a one tile radius. The less HP they have, the more damage the explosion inflicts. If they are killed before they explode, the effect no longer triggers.

• Only works on minions fashioned from corpses.

• Costs [color=%negative%]5[/color] AP and [color=%negative%]25[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendPossession <- ::Legends.tooltip(@"
Enter the mind of a thrall and lend your power for one turn.

[color=%active%][u]Active:[/u][/color]
• Increases thralls combat prowess. Only works on allied undead. Possessing a thrall makes them immune to being [color=%status%]Charmed[/color] for the duration of the possession.

• Costs [color=%negative%]5[/color] AP and [color=%negative%]15[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendSiphon <- ::Legends.tooltip(@"
Siphon their lifeforce into yourself!

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Siphon[/color] skill which allows you to draw from the lifeforce of your victim and transfer up to [color=%positive%]30%[/color] of their Hitpoints to yourself.

• You may not drain more Hitpoints than you are missing nor drain a victim to their death.

• Effectiveness is reduced by [color=%negative%]5%[/color] for each tile away from your target.

• Chance to hit is based on Melee Attack.

• Costs [color=%negative%]5[/color] AP and [color=%negative%]10[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendValaInscriptionMastery <- ::Legends.tooltip(@"
The Vala becomes is a master at the intricate and lost art of inscribing signs and sigils.

[color=%passive%][u]Passive:[/u][/color]
• When taking [color=%perk%]Staff Mastery[/color], the Vala will become able to inscribe shields and weapons.

• When taking [color=%perk%]Nimble[/color] or [color=%perk%]Lithe[/color], the Vala will become able to inscribe Armor and Helmets.

• When she achieves level 11, she will also increase the speed at which she can craft runes by [color=%positive%]30%[/color].
");

::Const.Strings.PerkDescription.LegendValaInscribeWeapon <- ::Legends.tooltip(@"
Learn to inscribe rune sigils for weapons.

[color=%passive%][u]Passive:[/u][/color]
• Allows the Vala to inscribe rocks with weapon specific rune sigils while encamped to create powerful rune stones.

• Possibilities: accuracy, bleeding, feeding, poison, power.
");

::Const.Strings.PerkDescription.LegendValaInscribeHelmet <- ::Legends.tooltip(@"
Learn to inscribe rune sigils for helmets.

[color=%passive%][u]Passive:[/u][/color]
 • Allows the Vala to inscribe rocks with helmet specific rune sigils while encamped to create powerful rune stones.

• Possibilities: bravery, clarity, luck.
");

::Const.Strings.PerkDescription.LegendValaInscribeArmor <- ::Legends.tooltip(@"
Learn to inscribe rune sigils for armor.

[color=%passive%][u]Passive:[/u][/color]
• Allows the Vala to inscribe rocks with armor specific rune sigils while encamped to create powerful rune stones.

• Possibilities: endurance, resilience, safety.
");

::Const.Strings.PerkDescription.LegendValaInscribeShield <- ::Legends.tooltip(@"
Learn to inscribe rune sigils for shields

[color=%passive%][u]Passive:[/u][/color]
• Allows the Vala to inscribe rocks with shield specific rune sigils while encamped to create powerful rune stones.

• Possibilities: defense, radiance.
");

::Const.Strings.PerkDescription.LegendValaChantMastery <- ::Legends.tooltip(@"
Obtain mastery over chants.

[color=%passive%][u]Passive:[/u][/color]
• Chants build up [color=%negative%]25%[/color] less Fatigue.

• The effects of the [color=%skill%]Heightened Senses[/color], [color=%skill%]Disharmony[/color] and [color=%skill%]Fury[/color] chants are increased by [color=%positive%]10%[/color].
");

::Const.Strings.PerkDescription.LegendValaChantDisharmony <- ::Legends.tooltip(@"
A very disagreeable and cacophonous chant can makes it almost impossible for enemies to focus and concentrate properly.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Disharmony[/color] chant which prevents enemies from enforcing Zones of Control while adjacent to the Vala and enemies within 3 tiles of the Vala will be afflicted by a malus to Initiative.

• The debuff to Initiative increases by [color=%negative%]1%[/color] for every 15 points of Resolve and Fatigue the Vala has.

• The reduction weakens by [color=%negative%]25%[/color] per one tile the target is away from the Vala.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]30[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendValaChantFury <- ::Legends.tooltip(@"
A chant that gets the blood boiling, making your allies eager to fight.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Fury[/color] chant which grants all allies within three tiles of the Vala, including the Vala herself, [color=%positive%]+1%[/color] bonus damage for every [color=%positive%]30[/color] points of Resolve the Vala has, every [color=%positive%]30[/color] points of available Fatigue the Vala has, and every [color=%positive%]3[/color] Hitpoints the buff recipient has.

• Also grants a chance for allies to retaliate against attackers that hit them in melee range that is equal to [color=%positive%]25%[/color] of the Vala's Resolve + [color=%positive%]33%[/color] of the recipient's base Hitpoints.

• Retaliation damage is increased by [color=%positive%]+1[/color] for every [color=%positive%]4[/color] points of Resolve the Vala has and every [color=%positive%]3[/color] Hitpoints the buff recipient has.

• This chants effectiveness is decreased by [color=%negative%]25%[/color] per one tile away from the Vala.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]30[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendValaChantSenses <- ::Legends.tooltip(@"
An intriguing chant that stimulates the senses.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Heightened Senses[/color] chant which grants all allies within three tiles of the Vala, including the Vala herself, a bonus to Melee Defense and Ranged Defense.

• The bonus defense is increased by [color=%positive%]1[/color] for every 15 points of Resolve the vala has, as well as every 15 points of avaliable Fatigue the recipient has.

• The bonus is reduced by [color=%negative%]25%[/color] per one tile the target is away from the Vala.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]30[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendValaTranceMastery <- ::Legends.tooltip(@"
Increase your mastery over trances.

[color=%passive%][u]Passive:[/u][/color]
• Entering trances builds up [color=%negative%]25%[/color] less Fatigue.

• Gain a [color=%positive%]50%[/color] chance to not drop out of trance when receiving damage.

• Trances gain [color=%positive%]+15%[/color] chance to succeed.
");

::Const.Strings.PerkDescription.LegendValaTrancePerspective <- ::Legends.tooltip(@"
Incorporeal Perspective.

[color=%active%][u]Active:[/u][/color]
• Unlocks [color=%skill%]Incorporeal Perspective[/color] skill.

•
");

::Const.Strings.PerkDescription.LegendValaTranceMalevolent <- ::Legends.tooltip(@"
The spirit world is home to many malevolent beings, and the Vala knows how to contact them.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Malevolent Spirits[/color] trance which calls spirits to harass, torment, and weaken any target within seven tiles.

• The spirits increase the Fatigue use of the victim by [color=%positive%]1%[/color] for every 25 Resolve, decreases their maximum Fatigue by [color=%positive%]1%[/color] for every 5 Resolve, and decrease damage dealt by [color=%positive%]1%[/color] for every 10 Resolve the Vala has.

• Each turn, the spirits have a chance to spread to additional enemies within two tiles. This chance is equal to the Vala's Resolve minus the victim's Resolve. The chance is [color=%negative%]halved[/color] if the target is more than one tile away.

• Chance to hit is determined by the Vala's Resolve and each failure increases her chance to hit.

• Costs [color=%negative%]6[/color] AP and [color=%negative%]30[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendValaWarden <- ::Legends.tooltip(@"
Each individual has a Warden spirit that follows their soul from birth to death.

[color=%passive%][u]Passive:[/u][/color]
• The Vala has a remarkable connection with her Warden which allows it to manifest itself in a semi-physical form and help her out during battle.

• Automatically summons the Warden at the start of a fight. It can be beaten, but it never dies.

• The Warden's stats scale with the Vala's Resolve.
");

::Const.Strings.PerkDescription.LegendValaSpiritualBond <- ::Legends.tooltip(@"
The bond between the Vala and her Warden has grown strong with the passing of time.

[color=%passive%][u]Passive:[/u][/color]
• A percentage of the Vala's incoming Hitpoints damage is dealt to the Warden instead. The Warden also gains a scaling damage bonus.

•  The redirected damage starts at [color=%positive%]10%[/color] and increases by [color=%positive%]1%[/color] for every 4 points of Resolve up to a maximum of [color=%positive%]50%[/color].

• Additionally, the Warden gains [color=%positive%]5%[/color] of the Vala's Resolve as a scaling damage bonus.
");

::Const.Strings.PerkDescription.LegendValaThreads <- ::Legends.tooltip(@"
As the Vala swings and weaves her staff she spins and twines the threads of fate of those she hits with it.

[color=%passive%][u]Passive:[/u][/color]
• The Vala needs her staff equipped for this perk to work

• When the Vala hits a target, gain a chance based on Resolve, to apply a stacking debuff that lowers maximum Hitpoints and increases the amount of damage taken.

• Each stack reduces maximum Hitpoints by [color=%negative%]10%[/color] and increases damage taken by [color=%positive%]10%[/color], up to a maximum of 5 stacks.
");

::Const.Strings.PerkDescription.LegendValaPremonition <- ::Legends.tooltip(@"
As if being warned by some higher being, the Vala occasionally gets glimpses of the immediate future and any dangers it may hold, letting her prepare herself accordingly.

[color=%passive%][u]Passive:[/u][/color]
• Grants a chance that an attacker will need two successful rolls to damage the Vala.

• This chance begins at [color=%positive%]9%[/color] and scales with levels, up to a maximum of [color=%positive%]33%[/color] at level 12.

• Additionally, reduces chance to be targeted by enemies by [color=%negative%]9%[/color], scaling with levels up to a maximum of [color=%negative%]33%[/color] at level 12.
");

::Const.Strings.PerkDescription.LegendInventorAnatomy <- ::Legends.tooltip(@"
Through extensive study of the human form, you learn how to fashion replacement parts from wood and metal.

[color=%passive%][u]Passive:[/u][/color]
• Unlocks a series of events that let you create prosthetic body parts to help your mercenaries Resolve their permanent [color=%status%]Injuries[/color] that are presented through random events.
");

::Const.Strings.PerkDescription.LegendGuideSteps <- ::Legends.tooltip(@"
Unlocks the [color=%skill%]Guide Steps[/color] skill, that grants pathfinder to all allies within [color=%positive%]4[/color] tiles.
");

::Const.Strings.PerkDescription.LegendBerserkerRage <- ::Legends.tooltip(@"
Gain rage stacks over the course of a battle.

[color=%passive%][u]Passive:[/u][/color]
• Each stack increases Damage by [color=%positive%]1%[/color], Initiative by [color=%positive%]1[/color], Resolve by [color=%positive%]1[/color] and reduces damage received by [color=%positive%]2%[/color].

• Gain [color=%positive%]1[/color] stack each time you take damage, and [color=%positive%]3[/color] stacks each time you kill.

• Lose [color=%negative%]2[/color] rage stacks per turn.

• Can only accumulate a maximum of 40 stacks and 70% damage reduction.
");

::Const.Strings.PerkDescription.LegendAssuredConquest <- ::Legends.tooltip(@"
Your confidence affects your performance.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+10%[/color] Melee Skill, Ranged Skill, Melee Defense, and Ranged Defense when at [color=%status%]Confident[/color] morale.

• These bonuses reduce as your morale state decreases: [color=%positive%]+5%[/color] at [color=%status%]Steady[/color], [color=%negative%]-5%[/color] when [color=%status%]Breaking[/color] and [color=%negative%]-10%[/color] when [color=%status%]Fleeing[/color]. Removes the negative effects of the 'Cocky' trait.
");

::Const.Strings.PerkDescription.LegendTasteThePain <- ::Legends.tooltip(@"
You are invigorated by pain.

[color=%passive%][u]Passive:[/u][/color]Whenever getting hurt would normally trigger a morale check, instead gain [color=%positive%]10[/color] morale.
");

::Const.Strings.PerkDescription.LegendBecomeBerserker <- ::Legends.tooltip(@"
Become a berserker

[color=%passive%][u]Passive:[/u][/color]This character background changes into a berserker, losing all current perks.
");

::Const.Strings.PerkDescription.LegendSkillfulStacking <- ::Legends.tooltip(@"
By creating neat stacks and tying them down well you can carry more gear.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]12[/color] additional stash spaces and [color=%positive%]+9[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendEfficientPacking <- ::Legends.tooltip(@"
Arranging gear in just the right way, you're able to squeeze more things into the same space.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]8[/color] additional stash spaces and [color=%positive%]+6[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendAmmoBinding <- ::Legends.tooltip(@"
Expertise in making ammunition lets you strip it down to pack the parts for storage, it also lets you draw out arrows faster.

[color=%passive%][u]Passive:[/u][/color]
• Increases maximum ammunition storage by [color=%positive%]10[/color] and Ranged skill by [color=%positive%]+5%[/color].
");

::Const.Strings.PerkDescription.LegendAmmoBundles <- ::Legends.tooltip(@"
Using blankets and ropes to group large bundles of ammunition together you are able to carry far more. These bundles can also be used to shield yourself from enemy fire.

[color=%passive%][u]Passive:[/u][/color]
• Increases maximum ammunition storage by [color=%positive%]20[/color] and Ranged Defense by [color=%positive%]+5%[/color].
");

::Const.Strings.PerkDescription.LegendMedPackages <- ::Legends.tooltip(@"
Not all of a plant is required for healing, your knowledge of the active ingredients lets you throw away excess leaves and roots. Your knowledge of medicines lets you repack them into more efficient packages.

[color=%passive%][u]Passive:[/u][/color]
• Increases maximum medicine storage by [color=%positive%]30[/color] and Resolve by [color=%positive%]+5%[/color].
");

::Const.Strings.PerkDescription.LegendMedIngredients <- ::Legends.tooltip(@"
Learning the plants of the healing trade allows you to fashion crude healing supplies from common ingredients.

[color=%passive%][u]Passive:[/u][/color]
• Unlocks crafting bandages and medicine.

• Increases maximum medicine storage by [color=%positive%]10[/color] and Resolve by [color=%positive%]+5%[/color].
");

::Const.Strings.PerkDescription.LegendToolsDrawers <- ::Legends.tooltip(@"
Organising your tools into labeled compartments lets you carry more.

[color=%passive%][u]Passive:[/u][/color]
• Increases maximum tool storage by [color=%positive%]10[/color]
• Reduces global tool usage by [color=%positive%]4%[/color].
• Increases Fatigue by [color=%positive%]+3[/color].
");

::Const.Strings.PerkDescription.LegendToolsSpares <- ::Legends.tooltip(@"
Your experience with repairs has taught you to save your scraps and left over parts. These spares take up little space but are often just what you need for field repairs.

[color=%passive%][u]Passive:[/u][/color]
• Increases maximum tool storage by [color=%positive%]20[/color].
• Reduces global tool usage by [color=%positive%]6%[/color].
• Increases Fatigue by [color=%positive%]+6[/color].
");

::Const.Strings.PerkDescription.LegendBarterConvincing <- ::Legends.tooltip(@"
This characters skill with words makes their trade proposals more acceptable.

[color=%passive%][u]Passive:[/u][/color]
• Increases Barter skill by [color=%positive%]+1%[/color], improving all buy and sell prices and rewards from trade contracts.

• They also generate [color=%positive%]+10 Crowns[/color] each day through their investments and an additional [color=%positive%]+1 Crowns[/color] per level.

• Unfortunately, their negotiation skill also increases their daily pay rate by [color=%negative%]+25%[/color].
");

::Const.Strings.PerkDescription.LegendBarterTrustworthy <- ::Legends.tooltip(@"
This character's body language makes people believe them, leading to more favourable trade agreements.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+2%[/color] barter skill.

• Barter skill begins falling off at higher total rates.
");

::Const.Strings.PerkDescription.LegendBribe <- ::Legends.tooltip(@"
You've never met a problem that money couldn't solve.

[color=%active%][u]Active:[/u][/color]
• Throw coins at your enemies to bribe them away from battle, only works on humans. The cost is the XP that would be granted by killing the enemy, to the power of 1.3.

• Costs [color=%negative%]variable[/color] AP and [color=%negative%]variable[/color] Fatigue based on the XP.
");

::Const.Strings.PerkDescription.LegendOffBookDeal <- ::Legends.tooltip(@"
Convince anyone into selling you their priciest possession. Even if that means paying extra.

[color=%passive%][u]Passive:[/u][/color]
• Reduces Barter by [color=%negative%]-1%[/color].

• When entering a town that has no active situation, apply the 'Off-Book Deal' situation for 3 days.

• This situation grants [color=%positive%]+10%[/color] to available items and [color=%positive%]+10%[/color] to buying price for each brother with this perk.
");

::Const.Strings.PerkDescription.LegendPatientHunter <- ::Legends.tooltip(@"
Carefully evaluate your enemies and bide your time.

[color=%passive%][u]Passive:[/u][/color]
• When ending your turn, excess Action Points will be transfered to your next turn with a maximum of 3.
");

::Const.Strings.PerkDescription.LegendBarrage <- ::Legends.tooltip(@"
Lets hope your enemies like fighting in the shade.

[color=%passive%][u]Passive:[/u][/color]
•[color=%skill%]Sling Stone[/color] will now [color=%skill%]Debilitate[/color] on headshots and [color=%skill%]Baffle[/color] on body shots.

• [color=%skill%]Fire Handgonne[/color] will apply [color=%skill%]Shellshocked[/color] on headshots.

• [color=%skill%]Sling Heavy Stone[/color] will stun on headshots.
");

::Const.Strings.PerkDescription.LegendStaffBlock <- ::Legends.tooltip(@"
Give them no quarter!

[color=%active%][u]Active:[/u][/color]
• Grants the [color=%skill%]Staff Riposte[/color] ability which allows counterattack any opponent that misses you in melee.

[color=%passive%][u]Passive:[/u][/color]
• Additionally, while wielding a staff, the defense malus due to being surrounded by opponents is reduced by [color=%negative%]3[/color].

• If you have [color=%perk%]Underdog[/color] or [color=%perk%]Battleheart[/color], this perk will instead increase defenses by [color=%positive%]5[/color].
");

::Const.Strings.PerkDescription.LegendMinnesanger <- ::Legends.tooltip(@"
'Step outside mine walls, wearing an expensive tunic. Thee sayeth thou art highborn, but I heareth thou art eunich.'

[color=%passive%][u]Passive:[/u][/color]
• Fatigue cost for Song skills is reduced by [color=%negative%]25%[/color] and AP cost by [color=%negative%]1[/color].

• Increases the effects of [color=%skill%]Song of Life[/color] and [color=%skill%]War Chant[/color] by [color=%positive%]3[/color] Hitpoints and [color=%positive%]2[/color] Fatigue, respectively.
");

::Const.Strings.PerkDescription.LegendMeistersanger <- ::Legends.tooltip(@"
You have stepped up above playing shameful songs, ridiculing nobles and are a musician of some renown, whos fine melodies can whip any company into a battle frenzy.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Martial March[/color] skill which increases AP by [color=%negative%]1[/color] for one turn to all allies within an 8 tile range.

• Costs [color=%negative%]9[/color] AP and [color=%negative%]45[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendSpecialistButcher <- ::Legends.tooltip(@"
Your skill on the butcher's block seems to be easily translated to chopping limbs on the battlefield.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+12[/color] chance to hit and [color=%positive%]+2[/color] Bleed damage while using a Butcher's Cleaver.

• When taking [color=%perk%]Cleaver Mastery[/color] you will also gain [color=%positive%]10%[/color] bonus damage.

• For other weapons classified as Cleavers, but not Whips, you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation.
");

::Const.Strings.PerkDescription.LegendSpecialistBlacksmith <- ::Legends.tooltip(@"
Diligent practice with the hammer each day has proven to be equally good at crafting armor and finding it's weak points.

[color=%passive%][u]Passive:[/u][/color]
• While using a Blacksmith's Hammer gain [color=%positive%]+12[/color] chance to hit and [color=%positive%]+30%[/color] effectiveness vs armor.

• When taking [color=%perk%]Hammer Mastery[/color] you will also gain [color=%positive%]10%[/color] bonus damage.

• For other weapons classified as One Handed Hammers, you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation.
");

::Const.Strings.PerkDescription.LegendSpecialistPrisoner <- ::Legends.tooltip(@"
Life on the streets has shown you how to properly bury a knife in another person.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+12[/color] chance to hit while using any Knife.

• When taking [color=%perk%]Dagger Mastery[/color] you will also gain [color=%positive%]10%[/color] bonus damage.

• For other weapons classified as Daggers, you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation.

• You will also receive the Deathblow skill and Daggers that already have Deathblow, like Qatal Daggers, will have a buffed version.
");

::Const.Strings.PerkDescription.LegendSpecialistMusician <- ::Legends.tooltip(@"
Taverns have taught you that instruments can be used to make spin tunes, bash heads and block a thrown vegetable.

[color=%passive%][u]Passive:[/u][/color]
• Increases the effects of [color=%skill%]Song of Life[/color] and [color=%skill%]War Chant[/color] by [color=%positive%]3[/color] Hitpoints and [color=%positive%]2[/color] Fatigue, respectively.

• Gain [color=%positive%]+10[/color] Melee Defense when using Musical Instruments.
");

::Const.Strings.PerkDescription.LegendSpecialistMilitia <- ::Legends.tooltip(@"
You have mastered the trusty spear and you can use it both for dealing damage and keeping enemies at bay.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+12[/color] chance to hit and [color=%positive%]15%[/color] Melee Damage on Attacks of Opportunity while using a Militia Spear, Wooden Spear and Ancient spear.

• When taking [color=%perk%]Spear Mastery[/color] you will also gain [color=%positive%]10%[/color] bonus damage.

• For other weapons classified as Spears you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation.
");

::Const.Strings.PerkDescription.LegendSpecialistMiner <- ::Legends.tooltip(@"
Cracking rocks and cracking skulls aren't that much different.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+12[/color] chance to hit while using a Two Handed Hammer, Pickaxe or Military Pick.

• When taking [color=%perk%]Hammer Mastery[/color] you will also gain [color=%positive%]10%[/color] bonus damage.

• For other weapons classified as Two Handed Hammers, you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation.

• The bonus will be doubled against Ifrits and Rock Unholds.
");

::Const.Strings.PerkDescription.LegendSpecialistFarmhand <- ::Legends.tooltip(@"
Years of using farming tools have given you an understanding of how to stab true and slash in smooth strokes.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+12[/color] chance to hit and [color=%positive%]+25%[/color] Armor Damage while using a Pitchfork, Wooden Pitchfork, Hoe, Scythe or Wooden Flail.

• When taking [color=%perk%]Polearm Mastery[/color] you will also gain [color=%positive%]10%[/color] bonus damage.

• For other weapons classified as Polearms, you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation.
");

::Const.Strings.PerkDescription.LegendSpecialistPoacher <- ::Legends.tooltip(@"
From small game to big bounties.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+12[/color] chance to hit while using a Wonky Bow or Short Bow.

• When using Armor Piercing Arrows gain [color=%positive%]+25%[/color] armor penetration.

• When using Broad Head Arrows gain [color=%positive%]10%[/color] Bonus Damage and cause minor but long-lasting [color=%status%]Bleeding[/color] on any target you deal direct Hitpoints damage to with any weapon.

• The [color=%status%]Bleed[/color] deals [color=%damage%]2[/color] damage per turn and lasts five turns.

• When taking [color=%perk%]Bow Mastery[/color] you will also gain [color=%positive%]10%[/color] bonus damage.

• For other weapons classified as Bows, you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation.

• The bonus will be doubled against Wolves and Hyenas.
");

::Const.Strings.PerkDescription.LegendSpecialistGravedigger <- ::Legends.tooltip(@"
You used to dig up graves, now you're digging graves.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+12[/color] chance to hit while using a Shovel.

• When taking [color=%perk%]Mace Mastery[/color] you will also gain [color=%positive%]10%[/color] bonus damage.

• For other weapons classified as Two Handed Mace, you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation.

• If you are using a Shovel you will also receive the Knock Out skill.

• While using a Two Handed Mace, you will also receive the Gravedigging effect, which provides bonuses to Initiative, Damage and Resolve based on the amount of corpses on the battlefield.
");

::Const.Strings.PerkDescription.LegendSpecialistWoodsman <- ::Legends.tooltip(@"
Timber!

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+12[/color] chance to hit while using a Woodcutter's Axe or Handsaw.

• When taking [color=%perk%]Axe Mastery[/color] you will also gain [color=%positive%]10%[/color] bonus damage.

• For non-specialist weapons classified as Two Handed Axes, you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation.

• Allows this character to harvest wood while in camp.

• The bonus will be doubled against Schrats.
");

::Const.Strings.PerkDescription.LegendSpecialistHerbalist <- ::Legends.tooltip(@"
Call an 'erbalist...But not for me!

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+12[/color] chance to hit and [color=%positive%]30%[/color] of lowered threshold to inflict injuries as additional damage to hitpoints while using a Sickle.

• When taking [color=%perk%]Sword Mastery[/color] you will also gain [color=%positive%]10%[/color] bonus damage.

• For other weapons classified as One Handed Swords, you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation. Additionally reduces the Action Point cost of [color=%skill%]Slash[/color] by [color=%negative%]1[/color] when using a Sickle
");

::Const.Strings.PerkDescription.LegendSpecialistReaper <- ::Legends.tooltip(@"
Practicing with the unwieldy scythe has taught you how to twist your torso to produce repeatable smooth strokes.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+15[/color] chance to hit while using a Scythe or Warscythe.

• When taking [color=%perk%]Polearm Mastery[/color] or [color=%perk%]Cleaver Mastery[/color] you will also gain [color=%positive%]15%[/color] bonus damage.
");

::Const.Strings.PerkDescription.LegendSpecialistCultist <- ::Legends.tooltip(@"
Practice in the arts of punishment makes the tips of the cattail to inflict horrible injuries with greater accuracy.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+12[/color] chance to hit and [color=%positive%]+15%[/color] Chance to hit the head and while using Cat o nine tails.

• When taking [color=%perk%]Flail Mastery[/color] or [color=%positive%]Cleaver Mastery[/color] you will also gain [color=%positive%]10%[/color] bonus damage.

• For other weapons classified as Flails or Whips, you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation.
");

::Const.Strings.PerkDescription.LegendSpecialistShepherd <- ::Legends.tooltip(@"
Slinger? I hardly knew 'er!

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+12[/color] chance to hit and [color=%positive%]25%[/color] additional armor damage when using a Sling or Slingshot.

• When taking [color=%perk%]Sling Mastery[/color] you will also gain [color=%positive%]10%[/color] bonus damage.

• For other weapons classified as Slings, you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation.
");

::Const.Strings.PerkDescription.LegendSpecialistInventor <- ::Legends.tooltip(@"
Using your wits and tools, you've managed to create aids, which help you use unwieldy mechanical weapons with skill and dexterity.

[color=%passive%][u]Specialist Weapon Perk:[/u][/color]
• Gain [color=%positive%]+12[/color] chance to hit while using a Firearm.

• Reduce AP cost for Handgonne [color=%skill%]Reload[/color] by [color=%negative%]1[/color] and [color=%positive%]10%[/color] bonus damage when taking [color=%perk%]Crossbow Mastery[/color].

• Gain [color=%positive%]+12[/color] chance to hit while using a Firelance.

• When taking [color=%perk%]Spear Mastery[/color] you will also gain [color=%positive%]10%[/color] bonus damage.

• For other weapons classified as Firearms, you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation.
");

::Const.Strings.PerkDescription.LegendSpecialistBodyguard <- ::Legends.tooltip(@"
Eating and sleeping with your blade has turned it into an extension of your arm.

[color=%passive%][u]Specialist Weapon Perk:[/u][/color]
• Gain [color=%positive%]+12[/color] chance to hit, [color=%positive%]10%[/color] damage for all Melee area of effect attacks and [color=%positive%]20%[/color] damage when [color=%status%]Riposting[/color] when using a Longsword.

• When taking [color=%perk%]Sword Mastery[/color] gain [color=%positive%]10%[/color] damage.

• For other weapons classified as a Two-Handed Sword, you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation.
");

::Const.Strings.PerkDescription.LegendSpecialistInquisition <- ::Legends.tooltip(@"
Nobody expects the Inquisition!

[color=%passive%][u]Specialist Weapon Perk:[/u][/color]
• Gain [color=%positive%]+12[/color] chance to hit while using Hand Crossbow or Spiked Impaler.

• When taking [color=%perk%]Crossbow Mastery[/color] gain [color=%positive%]10%[/color] damage.

• Gain [color=%positive%]+12[/color] chance to hit while using a Wooden Stake.

• For other weapons classified as Crossbows, you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation.

• While using Crossbows the bonus will be doubled against Hexe and Alps.
");

::Const.Strings.PerkDescription.LegendSpecialistClub <- ::Legends.tooltip(@"
Mastering the art of leaning against a wall with a big stick has it's benefits.

[color=%passive%][u]Specialist Weapon Perk:[/u][/color]
• Gain [color=%positive%]+12[/color] chance to hit and [color=%positive%]+5[/color] fatigue per hit while using a Wooden Stick or Bludgeon.

• When taking [color=%perk%]Mace Mastery[/color] gain [color=%positive%]10%[/color] damage.

• For other weapons classified as One-Handed Mace, you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation.
");

::Const.Strings.PerkDescription.LegendSpecialistSelfdefense <- ::Legends.tooltip(@"
Twist and thrust with your staff to deflect blows and intercept strikes.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+12[/color] chance to hit and [color=%positive%]+16[/color] Defense while wielding a pure staves or magic staves.

• When taking [color=%perk%]Staff Mastery[/color] gain [color=%positive%]10%[/color] damage.

• For other weapons classified as a Staff, you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation.

• When wielding slingstaves, musical instruments and other hybrid staves the bonus is only [color=%positive%]+8[/color] Defense.
");

::Const.Strings.PerkDescription.LegendSpecialistRaider <- ::Legends.tooltip(@"
An axe to the back of the head solves many issues, you even get to keep the loot!

[color=%passive%][u]Specialist Weapon Perk:[/u][/color]
• Gain [color=%positive%]+12[/color] chance to hit while using a Crude Axe or Throwing Axe.

• When taking [color=%perk%]Axe Mastery[/color] or [color=%perk%]Throwing Mastery[/color] gain [color=%positive%]10%[/color] damage.

• For other weapons classified as One-Handed Axes, you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation.
");

::Const.Strings.PerkDescription.LegendSpecialistSpearfisher <- ::Legends.tooltip(@"
Throwing a spear and throwing a net is just muscle memory at this point.

[color=%passive%][u]Specialist Weapon Perk:[/u][/color]
• Gain [color=%positive%]+12[/color] chance to hit while using a Javelins.

• When taking [color=%perk%]Throwing Specialization[/color] gain [color=%positive%]10%[/color] damage.

• Each time you use a throwing weapon, you can use [color=%skill%]Throw Net[/color] for free.

• For other weapons classified as Throwing, you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation.
");

::Const.Strings.PerkDescription.LegendSpecialistSharpshooter <- ::Legends.tooltip(@"
Thread the needle from this distance? No sweat.

[color=%passive%][u]Specialist Weapon Perk:[/u][/color]
• Gain [color=%positive%]+12[/color] chance to hit and [color=%positive%]1[/color] additional range while using a Warbow.

• When taking [color=%perk%]Bow Mastery[/color] gain [color=%positive%]10%[/color] damage.

• For other weapons classified as Longbows, you can get a scaling percentage of these bonuses, starting from 25% and increasing gradually to 100% according to your choice in campaign generation.
");

::Const.Strings.PerkDescription.LegendBigGameHunter <- ::Legends.tooltip(@"
The bigger they are...

[color=%passive%][u]Passive:[/u][/color]
• When fighting beasts, gain an additional modifier that deals bonus damage based on the percentage of the target's missing Hitpoints. The more Hitpoints the target has lost, the more bonus damage is dealt, up to the total damage of the attack.

• When not fighting beasts, gain [color=%positive%]+10%[/color] ranged weapon damage but no additional modifier.

• Only works with ranged weapons.
");

::Const.Strings.PerkDescription.LegendSecondWind <- ::Legends.tooltip(@"
Even the fiercest battles can't keep you down.

[color=%passive%][u]Passive:[/u][/color]
• When falling below [color=%negative%]50%[/color] Hitpoints for the first time in each combat, fully refresh your Fatigue, and grant [color=%positive%]+5[/color] Fatigue Recovery for 3 turns.

• Additionally, remove any [color=%status%]Stun[/color], [color=%status%]Daze[/color], [color=%status%]Stagger[/color], [color=%status%]Baffle[/color], [color=%status%]Charmed[/color] or [color=%status%]Sleeping[/color] status.

• Only occurs once per combat.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Second Wind[/color] skill with the same effects as the passive.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]0[/color] Fatigue. Can only be used once per combat when accumulated fatigue is more than 50% of maximum. If the passive effect activates the active can't be used.
");

::Const.Strings.PerkDescription.LegendMarkTarget <- ::Legends.tooltip(@"
'The ugly one, right there! Take him out!'

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Mark Target[/color] skill which marks any target within nine tiles and reduces their Melee and Ranged Defenses by [color=%negative%]-10[/color] for three turns.

• Provides increased damage against the target up to 20%.

• Costs [color=%negative%]2[/color] AP and [color=%negative%]10[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendFieldTriage <- ::Legends.tooltip(@"
Spend medicine to heal a unit on the battlefield.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Field Triage[/color] skill which heals any adjacent ally by up to [color=%positive%]20[/color] Hitpoints.

• Uses [color=%negative%]1[/color] medicine per [color=%positive%]2[/color] Hitpoints healed.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]16[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendFieldRepairs <- ::Legends.tooltip(@"
Spend armor parts to repair armor on the battlefield.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Field Repairs[/color] skill which repairs up to [color=%positive%]20[/color] armor durability for any adjacent ally.

• Uses [color=%negative%]1[/color] tool per [color=%positive%]5[/color] durability repaired.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]16[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendDangerPay <- ::Legends.tooltip(@"
Every person has their price.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Danger Pay[/color] skill which allows you to target any ally that is paid a wage within three tiles and Spend [color=%positive%]10[/color] times the unit's daily wage to set them at [color=%status%]Confident[/color] morale.

• Upon receiving extra payment, the recipient becomes [color=%status%]Motivated[/color] for three turns.

• [color=%status%]Motivated[/color] grants [color=%positive%]10%[/color] more damage, [color=%positive%]5%[/color] more Ranged and Melee Skill, and [color=%positive%]15%[/color] more Resolve.

• Costs [color=%negative%]2[/color] AP and [color=%negative%]4[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendPreparedForAnything <- ::Legends.tooltip(@"
Instruct your mercenaries how to secret additional supplies about their person during battle.

[color=%passive%][u]Passive:[/u][/color]
• Grants the 'Bags and Belts' perk to anyone you fight with.
");

::Const.Strings.PerkDescription.LegendBrinkOfDeath <- ::Legends.tooltip(@"
Use your knowledge of undeath to bring your mercenaries back from the dead.

[color=%passive%][u]Passive:[/u][/color]
• Gives 66% chance for ally to come back as undead
");

::Const.Strings.PerkDescription.LegendStrictSermons <- ::Legends.tooltip(@"
Endlessly repeating the lessons of the old gods to your mercenaries will imbue them with faith in the heat of battle.

[color=%passive%][u]Passive:[/u][/color]
• Grants the 'Fortified Mind' perk to anyone you fight with.
");

::Const.Strings.PerkDescription.LegendInfectiousRage <- ::Legends.tooltip(@"
The frenzy of the berserker rage is aided with clouds of herbs and ritual dances. These can be spread to your allies.

[color=%passive%][u]Passive:[/u][/color]
• Grants the 'Berserk' perk to anyone you fight with.
");

::Const.Strings.PerkDescription.LegendTeacher <- ::Legends.tooltip(@"
The techniques you have mastered are inspirational and inspire curiosity in those who behold.

[color=%passive%][u]Passive:[/u][/color]
• Grants the 'Student' perk to anyone you fight with.
");

::Const.Strings.PerkDescription.LegendResurrectionist <- ::Legends.tooltip(@"
This character's experience with corpses gives an additional chance to retrieve each human body or skeleton from the battlefield.

[color=%passive%][u]Passive:[/u][/color]
• If you are already collecting them, increases the chance by [color=%positive%]5%[/color].
");

::Const.Strings.PerkDescription.LegendScry <- ::Legends.tooltip(@"
Use your extraordinary senses to notice things no one else can.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Scry[/color] skill which reveals everything within twelve tiles.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]15[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendPiercingShot <- ::Legends.tooltip(@"
Launch a shot so powerful it goes through an additional target.

[color=%passive%][u]Active/Passive:[/u][/color]
• Unlocks the [color=%skill%]Piercing Shot[/color] skill which allows bows and crossbows to hit two targets in a straight line, but will only do [color=%negative%]50%[/color] damage on the second target.

• Additionally, Handgonnes gain [color=%positive%]+1[/color] range.

• Does not work with throwing weapons.

• Costs [color=%negative%]5[/color] AP and [color=%negative%]20[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendLevitate <- ::Legends.tooltip(@"
Levitate a person above the ground, making movement across any terrain cost less.

[color=%active%][u]Active:[/u][/color]
• Movement across any terrain cost [color=%negative%]1[/color] AP and [color=%negative%]2[/color] Fatigue per tile.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]20[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendTeleport <- ::Legends.tooltip(@"
Step through the world, disappearing from one place and reappearing in another place immediately.

[color=%active%][u]Active:[/u][/color]
• Unlocks [color=%skill%]Teleport[/color] skill which allows you to teleport up to eight tiles.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]40[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendSpecialistShieldSkill <- ::Legends.tooltip(@"
Learn to keep your shield up.

[color=%passive%][u]Passive:[/u][/color]
• The first two times you end a turn without [color=%skill%]Shieldwall[/color] activated, gain [color=%skill%]Shieldwall[/color].

• Gain [color=%positive%]10%[/color] damage reduction while using a shield.
");

::Const.Strings.PerkDescription.LegendSpecialistShieldPush <- ::Legends.tooltip(@"
Learn to use your shield without wasted movement.

[color=%passive%][u]Passive:[/u][/color]
• The [color=%skill%]Knock Back[/color] skill costs [color=%positive%]25%[/color] less Fatigue and Action Points.
");

::Const.Strings.PerkDescription.LegendMasteryNets <- ::Legends.tooltip(@"
Master the ability to ensnare others and to disentangle yourself.

[color=%passive%][u]Passive:[/u][/color]
• When throwing nets reduce Fatigue cost by [color=%negative%]25%[/color] and AP cost to [color=%negative%]3[/color].

• When freeing yourself or allies gain a baseline [color=%positive%]99%[/color] chance to succeed in removing rooting effects, such as nets, vines, webs, and ensnarement by some beasts.

• Reduces Fatigue cost of freeing yourself or allies by [color=%negative%]66%[/color] and AP cost to [color=%negative%]3[/color].
");

::Const.Strings.PerkDescription.LegendMasterySlings <- ::Legends.tooltip(@"
Master the difficult angles and timings of slinging rocks from afar.

[color=%passive%][u]Passive:[/u][/color]
• Fatigue cost for Sling skills is reduced by [color=%negative%]25%[/color].

• Accuracy with slings and slingshots is increased by [color=%positive%]+10%[/color], accuracy with Staff Slings is increased by [color=%positive%]+5%[/color] and maximum firing range with slings and slingshots is increased by [color=%positive%]+1[/color].

• When using One Handed slings, waiting during your turn or using [color=%skill%]Wind Up[/color] will add the [color=%skill%]Prepare Bullet[/color] effect, which will increase damage by [color=%positive%]10%[/color] of your Initiative and the Range of attacks by [color=%positive%]+1[/color]

• Additionally allows you to launch bombs and flasks with a Staff Sling.
");

::Const.Strings.PerkDescription.LegendFavouredEnemyGhoul <- ::Legends.tooltip(@"
Studying these monstrosities has given you insights into the strengths and weaknesses of the pallid necrophilic flesh devourers.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill and maximum damage while fighting Nachzehrers.

• Additionally, this bonus increases the more Nachzehrers you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Nachzehrers | [color=%positive%]+0.16%[/color]
  - Skin Ghoul | [color=%positive%]+0.5%[/color]

• At 15% or more (including the base 5% bonus), you will unlock an extremely difficult legendary contract to hunt elite nachzehrers, also known as Skin Ghouls.

• Total bonus capped at 25%.
");

::Const.Strings.PerkDescription.LegendFavouredEnemyHexen <- ::Legends.tooltip(@"
Understanding the techniques of the malevolent crones gives you protection against their coven.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill and Resolve while fighting hexe.

• Additionally, this bonus increases the more Hexe you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Hexe | [color=%positive%]+0.5%[/color]
  - Coven Leader | [color=%positive%]+2%[/color]

• At 15% or more (including the base 5% bonus), you will unlock an extremely difficult legendary contract to hunt powerful hexe, also known as a Coven Leader.

• Total bonus capped at 25%.
");

::Const.Strings.PerkDescription.LegendFavouredEnemyAlps <- ::Legends.tooltip(@"
Preparing for the nightmare creepers gives you techniques against their haggard curses.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill and Resolve while fighting alps.

• Additionally, this bonus increases the more alps you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Alp | [color=%positive%]+0.25%[/color]
  - Demon Alp | [color=%positive%]+1%[/color]

• At 15% or more (including the base 5% bonus), you will unlock an extremely difficult legendary contract to hunt a much stronger demon alp.

• Total bonus capped at 25%.
");

::Const.Strings.PerkDescription.LegendFavouredEnemyUnhold <- ::Legends.tooltip(@"
These gigantic ravenous creatures are dangerous but stupid, that can be used to your advantage.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill and maximum damage while fighting unholds.

• Additionally, this bonus increases the more unholds you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Unhold (all types) | [color=%positive%]+0.5%[/color]
  - Rock Unhold | [color=%positive%]+2%[/color]

• At 15% or more (including the base 5% bonus), you will unlock an extremely difficult legendary to hunt armored Mountain Unholds.

• Total bonus capped at 25%.
");

::Const.Strings.PerkDescription.LegendFavouredEnemyLindwurm <- ::Legends.tooltip(@"
Understanding the morphology of these noxious serpents opens up weak spots in their scales.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill and maximum damage while fighting lindwurms or serpents.

• Additionally, this bonus increases the more lindwurms or Serpents you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Lindwurm | [color=%positive%]+1%[/color]
  - Serpent | [color=%positive%]+0.5%[/color]
  - Stollwurm | [color=%positive%]+2.5%[/color]

• At 15% or more (including the base 5% bonus), you will unlock an extremely difficult legendary contract to hunt a burrowing Stollwurm.

• Total bonus capped at 25%.
");

::Const.Strings.PerkDescription.LegendFavouredEnemyDirewolf <- ::Legends.tooltip(@"
The vicious jaws of a direwolf can tear limbs asunder. In the heat of their blood soaked frenzy, they leave themselves open for counter attack.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill and maximum damage while fighting wolves or hyenas.

• Additionally, this bonus increases the more wolves or hyenas you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Direwolf | [color=%positive%]+0.2%[/color]
  - Hyena | [color=%positive%]+0.2%[/color]
  - White Direwolf | [color=%positive%]+0.5%[/color]

• At 15% or more (including the base 5% bonus), you will unlock an extremely difficult legendary contract to hunt white wolves.

• Total bonus capped at 25%.
");

::Const.Strings.PerkDescription.LegendFavouredEnemySpider <- ::Legends.tooltip(@"
These skittering deadly arachnids are weak on their own but strong in numbers. However, they can be beaten.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill and maximum damage while fighting webknechts.

• Additionally, this bonus increases the more webknechts you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Webknecht | [color=%positive%]+0.125%[/color]
  - Spider Eggs | [color=%positive%]+0.5%[/color]
  - Redback | [color=%positive%]+1%[/color]

• At 15% or more (including the base 5% bonus), you will unlock an extremely difficult legendary contract to hunt redback spiders.

• Total bonus capped at 25%.
");

::Const.Strings.PerkDescription.LegendFavouredEnemySchrat <- ::Legends.tooltip(@"
The strong branches of a living tree and uncaring mantle of animated stones are deadly foes, but bark and boulder can be felled with the right knowledge.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill and maximum damage while fighting schrats or ifrits.

• Additionally, this bonus increases the more schrats or ifrits you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Schrat | [color=%positive%]+1%[/color]
  - Sapling | [color=%positive%]+0.2%[/color]
  - Ifrit | [color=%positive%]+0.125%[/color]
  - Greenwood Schrat | [color=%positive%]+1%[/color]
  - Greenwood Sapling | [color=%positive%]+0.4%[/color]

• At 15% or more (including the base 5% bonus), you will unlock an extremely difficult legendary contract to hunt an endlessly multiplying Greenwood Schrat.

• Total bonus capped at 25%.
");

::Const.Strings.PerkDescription.LegendFavouredEnemyOrk <- ::Legends.tooltip(@"
These marauding brutes are a force to be reckoned with, though their fighting style lacks finesse and can be countered with the right techniques.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill and maximum damage while fighting orcs.

• Additionally, this bonus increases the more orcs you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Orc Young | [color=%positive%]+0.125%[/color]
  - Orc Berserker | [color=%positive%]+0.2%[/color]
  - Orc Warrior | [color=%positive%]+0.2%[/color]
  - Orc Elite | [color=%positive%]+0.25%[/color]
  - Orc Behemoth | [color=%positive%]+0.5%[/color]
  - Orc Warlord | [color=%positive%]+1%[/color]

• Also increases spawn rate of orc champions.

• Total bonus capped at 25%.
");

::Const.Strings.PerkDescription.LegendFavouredEnemyGoblin <- ::Legends.tooltip(@"
Goblins are the most dangerous living thing under five foot tall, and while they prove hard to hit, they still bleed and die all the same.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill and maximum damage while fighting goblins.

• Additionally, this bonus increases the more goblins you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Goblin Ambusher | [color=%positive%]+0.125%[/color]
  - Goblin Fighter | [color=%positive%]+0.125%[/color]
  - Goblin Wolfrider | [color=%positive%]+0.2%[/color]
  - Goblin Shaman | [color=%positive%]+0.25%[/color]
  - Goblin Overseer | [color=%positive%]+0.25%[/color]

• Also increases spawn rate of goblin champions.

• Total bonus capped at 25%.
");

::Const.Strings.PerkDescription.LegendFavouredEnemyVampire <- ::Legends.tooltip(@"
The terrifying abilities of the Necrosavants, Apparitions and Embalmed have developed over time beyond memory. Their techniques are honed to perfection, but that also makes them predictable.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill, maximum damage and Resolve while fighting necrosavants, höllenhounds, geists, winselmutters and embalmed.

• Additionally, this bonus increases the more of these enemy types you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Necrosavant | [color=%positive%]+0.25%[/color]
  - Necrosavant Lord | [color=%positive%]+0.5%[/color]
  - Höllenhound | [color=%positive%]+0.125%[/color]
  - Geist | [color=%positive%]+0.125%[/color]
  - Winselmutter | [color=%positive%]+0.25%[/color]
  - Embalmed Slave | [color=%positive%]+0.25%[/color]
  - Embalmed Soldier | [color=%positive%]+0.5%[/color]
  - Embalmed Noble | [color=%positive%]+1%[/color]
  - Embalmed Priest | [color=%positive%]+1.25%[/color]
  - Embalmed Queen | [color=%positive%]+2%[/color]

• Also increases spawn rate of necrosavant champions.

• Total bonus capped at 25%.
");
 //No contract
//Lich and Emporer not included
::Const.Strings.PerkDescription.LegendFavouredEnemySkeleton <- ::Legends.tooltip(@"
The legions from the ancient empire still harass this world, yet their connection to the world of the living can be severed.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill, and maximum damage while fighting ancient dead.

• Additionally, this bonus increases the more of these enemy types you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Ancient Auxiliary | [color=%positive%]+0.01%[/color]
  - Ancient Legionary | [color=%positive%]+0.2%[/color]
  - Honor Guard | [color=%positive%]+0.5%[/color]
  - Ancient Priest | [color=%positive%]+0.5%[/color]
  - Phylactery | [color=%positive%]+1%[/color]
  - Ancient Gladiator | [color=%positive%]+0.5%[/color]
  - Flying Skull | [color=%positive%]+0.04%[/color]

• Also increases spawn rate of ancient dead champions.

• Total bonus capped at 25%.
");

//Treasure hunters and betrayers included as knights
::Const.Strings.PerkDescription.LegendFavouredEnemyZombie <- ::Legends.tooltip(@"
Shambling corpses come wave on wave, rising sleepless from their graves.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill, and maximum damage while fighting wiedergangers.

• Additionally, this bonus increases the more of these enemy types you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Wiederganger | [color=%positive%]+0.01%[/color]
  - Wiederganger Yeoman | [color=%positive%]+0.1%[/color]
  - Fallen Hero | [color=%positive%]+0.2%[/color]
  - Necromancer | [color=%positive%]+0.25%[/color]

• Also increases spawn rate of fallen and necromancer champions.

• Total bonus capped at 25%.
");

::Const.Strings.PerkDescription.LegendFavouredEnemyNoble <- ::Legends.tooltip(@"
Soldiers in glittering armor and colourful pennants, they are merely sanctioned brigands. No gods, no masters.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill, and maximum damage while fighting noble soldiers.

• Additionally, this bonus increases the more of these enemy types you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Footman | [color=%positive%]+0.125%[/color]
  - Zweihander | [color=%positive%]+0.25%[/color]
  - Billman | [color=%positive%]+0.125%[/color]
  - Arbalester | [color=%positive%]+0.125%[/color]
  - Standard Bearer | [color=%positive%]+0.5%[/color]
  - Sergeant | [color=%positive%]+0.5%[/color]
  - Fencer | [color=%positive%]+0.25%[/color]
  - Halberdier | [color=%positive%]+0.25%[/color]
  - Slinger | [color=%positive%]+0.125%[/color]
  - Knight | [color=%positive%]+1%[/color]
  - Elite Footman | [color=%positive%]+0.125%[/color]
  - Pollaxe | [color=%positive%]+0.125%[/color]
  - Sureshot | [color=%positive%]+0.125%[/color]

• Also increases spawn rate of knight and fencer champions.

• Total bonus capped at 25%.
");

::Const.Strings.PerkDescription.LegendFavouredEnemyBandit <- ::Legends.tooltip(@"
They hide in the bridleways and forests of this world and take what they can. The brigands must be purged to restore order in this world.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill, and maximum damage while fighting brigands.

• Additionally, this bonus increases the more brigands you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Rabble | [color=%positive%]+0.025%[/color]
  - Thug | [color=%positive%]+0.0625%[/color]
  - Poacher | [color=%positive%]+0.0625%[/color]
  - Marksman | [color=%positive%]+0.125%[/color]
  - Raider | [color=%positive%]+0.125%[/color]
  - Veteran | [color=%positive%]+0.2%[/color]
  - Bandit Leader | [color=%positive%]+0.25%[/color]
  - Warlord | [color=%positive%]+1%[/color]

• Also increases spawn rate of brigand warlord and brigand leader champions.

• At 15% or more (including the base 5% bonus), you will unlock a difficult legendary contract to stop a brigand army from taking over a settlement.

• Total bonus capped at 25%.
");

//Madman is registered as king
::Const.Strings.PerkDescription.LegendFavouredEnemyBarbarian <- ::Legends.tooltip(@"
Civilization must be brought to those godless brutes. They may be strong, but they lack skill.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill, and maximum damage while fighting barbarians.

• Additionally, this bonus increases the more barbarians you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Warhound | [color=%positive%]+0.0625%[/color]
  - Thrall | [color=%positive%]+0.1%[/color]
  - Reaver | [color=%positive%]+0.25%[/color]
  - Chosen | [color=%positive%]+0.25%[/color]
  - Drummer | [color=%positive%]+0.25%[/color]
  - Beastmaster | [color=%positive%]+0.125%[/color]
  - King | [color=%positive%]+1%[/color]

• Also increases spawn rate of barbarian king and barbarian chosen champions.

• At 15% or more (including the base 5% bonus), you will unlock a very difficult legendary contract to escort an important barbarian prisoner.

• Total bonus capped at 25%.
");

::Const.Strings.PerkDescription.LegendFavouredEnemyArcher <- ::Legends.tooltip(@"
Many claim to be the greatest shot in the land, but none have outshot you yet.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill, and maximum damage while fighting archer archetypes.

• Additionally, this bonus increases the more archer archetypes you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Master Archer | [color=%positive%]+0.5%[/color]
  - Bandit Marksman | [color=%positive%]+0.125%[/color]
  - Rabble Poacher | [color=%positive%]+0.025%[/color]
  - Bandit Poacher | [color=%positive%]+0.0625%[/color]
  - Militia Marksman | [color=%positive%]+0.05%[/color]
  - Arbalist | [color=%positive%]+0.25%[/color]
  - Slinger | [color=%positive%]+0.0125%[/color]
  - Goblin Ambusher | [color=%positive%]+0.0125%[/color]
  - Nomad Slinger | [color=%positive%]+0.0125%[/color]
  - Nomad Marksman | [color=%positive%]+0.25%[/color]
  - Gunner | [color=%positive%]+0.25%[/color]
  - Desert Stalker | [color=%positive%]+0.5%[/color]

• Also increases spawn rate of archer archetype champions.

• Reduces the penalty for attacking targets behind cover by [color=%negative%]33%[/color].

• Total bonus capped at 25%.
");

::Const.Strings.PerkDescription.LegendFavouredEnemySwordmaster <- ::Legends.tooltip(@"
The path to martial prowess is beset by the fake and the weak. Only one can stand to be the greatest.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill, and maximum damage while fighting elite melee combatants.

• Additionally, this bonus increases the more swordmaster archetypes you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Hedge Knight | [color=%positive%]+0.25%[/color]
  - Knight | [color=%positive%]+1%[/color]
  - Zweihander | [color=%positive%]+0.25%[/color]
  - Swordmaster | [color=%positive%]+0.5%[/color]
  - Bandit Leader | [color=%positive%]+0.25%[/color]
  - Bandit Warlord | [color=%positive%]+1%[/color]
  - Fencer | [color=%positive%]+0.25%[/color]
  - Barbarian King | [color=%positive%]+1%[/color]
  - Sergeant | [color=%positive%]+0.0125%[/color]
  - Officer | [color=%positive%]+0.5%[/color]
  - Gladiator | [color=%positive%]+0.5%[/color]
  - Assassin | [color=%positive%]+0.5%[/color]
  - Nomad Leader | [color=%positive%]+0.25%[/color]
  - Executioner | [color=%positive%]+0.5%[/color]
  - Desert Devil | [color=%positive%]+0.5%[/color]

• Also increases spawn rate of swordmaster archetype champions.

• Unlocks a very difficult repeating event to fight a champion in single combat for a reward.

• Total bonus capped at 25%.
");

::Const.Strings.PerkDescription.LegendFavouredEnemyMercenary <- ::Legends.tooltip(@"
Moulded by greed, mercenaries have no cause, no principles and no honour. They seek only coin, so they shall find only death.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill, and maximum damage while fighting mercenaries.

• Additionally, this bonus increases the more mercenaries you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Wardog | [color=%positive%]+0.0625%[/color]
  - Mercenary | [color=%positive%]+0.5%[/color]
  - Bounty Hunter | [color=%positive%]+0.25%[/color]

• Total bonus capped at 25%.
");

::Const.Strings.PerkDescription.LegendFavouredEnemyCaravan <- ::Legends.tooltip(@"
The commonfolk of the land are weak and powerless. Their pitiful lives are pathetic, they should be grateful to behold true might in their dying moments.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill, and maximum damage while fighting militia, peasants, and caravans.

• Additionally, this bonus increases the more of any militia, peasants, and caravans you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Peasant | [color=%positive%]+0.04%[/color]
  - Caravan Hand | [color=%positive%]+0.1%[/color]
  - Caravan Guard | [color=%positive%]+0.125%[/color]
  - Militia | [color=%positive%]+0.05%[/color]
  - Militia Veteran | [color=%positive%]+0.2%[/color]
  - Militia Captain | [color=%positive%]+0.25%[/color]

• [color=%positive%]5%[/color] chance to get any items from slain enemies, that might not otherwise be available to loot. Stacks with itself and effects of a similar nature.

• Total bonus capped at 25%.
");

::Const.Strings.PerkDescription.LegendFavouredEnemySoutherner <- ::Legends.tooltip(@"
The southern city states are horrific, their slavery and conscription are affronts to human dignity.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill, and maximum damage while fighting southern city states.

• Additionally, this bonus increases the more southerners you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Indebted | [color=%positive%]+0.04%[/color]
  - Conscript | [color=%positive%]+0.125%[/color]
  - Gunner | [color=%positive%]+0.25%[/color]
  - Officer | [color=%positive%]+0.5%[/color]
  - Engineer | [color=%positive%]+1%[/color]
  - Assassin | [color=%positive%]+0.5%[/color]
  - Manhunter | [color=%positive%]+0.25%[/color]
  - Manhunter Veteran | [color=%positive%]+0.5%[/color]

• Also increases spawn rate of champion officers, assassins, and manhunters.

• Total bonus capped at 25%.
");

::Const.Strings.PerkDescription.LegendFavouredEnemyNomad <- ::Legends.tooltip(@"
The nomads are uncivilised heathens, without even towns to their name, they must be brought to heel.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to Melee Skill, Ranged Skill, and maximum damage while fighting nomads.

• Additionally, this bonus increases the more nomads you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Indebted | [color=%positive%]+0.04%[/color]
  - Cutthroat | [color=%positive%]+0.0625%[/color]
  - Outlaw | [color=%positive%]+0.125%[/color]
  - Nomad Slinger | [color=%positive%]+0.1%[/color]
  - Nomad Archer | [color=%positive%]+0.0625%[/color]
  - Nomad Leader | [color=%positive%]+0.25%[/color]

• Also increases spawn rate of champion nomad leaders.

• Total bonus capped at 25%.
");

::Const.Strings.PerkDescription.LegendForcefulSwing <- ::Legends.tooltip(@"
Use the power of your hips and core to imbue more force into your swings.

[color=%passive%][u]Passive:[/u][/color]
• Melee AOE skills do [color=%positive%]+10%[/color] damage.
");

::Const.Strings.PerkDescription.LegendSpecSpearWall <- ::Legends.tooltip(@"
Endless training in holding the line in a spear wall has made it a second nature.

[color=%passive%][u]Passive:[/u][/color]
• [color=%skill%]Spearwall[/color] costs [color=%negative%]-50%[/color] less Fatigue.

• [color=%skill%]Spearwall[/color] AP cost is reduced to [color=%negative%]3[/color].

• [color=%skill%]Spearwall[/color] does [color=%positive%]+25%[/color] damage.
");

::Const.Strings.PerkDescription.LegendBalance <- ::Legends.tooltip(@"
Balancing your armor can allow protect against different threats.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+15[/color] Ranged Defense. For every 5 points of armor and helmet weight decrease this bonus by [color=%negative%]1[/color], but gain [color=%positive%]1[/color] Melee Defense up to a maximum of 15.
");

::Const.Strings.PerkDescription.LegendPerfectFit <- ::Legends.tooltip(@"
Well fitting armor lets you strike faster and fight longer.

[color=%passive%][u]Passive:[/u][/color]
• Reduce the Fatigue cost of all your skills by [color=%negative%]15%[/color], and gain [color=%positive%]30%[/color] Initiative.

• The bonus decreases if the combined Weight penalties of your body and head armor exceed half of your maximum Fatigue. Maximum fatigue is influenced by the weight of all your combined gear, not just armor.
");

::Const.Strings.PerkDescription.LegendThrustMaster <- ::Legends.tooltip(@"
Poking things where they don't belong is just a natural inclination for some.

[color=%passive%][u]Passive:[/u][/color]
• [color=%skill%]Thrust[/color], [color=%skill%]Prong[/color], [color=%skill%]Skewer[/color], [color=%skill%]Impale[/color], [color=%skill%]Rupture[/color] and [color=%skill%]Glaive Strike[/color] do [color=%positive%]+15%[/color] damage.

• Also removes the hitchance penalty per tile when throwing Spears and Javelins.
");

::Const.Strings.PerkDescription.LegendLithe <- ::Legends.tooltip(@"
Medium armor provides a sweet spot between movement and protection.

[color=%passive%][u]Passive:[/u][/color]
• All incoming damage to your Armor and Hitpoints is reduced by [color=%negative%]30%[/color], when the combined weight of head and body armor is between 25 and 35.

• Outside this range, the bonus drops exponentially.

• As your armor takes damage, the damage mitigation to Armor drops slowly to half its maximum value, but remains unchanged for Hitpoint damage mitigation.
");

::Const.Strings.PerkDescription.LegendInTheZone <- ::Legends.tooltip(@"
Use your armor's blend of protection and mobility to punish your foes' mistakes!

[color=%passive%][u]Passive:[/u][/color]
• Gain a stacking buff that boosts your Melee Skill and Melee Damage by [color=%positive%]0.5%[/color] up to a maximum of [color=%positive%]12.5%[/color].

• You gain [color=%positive%]0.5%[/color] when you dodge a Melee attack and lose [color=%negative%]1%[/color] when you get hit by any attack.

• When engaged in Melee, the Melee Damage bonus is doubled, up to a maximum of [color=%positive%]25%[/color].

• If your Initiative is higher than twice your armor's weight (penalty to Maximum Fatigue), you start the battle with stacks equal to your armor's weight above 15.
");

::Const.Strings.PerkDescription.LegendHidden <- ::Legends.tooltip(@"
Master the art of concealment.

[color=%active%][u]Active:[/u][/color]
• Unlocks [color=%skill%]Camoflauge[/color] skill which allows you to blend in with your surroundings and remain [color=%status%]Hidden[/color] from the enemy for three turns, or until your next attack.

• Costs [color=%negative%]8[/color] AP and [color=%negative%]40[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendSpecStaffStun <- ::Legends.tooltip(@"
Master the movements required to spin your staff in a great flourish that lands with additional force.

[color=%passive%][u]Passive:[/u][/color]
• Any strike with a staff that would normally [color=%status%]Daze[/color], also [color=%status%]Stuns[/color] and [color=%status%]Staggers[/color].
");

::Const.Strings.PerkDescription.LegendDrumsOfWar <- ::Legends.tooltip(@"
Learn powerful rhythms that drive your allies on.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]War Chant[/color] skill which restores [color=%positive%]+3[/color] Fatigue to every ally within eight tiles.

• Can only be used with a Drum or Lute equipped.

• Costs [color=%negative%]8[/color] AP and [color=%negative%]30[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendSpecUnarmed <- ::Legends.tooltip(@"
Master the martial arts of unarmed combat.

[color=%passive%][u]Passive:[/u][/color]
• Reduces the Fatigue costs of [color=%skill%]Hand to Hand[/color], [color=%skill%]Kick[/color], [color=%skill%]Grapple[/color], [color=%skill%]Choke[/color], and [color=%skill%]Tackle[/color] by [color=%negative%]25%[/color].

• Increases Fatigue inflicted for [color=%skill%]Hand to Hand[/color] by [color=%positive%]5[/color] and reduce AP cost by [color=%negative%]1[/color].

• [color=%skill%]Kick[/color] has [color=%status%]Daze[/color] chance increased to [color=%positive%]50%[/color] and hit chance increased by [color=%positive%]15%[/color].

• [color=%skill%]Grapple[/color] now has a [color=%positive%]100%[/color] chance to be disarm on hit and hit chance is increased by [color=%positive%]+10%[/color].

• [color=%skill%]Tackle[/color] gains [color=%positive%]+10%[/color] chance to hit.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Tackle[/color] skill which on a hit knocks over your opponent.

• [color=%status%]Knocked Over[/color] enemies have their Melee Defense reduced by [color=%negative%]-50%[/color], their Initiative reduced by [color=%negative%]-70%[/color], and increases damage they take by [color=%positive%]25%[/color].

• Hit chance determined by how Fatigued the target is.

• Costs [color=%negative%]6[/color] AP and [color=%negative%]30[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendGrappler <- ::Legends.tooltip(@"
A time tested tradition of getting your opponent to the ground, disarmed and reeling!

[color=%passive%][u]Passive:[/u][/color]
• [color=%skill%]Grapple[/color] will no longer have a chance to hit malus. Any hit with [color=%skill%]Hand to Hand[/color] has a [color=%positive%]25%[/color] to apply [color=%status%]Grapple[/color].

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Choke[/color] skill when both hands are free.

• [color=%status%]Choked[/color] enemies have their Fatigue Recovery reduced by [color=%negative%]15[/color].

• Damage inflicted is determined by the difference in Fatigue between you and your target.

• Hit chance determined by your target's Fatigue, [color=%negative%]0%[/color] if they are fresh and [color=%positive%]100%[/color] if they are exhausted.

• Hit chance is increased by [color=%positive%]+10%[/color] if your target is [color=%status%]Dazed[/color] or [color=%status%]Parried[/color], [color=%positive%]+25%[/color] if they are [color=%status%]Stunned[/color] or [color=%status%]Netted[/color], and  [color=%positive%]+50%[/color] If they are [color=%status%]Grappled[/color] or [color=%status%]Sleeping[/color].

• Costs [color=%negative%]4[/color] AP and [color=%negative%]20[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendAmbidextrous <- ::Legends.tooltip(@"
Unlock the ability to punch with your off hand!

[color=%passive%][u]Passive:[/u][/color]
• When your offhand is free allows you to use [color=%skill%]Hand to Hand[/color] and attack with the ability on each attack.

• If you are using a Buckler, Mummy Shield or Parry Dagger you will attack with [color=%skill%]Buckler bash[/color] or [color=%skill%]Stab[/color] instead.

• Additionally, gain [color=%positive%]+5[/color] Melee Skill and [color=%positive%]+10[/color] Melee Defense if both hands are free.
");

::Const.Strings.PerkDescription.LegendPugilist <- ::Legends.tooltip(@"
The first rule of...

[color=%passive%][u]Passive:[/u][/color]
• Increase [color=%skill%]Hand to Hand[/color] damage by [color=%positive%]25%[/color]. [color=%skill%]Kick[/color] can now be used without a free hand and will do [color=%positive%]10-15[/color] Damage.
");

::Const.Strings.PerkDescription.LegendPummelIntoSubmission <- ::Legends.tooltip(@"
Strike while they're down!

[color=%passive%][u]Passive:[/u][/color]
• Attacks deal an additional [color=%positive%]+5[/color] fatigue per hit.

• Each point of fatigue damage over the target's maximum fatigue will be translated to additional damage done.
");

::Const.Strings.PerkDescription.LegendFieldTreats <- ::Legends.tooltip(@"
Make liberal use of alcohol and food to motivate your mercenaries.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Field Treats[/color] skill which allows you to spend [color=%negative%]20[/color] food to improve an adjacent allies morale from [color=%status%]Wavering[/color] to [color=%status%]Steady[/color].

• Cannot be applied to someone who has already been rallied.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]16[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendSmashingShields <- ::Legends.tooltip(@"
Some folks take joy in the simple pleasures of destroying shields.

[color=%passive%][u]Passive:[/u][/color]
• Grants an additional [color=%positive%]+100%[/color] damage to shields when using [color=%skill%]Split Shield[/color] or a Throwing Spear.
• If the shield is destroyed, gain [color=%positive%]4[/color] additional AP and any damage above the max durability of the target's shield will hit the target.
");

::Const.Strings.PerkDescription.LegendSmackdown <- ::Legends.tooltip(@"
Use your size and strength to dominate the battlefield, combining the best of both worlds in offense and defense.

[color=%passive%][u]Passive:[/u][/color]
• Effectiveness vs Armor is increased by [color=%positive%]30%[/color] for any weapon used.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Wind Up[/color] skill which allows you to knock back and [color=%status%]Baffle[/color] an opponent on your next swing.
• [color=%status%]Baffled[/color] enemies suffer [color=%negative%]-15%[/color] Damage, Fatigue, and Initiative.
• Costs [color=%negative%]2[/color] AP and [color=%negative%]15[/color] Fatigue.
• When wielding a two-handed weapon, reduces AP cost to [color=%negative%]1[/color]. Works only with melee weapons, unarmed attacks and one handed slings. With one handed slings it will grant the [color=%skill%]Prepare Bullet[/color] effect.
");

::Const.Strings.PerkDescription.LegendBoneBreaker <- ::Legends.tooltip(@"
Even if your strikes don't penetrate the opponent's armor, you'll make sure they feel it.

[color=%passive%][u]Passive:[/u][/color]
• Increases hitpoint damage by [color=%positive%]10%[/color] of the armor damage done to the target. Attacks that don't deal armor damage or fully penetrate the target's armor will not receive any bonuses, and the bonus damage is subject to damage reductions from the target.
");

::Const.Strings.PerkDescription.LegendClarity <- ::Legends.tooltip(@"
A well honed mind can perceive more in each instant, making time appear slower in key instants of need.

[color=%passive%][u]Passive:[/u][/color]
• An additional [color=%positive%]+10%[/color] of any damage ignores armor.

• Does not work if you are [color=%status%]Dazed[/color], [color=%status%]Drunk[/color], [color=%status%]Hungover[/color], [color=%status%]Taunted[/color], [color=%status%]Staggered[/color], [color=%status%]Horrified[/color], [color=%status%]Concussed[/color] or [color=%status%]Wavering[/color].

• Doubles the armor ignore bonus if under the effect of the following potions: Iron Will, Lionheart, Cat, Second Wind or Hexen Ichor.
");

::Const.Strings.PerkDescription.LegendAlert <- ::Legends.tooltip(@"
Pay close attention at all times, surveying the surroundings and assessing every clue for an insight.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+20%[/color] Initiative.
");

::Const.Strings.PerkDescription.LegendBloodbath <- ::Legends.tooltip(@"
Take joy in the suffering of others.

[color=%passive%][u]Passive:[/u][/color]
• Gain Melee Skill, Ranged Skill, Fatigue Recovery and Resolve for each character that is [color=%status%]Bleeding[/color] or has a temporary [color=%status%]Injury[/color] on the field. Double the bonus if you're adjacent to bleeding enemies.

• The fatigue recovery bonus cannot exceed 5.
");

::Const.Strings.PerkDescription.LegendTerrifyingVisage <- ::Legends.tooltip(@"
The mere sight of this character sends enemies fleeing.

[color=%passive%][u]Passive:[/u][/color]
• Reduces Resolve of adjacent enemies by [color=%negative%]-15[/color].
");

::Const.Strings.PerkDescription.LegendFreedomOfMovement <- ::Legends.tooltip(@"
A skilled mercenary has unimpeded movement regardless of armor.

[color=%passive%][u]Passive:[/u][/color]
• Reduces Fatigue cost of [color=%skill%]Climb[/color], [color=%skill%]Lunge[/color], [color=%skill%]Footwork[/color], [color=%skill%]Rotation[/color], [color=%skill%]Leap[/color], [color=%skill%]Quick Step[/color], [color=%skill%]Evasion[/color] and [color=%skill%]Tumble[/color] by [color=%negative%]50%[/color].

• The Action Point cost of [color=%skill%]Climb[/color], [color=%skill%]Footwork[/color] and [color=%skill%]Rotation[/color] is reduced by [color=%negative%]1[/color], [color=%skill%]Leap[/color] by [color=%negative%]3[/color] and [color=%skill%]Evasion[/color] by [color=%negative%]2[/color].

• Picking this perk will also add [color=%perk%]Tactical Maneuvers[/color] and [color=%perk%]Quick Step[/color] to your perk tree.
");

::Const.Strings.PerkDescription.LegendOnslaught <- ::Legends.tooltip(@"
Don't slow down!

[color=%passive%][u]Passive:[/u][/color]
• Grants a [color=%positive%]50%[/color] chance to apply [color=%status%]Baffled[/color] on every hit with any weapon, when your Initiative is higher than that of your opponent.

• [color=%status%]Baffled[/color] enemies have [color=%negative%]-15%[/color] damage, Fatigue, and Initiative.

• [color=%positive%]30%[/color] of your gear weight will be added to melee damage done with a maximum bonus of 30%.
");

::Const.Strings.PerkDescription.LegendBackToBasics <- ::Legends.tooltip(@"
Years of practice lead this character to fall back to their instincts and basic training under extreme stress.

[color=%passive%][u]Passive:[/u][/color]
• When this character takes damage, they will gain a stacking [color=%positive%]+5[/color] Melee Defense until the start of their next turn.

• If they take damage while [color=%status%]Fleeing[/color], they have a chance to rally. The chance is equal to half their Resolve.

• Also grants [color=%positive%]+10%[/color] training speed in camp.
");

::Const.Strings.PerkDescription.LegendPushTheAdvantage <- ::Legends.tooltip(@"
Carpe juggular!

[color=%passive%][u]Passive:[/u][/color]
• Gain an additional [color=%positive%]20%[/color] damage on hits to the head and chance to hit the head against targets that are [color=%status%]Debilitated[/color] or have sustained any injury effects, like a broken arm.

• Also grants [color=%positive%]+10%[/color] damage on hits to the head and chance to hit the head against targets who suffer from any of the following effects: [color=%status%]Baffled[/color], [color=%status%]Dazed[/color], [color=%status%]Distracted[/color], [color=%status%]Grappled[/color], [color=%status%]Netted[/color], [color=%status%]Rooted[/color], [color=%status%]Shellshocked[/color], [color=%status%]Sleeping[/color], [color=%status%]Staggered[/color], [color=%status%]Stunned[/color], [color=%status%]Vulnerable[/color], [color=%status%]Webbed[/color], or [color=%status%]Withered[/color].
");

::Const.Strings.PerkDescription.LegendMindOverBody <- ::Legends.tooltip(@"
Push your body beyond what is humanly possible through your sheer force of will.

[color=%passive%][u]Passive:[/u][/color]
• Gain scaling Fatigue reduction on skills and Fatigue cost of getting hit for each point of Resolve over 60.

70 Resolve: [color=%negative%]7%[/color] Fatigue reduction
80 Resolve: [color=%negative%]10%[/color] Fatigue reduction
90 Resolve: [color=%negative%]18%[/color] Fatigue reduction
100 Resolve: [color=%negative%]22%[/color] Fatigue reduction
120 Resolve: [color=%negative%]29%[/color] Fatigue reduction
140 Resolve: [color=%negative%]34%[/color] Fatigue reduction
160 Resolve: [color=%negative%]39%[/color] Fatigue reduction
");

::Const.Strings.PerkDescription.LegendEscapeArtist <- ::Legends.tooltip(@"
Others see it as magic, but your deft hands know better.

[color=%passive%][u]Passive:[/u][/color]
• Grants a baseline 99% chance to [color=%skill%]Break Free[/color] from rooting effects, such as nets and webs.

 • Reduces the Action Point cost of [color=%skill%]Break Free[/color] by [color=%negative%]1[/color].
");

::Const.Strings.PerkDescription.LegendGatherer <- ::Legends.tooltip(@"
Knowledge of the landscape and vegetation provides a wealth of opportunities when gathering in camp.

[color=%passive%][u]Passive:[/u][/color]
• [color=%positive%]Doubles[/color] the bonus of characters with this perk finding special items while assigned to gathering in camp.

• When the total bonus from all characters with or without this perk is above 10% while assigned to gathering in camp, they can find mushrooms, poisons, antidotes and powders without crafting them.
");
 //Characters gain their level as a percentage reduction in hours required to find special items when gathering in camp. This perk doubles that.
::Const.Strings.PerkDescription.LegendPotionBrewer <- ::Legends.tooltip(@"
Expertise in potions and tinctures allows the creation of potions while gathering in camp.

[color=%passive%][u]Passive:[/u][/color]
• This skill unlocks the chance to create lionheart, ironwill, recovery and cat potions while gathering. An apothecary, druid, alchemist or vala must gather the ingredients for the potion brewer.

• When the total level of all brewers ([color=%perk%]Potion Brewer[/color] perk) is above [color=%positive%]35[/color] and Apothecaries (backgrounds or [color=%perk%]Gathering[/color] perk) is above [color=%positive%]45[/color], gain a chance to create potions of knowledge when gathering tent is upgraded.

• Unlocks alcohol crafting in the crafting tent.
");

::Const.Strings.PerkDescription.LegendSpecCultHood <- ::Legends.tooltip(@"
In Pain we find the truth of ourselves. We have no identity beyond servitude, our glory is agony.

[color=%passive%][u]Passive:[/u][/color]
• While your face is obscured by a cultist hood, gain [color=%positive%]+15%[/color] of your total Resolve as a bonus to melee and Ranged Defense.

• Also works with cultist leather hood, leather helmet, sack, decayed sack helm, warlock hood or mask of davkul.

• Unlocks a crafting recipe to make cultist hoods and sacks.
");

::Const.Strings.PerkDescription.LegendSpecCultArmor <- ::Legends.tooltip(@"
Only in suffering can we know truth.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+75%[/color] of your missing Hitpoints as Resolve, while wearing cultist robes, barbarian hide, bone armor or warlock robes.

• Adds [color=%positive%]+5%[/color] maximum damage for every hostile entity adjacent to you.

• Unlocks a crafting recipe to make cultist robes.
");

::Const.Strings.PerkDescription.LegendPrepareBleed <- ::Legends.tooltip(@"
Time spent assessing an enemy, finding the arteries, will pay off in blood shed on the field.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Prepare to Bleed[/color] skill which primes your next strike to inflict [color=%damage%]5[/color] [color=%status%]Bleed[/color] damage for the next two turns.

• Costs [color=%negative%]2[/color] AP and [color=%negative%]15[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendPrepareGraze <- ::Legends.tooltip(@"
Long, slow, deep rending scratches that leave many bleeding grazes.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Prepare to Graze[/color] skill which primes your next strike to inflict [color=%damage%]2[/color] [color=%status%]Bleed[/color] damage for the next five turns.

• Costs [color=%negative%]2[/color] AP and [color=%negative%]15[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendCarnage <- ::Legends.tooltip(@"
If it bleeds, we can kill it.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]20%[/color] damage when attacking a [color=%status%]Bleeding[/color] enemy.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Prepare to Bleed[/color] skill which primes your next strike to inflict [color=%damage%]5[/color] [color=%status%]Bleed[/color] damage for the next two turns.

• Costs [color=%negative%]2[/color] AP and [color=%negative%]15[/color] Fatigue.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Prepare to Graze[/color] skill which primes your next strike to inflict [color=%damage%]2[/color] [color=%status%]Bleed[/color] damage for the next five turns.

• Costs [color=%negative%]2[/color] AP and [color=%negative%]15[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendUntouchable <- ::Legends.tooltip(@"
Staying hidden is about more than just clever disguise, one must be prepared to avoid stray blows and arrows in the heat of battle.

[color=%passive%][u]Passive:[/u][/color]
• Extends your camouflage by two turns.
");

::Const.Strings.PerkDescription.LegendAssassinate <- ::Legends.tooltip(@"
 Striking from the shadows allows you to bypass enemy defenses and strike for their undefended weak points.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+20%[/color] maximum and minimum damage while [color=%status%]Hidden[/color] by being within a bush or smoke.

• Assassins who specialize in the art of stealth gain [color=%positive%]+30%[/color] instead.

• Master assassins more deadly in stealth and killing gain [color=%positive%]+50%[/color].
");

::Const.Strings.PerkDescription.LegendMealPreperation <- ::Legends.tooltip(@"
A good company chef can make a meal from whatever can be scrounged up, and have it in your belly before camp breaks.

[color=%passive%][u]Passive:[/u][/color]
• Unlocks a chance to get better food rewards when this character is assigned to the Camp Kitchen in camp.

• The chance and rewards increase as you level up. Includes porridge, pies and puddings.
");

::Const.Strings.PerkDescription.LegendAlcoholBrewing <- ::Legends.tooltip(@"
Any camp worth its salt will have an alcohol still fashioned out of whatever can be pulled together.

[color=%passive%][u]Passive:[/u][/color]
• Unlocks a chance to get alcohol as a reward when this character is assigned to the Camp Kitchen in camp.

• The rewards increase as you level up. Includes beer, wine and mead.

• Allows alcohol crafting in the Crafting Tent.
");

::Const.Strings.PerkDescription.LegendHorseCharge <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• Use the great weight and speed of the horse to charge forward. Move up to four spaces and attack an enemy.
");

::Const.Strings.PerkDescription.LegendHorsePirouette <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• Learning to turn quickly allows quick changes in direction required to escape enemies.
");

::Const.Strings.PerkDescription.LegendHorseBitting <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• Getting a horse accustomed to the feel of a bit and a bridle, makes it easier to control the movements. This increases defenses in battle by 25% of the rider's Melee Defense.
");

::Const.Strings.PerkDescription.LegendHorseDesensitization <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• Using loud noises and sudden movements, the horse is trained to not react to the sounds of battle until the rider tells it to. This increases melee attack in battle by 25% of the rider's melee attack
");

::Const.Strings.PerkDescription.LegendHippology <- ::Legends.tooltip(@"
Knowledge of an animal's physiology allows for better diet, exercise and care.

[color=%passive%][u]Passive:[/u][/color]
• Increases Hitpoints by [color=%positive%]25%[/color] for each donkey in the company and their carrying capacity by [color=%positive%]+12[/color].
");

::Const.Strings.PerkDescription.LegendHorseImpulsion <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• Effective leverage of equestrian physiology relaxes the spinal column and allows the hindquarters to engage effectively. Increases Initiative by 25%
");

::Const.Strings.PerkDescription.LegendHorseLeadChange <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• A horse's lead leg can tire, by training a horse to swap legs it is possible to prevent the horse from tiring. Movement costs 25% less Fatigue.
");

::Const.Strings.PerkDescription.LegendHorseLegControl <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• it is not possible to hold the reins while firing a bow. Horse and rider must learn to communicate through the rider's legs. Increases ranged attack in battle by 25%
");

::Const.Strings.PerkDescription.LegendHorseLiberty <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• Though extensive roundpenning training, the horse gains trust in the movements of the rider. This increases Resolve in battle by 25% of the rider's Resolve
");

::Const.Strings.PerkDescription.LegendHorseLongeing <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• Time spent working on a long rope helps build trust between horse and rider. Increases Resolve by 25%
");

::Const.Strings.PerkDescription.LegendHorseParthianShot <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• shooting from a moving horse is not easy, extensive practice is required to reliably achieve such a feat. Increases ranged attack by 25%
");

::Const.Strings.PerkDescription.LegendHorsePiaffe <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• Keeping a horse moving can retain their focus and prepare them for an oncoming battle. Increases melee attack in battle by 25%
");

::Const.Strings.PerkDescription.LegendHorseTempiChange <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• the most challenging form of lead change, a tempi change requires shifting back and forth between lead legs. This form of training can allow the horse to change lead leg according to the situation, useful when under fire. Increases Ranged Defense by 25%
");

::Const.Strings.PerkDescription.LegendHorseCollection <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• By training the horse's posture, advanced movements become easier to perform and less draining. Increases Fatigue by 25%
");

::Const.Strings.PerkDescription.LegendHorseFlyingChange <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• Changing lead legs at high speeds is an advanced move that can allow horses to cover much larger distances. Gain 1 action point.
");

::Const.Strings.PerkDescription.LegendHorsePassage <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• Training the legs to raise higher and push harder can prepare horses for rough or muddy terrain. Decreases movement costs on rough terrain.
");

::Const.Strings.PerkDescription.LegendDrumsOfLife <- ::Legends.tooltip(@"
Learn powerful rhythms that drive your allies on.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Drums of Life[/color] skill which restores [color=%positive%]+4[/color] Hitpoints to every ally within eight tiles.

• Can only be used with a Drum or Lute equipped.

• Costs [color=%negative%]8[/color] AP and [color=%negative%]30[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendLacerate <- ::Legends.tooltip(@"
Lust for blood courses through your veins, each stroke rips and tears with a ferocity unmatched.

[color=%passive%][u]Passive:[/u][/color]
• Cause minor but long-lasting [color=%status%]Bleeding[/color] on any target you deal direct Hitpoints damage to with any weapon.

• The [color=%status%]Bleed[/color] deals [color=%damage%]2[/color] damage per turn and lasts five turns.

• This effect stacks.
");

::Const.Strings.PerkDescription.LegendPeaceful <- ::Legends.tooltip(@"
Not all folks are built for war, some find contentment in contemplation or practicing a trade.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+20[/color] Resolve and [color=%positive%]+5%[/color] experience gain, in exchange for [color=%negative%]-20[/color] Melee and Ranged Skill.

• Becomes content with being in reserve, and consumes half rations while there.

• When in combat, this character grants [color=%positive%]+3[/color] Resolve and [color=%positive%]+1%[/color] XP gain to allies.
");

::Const.Strings.PerkDescription.LegendSummonHound <- ::Legends.tooltip(@"
Forming close bonds with hounds grants the ability to call to them.

[color=%active%][u]Active:[/u][/color]
• Summon a loyal hound to your side in battle.

• Costs [color=%negative%]5[/color] AP and [color=%negative%]15[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendSummonWolf <- ::Legends.tooltip(@"
Cultivating a relationship with the wolves allows you to call them to your side.

[color=%active%][u]Active:[/u][/color]
• Summon a wolf to aid you in battle.

• Costs [color=%negative%]7[/color] AP and [color=%negative%]15[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendSummonFalcon <- ::Legends.tooltip(@"
Years spent feeding and caring for falcons has made them your friends.

[color=%active%][u]Active:[/u][/color]
• Summon a falcon to guide you in battle.

• Costs [color=%negative%]6[/color] AP and [color=%negative%]15[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendSummonBear <- ::Legends.tooltip(@"
Endless communion with the animals has won you the trust of the bears.

[color=%active%][u]Active:[/u][/color]
• Adds a pet bear to your stash, make sure you have space before taking this perk.

• Unlocks an event to tame bears in the woods.
");

::Const.Strings.PerkDescription.LegendSummonCatapult <- ::Legends.tooltip(@"
Put to use your skill in the creation and maintenance of siege weapons.

[color=%passive%][u]Passive:[/u][/color]
 Unlocks crafting Catapults in the crafting tent.
");

::Const.Strings.PerkDescription.LegendNetRepair <- ::Legends.tooltip(@"
Many years spent repairing and packing nets allows you to create nets and wield them more effectively.

[color=%passive%][u]Passive:[/u][/color]
 • Allows your company to repair a broken net (refill ammo charges) for a cost of 15 ammo.

• Grants[color=%positive%]+10[/color] Melee Defense while holding a net.

• Ignore the weight of nets, both when equipped or in your bag.
");

::Const.Strings.PerkDescription.LegendNetCasting <- ::Legends.tooltip(@"
Perfect the art of casting nets.

[color=%passive%][u]Passive:[/u][/color]
• Increases the throwing range of nets and reinforced nets by [color=%positive%]2[/color].

• Equipping a net when the offhand is free and always costs no Action Points.

• Nets you throw have a chance to be reusable in battle.

• Regular Nets have a [color=%positive%]25%[/color] chance to be reusable and Reinforced Nets have a [color=%positive%]50%[/color] chance to be reusable.

• All nets have a [color=%positive%]100%[/color] chance to be reusable if the target is killed before breaking free.
");

::Const.Strings.PerkDescription.LegendPacifist <- ::Legends.tooltip(@"
Fighting is a brutal thuggish pastime, most folk prefer a life without frequent bouts of extreme violence.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+10%[/color] Resolve.

• This character now gains experience from battle while in reserves.

• Additionally, this character does not count towards your party strength when determining game difficulty.

• Become content with being in reserve, and each battle in which they are forced to attack in worsens their mood.
");

::Const.Strings.PerkDescription.LegendMagicMissile <- ::Legends.tooltip(@"


[color=%active%][u]Active:[/u][/color]
• Release a controlled forceful bolt, leaping towards a foe. Damage based on current Initiative, accuracy based on ranged attack skill.
");

::Const.Strings.PerkDescription.LegendHorseMovement <- ::Legends.tooltip(@"


[color=%passive%][u]Passive:[/u][/color]
Move like a horse, quickly across flat terrain, but slowly through bogs and mountains.
");

::Const.Strings.PerkDescription.LegendCampCook <- ::Legends.tooltip(@"
There is a fine art to cooking, skills and ingredients that are not obvious but unlock a world of flavor or preserve food for longer.

[color=%passive%][u]Passive:[/u][/color]
• Unlocks food crafting in the crafting tent.

• Allows the creation of porridge, puddings, pies, meat curing, fruit drying and ration making.
");

::Const.Strings.PerkDescription.LegendPackleader <- ::Legends.tooltip(@"
Dogs can instinctively identify a pack leader, knowledge of their habits allows you to become the leader of their pack.

[color=%passive%][u]Passive:[/u][/color]
• Unlocks the ability to store additional dog items in your bags and use them in battle.
");

::Const.Strings.PerkDescription.LegendDogWhisperer <- ::Legends.tooltip(@"
You have a way with dogs, the bond you form with them imbues each dog with more confidence and strength, knowing that you are there gives them strength.

[color=%passive%][u]Passive:[/u][/color]
• Grants each dog you unleash the perks: [color=%perk%]Colossus[/color], [color=%perk%]Fortified Mind[/color], and [color=%perk%]Underdog[/color].
");

::Const.Strings.PerkDescription.LegendDogBreeder <- ::Legends.tooltip(@"
Intimate knowledge of dog care and conditions required for breeding allows you to successfully breed dogs.

[color=%passive%][u]Passive:[/u][/color]
• Unlocks a recipe in the crafting tent for breeding dogs.
");

::Const.Strings.PerkDescription.LegendDogHandling <- ::Legends.tooltip(@"
You have mastered the art of training dogs.

[color=%active%][u]Active:[/u][/color]
• In the heat of battle your hounds will respond and react to your commands, order them to attack or defend allies.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]0[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendDogMaster <- ::Legends.tooltip(@"
Your way with animals extends so far as turning those dogs that would do you harm.

[color=%active%][u]Active:[/u][/color]
• By spending [color=%negative%]1[/color] item of food you can make a dog flee from battle.

• The food item is chosen at random and the perk does not work if you have less than 25 food.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]0[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendHeightenedReflexes <- ::Legends.tooltip(@"
Your heightened senses leads your strikes to vitals.

[color=%passive%][u]Passive:[/u][/color]
• [color=%positive%]15%[/color] of your current Initiative will be translated into damage done.
");

::Const.Strings.PerkDescription.LegendWindReader <- ::Legends.tooltip(@"
You have learned to read the wind, estimating the path of arrows in uncertain conditions.

[color=%passive%][u]Passive:[/u][/color]
• Gain a third of your character's base Ranged Defense as Ranged Skill, with a minimum bonus of [color=%positive%]3[/color].

• Gain [color=%positive%]+5%[/color] Ranged Damage for each level difference when you have the high ground.
");

::Const.Strings.PerkDescription.LegendPaymaster <- ::Legends.tooltip(@"
Shifting numbers is a fine art, by negotiating pay terms and usury it is possible to drive down mercenary pay.

[color=%passive%][u]Passive:[/u][/color]
• Lowers daily wages for all mercenaries in the company by a percentage equal to your barter skill.

• This perk is only counted once per company.
");

::Const.Strings.PerkDescription.LegendQuartermaster <- ::Legends.tooltip(@"
By cooking bulk meals, using scraps, and saving leftovers you can save food for the company.

[color=%passive%][u]Passive:[/u][/color]
• Reduces food consumption by [color=%negative%]1[/color] for every mercenary.

• This perk is only counted once per company.
");

::Const.Strings.PerkDescription.LegendBarterGreed <- ::Legends.tooltip(@"
This character is keen to guard the horde of gold the company has accumulated — and intends to protect it with their life.

[color=%passive%][u]Passive:[/u][/color]
• For every 10,000 crowns you have in your stash:
- Gain [color=%positive%]+1.5[/color] to Melee Skill and Ranged Skill.
- Gain [color=%positive%]+1.5[/color] as Melee Defense and Ranged Defense.
- Gain [color=%positive%]+2[/color] to Resolve.

• The Bonus gained from Crowns above 80000 is reduced by [color=%negative%]20%[/color].

• Additionally, your global Barter is divided by [color=%negative%](1 + Brothers with this perk)[/color] at all times.
");

::Const.Strings.PerkDescription.LegendPrayerOfLife <- ::Legends.tooltip(@"
A prayer of hope and love restores wellbeing to your allies and tears at the undead.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Prayer of Hope[/color] skill.

• When activated adjacent allies gain [color=%positive%]+20%[/color] of your current Resolve as Hitpoints spread out over several turns. Can not heal more than 10 Hitpoints per turn.

• Inflicts a disintegrating ailment on each adjacent undead dealing [color=%damage%]10[/color] damage per turn for two turns.

• Does not work on cultists.

• Costs [color=%negative%]6[/color] AP and [color=%negative%]30[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendPrayerOfFaith <- ::Legends.tooltip(@"
A prayer of devotion grants strength to your allies and baffles the undead.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Prayer of Faith[/color] skill.

• When activated adjacent allies gain [color=%positive%]20%[/color] of your current Resolve as a bonus to Melee and Ranged Defense.

• Adjacent cultists and undead are [color=%status%]Baffled[/color].

• [color=%status%]Baffled[/color] enemies have their Melee Defense, Initiative, and Max Fatigue reduced by [color=%negative%]15%[/color].

•  Costs [color=%negative%]6[/color] AP and [color=%negative%]30[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendHolyFlame <- ::Legends.tooltip(@"
The old gods have allowed you to wield their light.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Holy Flame[/color] skill.

• When activated imbues a tile and its surrounding tiles with the Sanctified Ground effect for two turns.

• Human allies within the area become [color=%status%]Sanctified[/color], gaining immunity to [color=%status%]Injuries[/color], [color=%status%]Bleeding[/color], [color=%status%]Poisoned[/color], and [color=%status%]Morale checks[/color] when taking damage.

• Cultists and Undead become [color=%status%]Consecrated[/color], taking [color=%damage%]10[/color] to [color=%damage%]20[/color] damage each turn, and lose any immunity to [color=%status%]Injuries[/color], [color=%status%]Bleeding[/color], and [color=%status%]Poison[/color].

• Additionally, Undead cannot resurrect in the area while the flame is active.

• Costs [color=%negative%]7[/color] AP and [color=%negative%]30[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendShieldsUp <- ::Legends.tooltip(@"
Drilling your troops in a shieldwall prepares their reaction time to avoid early deaths on the battlefield.

[color=%passive%][u]Passive:[/u][/color]
• Taking this perk ensures every mercenary with a shield will use [color=%skill%]shieldwall[/color] before the start of each battle.
");

::Const.Strings.PerkDescription.LegendIncoming <- ::Legends.tooltip(@"
Direct allies to attack at once, granting enhanced skills and defense.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Incoming![/color] skill which Grants [color=%positive%]+5[/color] Ranged Skill, [color=%positive%]+5[/color] Resolve and [color=%positive%]+10[/color] Ranged Defense to all allies within four tiles for one turn.

• Costs [color=%negative%]5[/color] AP and [color=%negative%]20[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendZombieBite <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• braaaains
");

::Const.Strings.PerkDescription.LegendCheerOn <- ::Legends.tooltip(@"
Use your way with song to cheer on an ally.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Cheer On[/color] skill which Grants [color=%positive%]+2[/color] Action Points to an ally adjacent to you.

• Can only be used with an Instrument or Banner equipped.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]30[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendLeap <- ::Legends.tooltip(@"
Use your athletic skill to leap high and far.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Leap[/color] skill which allows you to quickly cover two tiles distance.

• Fatigue cost is increased by the weight of your armor.

• Costs [color=%negative%]6[/color] AP and [color=%negative%]15[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendTumble <- ::Legends.tooltip(@"
Make use of your acrobatic skill to dodge attacks and move out of trouble.

[color=%passive%][u]Passive:[/u][/color]
• As long as there's a free tile adjacent any attack against you will be rerolled. If the attack is ranged you will use your Melee Defense and if the attack is Melee you will use your Ranged Defense for the reroll.
");

::Const.Strings.PerkDescription.LegendHairSplitter <- ::Legends.tooltip(@"
Years of practice throwing things at apples above heads have granted a magnetic attraction to the cranium.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+30%[/color] chance to hit the head.
");

::Const.Strings.PerkDescription.LegendBearform <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• Transform into a powerful bear, doubles your Hitpoints. Requires free hands.
");

::Const.Strings.PerkDescription.LegendRoots <- ::Legends.tooltip(@"
Summon roots and vines to entangle your enemies.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Root[/color] skill which allows you to [color=%status%]Root[/color] any enemy within eight tiles.

• [color=%status%]Rooted[/color] enemies have their Melee Defense, Ranged Defense, and Initiative reduced by [color=%negative%]35%[/color].

• If affected by rain AP cost is reduced by [color=%negative%]1[/color] and Fatigue cost is reduced by [color=%negative%]10[/color].

• Costs [color=%negative%]6[/color] AP and [color=%negative%]15[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendWolfform <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• Transform into a nimble wolf, decreasing movement costs. Requires free hands.
");

::Const.Strings.PerkDescription.LegendTrueForm <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• Increases the length of your transformations to six turns.
");

::Const.Strings.PerkDescription.LegendSummonStorm <- ::Legends.tooltip(@"
Control the elements, calling down the rain.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Summon Storm[/color] skill.

• The first cast brings on light rain, the second cast brings a heavy storm.

• Must have empty hands.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]20[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendCallLightning <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• Call down lightning upon your enemies. Grants a 10% chance to unleash lightning on each unit within 4 tiles. Must have empty hands and it must be raining.
");

::Const.Strings.PerkDescription.LegendScryTrance <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• Scries an area of 12 tiles around the user. The user will be unable to move or act during the trance until cancelled. Minimum of one turn channel.
");

::Const.Strings.PerkDescription.LegendReadOmensTrance <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• The user enters a trance, telling all allies of their future. Grants [color=%positive%]10%[/color] chance to have any attacker require two successful attack rolls in order to hit.
");

::Const.Strings.PerkDescription.LegendDistantVisions <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• This character spends a lot of time alone outside camp, staring into the distance and smoking strange bark. Allows the user to have distant visions of towns.  Each morning this character is in reserves grants you insight into a specific town's current events and buildings.
");

::Const.Strings.PerkDescription.LegendScrollIngredients <- ::Legends.tooltip(@"
All those years of studying ancient languages finally has a use.

[color=%passive%][u]Passive:[/u][/color]
• Allows the user to identify Ancient Scrolls, when given a Cloth and Dyes. These tomes grant a specific effect, whereas an Ancient Scroll gives any random effect.
");

::Const.Strings.PerkDescription.LegendScholar <- ::Legends.tooltip(@"
Put your all into your studies.

[color=%passive%][u]Passive:[/u][/color]
• Allows the user to be counted as 'educated' for events, regardless if other conditions are met or they have the 'dumb' trait.

• [color=%positive%]10%[/color] chance to get any items from slain enemies, that might not otherwise be available to loot.

• Stacks with itself and effects of a similar nature. Does not need to be in combat for this perk to work.
");
 //Masons, Inventors and Historians and do not need this perk unless they have the dumb trait for scrolls.
::Const.Strings.PerkDescription.LegendCitrinitas <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• A powerful cocktail of ingredients provides a trance like state, granting the banner effect, and drums of war effects to everyone in the company at the end of the user's turn.
");

::Const.Strings.PerkDescription.LegendAlbedo <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• A concoction of secret materials that allows the user to restore up to 25 armor to a target.
");

::Const.Strings.PerkDescription.LegendNigredo <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• An alchemical mixture of acidic vapours, encased in flasks that can be thrown at the enemy to dissolves their armor.
");

::Const.Strings.PerkDescription.LegendHerbcraft <- ::Legends.tooltip(@"
Knowledge of the properties of various roots and herbs lets you construct medicines from base ingredients.

[color=%passive%][u]Passive:[/u][/color]
• Allows the creation of medicine, antidotes and poisons in the crafting tent.
");

::Const.Strings.PerkDescription.LegendWoodworking <- ::Legends.tooltip(@"
The ability to cut and shape wood is a craft few master.

[color=%passive%][u]Passive:[/u][/color]
• Allows the creation of fine wood from rough wood in the crafting tent.
");

::Const.Strings.PerkDescription.LegendOreHunter <- ::Legends.tooltip(@"
'Come all you young fellers, so young and so fine, and seek not your fortune in the dark dreary mine'.

[color=%passive%][u]Passive:[/u][/color]
• Allows this character to mine for minerals while assigned to the Supply Tent in camp.
");

::Const.Strings.PerkDescription.LegendSurpressUrges <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• Allows this character to control shapeshifting to some extent, no longer deliberately striking allies and foes alike while transformed.
");

::Const.Strings.PerkDescription.LegendControlInstincts <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• Gives character self control while transformed.
");

::Const.Strings.PerkDescription.LegendMasterAnger <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• Allows the character to transform at will, no longer randomly transforming during battle.
");

::Const.Strings.PerkDescription.LegendMagicBurningHands <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• Unleash a cone of blistering heat from your palms, can hit up to 9 targets for 10-15 damage.
");

::Const.Strings.PerkDescription.LegendMagicChainLightning <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• Fire a bolt of lightning at an enemy that can arc to two adjacent enemies.
");

::Const.Strings.PerkDescription.LegendMagicCircleOfProtection <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• A magic circle that protects all allies within casting. Leaving the circle breaks the protection.
");

::Const.Strings.PerkDescription.LegendMagicDaze <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• Assault the senses of your target with a conjured flurry of colorful sparks, whirs, and pops. Such an astonishing display is sure to leave anyone too [color=%status%]Bewildered[/color] to fight effectively.

 Does no damage.
");

::Const.Strings.PerkDescription.LegendMagicHailstone <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
 • Conjure a heavy ball of ice to crush your enemies.
");

::Const.Strings.PerkDescription.LegendMagicHealingWind <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• Restore the Hitpoints of all allies within 4 tiles. Must be holding a magic staff to use.
");

::Const.Strings.PerkDescription.LegendMagicImbue <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• Imbue someone with magical power, temporarily increasing accuracy and damage.
");

::Const.Strings.PerkDescription.LegendMagicLevitate <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• Levitate someone off the ground, granting them the ability to move freely across all terrain for a short duration.
");

::Const.Strings.PerkDescription.LegendMagicMissile <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• A burst of force, leaping forward into a foe.
");

::Const.Strings.PerkDescription.LegendMagicPsybeam <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• Launch a mental attack in the form of a ray at an enemy to [color=%status%]Stun[/color] or [color=%status%]Daze[/color] them. Does no damage.
");

::Const.Strings.PerkDescription.LegendMagicSleep <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• Use soothing vapours to lull an enemy to sleep. The chance of success is determined by the Resolves of the user and target.
");

::Const.Strings.PerkDescription.LegendMagicSoothingWind <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• Restore the Fatigue of all allies within 4 tiles. Must be holding a magic staff to use.
");

::Const.Strings.PerkDescription.LegendMagicTeleport <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• Teleport a short distance away.
");

::Const.Strings.PerkDescription.LegendMagicWebBolt <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• Send a web of silk out to ensnare an opponent, rooting them in place halving their damage, defenses and Initiative.
");

::Const.Strings.PerkDescription.LegendMasteryBurningHands <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• Increases the intensity of your heat, doubles the damage of burning hands.
");

::Const.Strings.PerkDescription.LegendMasteryChainLightning <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• Lightning gains +10% chance to hit and +1 range.
");

::Const.Strings.PerkDescription.LegendMasteryHailstone <- ::Legends.tooltip(@"
[color=%active%][u]Active:[/u][/color]
• Hailstone can now ignore 65% of armor and inflicts 125% damage to armor.
");

::Const.Strings.PerkDescription.LegendMagicMissileFocus <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• Reduce AP cost of Magic Missile by 1.
");

::Const.Strings.PerkDescription.LegendMagicMissileMastery <- ::Legends.tooltip(@"
[color=%passive%][u]Passive:[/u][/color]
• Reduce AP and cost of Magic Missile by 1. Reduce the base Fatigue cost of Magic Missile by 6.
");

::Const.Strings.PerkDescription.LegendUnarmedLunge <- ::Legends.tooltip(@"
In one motion take a step forward and land a blow on your enemy.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Unarmed Lunge[/color] skill which lets you move a tile and attack in a single action while unarmed.

• Does [color=%positive%]10-20[/color] damage without Unarmed Training.

• Costs [color=%negative%]6[/color] AP and [color=%negative%]30[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendThrowSand <- ::Legends.tooltip(@"
Its hard to fight with sand in your eyes.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Throw Dirt[/color] skill which allows you to throw dirt in the eyes of an enemy to distract them.

• [color=%status%]Distracted[/color] enemies have their Initiative and damage reduced by [color=%negative%]35%[/color].

• Can only be used once per fight.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]5[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendBackflip <- ::Legends.tooltip(@"
Extensive training in circus maneuvers allows you to move out of harm's way with astonishing speed.

[color=%passive%][u]Passive:[/u][/color]
• If you have taken the [color=%perk%]Footwork[/color] or [color=%perk%]Leap[/color] perk, they gain [color=%positive%]1[/color] range.
");

::Const.Strings.PerkDescription.LegendTwirl <- ::Legends.tooltip(@"
Practice in physical movement with a partner has given the ability to take the lead and move someone's body in a twirling movement.

[color=%passive%][u]Passive:[/u][/color]
• If you have taken the [color=%perk%]Rotation[/color] perk, it can now target enemies.
");

::Const.Strings.PerkDescription.LegendKnifeplay <- ::Legends.tooltip(@"
Learn to accurately throw your knives.

[color=%active%][u]Active:[/u][/color]
• Unlocks a bound throwing knife skill that does [color=%positive%]15-25[/color] damage with poor armor penetration.

• Has a [color=%positive%]+15%[/color] chance to hit the head.

• Has a range of three tiles.

• Has a [color=%positive%]25%[/color] chance to [color=%status%]Daze[/color] a target on hit.

• Benefits from perks that affect throwing weapons.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]5[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendOpportunist <- ::Legends.tooltip(@"
Make the most of the opportunity's presented to you in battle.

[color=%passive%][u]Passive:[/u][/color]
• When successfully landing a hit on an enemy who is [color=%status%]Bleeding[/color] or [color=%status%]Poisoned[/color], apply [color=%status%]Dazed[/color] to them.

• If you are within a smoke cloud, you will gain [color=%positive%]+10%[/color] Melee Skill and no penalty to Ranged Skill.
");

::Const.Strings.PerkDescription.LegendPrepared <- ::Legends.tooltip(@"
Coat your blade with posion.

[color=%passive%][u]Passive:[/u][/color]
• While using a dagger, dealing Hitpoints damage to an enemy has a [color=%positive%]+33%[/color] chance of poisoning them.

• You will also gain [color=%positive%]+12[/color] Melee Skill and [color=%positive%]+3[/color] Fatigue recovery per turn while holding a dagger in your mainhand.
");

::Const.Strings.PerkDescription.LegendLurker <- ::Legends.tooltip(@"
'I work better alone.'

[color=%passive%][u]Passive:[/u][/color]
• When neither ally nor enemy is within 2 tiles, gain [color=%positive%]+30%[/color] Ranged Defense, [color=%positive%]+20[/color] Initiative, and [color=%positive%]+3[/color] Action Points.

• If you are under the effects of [color=%status%]Hidden[/color], gain [color=%positive%]+10[/color] Fatigue recovery per turn and [color=%positive%]+20%[/color] Ranged Skill.

• If you are within a smoke cloud, gain [color=%positive%]+2[/color] maximum Action Points.
");

::Const.Strings.PerkDescription.LegendNightRaider <- ::Legends.tooltip(@"
Gain enhanced vision and tactical advantages at night.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+1[/color] vision and become unaffected by night time penalties.

• When attacking at night, adjacent enemies will lose [color=%negative%]10[/color] Resolve when adjacent to you.

• Gain [color=%positive%]+10%[/color] Melee and Ranged Skill while fighting at night.
");

::Const.Strings.PerkDescription.LegendAdaptive <- ::Legends.tooltip(@"
Who says you can't teach an old dog new tricks?

[color=%passive%][u]Passive:[/u][/color]
 Add a new Perk Group to this character's Perk Tree based on what is currently equipped in their hands, which is checked in the following order...

• [color=%positive%]Mainhand items:[/color] always checked first, giving priority to 'Specialist' Classes before Weapon Perk Groups.

• [color=%positive%]Hybrid Weapons:[/color] the character will be given the Perk Group they do not have, or be given one randomly from the applicable Weapon Types if they have neither.

• [color=%positive%]Offhand items:[/color] same as above.

• [color=%positive%]Unarmed:[/color] If no items are equipped, they will gain the Unarmed Perk Group if they do not have it.

•[color=%positive%]Armor:[/color] If armor weight is between [color=%negative%]0[/color] and [color=%negative%]15[/color] they will receive Light armor perk group. If weight is between [color=%negative%]16[/color] and [color=%negative%]35[/color] they will receive Medium armor perk group. If weight is over [color=%negative%]35[/color] they will receive Heavy armor perk group.

• [color=%negative%]If the character has all the Perk Groups of their equipped items, they will be given a random Trait Perk Group they do not have.[/color]

• When this character reaches level [color=%positive%]15[/color], the perk point spent is refunded.
");

::Const.Strings.PerkDescription.LegendRecuperation <- ::Legends.tooltip(@"
Heal more effectively over time.

[color=%passive%][u]Passive:[/u][/color]
• At the end of combat recover [color=%positive%]30%[/color] of your missing health and injuries recover [color=%positive%]1[/color] day faster.
");

::Const.Strings.PerkDescription.LegendClimb <- ::Legends.tooltip(@"
Learn to scale cliffs with unmatched speed!

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Climb[/color] skill which allows you to climb sheer cliffs up to five levels of height in one action.

• Does not trigger attacks of opportunity.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]20[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendBlendIn <- ::Legends.tooltip(@"
Hold yourself in a way that makes you seem more trouble than its worth, lean into trees, place objects between you and an enemy, and hide behind allies.

[color=%passive%][u]Passive:[/u][/color]
• Makes enemies [color=%positive%]50%[/color] less likely to attack you instead of an ally.

• Grants [color=%positive%]+5[/color] Ranged Defense and [color=%positive%]+3[/color] Melee Defense.
");

::Const.Strings.PerkDescription.LegendFashionable <- ::Legends.tooltip(@"
Style over substance.

[color=%passive%][u]Passive:[/u][/color]
• Tabards, cloaks and helmet vanity layers weigh nothing. This impacts [color=%perk%]Nimble[/color] and [color=%perk%]Lithe[/color].
");

::Const.Strings.PerkDescription.LegendHimshaw <- ::Legends.tooltip(@"
'In short, we tailored.'

[color=%passive%][u]Passive:[/u][/color]
• This mercenary will care for their own equipment. Once a day, at the end of combat repair [color=%negative%]20%[/color] of their body and helmet.

• At the start of each day additionally repair [color=%negative%]10%[/color] of their body and helmet.
");

::Const.Strings.PerkDescription.LegendSwagger <- ::Legends.tooltip(@"
Having an expensive, well polished armor seems to deflect blows and turn away arrows. Or at least that's what most mercenaries think.

[color=%passive%][u]Passive:[/u][/color]
• At the start of combat gain [color=%positive%]0.2%[/color] of your helmet and armor's value as armor condition and half that to the helmet. Will be removed at the end of combat.

• The final armor bonus value will be increased by [color=%positive%]1%[/color] for every point of armor weight (if you have 50 armor weight then you'll receive 50% more armor).
");

::Const.Strings.PerkDescription.LegendHelpful <- ::Legends.tooltip(@"
Enhance your logistical support in battle.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Pass Item[/color] skill which allows you to give items from your bag. Taking [color=%skill%]Quick Hands[/color] reduces the Action Point cost by [color=%negative%]2[/color].

• Does not work when receiving items.

• Costs [color=%negative%]2[/color] AP and [color=%negative%]5[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendLionheart <- ::Legends.tooltip(@"
A lion's heart beats with unyielding strength, facing every challenge with with fearless resolve!

[color=%passive%][u]Passive:[/u][/color]
• Being surrounded by enemies no longer affects your morale and increases your resolve by [color=%positive%]10%[/color].
");

::Const.Strings.PerkDescription.LegendStrengthInNumbers <- ::Legends.tooltip(@"
Surround, distract and strike true.

[color=%passive%][u]Passive:[/u][/color]
• The bonus to hitchance in melee is doubled to [color=%positive%]+10%[/color] for each ally surrounding and distracting your target.
");

::Const.Strings.PerkDescription.LegendKeenEyesight <- ::Legends.tooltip(@"
Learn how to use your superb eyesight to notice the smallest movements and predict your opponent's next attack, to hit distant targets and to avoid incoming projectiles.

[color=%passive%][u]Passive:[/u][/color]
• Gain a [color=%positive%]+3/+5[/color] bonus to Melee/Ranged Skill for each point of vision above 7.

• Gain a [color=%positive%]+3/+4[/color] bonus to Melee/Ranged Defense for each point of vision above 7.

• If your helmet reduces your vision score by at least 3/5 these bonuses are reduced by [color=%negative%]10%/20%[/color].

• For the purposes of this perk, your current vision is calculated as if you had no helmet, only the above penalty applies.
");

::Const.Strings.PerkDescription.LegendSleightOfHand <- ::Legends.tooltip(@"
An ace up your sleeve.

[color=%passive%][u]Passive:[/u][/color]
• Currently equipped throwing items that use ammo regain 1 ammo each turn.
");

::Const.Strings.PerkDescription.LegendPromisedPotential <- ::Legends.tooltip(@"
A natural talent, realized.

[color=%passive%][u]Passive:[/u][/color]
• Upon picking up increase every attribute by [color=%positive%]1-6[/color] depending on how many stars each attribute has. Untalented attributes are increased by [color=%positive%]1[/color], while talented are increased by [color=%positive%]2[/color] for every star.
");

::Const.Strings.PerkDescription.LegendWheelMaintenance <- ::Legends.tooltip(@"
True caravaneers know that regular wheel maintenance is vital on the road and wilderness.

[color=%passive%][u]Passive:[/u][/color]
• Increases movement speed on the world map by [color=%positive%]5%[/color]. Stacks with itself.
");

::Const.Strings.PerkDescription.LegendMasterTrainer <- ::Legends.tooltip(@"
My sword is my best friend. It is my life. I must master it as I must master my life.

[color=%passive%][u]Passive:[/u][/color]
• As long as this character is in the training tent every character training receives an additional [color=%positive%]+10%[/color] training speed in camp.
");

::Const.Strings.PerkDescription.LegendWhipThemInShape <- ::Legends.tooltip(@"
'You maggots may yet earn my respect'.

[color=%passive%][u]Passive:[/u][/color]
• Kills made by veteran mercenaries earn [color=%positive%]+100%[/color] shared XP for mercenaries who are level 11 or under.
");

::Const.Strings.PerkDescription.LegendTacticalManeuvers <- ::Legends.tooltip(@"
Every fight is like a dance, and you have just the right moves.

[color=%passive%][u]Passive:[/u][/color]
• Unlocks the [color=%skill%]Rotation[/color] skill which allows two characters to switch places while ignoring Zone of Control, as long as neither character is [color=%status%]Stunned[/color], [color=%status%]Rooted[/color] or otherwise disabled.

• Unlocks the [color=%skill%]Footwork[/color] skill which allows you to leave a Zone of Control without triggering free attacks.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]20[/color] Fatigue.
");

::Const.Strings.PerkDescription.LegendVersatile <- ::Legends.tooltip(@"
Oftentimes better than a master of one.

[color=%passive%][u]Passive:[/u][/color]
• Confers a [color=%negative%]50%[/color] damage bonus to Ranged Damage on next attack when attacking with a Melee Attack and a [color=%negative%]50%[/color] damage bonus to Melee Damage on next attack when attacking with a Ranged Attack.
");

