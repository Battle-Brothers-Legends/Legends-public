if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

::Const.Perks.BeastClassTree <- {
	ID = "BeastClassTree",
	Name = "Nets",
	Descriptions = [
		"catching beasts"
	],
	Tree = [
		[],
		[::Const.Perks.PerkDefs.LegendNetRepair],
		[::Const.Perks.PerkDefs.LegendNetCasting],
		[::Const.Perks.PerkDefs.LegendMasteryNets],
		[], // As of 18.2.0, LegendEscapeArtist is no longer a player perk; LegendMasteryNets achieves the same effects
		[],
		[]
	]
};

::Const.Perks.BardClassTree <- {
	ID = "BardClassTree",
	Name = "Bard",
	Descriptions = [
		"entertaining"
	],
	Tree = [
		[
		::Const.Perks.PerkDefs.LegendCheerOn,
		::Const.Perks.PerkDefs.LegendSpecialistLuteSkill
		],
		[::Const.Perks.PerkDefs.LegendDaze],
		[::Const.Perks.PerkDefs.LegendSpecialistLuteDamage],
		[::Const.Perks.PerkDefs.LegendEntice],
		[::Const.Perks.PerkDefs.LegendPush],
		[::Const.Perks.PerkDefs.LegendDrumsOfWar],
		[::Const.Perks.PerkDefs.LegendDrumsOfLife]
	]
};

::Const.Perks.HealerClassTree <- {
	ID = "HealerClassTree",
	Name = "Healing",
	Descriptions = [
		"healing"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendMedIngredients],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendSpecBandage],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendFieldTriage]
	]
};

::Const.Perks.FaithClassTree <- {
	ID = "FaithClassTree",
	Name = "Faith",
	Descriptions = [
		"faith"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendPrayerOfFaith],
		[::Const.Perks.PerkDefs.LegendPrayerOfLife],
		[::Const.Perks.PerkDefs.LegendHolyFlame]
	]
};

::Const.Perks.FistsClassTree <- {
	ID = "FistsClassTree",
	Name = "Unarmed",
	Descriptions = [
		"unarmed combat"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendAmbidextrous],
		[::Const.Perks.PerkDefs.LegendChoke],
		[::Const.Perks.PerkDefs.LegendGrapple],
		[::Const.Perks.PerkDefs.LegendSpecFists],
		[],
		[::Const.Perks.PerkDefs.LegendUnarmedTraining],
		[]
	]
};

::Const.Perks.ChefClassTree <- {
	ID = "ChefClassTree",
	Name = "Chef",
	Descriptions = [
		"cooking"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendMealPreperation],
		[::Const.Perks.PerkDefs.LegendCampCook],
		[::Const.Perks.PerkDefs.LegendAlcoholBrewing],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendQuartermaster],
		[::Const.Perks.PerkDefs.LegendFieldTreats]
	]
};

::Const.Perks.RepairClassTree <- {
	ID = "RepairClassTree",
	Name = "Repair",
	Descriptions = [
		"repairs"
	],
	Tree = [
		[],
		[::Const.Perks.PerkDefs.LegendToolsDrawers],
		[::Const.Perks.PerkDefs.LegendToolsSpares],
		[],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendFieldRepairs]
	]
};

::Const.Perks.BarterClassTree <- {
	ID = "BarterClassTree",
	Name = "Barter",
	Descriptions = [
		"bartering"
	],
	Tree = [
		[],
		[],
		[::Const.Perks.PerkDefs.LegendBarterConvincing],
		[],
		[::Const.Perks.PerkDefs.LegendBarterTrustworthy],
		[
			::Const.Perks.PerkDefs.LegendDangerPay,
			::Const.Perks.PerkDefs.LegendPaymaster
		],
		[
			::Const.Perks.PerkDefs.LegendOffBookDeal,
			::Const.Perks.PerkDefs.LegendBarterGreed
		]
	]
};

::Const.Perks.KnifeClassTree <- {
	ID = "KnifeClassTree",
	Name = "Knives",
	Descriptions = [
		"knives"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistKnifeSkill],
		[],
		[::Const.Perks.PerkDefs.LegendSpecialistKnifeDamage],
		[],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendAssassinate]
	]
};

::Const.Perks.ButcherClassTree <- {
	ID = "ButcherClassTree",
	Name = "Butcher",
	Descriptions = [
		"butchery"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistButcherSkill],
		[],
		[::Const.Perks.PerkDefs.LegendSpecialistButcherDamage],
		[],
		[::Const.Perks.PerkDefs.LegendSlaughter],
		[],
		[]
	]
};

::Const.Perks.HammerClassTree <- {
	ID = "HammerClassTree",
	Name = "Blacksmith",
	Descriptions = [
		"hammers"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistHammerSkill],
		[],
		[
			::Const.Perks.PerkDefs.LegendSpecialistHammerDamage,
			::Const.Perks.PerkDefs.LegendSmackdown
		],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.MilitiaClassTree <- {
	ID = "MilitiaClassTree",
	Name = "Militia",
	Descriptions = [
		"militia"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistMilitiaSkill],
		[],
		[::Const.Perks.PerkDefs.LegendSpecialistMilitiaDamage],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.PickaxeClassTree <- {
	ID = "PickaxeClassTree",
	Name = "Miner",
	Descriptions = [
		"pickaxes"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistPickaxeSkill],
		[],
		[
			::Const.Perks.PerkDefs.LegendSpecialistPickaxeDamage,
			::Const.Perks.PerkDefs.LegendSmackdown
		],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.PitchforkClassTree <- {
	ID = "PitchforkClassTree",
	Name = "Farmer",
	Descriptions = [
		"pitchforks"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistPitchforkSkill],
		[],
		[::Const.Perks.PerkDefs.LegendSpecialistPitchforkDamage],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.ShortbowClassTree <- {
	ID = "ShortbowClassTree",
	Name = "Shortbow",
	Descriptions = [
		"shortbows"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistShortbowSkill],
		[],
		[::Const.Perks.PerkDefs.LegendSpecialistShortbowDamage],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.ShovelClassTree <- {
	ID = "ShovelClassTree",
	Name = "Gravedigger",
	Descriptions = [
		"shovels"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistShovelSkill],
		[],
		[::Const.Perks.PerkDefs.LegendSpecialistShovelDamage],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.WoodaxeClassTree <- {
	ID = "WoodaxeClassTree",
	Name = "Lumberjack",
	Descriptions = [
		"axes"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistWoodaxeSkill],
		[],
		[::Const.Perks.PerkDefs.LegendSpecialistWoodaxeDamage],
		[],
		[::Const.Perks.PerkDefs.LegendWoodworking],
		[],
		[]
	]
};

::Const.Perks.SickleClassTree <- {
	ID = "SickleClassTree",
	Name = "Sickle",
	Descriptions = [
		"sickles"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistSickleSkill],
		[],
		[::Const.Perks.PerkDefs.LegendSpecialistSickleDamage],
		[],
		[::Const.Perks.PerkDefs.LegendGatherer],
		[::Const.Perks.PerkDefs.LegendHerbcraft],
		[::Const.Perks.PerkDefs.LegendPotionBrewer]
	]
};

::Const.Perks.NinetailsClassTree <- {
	ID = "NinetailsClassTree",
	Name = "Cat O' Nine Tails",
	Descriptions = [
		"ninetails"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistNinetailsSkill],
		[::Const.Perks.PerkDefs.LegendSpecCultHood],
		[::Const.Perks.PerkDefs.LegendSpecialistNinetailsDamage],
		[],
		[::Const.Perks.PerkDefs.LegendPrepareGraze],
		[::Const.Perks.PerkDefs.LegendSpecCultArmor],
		[::Const.Perks.PerkDefs.LegendLacerate]
	]
}

::Const.Perks.JugglerClassTree <- {
	ID = "JugglerClassTree",
	Name = "Juggler",
	Descriptions = [
		"acrobatics"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendLeap],
		[::Const.Perks.PerkDefs.LegendHairSplitter],
		[::Const.Perks.PerkDefs.Rotation],
		[::Const.Perks.PerkDefs.LegendTwirl],
		[::Const.Perks.PerkDefs.Footwork],
		[::Const.Perks.PerkDefs.LegendBackflip],
		[::Const.Perks.PerkDefs.LegendTumble]
	]
};

::Const.Perks.HoundmasterClassTree <- {
	ID = "HoundmasterClassTree",
	Name = "Hound Master",
	Descriptions = [
		"training dogs"
	],
	Tree = [
		[],
		[],
		[::Const.Perks.PerkDefs.LegendDogWhisperer],
		[::Const.Perks.PerkDefs.LegendDogBreeder],
		[::Const.Perks.PerkDefs.LegendDogHandling],
		[::Const.Perks.PerkDefs.LegendPackleader],
		[::Const.Perks.PerkDefs.LegendDogMaster]
	]
};

::Const.Perks.ScytheClassTree <- {
	ID = "ScytheClassTree",
	Name = "Scythe",
	Descriptions = [
		"scythes"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistScytheSkill],
		[],
		[::Const.Perks.PerkDefs.LegendSpecialistScytheDamage],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.ClassTrees <- {
	Tree = [
		::Const.Perks.BeastClassTree,
		::Const.Perks.BardClassTree,
		::Const.Perks.HealerClassTree,
		::Const.Perks.FaithClassTree,
		::Const.Perks.FistsClassTree,
		::Const.Perks.ChefClassTree,
		::Const.Perks.RepairClassTree,
		::Const.Perks.BarterClassTree,
		::Const.Perks.KnifeClassTree,
		::Const.Perks.ButcherClassTree,
		::Const.Perks.HammerClassTree,
		::Const.Perks.MilitiaClassTree,
		::Const.Perks.PickaxeClassTree,
		::Const.Perks.PitchforkClassTree,
		::Const.Perks.ShortbowClassTree,
		::Const.Perks.WoodaxeClassTree,
		::Const.Perks.SickleClassTree,
		::Const.Perks.NinetailsClassTree,
		::Const.Perks.JugglerClassTree,
		::Const.Perks.HoundmasterClassTree,
		::Const.Perks.ScytheClassTree,
	],
	function getRandom(_exclude)
	{
		local L = [];
		foreach (i, t in this.Tree)
		{
			if (_exclude != null && _exclude.find(t.ID))
			{
				continue;
			}
			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1)
		return this.Tree[L[r]];
	}

	function getRandomPerk()
	{
		local tree = this.getRandom(null);
		local L = [];
		foreach (row in tree.Tree)
		{
			foreach (p in row)
			{
				L.push(p);
			}
		}

		local r = this.Math.rand(0, L.len() - 1);
		return L[r];
	}
};
