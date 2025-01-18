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
		[::Legends.Perk.LegendNetRepair],
		[::Legends.Perk.LegendNetCasting],
		[::Legends.Perk.LegendMasteryNets],
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
		::Legends.Perk.LegendCheerOn,
		::Legends.Perk.LegendSpecialistLuteSkill
		],
		[::Legends.Perk.LegendDaze],
		[::Legends.Perk.LegendSpecialistLuteDamage],
		[::Legends.Perk.LegendEntice],
		[::Legends.Perk.LegendPush],
		[::Legends.Perk.LegendDrumsOfWar],
		[::Legends.Perk.LegendDrumsOfLife]
	]
};

::Const.Perks.HealerClassTree <- {
	ID = "HealerClassTree",
	Name = "Healing",
	Descriptions = [
		"healing"
	],
	Tree = [
		[::Legends.Perk.LegendMedIngredients],
		[],
		[],
		[::Legends.Perk.LegendSpecBandage],
		[],
		[],
		[::Legends.Perk.LegendFieldTriage]
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
		[::Legends.Perk.LegendPrayerOfFaith],
		[::Legends.Perk.LegendPrayerOfLife],
		[::Legends.Perk.LegendHolyFlame]
	]
};

::Const.Perks.FistsClassTree <- {
	ID = "FistsClassTree",
	Name = "Unarmed",
	Descriptions = [
		"unarmed combat"
	],
	Tree = [
		[::Legends.Perk.LegendAmbidextrous],
		[::Legends.Perk.LegendChoke],
		[::Legends.Perk.LegendGrapple],
		[::Legends.Perk.LegendSpecUnarmed],
		[],
		[::Legends.Perk.LegendUnarmedTraining],
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
		[::Legends.Perk.LegendMealPreperation],
		[::Legends.Perk.LegendCampCook],
		[::Legends.Perk.LegendAlcoholBrewing],
		[],
		[],
		[::Legends.Perk.LegendQuartermaster],
		[::Legends.Perk.LegendFieldTreats]
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
		[::Legends.Perk.LegendToolsDrawers],
		[::Legends.Perk.LegendToolsSpares],
		[],
		[],
		[],
		[::Legends.Perk.LegendFieldRepairs]
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
		[::Legends.Perk.LegendBarterConvincing],
		[],
		[::Legends.Perk.LegendBarterTrustworthy],
		[
			::Legends.Perk.LegendDangerPay,
			::Legends.Perk.LegendPaymaster
		],
		[
			::Legends.Perk.LegendOffBookDeal,
			::Legends.Perk.LegendBarterGreed
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
		[::Legends.Perk.LegendSpecialistKnifeSkill],
		[],
		[::Legends.Perk.LegendSpecialistKnifeDamage],
		[],
		[],
		[],
		[::Legends.Perk.LegendAssassinate]
	]
};

::Const.Perks.ButcherClassTree <- {
	ID = "ButcherClassTree",
	Name = "Butcher",
	Descriptions = [
		"butchery"
	],
	Tree = [
		[::Legends.Perk.LegendSpecialistButcherSkill],
		[],
		[::Legends.Perk.LegendSpecialistButcherDamage],
		[],
		[::Legends.Perk.LegendCarnage],
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
		[::Legends.Perk.LegendSpecialistHammerSkill],
		[],
		[
			::Legends.Perk.LegendSpecialistHammerDamage,
			::Legends.Perk.LegendSmackdown
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
		[::Legends.Perk.LegendSpecialistMilitiaSkill],
		[],
		[::Legends.Perk.LegendSpecialistMilitiaDamage],
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
		[::Legends.Perk.LegendSpecialistPickaxeSkill],
		[],
		[
			::Legends.Perk.LegendSpecialistPickaxeDamage,
			::Legends.Perk.LegendSmackdown
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
		[::Legends.Perk.LegendSpecialistPitchforkSkill],
		[],
		[::Legends.Perk.LegendSpecialistPitchforkDamage],
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
		[::Legends.Perk.LegendSpecialistShortbowSkill],
		[],
		[::Legends.Perk.LegendSpecialistShortbowDamage],
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
		[::Legends.Perk.LegendSpecialistShovelSkill],
		[],
		[::Legends.Perk.LegendSpecialistShovelDamage],
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
		[::Legends.Perk.LegendSpecialistWoodaxeSkill],
		[],
		[::Legends.Perk.LegendSpecialistWoodaxeDamage],
		[],
		[::Legends.Perk.LegendWoodworking],
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
		[::Legends.Perk.LegendSpecialistSickleSkill],
		[],
		[::Legends.Perk.LegendSpecialistSickleDamage],
		[],
		[::Legends.Perk.LegendGatherer],
		[::Legends.Perk.LegendHerbcraft],
		[::Legends.Perk.LegendPotionBrewer]
	]
};

::Const.Perks.NinetailsClassTree <- {
	ID = "NinetailsClassTree",
	Name = "Cat O' Nine Tails",
	Descriptions = [
		"ninetails"
	],
	Tree = [
		[::Legends.Perk.LegendSpecialistNinetailsSkill],
		[::Legends.Perk.LegendSpecCultHood],
		[::Legends.Perk.LegendSpecialistNinetailsDamage],
		[],
		[],
		[::Legends.Perk.LegendSpecCultArmor],
		[::Legends.Perk.LegendLacerate]
	]
}

::Const.Perks.JugglerClassTree <- {
	ID = "JugglerClassTree",
	Name = "Juggler",
	Descriptions = [
		"acrobatics"
	],
	Tree = [
		[::Legends.Perk.LegendLeap],
		[::Legends.Perk.LegendHairSplitter],
		[::Legends.Perk.Rotation],
		[::Legends.Perk.LegendTwirl],
		[::Legends.Perk.Footwork],
		[::Legends.Perk.LegendBackflip],
		[::Legends.Perk.LegendTumble]
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
		[::Legends.Perk.LegendDogWhisperer],
		[::Legends.Perk.LegendDogBreeder],
		[::Legends.Perk.LegendDogHandling],
		[::Legends.Perk.LegendPackleader],
		[::Legends.Perk.LegendDogMaster]
	]
};

::Const.Perks.ScytheClassTree <- {
	ID = "ScytheClassTree",
	Name = "Scythe",
	Descriptions = [
		"scythes"
	],
	Tree = [
		[::Legends.Perk.LegendSpecialistScytheSkill],
		[],
		[::Legends.Perk.LegendSpecialistScytheDamage],
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
