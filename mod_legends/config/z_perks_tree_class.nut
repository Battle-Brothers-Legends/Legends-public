if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

::Const.Perks.PoisonClassTree <- {
	ID = "PoisonClassTree",
	Name = "Poison",
	Icon = "ui/perks/legend_poisoner.png",
	Descriptions = [
		"poisons"
	],
	Tree = [
		[],
		[],
		[],
		[::Legends.Perk.LegendPoisoner],
		[],
		[],
		[]
	]
};

::Const.Perks.BeastClassTree <- {
	ID = "BeastClassTree",
	Name = "Nets",
	Icon = "ui/perks/legend_mastery_nets.png",
	Descriptions = [
		"catching beasts"
	],
	Tree = [
		[],
		[::Legends.Perk.LegendNetRepair, ::Legends.Perk.QuickHands],
		[::Legends.Perk.LegendNetCasting],
		[::Legends.Perk.LegendMasteryNets],
		[],
		[],
		[]
	]
};

::Const.Perks.TailorClassTree <- {
	ID = "TailorClassTree",
	Name = "Trendy",
	Icon = "ui/perks/legend_fashionable.png",
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
	Icon = "ui/perks/bandage_circle.png",
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
	Icon = "ui/perks/legend_prayer_of_faith.png",
	Descriptions = [
		"faith"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendPrayerOfFaith],
		[::Legends.Perk.LegendPrayerOfHope],
		[::Legends.Perk.LegendHolyFlame]
	]
};

::Const.Perks.KnifeClassTree <- {
	ID = "KnifeClassTree",
	Name = "Knives",
	Icon = "ui/perks/legend_specialist_prisoner.png",
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
	Icon = "ui/perks/legend_specialist_butcher.png",
	Descriptions = [
		"butchery"
	],
	Tree = [
		[::Legends.Perk.LegendSpecialistButcher],
		[],
		[],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.HammerClassTree <- {
	ID = "HammerClassTree",
	Name = "Blacksmith",
	Icon = "ui/perks/legend_specialist_blacksmith.png",
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
	Icon = "ui/perks/legend_specialist_militia.png",
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
	Icon = "ui/perks/legend_sleight_of_hand.png",
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
	Icon = "ui/perks/legend_specialist_miner.png",
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
	Icon = "ui/perks/legend_specialist_farmhand.png",
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
	Icon = "ui/perks/legend_specialist_poacher.png",
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
	Icon = "ui/perks/legend_specialist_gravedigger.png",
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
	Icon = "ui/perks/legend_specialist_woodsman.png",
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
	Icon = "ui/perks/legend_specialist_herbalist.png",
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
	Icon = "ui/perks/legend_specialist_shepherd.png",
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
	ID = "StaffClassTree",
	Name = "Staff Defense",
	Icon = "ui/perks/legend_deflection.png",
	Descriptions = [
		"staves"
	],
	Tree = [
		[],
		[],
		[::Legends.Perk.LegendDeflection],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.InventorClassTree <- {
	ID = "InventorClassTree",
	Name = "Inventor",
	Icon = "ui/perks/legend_specialist_inventor.png",
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
	Icon = "ui/perks/legend_specialist_cultist.png",
	Descriptions = [
		"ninetails"
	],
	Tree = [
		[
			// ::Legends.Perk.LegendSpecialistCultist
		],
		[::Legends.Perk.LegendDedication],
		[],
		[],
		[],
		[::Legends.Perk.LegendPenance],
		[::Legends.Perk.LegendLacerate]
	]
}

::Const.Perks.LongswordClassTree <- {
	ID = "LongswordClassTree",
	Name = "Swordsman",
	Icon = "ui/perks/legend_specialist_bodyguard.png",
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
	ID = "InquisitionClassTree",
	Name = "Inquisition",
	Icon = "ui/perks/legend_specialist_inquisition.png",
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
	ID = "ClubClassTree",
	Name = "Browbeater",
	Icon = "ui/perks/legend_specialist_club.png",
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
	Icon = "ui/perks/legend_leap.png",
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
	Icon = "ui/perks/legend_dog_whisperer.png",
	Descriptions = [
		"training dogs"
	],
	Tree = [
		[],
		[],
		[::Legends.Perk.LegendDogWhisperer],
		[],
		[::Legends.Perk.LegendDogHandling],
		[::Legends.Perk.LegendPackLeader],
		[]
	]
};

::Const.Perks.ScytheClassTree <- {
	ID = "ScytheClassTree",
	Name = "Scythe",
	Icon = "ui/perks/legend_specialist_reaper.png",
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
	Icon = "ui/perks/legend_specialist_sharpshooter.png",
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
	Icon = "ui/perks/legend_specialist_raider.png",
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
	Icon = "ui/perks/legend_specialist_spearfisher.png",
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
	GroupsCategory = "Class",
	Tree = [
		::Const.Perks.BeastClassTree,
		::Const.Perks.FaithClassTree,
		::Const.Perks.NinetailsClassTree,
		::Const.Perks.JugglerClassTree,
		::Const.Perks.HoundmasterClassTree,
		::Const.Perks.PoisonClassTree,
		::Const.Perks.TailorClassTree,
		::Const.Perks.ConArtistTree
		// ::Const.Perks.KnifeClassTree,
		// ::Const.Perks.ButcherClassTree,
		// ::Const.Perks.HammerClassTree,
		// ::Const.Perks.MilitiaClassTree,
		// ::Const.Perks.PickaxeClassTree,
		// ::Const.Perks.PitchforkClassTree,
		// ::Const.Perks.ShortbowClassTree,
		// ::Const.Perks.WoodaxeClassTree,
		// ::Const.Perks.ClubClassTree,
		// ::Const.Perks.InquisitionClassTree,
		// ::Const.Perks.LongswordClassTree,
		// ::Const.Perks.InventorClassTree,
		// ::Const.Perks.SickleClassTree,
		// ::Const.Perks.ScytheClassTree,
		// ::Const.Perks.SharpshooterClassTree,
		// ::Const.Perks.ShovelClassTree,
		// ::Const.Perks.SlingClassTree,
		// ::Const.Perks.SpearfisherClassTree,
		// ::Const.Perks.StaffClassTree,
		// ::Const.Perks.RaiderClassTree,
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

		local r = ::Math.rand(0, L.len() - 1);
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

		local r = ::Math.rand(0, L.len() - 1);
		return L[r];
	}
};
