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
		::Legends.Trait[traitDefObject.Const] <- size + i;
		if("Random" in traitDefObject && traitDefObject.Random) {
			::Legends.Traits.pushToCharacterTraits(traitDefObject);
		}
	}
}

local traitDefs = [];

// 'Random' key defines if trait should be added to the pool of random traits that spawn on bros

traitDefs.push({
	ID = "trait.player",
	Script = "scripts/skills/traits/player_character_trait",
	Const = "Player"
});
traitDefs.push({
	ID = "trait.eagle_eyes",
	Script = "scripts/skills/traits/eagle_eyes_trait",
	Const = "EagleEyes",
	Random = true
});
traitDefs.push({
	ID = "trait.short_sighted",
	Script = "scripts/skills/traits/short_sighted_trait",
	Const = "ShortSighted",
	Random = true
});
traitDefs.push({
	ID = "trait.tough",
	Script = "scripts/skills/traits/tough_trait",
	Const = "Tough",
	Random = true
});
traitDefs.push({
	ID = "trait.strong",
	Script = "scripts/skills/traits/strong_trait",
	Const = "Strong",
	Random = true
});
traitDefs.push({
	ID = "trait.hesitant",
	Script = "scripts/skills/traits/hesitant_trait",
	Const = "Hesistant",
	Random = true
});
traitDefs.push({
	ID = "trait.quick",
	Script = "scripts/skills/traits/quick_trait",
	Const = "Quick",
	Random = true
});
traitDefs.push({
	ID = "trait.tiny",
	Script = "scripts/skills/traits/tiny_trait",
	Const = "Tiny",
	Random = true
});
traitDefs.push({
	ID = "trait.cocky",
	Script = "scripts/skills/traits/cocky_trait",
	Const = "",
	Random = true
});
traitDefs.push({
	ID = "trait.clumsy",
	Script = "scripts/skills/traits/clumsy_trait",
	Const = "Clumsy",
	Random = true
});
traitDefs.push({
	ID = "trait.fearless",
	Script = "scripts/skills/traits/fearless_trait",
	Const = "Fearless",
	Random = true
});
traitDefs.push({
	ID = "trait.fat",
	Script = "scripts/skills/traits/fat_trait",
	Const = "Fat",
	Random = true
});
traitDefs.push({
	ID = "trait.dumb",
	Script = "scripts/skills/traits/dumb_trait",
	Const = "Dumb",
	Random = true
});
traitDefs.push({
	ID = "trait.bright",
	Script = "scripts/skills/traits/bright_trait",
	Const = "Bright",
	Random = true
});
traitDefs.push({
	ID = "trait.drunkard",
	Script = "scripts/skills/traits/drunkard_trait",
	Const = "Drunkard",
	Random = true
});
traitDefs.push({
	ID = "trait.fainthearted",
	Script = "scripts/skills/traits/fainthearted_trait",
	Const = "Fainthearthed",
	Random = true
});
traitDefs.push({
	ID = "trait.bleeder",
	Script = "scripts/skills/traits/bleeder_trait",
	Const = "Bleeder",
	Random = true
});
traitDefs.push({
	ID = "trait.ailing",
	Script = "scripts/skills/traits/ailing_trait",
	Const = "Ailing",
	Random = true
});
traitDefs.push({
	ID = "trait.determined",
	Script = "scripts/skills/traits/determined_trait",
	Const = "Determined",
	Random = true
});
traitDefs.push({
	ID = "trait.dastard",
	Script = "scripts/skills/traits/dastard_trait",
	Const = "Dastard",
	Random = true
});
traitDefs.push({
	ID = "trait.deathwish",
	Script = "scripts/skills/traits/deathwish_trait",
	Const = "Deathwish",
	Random = true
});
traitDefs.push({
	ID = "trait.fragile",
	Script = "scripts/skills/traits/fragile_trait",
	Const = "Fragile",
	Random = true
});
traitDefs.push({
	ID = "trait.insecure",
	Script = "scripts/skills/traits/insecure_trait",
	Const = "Insecure",
	Random = true
});
traitDefs.push({
	ID = "trait.optimist",
	Script = "scripts/skills/traits/optimist_trait",
	Const = "Optimist",
	Random = true
});
traitDefs.push({
	ID = "trait.pessimist",
	Script = "scripts/skills/traits/pessimist_trait",
	Const = "Pessimist",
	Random = true
});
traitDefs.push({
	ID = "trait.superstitious",
	Script = "scripts/skills/traits/superstitious_trait",
	Const = "Superstitious",
	Random = true
});
traitDefs.push({
	ID = "trait.brave",
	Script = "scripts/skills/traits/brave_trait",
	Const = "Brave",
	Random = true
});
traitDefs.push({
	ID = "trait.dexterous",
	Script = "scripts/skills/traits/dexterous_trait",
	Const = "Dexterous",
	Random = true
});
traitDefs.push({
	ID = "trait.sure_footing",
	Script = "scripts/skills/traits/sure_footing_trait",
	Const = "SureFooting",
	Random = true
});
traitDefs.push({
	ID = "trait.asthmatic",
	Script = "scripts/skills/traits/asthmatic_trait",
	Const = "Asthmatic",
	Random = true
});
traitDefs.push({
	ID = "trait.iron_lungs",
	Script = "scripts/skills/traits/iron_lungs_trait",
	Const = "IronLungs",
	Random = true
});
traitDefs.push({
	ID = "trait.craven",
	Script = "scripts/skills/traits/craven_trait",
	Const = "Craven",
	Random = true
});
traitDefs.push({
	ID = "trait.greedy",
	Script = "scripts/skills/traits/greedy_trait",
	Const = "Greedy",
	Random = true
});
traitDefs.push({
	ID = "trait.gluttonous",
	Script = "scripts/skills/traits/gluttonous_trait",
	Const = "Gluttonous",
	Random = true
});
traitDefs.push({
	ID = "trait.spartan",
	Script = "scripts/skills/traits/spartan_trait",
	Const = "Spartan",
	Random = true
});
traitDefs.push({
	ID = "trait.athletic",
	Script = "scripts/skills/traits/athletic_trait",
	Const = "Athletic",
	Random = true
});
traitDefs.push({
	ID = "trait.brute",
	Script = "scripts/skills/traits/brute_trait",
	Const = "Brute",
	Random = true
});
traitDefs.push({
	ID = "trait.irrational",
	Script = "scripts/skills/traits/irrational_trait",
	Const = "Irrational",
	Random = true
});
traitDefs.push({
	ID = "trait.clubfooted",
	Script = "scripts/skills/traits/clubfooted_trait",
	Const = "Clubfooted",
	Random = true
});
traitDefs.push({
	ID = "trait.loyal",
	Script = "scripts/skills/traits/loyal_trait",
	Const = "Loyal",
	Random = true
});
traitDefs.push({
	ID = "trait.disloyal",
	Script = "scripts/skills/traits/disloyal_trait",
	Const = "Disloyal",
	Random = true
});
traitDefs.push({
	ID = "trait.bloodthirsty",
	Script = "scripts/skills/traits/bloodthirsty_trait",
	Const = "Bloodthirsty",
	Random = true
});
traitDefs.push({
	ID = "trait.iron_jaw",
	Script = "scripts/skills/traits/iron_jaw_trait",
	Const = "IronJaw",
	Random = true
});
traitDefs.push({
	ID = "trait.survivor",
	Script = "scripts/skills/traits/survivor_trait",
	Const = "Survivor",
	Random = true
});
traitDefs.push({
	ID = "trait.impatient",
	Script = "scripts/skills/traits/impatient_trait",
	Const = "Impatient",
	Random = true
});
traitDefs.push({
	ID = "trait.swift",
	Script = "scripts/skills/traits/swift_trait",
	Const = "Swift",
	Random = true
});
traitDefs.push({
	ID = "trait.night_blind",
	Script = "scripts/skills/traits/night_blind_trait",
	Const = "NightBlind",
	Random = true
});
traitDefs.push({
	ID = "trait.night_owl",
	Script = "scripts/skills/traits/night_owl_trait",
	Const = "NightOwl",
	Random = true
});
traitDefs.push({
	ID = "trait.paranoid",
	Script = "scripts/skills/traits/paranoid_trait",
	Const = "Paranoid",
	Random = true
});
traitDefs.push({
	ID = "trait.hate_greenskins",
	Script = "scripts/skills/traits/hate_greenskins_trait",
	Const = "HateGreenskins",
	Random = true
});
traitDefs.push({
	ID = "trait.hate_undead",
	Script = "scripts/skills/traits/hate_undead_trait",
	Const = "HateUndead",
	Random = true
});
traitDefs.push({
	ID = "trait.hate_beasts",
	Script = "scripts/skills/traits/hate_beasts_trait",
	Const = "HateBeasts",
	Random = true
});
traitDefs.push({
	ID = "trait.fear_beasts",
	Script = "scripts/skills/traits/fear_beasts_trait",
	Const = "FearBeasts",
	Random = true
});
traitDefs.push({
	ID = "trait.fear_undead",
	Script = "scripts/skills/traits/fear_undead_trait",
	Const = "FearUndead",
	Random = true
});
traitDefs.push({
	ID = "trait.fear_greenskins",
	Script = "scripts/skills/traits/fear_greenskins_trait",
	Const = "FearGreenskins",
	Random = true
});
traitDefs.push({
	ID = "trait.teamplayer",
	Script = "scripts/skills/traits/teamplayer_trait",
	Const = "Teamplayer",
	Random = true
});
traitDefs.push({
	ID = "trait.weasel",
	Script = "scripts/skills/traits/weasel_trait",
	Const = "Weasel",
	Random = true
});
traitDefs.push({
	ID = "trait.huge",
	Script = "scripts/skills/traits/huge_trait",
	Const = "Huge",
	Random = true
});
traitDefs.push({
	ID = "trait.lucky",
	Script = "scripts/skills/traits/lucky_trait",
	Const = "Lucky",
	Random = true
});
// Legends additions
traitDefs.push({
	ID = "trait.legend_hate_nobles",
	Script = "scripts/skills/traits/legend_hate_nobles_trait",
	Const = "LegendHateNobles",
	Random = true
});
traitDefs.push({
	ID = "trait.legend_fear_nobles",
	Script = "scripts/skills/traits/legend_fear_nobles_trait",
	Const = "LegendFearNobles",
	Random = true
});
traitDefs.push({
	ID = "trait.legend_steady_hands",
	Script = "scripts/skills/traits/legend_steady_hands_trait",
	Const = "LegendSteadyHands",
	Random = true
});
traitDefs.push({
	ID = "trait.legend_slack",
	Script = "scripts/skills/traits/legend_slack_trait",
	Const = "LegendSlack",
	Random = true
});
traitDefs.push({
	ID = "trait.legend_frail",
	Script = "scripts/skills/traits/legend_frail_trait",
	Const = "LegendFrail",
	Random = true
});
traitDefs.push({
	ID = "trait.legend_natural",
	Script = "scripts/skills/traits/legend_natural_trait",
	Const = "LegendNatural",
	Random = true
});
traitDefs.push({
	ID = "trait.legend_unpredictable",
	Script = "scripts/skills/traits/legend_unpredictable_trait",
	Const = "LegendUnpredictable",
	Random = true
});
traitDefs.push({
	ID = "trait.legend_predictable",
	Script = "scripts/skills/traits/legend_predictable_trait",
	Const = "LegendPredictable",
	Random = true
});
traitDefs.push({
	ID = "trait.legend_pragmatic",
	Script = "scripts/skills/traits/legend_pragmatic_trait",
	Const = "LegendPragmatic",
	Random = true
});
traitDefs.push({
	ID = "trait.legend_light",
	Script = "scripts/skills/traits/legend_light_trait",
	Const = "LegendLight",
	Random = true
});
traitDefs.push({
	ID = "trait.legend_heavy",
	Script = "scripts/skills/traits/legend_heavy_trait",
	Const = "LegendHeavy",
	Random = true
});
traitDefs.push({
	ID = "trait.legend_firm",
	Script = "scripts/skills/traits/legend_firm_trait",
	Const = "LegendFirm",
	Random = true
});
traitDefs.push({
	ID = "trait.legend_ambitious",
	Script = "scripts/skills/traits/legend_ambitious_trait",
	Const = "LegendAmbitious",
	Random = true
});
traitDefs.push({
	ID = "trait.legend_aggressive",
	Script = "scripts/skills/traits/legend_aggressive_trait",
	Const = "LegendAggressive",
	Random = true
});
traitDefs.push({
	ID = "trait.legend_gift_of_people",
	Script = "scripts/skills/traits/legend_gift_of_people_trait",
	Const = "LegendGiftOfPeople",
	Random = true
});
traitDefs.push({
	ID = "trait.legend_double_tongued",
	Script = "scripts/skills/traits/legend_double_tongued_trait",
	Const = "LegendDoubleTongued",
	Random = true
});
traitDefs.push({
	ID = "trait.legend_seductive",
	Script = "scripts/skills/traits/legend_seductive_trait",
	Const = "LegendSeductive",
	Random = true
});
traitDefs.push({
	ID = "trait.legend_fear_dark",
	Script = "scripts/skills/traits/legend_fear_dark_trait",
	Const = "LegendFearDark",
	Random = true
});
traitDefs.push({
	ID = "trait.legend_sureshot",
	Script = "scripts/skills/traits/legend_sureshot_trait",
	Const = "LegendSureshot",
	Random = true
});

::Legends.Traits.addTraitDefObjects(traitDefs);
