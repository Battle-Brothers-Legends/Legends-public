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
		::Legends.Perk.LegendSpecialistMusician
		],
		[::Legends.Perk.LegendDaze],
		[],
		[::Legends.Perk.LegendEntice],
		[::Legends.Perk.LegendPush],
		[::Legends.Perk.LegendMinnesanger],
		[::Legends.Perk.LegendMeistersanger]
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
		[::Legends.Perk.LegendSpecialistPrisoner],
		[],
		[],
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
		[::Legends.Perk.LegendSpecialistButcher],
		[],
		[],
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
		[::Legends.Perk.LegendSpecialistBlacksmith],
		[],
		[::Legends.Perk.LegendSmackdown],
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
		[::Legends.Perk.LegendSpecialistMilitia],
		[],
		[],
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
		[::Legends.Perk.LegendSpecialistMiner],
		[],
		[::Legends.Perk.LegendSmackdown],
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
		[::Legends.Perk.LegendSpecialistFarmhand],
		[],
		[],
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
		[::Legends.Perk.LegendSpecialistPoacher],
		[],
		[],
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
		[::Legends.Perk.LegendSpecialistGravedigger],
		[],
		[],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.WoodaxeClassTree <- {
	ID = "WoodaxeClassTree",
	Name = "Woodsman",
	Descriptions = [
		"axes"
	],
	Tree = [
		[::Legends.Perk.LegendSpecialistWoodsman],
		[],
		[],
		[],
		[::Legends.Perk.LegendWoodworking],
		[],
		[]
	]
};

::Const.Perks.SickleClassTree <- {
	ID = "SickleClassTree",
	Name = "Herbalist",
	Descriptions = [
		"sickles"
	],
	Tree = [
		[::Legends.Perk.LegendSpecialistHerbalist],
		[],
		[],
		[],
		[::Legends.Perk.LegendGatherer],
		[::Legends.Perk.LegendHerbcraft],
		[::Legends.Perk.LegendPotionBrewer]
	]
};

::Const.Perks.SlingClassTree <- {
	ID = "SlingClassTree",
	Name = "Sling",
	Descriptions = [
		"slings"
	],
	Tree = [
		[::Legends.Perk.LegendSpecialistShepherd],
		[],
		[],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.StaffClassTree <- {
	ID = "SpecialistStaffTree",
	Name = "Staff Defense",
	Descriptions = [
		"staves"
	],
	Tree = [
		[],
		[],
		[::Const.Perks.PerkDefs.LegendSpecialistSelfDefense],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.InventorClassTree <- {
	ID = "SpecialistInventorTree",
	Name = "Inventor",
	Descriptions = [
		"firearms"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistInventor],
		[],
		[],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.NinetailsClassTree <- {
	ID = "NinetailsClassTree",
	Name = "Cat O' Nine Tails",
	Descriptions = [
		"ninetails"
	],
	Tree = [
		[::Legends.Perk.LegendSpecialistCultist],
		[::Legends.Perk.LegendSpecCultHood],
		[],
		[],
		[],
		[::Legends.Perk.LegendSpecCultArmor],
		[::Legends.Perk.LegendLacerate]
	]
}

::Const.Perks.LongswordClassTree <- {
	ID = "SpecialistLongswordTree",
	Name = "Swordsman",
	Descriptions = [
		"swords"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistBodyguard],
		[],
		[],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.InquisitionClassTree <- {
	ID = "SpecialistInquisitionTree",
	Name = "Inquisition",
	Descriptions = [
		"crossbows"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistInquisition],
		[],
		[],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.ClubClassTree <- {
	ID = "SpecialistBrowbeaterTree",
	Name = "Browbeater",
	Descriptions = [
		"clubs"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistClub],
		[],
		[],
		[],
		[],
		[],
		[]
	]
};

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
		[::Legends.Perk.LegendSpecialistReaper],
		[],
		[],
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
		::Const.Perks.ClubClassTree,
		::Const.Perks.InquisitionClassTree,
		::Const.Perks.BodyguardClassTree,
		::Const.Perks.InventorClassTree,
		::Const.Perks.StaffClassTree,
		::Const.Perks.SlingClassTree
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

		local r = this.Math.rand(0, L.len() - 1);
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
