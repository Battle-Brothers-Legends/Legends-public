if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

::Const.Perks.PoisonClassTree <- {
	ID = "PoisonClassTree",
	Name = "Poison",
	Descriptions = [
		"poisons"
	],
	Tree = [
		[],
		[],
		[],
		[::Legends.Perk.LegendSpecPoison],
		[],
		[],
		[]
	]
};

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

::Const.Perks.TailorClassTree <- {
ID = "TailorClassTree",
	Name = "Trendy",
	Descriptions = [
		"tailoring"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFashionable],
		[]
	]
};

::Const.Perks.HealerClassTree <- {
	ID = "HealerClassTree",
	Name = "Healing",
	Descriptions = [
		"healing"
	],
	Tree = [
		[],
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

::Const.Perks.ConArtistTree <- {
	ID = "ConArtistTree",
	Name = "Con Artist",
	Descriptions = [
		"sleight of hand"
	],
	Tree = [
		[::Legends.Perk.LegendSleightOfHand],
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
		[],
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
		[],
		[],
		[]
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
		[::Legends.Perk.LegendSpecialistSelfdefense],
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
		[::Legends.Perk.LegendSpecialistInventor],
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
		[::Legends.Perk.LegendSpecialistBodyguard],
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
		[::Legends.Perk.LegendSpecialistInquisition],
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
		[::Legends.Perk.LegendSpecialistClub],
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
		[::Legends.Perk.LegendTacticalManeuvers],
		[::Legends.Perk.LegendTwirl],
		[],
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
		[],
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

::Const.Perks.SharpshooterClassTree <- {
	ID = "SharpshooterClassTree",
	Name = "Sharpshooter",
	Descriptions = [
		"longbows"
	],
	Tree = [
		[::Legends.Perk.LegendSpecialistSharpshooter],
		[],
		[],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.RaiderClassTree <- {
	ID = "RaiderClassTree",
	Name = "Raider",
	Descriptions = [
		"handaxes and throwing axes"
	],
	Tree = [
		[::Legends.Perk.LegendSpecialistRaider],
		[],
		[],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.SpearfisherClassTree <- {
	ID = "SpearfisherClassTree",
	Name = "Spearfisher",
	Descriptions = [
		"javelins"
	],
	Tree = [
		[::Legends.Perk.LegendSpecialistSpearfisher],
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
		::Const.Perks.FaithClassTree,
		::Const.Perks.KnifeClassTree,
		::Const.Perks.ButcherClassTree,
		::Const.Perks.HammerClassTree,
		::Const.Perks.MilitiaClassTree,
		::Const.Perks.PickaxeClassTree,
		::Const.Perks.PitchforkClassTree,
		::Const.Perks.ShortbowClassTree,
		::Const.Perks.WoodaxeClassTree,
		::Const.Perks.NinetailsClassTree,
		::Const.Perks.JugglerClassTree,
		::Const.Perks.HoundmasterClassTree,
		::Const.Perks.ClubClassTree,
		::Const.Perks.InquisitionClassTree,
		::Const.Perks.LongswordClassTree,
		::Const.Perks.InventorClassTree,
		::Const.Perks.SickleClassTree,
		::Const.Perks.ScytheClassTree,
		::Const.Perks.SharpshooterClassTree,
		::Const.Perks.ShovelClassTree,
		::Const.Perks.SlingClassTree,
		::Const.Perks.SpearfisherClassTree,
		::Const.Perks.StaffClassTree,
		::Const.Perks.RaiderClassTree,
		::Const.Perks.PoisonClassTree,
		::Const.Perks.TailorClassTree
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
