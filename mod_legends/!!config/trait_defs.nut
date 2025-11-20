if (!("Traits" in ::Legends))
	::Legends.Traits <- {};

if (!("Trait" in ::Legends))
	::Legends.Trait <- {};

::Legends.Traits.TraitDefObjects <- [];

::Legends.Traits.pushToCharacterTraits <- function (_obj) {
	foreach (obj in ::Const.CharacterTraits) {
		if (obj[0] == _obj.ID)
			return;
	}
	::Const.CharacterTraits.push([_obj.ID, _obj.Script])
}

::Legends.Traits.addTraitDefObjects <- function( _traitDefObjects )
{
	local size = ::Legends.Traits.TraitDefObjects.len();
	::Legends.Traits.TraitDefObjects.extend(_traitDefObjects);
	foreach (i, traitDefObject in _traitDefObjects)
	{
		if (traitDefObject.Const in ::Legends.Trait)
			::Legends.Trait[traitDefObject.Const] = size + i;
		else
			::Legends.Trait[traitDefObject.Const] <- size + i;
		if("Random" in traitDefObject && traitDefObject.Random) {
			::Legends.Traits.pushToCharacterTraits(traitDefObject);
		}
	}
}

local traitDefs = [];

// 'Random' key defines if trait should be added to the pool of random traits that spawn on bros

::Legends.Trait.Player <- null;
traitDefs.push({
	ID = "trait.player",
	Script = "scripts/skills/traits/player_character_trait",
	Const = "Player"
});

::Legends.Trait.EagleEyes <- null;
traitDefs.push({
	ID = "trait.eagle_eyes",
	Script = "scripts/skills/traits/eagle_eyes_trait",
	Const = "EagleEyes",
	Random = true
});

::Legends.Trait.ShortSighted <- null;
traitDefs.push({
	ID = "trait.short_sighted",
	Script = "scripts/skills/traits/short_sighted_trait",
	Const = "ShortSighted",
	Random = true
});

::Legends.Trait.Tough <- null;
traitDefs.push({
	ID = "trait.tough",
	Script = "scripts/skills/traits/tough_trait",
	Const = "Tough",
	Random = true
});

::Legends.Trait.Strong <- null;
traitDefs.push({
	ID = "trait.strong",
	Script = "scripts/skills/traits/strong_trait",
	Const = "Strong",
	Random = true
});

::Legends.Trait.Hesistant <- null;
traitDefs.push({
	ID = "trait.hesitant",
	Script = "scripts/skills/traits/hesitant_trait",
	Const = "Hesistant",
	Random = true
});

::Legends.Trait.Quick <- null;
traitDefs.push({
	ID = "trait.quick",
	Script = "scripts/skills/traits/quick_trait",
	Const = "Quick",
	Random = true
});

::Legends.Trait.Tiny <- null;
traitDefs.push({
	ID = "trait.tiny",
	Script = "scripts/skills/traits/tiny_trait",
	Const = "Tiny",
	Random = true
});

::Legends.Trait.Cocky <- null;
traitDefs.push({
	ID = "trait.cocky",
	Script = "scripts/skills/traits/cocky_trait",
	Const = "Cocky",
	Random = true
});

::Legends.Trait.Clumsy <- null;
traitDefs.push({
	ID = "trait.clumsy",
	Script = "scripts/skills/traits/clumsy_trait",
	Const = "Clumsy",
	Random = true
});

::Legends.Trait.Fearless <- null;
traitDefs.push({
	ID = "trait.fearless",
	Script = "scripts/skills/traits/fearless_trait",
	Const = "Fearless",
	Random = true
});

::Legends.Trait.Fat <- null;
traitDefs.push({
	ID = "trait.fat",
	Script = "scripts/skills/traits/fat_trait",
	Const = "Fat",
	Random = true
});

::Legends.Trait.Dumb <- null;
traitDefs.push({
	ID = "trait.dumb",
	Script = "scripts/skills/traits/dumb_trait",
	Const = "Dumb",
	Random = true
});

::Legends.Trait.Bright <- null;
traitDefs.push({
	ID = "trait.bright",
	Script = "scripts/skills/traits/bright_trait",
	Const = "Bright",
	Random = true
});

::Legends.Trait.Drunkard <- null;
traitDefs.push({
	ID = "trait.drunkard",
	Script = "scripts/skills/traits/drunkard_trait",
	Const = "Drunkard",
	Random = true
});

::Legends.Trait.Fainthearted <- null;
traitDefs.push({
	ID = "trait.fainthearted",
	Script = "scripts/skills/traits/fainthearted_trait",
	Const = "Fainthearted",
	Random = true
});

::Legends.Trait.Bleeder <- null;
traitDefs.push({
	ID = "trait.bleeder",
	Script = "scripts/skills/traits/bleeder_trait",
	Const = "Bleeder",
	Random = true
});

::Legends.Trait.Ailing <- null;
traitDefs.push({
	ID = "trait.ailing",
	Script = "scripts/skills/traits/ailing_trait",
	Const = "Ailing",
	Random = true
});

::Legends.Trait.Determined <- null;
traitDefs.push({
	ID = "trait.determined",
	Script = "scripts/skills/traits/determined_trait",
	Const = "Determined",
	Random = true
});

::Legends.Trait.Dastard <- null;
traitDefs.push({
	ID = "trait.dastard",
	Script = "scripts/skills/traits/dastard_trait",
	Const = "Dastard",
	Random = true
});

::Legends.Trait.Deathwish <- null;
traitDefs.push({
	ID = "trait.deathwish",
	Script = "scripts/skills/traits/deathwish_trait",
	Const = "Deathwish",
	Random = true
});

::Legends.Trait.Fragile <- null;
traitDefs.push({
	ID = "trait.fragile",
	Script = "scripts/skills/traits/fragile_trait",
	Const = "Fragile",
	Random = true
});

::Legends.Trait.Insecure <- null;
traitDefs.push({
	ID = "trait.insecure",
	Script = "scripts/skills/traits/insecure_trait",
	Const = "Insecure",
	Random = true
});

::Legends.Trait.Optimist <- null;
traitDefs.push({
	ID = "trait.optimist",
	Script = "scripts/skills/traits/optimist_trait",
	Const = "Optimist",
	Random = true
});

::Legends.Trait.Pessimist <- null;
traitDefs.push({
	ID = "trait.pessimist",
	Script = "scripts/skills/traits/pessimist_trait",
	Const = "Pessimist",
	Random = true
});

::Legends.Trait.Superstitious <- null;
traitDefs.push({
	ID = "trait.superstitious",
	Script = "scripts/skills/traits/superstitious_trait",
	Const = "Superstitious",
	Random = true
});

::Legends.Trait.Brave <- null;
traitDefs.push({
	ID = "trait.brave",
	Script = "scripts/skills/traits/brave_trait",
	Const = "Brave",
	Random = true
});

::Legends.Trait.Dexterous <- null;
traitDefs.push({
	ID = "trait.dexterous",
	Script = "scripts/skills/traits/dexterous_trait",
	Const = "Dexterous",
	Random = true
});

::Legends.Trait.SureFooting <- null;
traitDefs.push({
	ID = "trait.sure_footing",
	Script = "scripts/skills/traits/sure_footing_trait",
	Const = "SureFooting",
	Random = true
});

::Legends.Trait.Asthmatic <- null;
traitDefs.push({
	ID = "trait.asthmatic",
	Script = "scripts/skills/traits/asthmatic_trait",
	Const = "Asthmatic",
	Random = true
});

::Legends.Trait.IronLungs <- null;
traitDefs.push({
	ID = "trait.iron_lungs",
	Script = "scripts/skills/traits/iron_lungs_trait",
	Const = "IronLungs",
	Random = true
});

::Legends.Trait.Craven <- null;
traitDefs.push({
	ID = "trait.craven",
	Script = "scripts/skills/traits/craven_trait",
	Const = "Craven",
	Random = true
});

::Legends.Trait.Greedy <- null;
traitDefs.push({
	ID = "trait.greedy",
	Script = "scripts/skills/traits/greedy_trait",
	Const = "Greedy",
	Random = true
});

::Legends.Trait.Gluttonous <- null;
traitDefs.push({
	ID = "trait.gluttonous",
	Script = "scripts/skills/traits/gluttonous_trait",
	Const = "Gluttonous",
	Random = true
});

::Legends.Trait.Spartan <- null;
traitDefs.push({
	ID = "trait.spartan",
	Script = "scripts/skills/traits/spartan_trait",
	Const = "Spartan",
	Random = true
});

::Legends.Trait.Athletic <- null;
traitDefs.push({
	ID = "trait.athletic",
	Script = "scripts/skills/traits/athletic_trait",
	Const = "Athletic",
	Random = true
});

::Legends.Trait.Brute <- null;
traitDefs.push({
	ID = "trait.brute",
	Script = "scripts/skills/traits/brute_trait",
	Const = "Brute",
	Random = true
});

::Legends.Trait.Irrational <- null;
traitDefs.push({
	ID = "trait.irrational",
	Script = "scripts/skills/traits/irrational_trait",
	Const = "Irrational",
	Random = true
});

::Legends.Trait.Clubfooted <- null;
traitDefs.push({
	ID = "trait.clubfooted",
	Script = "scripts/skills/traits/clubfooted_trait",
	Const = "Clubfooted",
	Random = true
});

::Legends.Trait.Loyal <- null;
traitDefs.push({
	ID = "trait.loyal",
	Script = "scripts/skills/traits/loyal_trait",
	Const = "Loyal",
	Random = true
});

::Legends.Trait.Disloyal <- null;
traitDefs.push({
	ID = "trait.disloyal",
	Script = "scripts/skills/traits/disloyal_trait",
	Const = "Disloyal",
	Random = true
});

::Legends.Trait.Bloodthirsty <- null;
traitDefs.push({
	ID = "trait.bloodthirsty",
	Script = "scripts/skills/traits/bloodthirsty_trait",
	Const = "Bloodthirsty",
	Random = true
});

::Legends.Trait.IronJaw <- null;
traitDefs.push({
	ID = "trait.iron_jaw",
	Script = "scripts/skills/traits/iron_jaw_trait",
	Const = "IronJaw",
	Random = true
});

::Legends.Trait.Survivor <- null;
traitDefs.push({
	ID = "trait.survivor",
	Script = "scripts/skills/traits/survivor_trait",
	Const = "Survivor",
	Random = true
});

::Legends.Trait.Impatient <- null;
traitDefs.push({
	ID = "trait.impatient",
	Script = "scripts/skills/traits/impatient_trait",
	Const = "Impatient",
	Random = true
});

::Legends.Trait.Swift <- null;
traitDefs.push({
	ID = "trait.swift",
	Script = "scripts/skills/traits/swift_trait",
	Const = "Swift",
	Random = true
});

::Legends.Trait.NightBlind <- null;
traitDefs.push({
	ID = "trait.night_blind",
	Script = "scripts/skills/traits/night_blind_trait",
	Const = "NightBlind",
	Random = true
});

::Legends.Trait.NightOwl <- null;
traitDefs.push({
	ID = "trait.night_owl",
	Script = "scripts/skills/traits/night_owl_trait",
	Const = "NightOwl",
	Random = true
});

::Legends.Trait.Paranoid <- null;
traitDefs.push({
	ID = "trait.paranoid",
	Script = "scripts/skills/traits/paranoid_trait",
	Const = "Paranoid",
	Random = true
});

::Legends.Trait.HateGreenskins <- null;
traitDefs.push({
	ID = "trait.hate_greenskins",
	Script = "scripts/skills/traits/hate_greenskins_trait",
	Const = "HateGreenskins",
	Random = true
});

::Legends.Trait.HateUndead <- null;
traitDefs.push({
	ID = "trait.hate_undead",
	Script = "scripts/skills/traits/hate_undead_trait",
	Const = "HateUndead",
	Random = true
});

::Legends.Trait.HateBeasts <- null;
traitDefs.push({
	ID = "trait.hate_beasts",
	Script = "scripts/skills/traits/hate_beasts_trait",
	Const = "HateBeasts",
	Random = true
});

::Legends.Trait.FearBeasts <- null;
traitDefs.push({
	ID = "trait.fear_beasts",
	Script = "scripts/skills/traits/fear_beasts_trait",
	Const = "FearBeasts",
	Random = true
});

::Legends.Trait.FearUndead <- null;
traitDefs.push({
	ID = "trait.fear_undead",
	Script = "scripts/skills/traits/fear_undead_trait",
	Const = "FearUndead",
	Random = true
});

::Legends.Trait.FearGreenskins <- null;
traitDefs.push({
	ID = "trait.fear_greenskins",
	Script = "scripts/skills/traits/fear_greenskins_trait",
	Const = "FearGreenskins",
	Random = true
});

::Legends.Trait.Teamplayer <- null;
traitDefs.push({
	ID = "trait.teamplayer",
	Script = "scripts/skills/traits/teamplayer_trait",
	Const = "Teamplayer",
	Random = true
});

::Legends.Trait.Weasel <- null;
traitDefs.push({
	ID = "trait.weasel",
	Script = "scripts/skills/traits/weasel_trait",
	Const = "Weasel",
	Random = true
});

::Legends.Trait.Huge <- null;
traitDefs.push({
	ID = "trait.huge",
	Script = "scripts/skills/traits/huge_trait",
	Const = "Huge",
	Random = true
});

::Legends.Trait.Lucky <- null;
traitDefs.push({
	ID = "trait.lucky",
	Script = "scripts/skills/traits/lucky_trait",
	Const = "Lucky",
	Random = true
});

::Legends.Trait.PitFighter <- null;
traitDefs.push({
	ID = "trait.pit_fighter",
	Script = "scripts/skills/traits/arena_pit_fighter_trait",
	Const = "PitFighter"
});

::Legends.Trait.ArenaFighter <- null;
traitDefs.push({
	ID = "trait.arena_fighter",
	Script = "scripts/skills/traits/arena_fighter_trait",
	Const = "ArenaFighter"
});

::Legends.Trait.ArenaVeteran <- null;
traitDefs.push({
	ID = "trait.arena_veteran",
	Script = "scripts/skills/traits/arena_veteran_trait",
	Const = "ArenaVeteran"
});

::Legends.Trait.Addict <- null;
traitDefs.push({
	ID = "trait.addict",
	Script = "scripts/skills/traits/addict_trait",
	Const = "Addict"
});

::Legends.Trait.Mad <- null;
traitDefs.push({
	ID = "trait.mad",
	Script = "scripts/skills/traits/mad_trait",
	Const = "Mad"
});

::Legends.Trait.Old <- null;
traitDefs.push({
	ID = "trait.old",
	Script = "scripts/skills/traits/old_trait",
	Const = "Old"
});

::Legends.Trait.CultistProphet <- null;
traitDefs.push({
	ID = "trait.cultist_prophet",
	Script = "scripts/skills/traits/cultist_prophet_trait",
	Const = "CultistProphet"
});

::Legends.Trait.CultistChosen <- null;
traitDefs.push({
	ID = "trait.cultist_chosen",
	Script = "scripts/skills/traits/cultist_chosen_trait",
	Const = "CultistChosen"
});

::Legends.Trait.CultistDisciple <- null;
traitDefs.push({
	ID = "trait.cultist_disciple",
	Script = "scripts/skills/traits/cultist_disciple_trait",
	Const = "CultistDisciple"
});

::Legends.Trait.CultistAcolyte <- null;
traitDefs.push({
	ID = "trait.cultist_acolyte",
	Script = "scripts/skills/traits/cultist_acolyte_trait",
	Const = "CultistAcolyte"
});

::Legends.Trait.CultistZealot <- null;
traitDefs.push({
	ID = "trait.cultist_zealot",
	Script = "scripts/skills/traits/cultist_zealot_trait",
	Const = "CultistZealot"
});

::Legends.Trait.CultistFanatic <- null;
traitDefs.push({
	ID = "trait.cultist_fanatic",
	Script = "scripts/skills/traits/cultist_fanatic_trait",
	Const = "CultistFanatic"
});

::Legends.Trait.GloriousResolve <- null;
traitDefs.push({
	ID = "trait.glorious",
	Script = "scripts/skills/traits/glorious_resolve_trait",
	Const = "GloriousResolve"
});

::Legends.Trait.GloriousEndurance <- null;
traitDefs.push({
	ID = "trait.glorious",
	Script = "scripts/skills/traits/glorious_endurance_trait",
	Const = "GloriousEndurance"
});

::Legends.Trait.GloriousQuickness <- null;
traitDefs.push({
	ID = "trait.cultist_fanatic",
	Script = "scripts/skills/traits/glorious_quickness_trait",
	Const = "GloriousQuickness"
});

::Legends.Trait.OathOfHumility <- null;
traitDefs.push({
	ID = "trait.oath_of_humility",
	Script = "scripts/skills/traits/oath_of_humility_trait",
	Const = "OathOfHumility"
});

::Legends.Trait.OathOfValor <- null;
traitDefs.push({
	ID = "trait.oath_of_valor",
	Script = "scripts/skills/traits/oath_of_valor_trait",
	Const = "OathOfValor"
});

::Legends.Trait.OathOfEndurance <- null;
traitDefs.push({
	ID = "trait.oath_of_endurance",
	Script = "scripts/skills/traits/oath_of_endurance_trait",
	Const = "OathOfEndurance"
});

::Legends.Trait.OathOfVengeance <- null;
traitDefs.push({
	ID = "trait.oath_of_vengeance",
	Script = "scripts/skills/traits/oath_of_vengeance_trait",
	Const = "OathOfVengeance"
});

::Legends.Trait.OathOfRighteousness <- null;
traitDefs.push({
	ID = "trait.oath_of_righteousness",
	Script = "scripts/skills/traits/oath_of_righteousness_trait",
	Const = "OathOfRighteousness"
});

::Legends.Trait.OathOfDominion <- null;
traitDefs.push({
	ID = "trait.oath_of_dominion",
	Script = "scripts/skills/traits/oath_of_dominion_trait",
	Const = "OathOfDominion"
});

::Legends.Trait.OathOfWrath <- null;
traitDefs.push({
	ID = "trait.oath_of_wrath",
	Script = "scripts/skills/traits/oath_of_wrath_trait",
	Const = "OathOfWrath"
});

::Legends.Trait.OathOfHonor <- null;
traitDefs.push({
	ID = "trait.oath_of_honor",
	Script = "scripts/skills/traits/oath_of_honor_trait",
	Const = "OathOfHonor"
});

::Legends.Trait.OathOfCamaderie <- null;
traitDefs.push({
	ID = "trait.oath_of_camaraderie",
	Script = "scripts/skills/traits/oath_of_camaraderie_trait",
	Const = "OathOfCamaderie"
});

::Legends.Trait.OathOfSacrifice <- null;
traitDefs.push({
	ID = "trait.oath_of_sacrifice",
	Script = "scripts/skills/traits/oath_of_sacrifice_trait",
	Const = "OathOfSacrifice"
});

::Legends.Trait.OathOfFortification <- null;
traitDefs.push({
	ID = "trait.oath_of_fortification",
	Script = "scripts/skills/traits/oath_of_fortification_trait",
	Const = "OathOfFortification"
});

::Legends.Trait.OathOfDistinction <- null;
traitDefs.push({
	ID = "trait.oath_of_distinction",
	Script = "scripts/skills/traits/oath_of_distinction_trait",
	Const = "OathOfDistinction"
});

::Legends.Trait.LegendHateNobles <- null;
traitDefs.push({
	ID = "trait.legend_hate_nobles",
	Script = "scripts/skills/traits/legend_hate_nobles_trait",
	Const = "LegendHateNobles",
	Random = true
});

::Legends.Trait.LegendFearNobles <- null;
traitDefs.push({
	ID = "trait.legend_fear_nobles",
	Script = "scripts/skills/traits/legend_fear_nobles_trait",
	Const = "LegendFearNobles",
	Random = true
});

::Legends.Trait.LegendSteadyHands <- null;
traitDefs.push({
	ID = "trait.legend_steady_hands",
	Script = "scripts/skills/traits/legend_steady_hands_trait",
	Const = "LegendSteadyHands",
	Random = true
});

::Legends.Trait.LegendSlack <- null;
traitDefs.push({
	ID = "trait.legend_slack",
	Script = "scripts/skills/traits/legend_slack_trait",
	Const = "LegendSlack",
	Random = true
});

::Legends.Trait.LegendFrail <- null;
traitDefs.push({
	ID = "trait.legend_frail",
	Script = "scripts/skills/traits/legend_frail_trait",
	Const = "LegendFrail",
	Random = true
});

::Legends.Trait.LegendTalented <- null;
traitDefs.push({
	ID = "trait.legend_natural",
	Script = "scripts/skills/traits/legend_talented_trait",
	Const = "LegendTalented",
	Random = true
});

::Legends.Trait.LegendUnpredictable <- null;
traitDefs.push({
	ID = "trait.legend_unpredictable",
	Script = "scripts/skills/traits/legend_unpredictable_trait",
	Const = "LegendUnpredictable",
	Random = true
});

::Legends.Trait.LegendPredictable <- null;
traitDefs.push({
	ID = "trait.legend_predictable",
	Script = "scripts/skills/traits/legend_predictable_trait",
	Const = "LegendPredictable",
	Random = true
});

::Legends.Trait.LegendPragmatic <- null;
traitDefs.push({
	ID = "trait.legend_pragmatic",
	Script = "scripts/skills/traits/legend_pragmatic_trait",
	Const = "LegendPragmatic",
	Random = true
});

::Legends.Trait.LegendLight <- null;
traitDefs.push({
	ID = "trait.legend_light",
	Script = "scripts/skills/traits/legend_light_trait",
	Const = "LegendLight",
	Random = true
});

::Legends.Trait.LegendHeavy <- null;
traitDefs.push({
	ID = "trait.legend_heavy",
	Script = "scripts/skills/traits/legend_heavy_trait",
	Const = "LegendHeavy",
	Random = true
});

::Legends.Trait.LegendMartial <- null;
traitDefs.push({
	ID = "trait.legend_martial",
	Script = "scripts/skills/traits/legend_martial_trait",
	Const = "LegendMartial",
	Random = true
});

::Legends.Trait.LegendAmbitious <- null;
traitDefs.push({
	ID = "trait.legend_ambitious",
	Script = "scripts/skills/traits/legend_ambitious_trait",
	Const = "LegendAmbitious",
	Random = true
});

::Legends.Trait.LegendAggressive <- null;
traitDefs.push({
	ID = "trait.legend_aggressive",
	Script = "scripts/skills/traits/legend_aggressive_trait",
	Const = "LegendAggressive",
	Random = true
});

::Legends.Trait.LegendGiftOfPeople <- null;
traitDefs.push({
	ID = "trait.legend_gift_of_people",
	Script = "scripts/skills/traits/legend_gift_of_people_trait",
	Const = "LegendGiftOfPeople",
	Random = true
});

::Legends.Trait.LegendDoubleTongued <- null;
traitDefs.push({
	ID = "trait.legend_double_tongued",
	Script = "scripts/skills/traits/legend_double_tongued_trait",
	Const = "LegendDoubleTongued",
	Random = true
});

::Legends.Trait.LegendSeductive <- null;
traitDefs.push({
	ID = "trait.legend_seductive",
	Script = "scripts/skills/traits/legend_seductive_trait",
	Const = "LegendSeductive",
	Random = true
});

::Legends.Trait.LegendFearDark <- null;
traitDefs.push({
	ID = "trait.legend_fear_dark",
	Script = "scripts/skills/traits/legend_fear_dark_trait",
	Const = "LegendFearDark",
	Random = true
});

::Legends.Trait.LegendSureshot <- null;
traitDefs.push({
	ID = "trait.legend_sureshot",
	Script = "scripts/skills/traits/legend_sureshot_trait",
	Const = "LegendSureshot",
	Random = true
});

::Legends.Trait.LegendProstheticEar <- null;
traitDefs.push({
	ID = "trait.legend_prosthetic_ear",
	Script = "scripts/skills/traits/legend_prosthetic_ear",
	Const = "LegendProstheticEar"
});

::Legends.Trait.LegendProstheticEye <- null;
traitDefs.push({
	ID = "trait.legend_prosthetic_eye",
	Script = "scripts/skills/traits/legend_prosthetic_eye",
	Const = "LegendProstheticEye"
});

::Legends.Trait.LegendProstheticFinger <- null;
traitDefs.push({
	ID = "trait.legend_prosthetic_finger",
	Script = "scripts/skills/traits/legend_prosthetic_finger",
	Const = "LegendProstheticFinger"
});

::Legends.Trait.LegendProstheticFoot <- null;
traitDefs.push({
	ID = "trait.legend_prosthetic_foot",
	Script = "scripts/skills/traits/legend_prosthetic_foot",
	Const = "LegendProstheticFoot"
});

::Legends.Trait.LegendProstheticForearm <- null;
traitDefs.push({
	ID = "trait.legend_prosthetic_forearm",
	Script = "scripts/skills/traits/legend_prosthetic_forearm",
	Const = "LegendProstheticForearm"
});

::Legends.Trait.LegendProstheticHand <- null;
traitDefs.push({
	ID = "trait.legend_prosthetic_hand",
	Script = "scripts/skills/traits/legend_prosthetic_hand",
	Const = "LegendProstheticHand"
});

::Legends.Trait.LegendProstheticLeg <- null;
traitDefs.push({
	ID = "trait.legend_prosthetic_leg",
	Script = "scripts/skills/traits/legend_prosthetic_leg",
	Const = "LegendProstheticLeg"
});

::Legends.Trait.LegendProstheticNose <- null;
traitDefs.push({
	ID = "trait.legend_prosthetic_nose",
	Script = "scripts/skills/traits/legend_prosthetic_nose",
	Const = "LegendProstheticNose"
});

::Legends.Trait.LegendArenaChampion <- null;
traitDefs.push({
	ID = "trait.legend_arena_champion",
	Script = "scripts/skills/traits/legend_arena_champion_trait",
	Const = "LegendArenaChampion"
});

::Legends.Trait.LegendArenaInvictus <- null;
traitDefs.push({
	ID = "trait.legend_arena_invictus",
	Script = "scripts/skills/traits/legend_arena_invictus_trait",
	Const = "LegendArenaInvictus"
});

::Legends.Trait.LegendRottenFlesh <- null;
traitDefs.push({
	ID = "trait.legend_rotten_flesh",
	Script = "scripts/skills/traits/legend_rotten_flesh_trait",
	Const = "LegendRottenFlesh"
});

::Legends.Trait.LegendIntensiveTraining <- null;
traitDefs.push({
	ID = "trait.legend_intensive_training_trait",
	Script = "scripts/skills/traits/legend_intensive_training_trait",
	Const = "LegendIntensiveTraining"
});

::Legends.Trait.LegendFleshless <- null;
traitDefs.push({
	ID = "trait.legend_fleshless",
	Script = "scripts/skills/traits/legend_fleshless_trait",
	Const = "LegendFleshless"
});

::Legends.Trait.LegendDeathlySpectre <- null;
traitDefs.push({
	ID = "trait.legend_deathly_spectre",
	Script = "scripts/skills/traits/legend_deathly_spectre_trait",
	Const = "LegendDeathlySpectre"
});

::Legends.Trait.LegendLWRelationship <- null;
traitDefs.push({
	ID = "trait.legend_lw_relationship",
	Script = "scripts/skills/traits/legend_lw_relationship_trait",
	Const = "LegendLWRelationship"
});

::Legends.Trait.LegendNomad <- null;
traitDefs.push({
	ID = "trait.legend_nomad",
	Script = "scripts/skills/traits/legend_nomad_trait",
	Const = "LegendNomad"
});

::Legends.Trait.LegendUndeadKiller <- null;
traitDefs.push({
	ID = "trait.undead_killer",
	Script = "scripts/skills/traits/legend_undead_killer_trait",
	Const = "LegendUndeadKiller"
});

::Legends.Trait.LegendBeastslayers <- null;
traitDefs.push({
	ID = "trait.legend_beastslayers",
	Script = "scripts/skills/traits/legend_beastslayers_trait",
	Const = "LegendBeastslayers"
});

::Legends.Trait.LegendCannibalistic <- null;
traitDefs.push({
	ID = "trait.legend_cannibalistic",
	Script = "scripts/skills/traits/legend_cannibalistic",
	Const = "LegendCannibalistic"
});

::Legends.Trait.LegendNecromancer <- null;
traitDefs.push({
	ID = "trait.legend_necromancer",
	Script = "scripts/skills/traits/legend_necromancer_trait",
	Const = "LegendNecromancer"
});

::Legends.Trait.LegendPeasant <- null;
traitDefs.push({
	ID = "trait.legend_peasant",
	Script = "scripts/skills/traits/legend_peasant_trait",
	Const = "LegendPeasant"
});

::Legends.Trait.LegendWitheringAura <- null;
traitDefs.push({
	ID = "trait.legend_withering_aura",
	Script = "scripts/skills/traits/legend_withering_aura_trait",
	Const = "LegendWitheringAura"
});

::Legends.Trait.LegendDonkeyAppetite <- null;
traitDefs.push({
	ID = "trait.legend_appetite_donkey",
	Script = "scripts/skills/traits/legend_appetite_donkey",
	Const = "LegendDonkeyAppetite"
});

::Legends.Trait.LegendHorse <- null;
traitDefs.push({
	ID = "trait.legend_horse",
	Script = "scripts/skills/traits/legend_horse_trait",
	Const = "LegendHorse"
});

::Legends.Trait.LegendInquisitionDisciple <- null;
traitDefs.push({
	ID = "trait.legend_inquisition_disciple",
	Script = "scripts/skills/traits/legend_inquisition_disciple_trait",
	Const = "LegendInquisitionDisciple"
});

::Legends.Trait.LegendNobleKiller <- null;
traitDefs.push({
	ID = "trait.noble_killer",
	Script = "scripts/skills/traits/legend_noble_killer_trait",
	Const = "LegendNobleKiller"
});

::Legends.Trait.LegendBrothersInChains <- null;
traitDefs.push({
	ID = "trait.legend_brothers_in_chains",
	Script = "scripts/skills/traits/legend_brothers_in_chains_trait",
	Const = "LegendBrothersInChains"
});

::Legends.Trait.LegendPeaceful <- null;
traitDefs.push({
	ID = "trait.legend_peaceful",
	Script = "scripts/skills/traits/legend_peaceful_trait",
	Const = "LegendPeaceful"
});

::Legends.Trait.RacialSkeleton <- null;
traitDefs.push({
	ID = "racial.skeleton",
	Script = "scripts/skills/racial/skeleton_racial",
	Const = "RacialSkeleton",
	Name = "Resistant to Ranged Attacks",
});

::Legends.Trait.RacialSerpent <- null;
traitDefs.push({
	ID = "racial.serpent",
	Script = "scripts/skills/racial/serpent_racial",
	Const = "RacialSerpent",
	Name = "",
});

::Legends.Trait.RacialUnhold <- null;
traitDefs.push({
	ID = "racial.unhold",
	Script = "scripts/skills/racial/unhold_racial",
	Const = "RacialUnhold",
	Name = "Unhold Passive",
});

::Legends.Trait.RacialGolem <- null;
traitDefs.push({
	ID = "racial.golem",
	Script = "scripts/skills/racial/golem_racial",
	Const = "RacialGolem",
	Name = "",
});

::Legends.Trait.RacialAlp <- null;
traitDefs.push({
	ID = "racial.alp",
	Script = "scripts/skills/racial/alp_racial",
	Const = "RacialAlp",
	Name = "",
});

::Legends.Trait.RacialChampion <- null;
traitDefs.push({
	ID = "racial.champion",
	Script = "scripts/skills/racial/champion_racial",
	Const = "RacialChampion",
	Name = "Champion",
});

::Legends.Trait.RacialGhost <- null;
traitDefs.push({
	ID = "racial.ghost",
	Script = "scripts/skills/racial/ghost_racial",
	Const = "RacialGhost",
	Name = "Incorporeal",
});

::Legends.Trait.RacialGoblinAmbusher <- null;
traitDefs.push({
	ID = "racial.goblin_ambusher",
	Script = "scripts/skills/racial/goblin_ambusher_racial",
	Const = "RacialGoblinAmbusher",
	Name = "Poison",
});

::Legends.Trait.RacialGoblinShaman <- null;
traitDefs.push({
	ID = "racial.goblin_shaman",
	Script = "scripts/skills/racial/goblin_shaman_racial",
	Const = "RacialGoblinShaman",
	Name = "Shaman",
});

::Legends.Trait.RacialLindwurm <- null;
traitDefs.push({
	ID = "racial.lindwurm",
	Script = "scripts/skills/racial/lindwurm_racial",
	Const = "RacialLindwurm",
	Name = "Acid Blood",
});

::Legends.Trait.RacialSchrat <- null;
traitDefs.push({
	ID = "racial.schrat",
	Script = "scripts/skills/racial/schrat_racial",
	Const = "RacialSchrat",
	Name = "Shielded",
});

::Legends.Trait.RacialSpider <- null;
traitDefs.push({
	ID = "racial.spider",
	Script = "scripts/skills/racial/spider_racial",
	Const = "RacialSpider",
	Name = "Poison",
});

::Legends.Trait.RacialTricksterGod <- null;
traitDefs.push({
	ID = "racial.trickster_god",
	Script = "scripts/skills/racial/trickster_god_racial",
	Const = "RacialTricksterGod",
	Name = "",
});

::Legends.Trait.RacialVampire <- null;
traitDefs.push({
	ID = "racial.vampire",
	Script = "scripts/skills/racial/vampire_racial",
	Const = "RacialVampire",
	Name = "Vampire",
});

::Legends.Trait.RacialLegendBogUnhold <- null;
traitDefs.push({
	ID = "racial.legend_bog_unhold",
	Script = "scripts/skills/racial/legend_bog_unhold_racial",
	Const = "RacialLegendBogUnhold",
	Name = "Unhold Passive",
});

::Legends.Trait.RacialLegendGreenwoodSchrat <- null;
traitDefs.push({
	ID = "racial.legend_greenwood_schrat",
	Script = "scripts/skills/racial/legend_greenwood_schrat_racial",
	Const = "RacialLegendGreenwoodSchrat",
	Name = "Shielded",
});

::Legends.Trait.RacialLegendHorse <- null;
traitDefs.push({
	ID = "racial.legend_horse",
	Script = "scripts/skills/racial/legend_horse_racial",
	Const = "RacialLegendHorse",
	Name = "Horse Movement",
});

::Legends.Trait.RacialLegendKobold <- null;
traitDefs.push({
	ID = "racial.legend_kobold",
	Script = "scripts/skills/racial/legend_kobold_racial",
	Const = "RacialLegendKobold",
	Name = "Slippery",
});

::Legends.Trait.RacialLegendMummy <- null;
traitDefs.push({
	ID = "racial.legend_mummy",
	Script = "scripts/skills/racial/legend_mummy_racial",
	Const = "RacialLegendMummy",
	Name = "Resistant to Ranged Attacks",
});

::Legends.Trait.RacialLegendRabble <- null;
traitDefs.push({
	ID = "racial.legend_rabble",
	Script = "scripts/skills/racial/legend_rabble_racial",
	Const = "RacialLegendRabble",
	Name = "Coerced",
});

::Legends.Trait.RacialLegendRedbackSpider <- null;
traitDefs.push({
	ID = "racial.legend_redback_spider",
	Script = "scripts/skills/racial/legend_redback_spider_racial",
	Const = "RacialLegendRedbackSpider",
	Name = "Redback Poison",
});

::Legends.Trait.RacialLegendClusterSpider <- null;
traitDefs.push({
	ID = "racial.legend_cluster_spider",
	Script = "scripts/skills/racial/legend_cluster_spider_racial",
	Const = "RacialLegendClusterSpider",
	Name = "Cluster",
});

::Legends.Trait.RacialLegendRockUnhold <- null;
traitDefs.push({
	ID = "racial.legend_rock_unhold",
	Script = "scripts/skills/racial/legend_rock_unhold_racial",
	Const = "RacialLegendRockUnhold",
	Name = "Rock Unhold Passive",
});

::Legends.Trait.RacialLegendWerewolf <- null;
traitDefs.push({
	ID = "racial.legend_werewolf",
	Script = "scripts/skills/racial/legend_werewolf_racial",
	Const = "RacialLegendWerewolf",
	Name = "Blind Rage",
});

::Legends.Trait.RacialFleshGolem <- null;
traitDefs.push({
	ID = "racial.flesh_golem",
	Script = "scripts/skills/racial/flesh_golem_racial",
	Const = "RacialFleshGolem",
	Name = "Flesh Golem Racial",
});

::Legends.Trait.RacialGrandDiviner <- null;
traitDefs.push({
	ID = "racial.grand_diviner",
	Script = "scripts/skills/racial/grand_diviner_racial",
	Const = "RacialGrandDiviner",
	Name = "Diviner\'s Fury",
});


::Legends.Traits.addTraitDefObjects(traitDefs);
::Const.CharacterTraits = ::Const.CharacterTraits.filter(@(idx, trait) trait[0] != "trait.legend_frail");