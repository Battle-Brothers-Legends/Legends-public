if (!("Traits" in ::Legends)) {
	::Legends.Traits <- {};
}

if (!("Trait" in ::Legends)) {
	::Legends.Trait <- {};
}

::Legends.Traits.createTraitDef <- function (_def) {
	::Legends.Trait[_def.Const] <- null;
	local constString = _def.Const;
	local type = "trait";
	if (constString.find("Racial") == 0) {
		constString = constString.slice(6);
		type = "racial";
	}
	local snakeCase = ::Legends.DefsHelpers.convertToSnakeCase(constString);
	if (!("ID" in _def)) {
		_def.ID <- type + "." + snakeCase;
	}

	if (!("Script" in _def)) {
		_def.Script <- "scripts/skills/" + (type == "trait" ? "traits" : type) + "/" + snakeCase + "_" + type;
	}

	if (!("Name" in _def)) {
		_def.Name <- ::Legends.DefsHelpers.convertToDisplayName(constString);
	}

	if (!("Icon" in _def)) {
		_def.Icon <- "ui/traits/" + snakeCase + ".png";
	}

	if (!("Random" in _def)) {
		_def.Random <- false;
	}

	if (!("VisibleOnRecruitment" in _def)) {
		_def.VisibleOnRecruitment <- false;
	}

	return _def;
};

::Legends.Traits.TraitDefObjects <- [];
::Legends.Traits.LookupMap <- {};

::Legends.Traits.pushToCharacterTraits <- function (_obj) {
	foreach (obj in ::Const.CharacterTraits) {
		if (obj[0] == _obj.ID) {
			return;
		}
	}
	::Const.CharacterTraits.push([_obj.ID, _obj.Script]);
}

::Legends.Traits.addTraitDefObjects <- function (_traitDefObjects) {
	local size = ::Legends.Traits.TraitDefObjects.len();
	local count = 0;
	foreach (constName, def in _traitDefObjects) {
		def.Const <- constName;
		::Legends.Traits.TraitDefObjects.push(::Legends.Traits.createTraitDef(def));
		local i = size + count;
		if (def.Const in ::Legends.Trait) {
			::Legends.Trait[def.Const] = size + i;
		} else {
			::Legends.Trait[def.Const] <- size + i;
		}
		if ("Random" in def && def.Random) {
			::Legends.Traits.pushToCharacterTraits(def);
		}
		::Legends.Traits.LookupMap[def.ID] <- def;
		count++;
	}
}

// the pool of random traits that spawn on bros
local traitDefs = {
	// not setting icons on Vanilla stuff currently, they don't use onCreate anyway
	Ailing = {},
	Asthmatic = {},
	Athletic = {
		VisibleOnRecruitment = true
	},
	Bleeder = {},
	Bloodthirsty = {},
	Brave = {},
	Bright = {},
	Brute = {},
	Clubfooted = {},
	Clumsy = {},
	Cocky = {
		VisibleOnRecruitment = true
	},
	Craven = {},
	Dastard = {},
	Deathwish = {},
	Determined = {},
	Dexterous = {},
	Disloyal = {},
	Drunkard = {},
	Dumb = {},
	EagleEyes = {},
	Fainthearted = {},
	Fat = {
		VisibleOnRecruitment = true
	},
	FearBeasts = {
		Name = "Fear of Beasts"
	},
	FearGreenskins = {
		Name = "Fear of Greenskins"
	},
	Fearless = {},
	FearUndead = {
		Name = "Fear of Undead"
	},
	Fragile = {},
	Gluttonous = {},
	Greedy = {},
	HateBeasts = {
		Name = "Hate for Beasts"
	},
	HateGreenskins = {
		Name = "Hate for Greenskins"
	},
	HateUndead = {
		Name = "Hate for Undead"
	},
	Hesitant = {
		VisibleOnRecruitment = true
	},
	Huge = {
		VisibleOnRecruitment = true
	},
	Impatient = {},
	Insecure = {},
	IronJaw = {},
	IronLungs = {},
	Irrational = {},
	Loyal = {},
	Lucky = {},
	NightBlind = {},
	NightOwl = {},
	Optimist = {},
	Paranoid = {},
	Pessimist = {},
	Quick = {},
	ShortSighted = {},
	Spartan = {},
	Strong = {},
	Superstitious = {},
	SureFooting = {},
	Survivor = {},
	Swift = {},
	Teamplayer = {},
	Tiny = {
		VisibleOnRecruitment = true
	},
	Tough = {},
	Weasel = {},
	LegendAggressive = {},
	LegendAmbitious = {},
	LegendCharming = {},
	LegendDoubleTongued = {},
	LegendNyctophobia = {},
	LegendFearNobles = {
		Name = "Fear of Nobles"
	},
	LegendHateNobles = {
		Name = "Hate for Nobles"
	},
	LegendLumbering = {
		VisibleOnRecruitment = true
	},
	LegendLight = {
		VisibleOnRecruitment = true
	},
	LegendMartial = {},
	LegendSeductive = {},
	LegendSlack = {},
	LegendSteadyHands = {},
	LegendSureshot = {},
	LegendTalented = {},
	LegendPragmatic = {},
	LegendPredictable = {},
	LegendUnpredictable = {},
};
foreach (_, def in traitDefs) {
	def.Random <- true;
}

// the pool of other traits and racials
local otherTraitDefs = {
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
	LegendNecromancer = {
		Icon = "ui/traits/trait_icon_00.png"
	},
	LegendNobleKiller = {
		Icon = "ui/traits/legend_hate_nobles.png"
	},
	LegendNomad = {
		Icon = "ui/traits/trait_icon_00.png"
	},
	LegendPeasant = {
		Icon = "ui/traits/trait_icon_00.png"
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
	RacialChampion = {},
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

// merge staticTraitDefs into traitDefs
foreach (key, def in otherTraitDefs) {
	traitDefs[key] <- def;
}

::Legends.Traits.addTraitDefObjects(traitDefs);
