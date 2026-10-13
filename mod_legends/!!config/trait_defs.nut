if (!("Traits" in ::Legends)) {
	::Legends.Traits <- {};
}

::Legends.Traits.TraitDefObjects <- {};
::Legends.Traits.LookupMap <- {};

::Legends.Traits.defaultDef <- function(_def) {
	local tokens = ::Legends.DefsHelpers.tokenizeConst(_def.Const);
	local type = "trait";
	if (tokens.find("Racial") == 0) {
		type = "racial";
		tokens.remove(0);
	}
	local transformedConst = tokens.reduce(@(p, c) p + c);
	local snakeCase = ::Legends.DefsHelpers.convertToSnakeCase(transformedConst);
	return {
		Const = _def.Const,
		ID = ::format("%s.%s", type, snakeCase),
		Script = ::format("scripts/skills/%s/%s_%s", (type == "trait" ? "traits" : type), snakeCase, type),
		Name = ::Legends.DefsHelpers.convertToDisplayName(transformedConst),
		Icon = ::format("ui/traits/%s.png", snakeCase),
		Random = false,
		VisibleOnRecruitment = false
	}
}

::Legends.Traits.transformDef <- function (_def) {
	local defaultDef = ::Legends.Traits.defaultDef(_def);
	foreach (key, value in _def) {
		if (key in defaultDef) {
			defaultDef[key] = value; // overwrite
		} else {
			// here's weird situation, we have a slot that was not defined in default, which most likely means bug
			defaultDef[key] <- value;
			::logWarning(::format("trait '%s' defines unknown field '%s' in traits_defs", defaultDef.ID, key));
		}
	}
	return defaultDef;
};

::Legends.Traits.pushToCharacterTraits <- function (_obj) {
	foreach (obj in ::Const.CharacterTraits) {
		if (obj[0] == _obj.ID) {
			return;
		}
	}
	::Const.CharacterTraits.push([_obj.ID, _obj.Script]);
}

::Legends.Traits.addTraitDefObjects <- function (_traitDefObjects) {
	foreach (constName, def in _traitDefObjects) {
		def.Const <- constName;
		def = ::Legends.Traits.transformDef(def);
		local hash = ::IO.scriptHashByFilename(def.Script);
		if (hash == null)
			::logError(::format("%s: hash is null for '%s'", def.Const, def.Script));
		::Legends.Traits.TraitDefObjects[hash] <- def;
		if (def.Const in ::Legends.Trait) {
			::Legends.Trait[def.Const] = hash;
		} else {
			::Legends.Trait[def.Const] <- hash;
		}
		if (def.Random)
			::Legends.Traits.pushToCharacterTraits(def);
		::Legends.Traits.LookupMap[def.ID] <- def;
	}
}

// the pool of random traits that spawn on bros
::Legends.Trait <- {
	// not setting icons on Vanilla stuff currently, they don't use onCreate anyway
	Ailing = {
		Random = true
	},
	Asthmatic = {
		Random = true
	},
	Athletic = {
		VisibleOnRecruitment = true,
		Random = true
	},
	Bleeder = {
		Random = true
	},
	Bloodthirsty = {
		Random = true
	},
	Brave = {
		Random = true
	},
	Bright = {
		Random = true
	},
	Brute = {
		Random = true
	},
	Clubfooted = {
		Random = true
	},
	Clumsy = {
		Random = true
	},
	Cocky = {
		VisibleOnRecruitment = true,
		Random = true
	},
	Craven = {
		Random = true
	},
	Dastard = {
		Random = true
	},
	Deathwish = {
		Random = true
	},
	Determined = {
		Random = true
	},
	Dexterous = {
		Random = true
	},
	Disloyal = {
		Random = true
	},
	Drunkard = {
		Random = true
	},
	Dumb = {
		Random = true
	},
	EagleEyes = {
		Random = true
	},
	Fainthearted = {
		Random = true
	},
	Fat = {
		VisibleOnRecruitment = true,
		Random = true
	},
	FearBeasts = {
		Name = "Fear of Beasts",
		Random = true
	},
	FearGreenskins = {
		Name = "Fear of Greenskins",
		Random = true
	},
	Fearless = {
		Random = true
	},
	FearUndead = {
		Name = "Fear of Undead",
		Random = true
	},
	Fragile = {
		Random = true
	},
	Gluttonous = {
		Random = true
	},
	Greedy = {
		Random = true
	},
	HateBeasts = {
		Name = "Hate for Beasts",
		Random = true
	},
	HateGreenskins = {
		Name = "Hate for Greenskins",
		Random = true
	},
	HateUndead = {
		Name = "Hate for Undead",
		Random = true
	},
	Hesitant = {
		VisibleOnRecruitment = true,
		Random = true
	},
	Huge = {
		VisibleOnRecruitment = true,
		Random = true
	},
	Impatient = {
		Random = true
	},
	Insecure = {
		Random = true
	},
	IronJaw = {
		Random = true
	},
	IronLungs = {
		Random = true
	},
	Irrational = {
		Random = true
	},
	Loyal = {
		Random = true
	},
	Lucky = {
		Random = true
	},
	NightBlind = {
		Random = true
	},
	NightOwl = {
		Random = true
	},
	Optimist = {
		Random = true
	},
	Paranoid = {
		Random = true
	},
	Pessimist = {
		Random = true
	},
	Quick = {
		Random = true
	},
	ShortSighted = {
		Random = true
	},
	Spartan = {
		Random = true
	},
	Strong = {
		Random = true
	},
	Superstitious = {
		Random = true
	},
	SureFooting = {
		Random = true
	},
	Survivor = {
		Random = true
	},
	Swift = {
		Random = true
	},
	Teamplayer = {
		Random = true
	},
	Tiny = {
		VisibleOnRecruitment = true,
		Random = true
	},
	Tough = {
		Random = true
	},
	Weasel = {
		Random = true
	},
	LegendAggressive = {
		Random = true
	},
	LegendAmbitious = {
		Random = true
	},
	LegendCharming = {
		Random = true
	},
	LegendDoubleTongued = {
		Random = true
	},
	LegendNyctophobia = {
		Random = true
	},
	LegendFearNobles = {
		Name = "Fear of Nobles",
		Random = true
	},
	LegendHateNobles = {
		Name = "Hate for Nobles",
		Random = true
	},
	LegendLumbering = {
		VisibleOnRecruitment = true,
		Random = true
	},
	LegendLight = {
		VisibleOnRecruitment = true,
		Random = true
	},
	LegendMartial = {
		Random = true
	},
	LegendSeductive = {
		Random = true
	},
	LegendSlack = {
		Random = true
	},
	LegendSteadyHands = {
		Random = true
	},
	LegendSureshot = {
		Random = true
	},
	LegendTalented = {
		Random = true
	},
	LegendPragmatic = {
		Random = true
	},
	LegendPredictable = {
		Random = true
	},
	LegendUnpredictable = {
		Random = true
	},
	Addict = {},
	ArenaFighter = {},
	ArenaVeteran = {},
	CultistAcolyte = {},
	CultistChosen = {},
	CultistDisciple = {},
	CultistFanatic = {},
	CultistProphet = {},
	CultistZealot = {},
	GloriousEndurance = {}, // the trait id for these is just 'glorious' in vanilla, but if we ever do anything extra it might be better to separate, otherwise ID = "trait.glorious"
	GloriousQuickness = {},
	GloriousResolve = {},
	Mad = {},
	OathOfCamaraderie = {},
	OathOfDistinction = {},
	OathOfDominion = {},
	OathOfEndurance = {},
	OathOfFortification = {},
	OathOfHonor = {},
	OathOfHumility = {},
	OathOfRighteousness = {},
	OathOfSacrifice = {},
	OathOfValor = {},
	OathOfVengeance = {},
	OathOfWrath = {},
	Old = {},
	PitFighter = {
		Script = "scripts/skills/traits/arena_pit_fighter_trait",
	},
	Player = {
		Script = "scripts/skills/traits/player_character_trait"
	},
	LegendArenaChampion = {},
	LegendArenaInvictus = {
		Name = "Invictus"
	},
	LegendCannibalistic = {},
	LegendDeathlySpectre = {
		Icon = "ui/perks/legend_raise_undead.png"
	},
	LegendDiscipleOfTheInquisition = {
		Icon = "ui/traits/trait_icon_67.png"
	},
	LegendFleshless = {},
	LegendIntensiveTraining = {
		Name = "Training progress"
	},
	LegendLoneWolfRelationship = {
		Icon = "ui/traits/trait_icon_00.png"
	},
	LegendNaturalOrder = {},
	LegendNobleKiller = {
		Icon = "ui/traits/legend_hate_nobles.png"
	},
	LegendProstheticEar = {
		VisibleOnRecruitment = true
	},
	LegendProstheticEye = {
		VisibleOnRecruitment = true
	},
	LegendProstheticFinger = {
		VisibleOnRecruitment = true
	},
	LegendProstheticFoot = {
		VisibleOnRecruitment = true
	},
	LegendProstheticForearm = {
		VisibleOnRecruitment = true
	},
	LegendProstheticHand = {
		VisibleOnRecruitment = true
	},
	LegendProstheticLeg = {
		VisibleOnRecruitment = true
	},
	LegendProstheticNose = {
		VisibleOnRecruitment = true
	},
	LegendRottingFlesh = {
		VisibleOnRecruitment = true
	},
	LegendUndeadKiller = {
		Icon = "ui/traits/trait_icon_50.png"
	},
	LegendUnitedInChains = {
		Icon = "ui/settlement_status/settlement_effect_40.png"
	},
	LegendWitheringAura = {
		Icon = "ui/perks/rust56_circle.png" //placeholder for now
	},
	// racials start here
	RacialAlp = {
		Name = ""
	},
	RacialChampion = {
		Name = "Champion"
	},
	RacialFleshGolem = {
		Name = "Flesh Golem Racial"
	},
	RacialGhost = {
		Name = "Incorporeal"
	},
	RacialGoblinAmbusher = {
		Name = "Poison"
	},
	RacialGoblinShaman = {
		Name = "Shaman"
	},
	RacialGolem = {
		Name = ""
	},
	RacialGrandDiviner = {
		Name = "Diviner\'s Fury",
	},
	RacialLindwurm = {
		Name = "Acid Blood"
	},
	RacialSchrat = {
		Name = "Shielded"
	},
	RacialSerpent = {
		Name = ""
	},
	RacialSkeleton = {
		Name = "Resistant to Ranged Attacks"
	},
	RacialSpider = {
		Name = "Poison"
	},
	RacialTricksterGod = {
		Name = ""
	},
	RacialUnhold = {
		Name = "Unhold Passive"
	},
	RacialVampire = {},
	RacialLegendBogUnhold = {
		Name = "Bog Unhold Passive"
	},
	RacialLegendClusterSpider = {
		Name = "Cluster"
	},
	RacialLegendGreenwoodSchrat = {
		Name = "Shielded"
	},
	RacialLegendMummy = {
		Name = "Resistant to Ranged Attacks"
	},
	RacialLegendRabble = {
		Name = "Coerced"
	},
	RacialLegendRedbackSpider = {
		Name = "Redback Poison"
	},
	RacialLegendRockUnhold = {
		Name = "Rock Unhold Passive"
	},
	RacialLegendWerewolf = {
		Name = "Blind Rage"
	},
	// unused entities
	LegendHorse = {
		Icon = "ui/traits/trait_icon_07.png"
	},
	RacialLegendHorse = {
		Name = "Horse Movement"
	},
	RacialLegendKobold = {
		Name = "Slippery"
	}
}

::Legends.Traits.addTraitDefObjects(clone ::Legends.Trait);
