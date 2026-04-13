if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

::Const.Perks.PoisonClassTree <- {
	ID = "PoisonClassTree",
	Name = "Poison",
	Icon = "ui/perks/mastery_poison.png",
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
	Icon = "ui/perks/net_perk.png",
	Descriptions = [
		"catching beasts"
	],
	Tree = [
		[],
		[::Legends.Perk.LegendNetRepair, ::Legends.Perk.QuickHands],
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
	Icon = "ui/perks/fashionable.png",
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
	Icon = "ui/perks/prayer_purple.png",
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
	Icon = "ui/perks/perk_spec_dagger.png",
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
	Icon = "ui/perks/perk_spec_butcher.png",
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
	Icon = "ui/perks/perk_spec_smith.png",
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
	Icon = "ui/perks/perk_spec_militia.png",
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
	Icon = "ui/perks/sleight_of_hand.png",
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
	Icon = "ui/perks/perk_spec_pickaxe.png",
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
	Icon = "ui/perks/perk_spec_bitchfork.png",
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
	Icon = "ui/perks/perk_spec_shortbow.png",
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
	Icon = "ui/perks/perk_spec_shovel.png",
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
	Icon = "ui/perks/perk_spec_woodsman.png",
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
	Icon = "ui/perks/perk_spec_sickle.png",
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
	Icon = "ui/perks/perk_spec_sling.png",
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
	Icon = "ui/perks/perk_spec_staff.png",
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
	ID = "InventorClassTree",
	Name = "Inventor",
	Icon = "ui/perks/perk_spec_firearm.png",
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
	Icon = "ui/perks/perk_spec_cultist.png",
	Descriptions = [
		"ninetails"
	],
	Tree = [
		[
			// ::Legends.Perk.LegendSpecialistCultist
		],
		[::Legends.Perk.LegendSpecCultHood],
		[],
		[],
		[],
		[::Legends.Perk.LegendSpecCultArmor],
		[::Legends.Perk.LegendLacerate]
	]
}

::Const.Perks.LongswordClassTree <- {
	ID = "LongswordClassTree",
	Name = "Swordsman",
	Icon = "ui/perks/perk_spec_2hsword.png",
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
	Icon = "ui/perks/perk_spec_xbow.png",
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
	Icon = "ui/perks/perk_spec_mace.png",
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
	Icon = "ui/perks/leap_circle.png",
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
	Icon = "ui/perks/perk_hound.png",
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
	Icon = "ui/perks/perk_spec_scythe.png",
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
	Icon = "ui/perks/perk_spec_longbow.png",
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
	Icon = "ui/perks/perk_spec_raider.png",
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
	Icon = "ui/perks/perk_spec_javelin.png",
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
		::Const.Perks.TailorClassTree
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
