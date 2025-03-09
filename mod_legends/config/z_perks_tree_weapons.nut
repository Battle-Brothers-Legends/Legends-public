if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

::Const.Perks.MaceTree <- {
	ID = "Mace",
	Name = "Mace",
	Descriptions = [
		"maces"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[],
		[::Legends.Perk.LegendOnslaught],
		[::Legends.Perk.SpecMace],
		[],
		[::Legends.Perk.LegendReturnFavor],
		[]
	]
};


::Const.Perks.FlailTree <- {
	ID = "Flail",
	Name = "Flail",
	Descriptions = [
		"flails"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[],
		[],
		[::Legends.Perk.SpecFlail],
		[],
		[::Legends.Perk.HeadHunter],
		[::Legends.Perk.BattleFlow]
	]
};

::Const.Perks.HammerTree <- {
	ID = "Hammer",
	Name = "Hammer",
	Descriptions = [
		"hammers"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	// Combined the two hammer perks and potentially looking to add another later.
	Tree = [
		[],
		[],
		[::Legends.Perk.LegendSmackdown],
		[::Legends.Perk.SpecHammer],
		[],
		[],
		[]
	]
};

::Const.Perks.AxeTree <- {
	ID = "Axe",
	Name = "Axe",
	Descriptions = [
		"axes"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[::Legends.Perk.LegendSmashingShields],
		[],
		[::Legends.Perk.SpecAxe],
		[],
		[],
		[::Legends.Perk.KillingFrenzy]
	]
};

::Const.Perks.CleaverTree <- {
	ID = "Cleaver",
	Name = "Cleaver",
	Descriptions = [
		"cleavers"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[],
		[],
		[::Legends.Perk.SpecCleaver],
		[],
		[::Legends.Perk.LegendBloodbath],
		[::Legends.Perk.Fearsome]
	]
};

::Const.Perks.TwoHandedTree <- {
	ID = "TwoHanded",
	Name = "Two-Handed",
	Descriptions = [
		"two handed weapons"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendSlaughterer, ::Legends.Perk.ReachAdvantage],
		[::Legends.Perk.LegendBloodyHarvest],
		[]
	]
};

::Const.Perks.SwordTree <- {
	ID = "Sword",
	Name = "Sword",
	Descriptions = [
		"swords"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[::Legends.Perk.LegendFeint],
		[],
		[::Legends.Perk.SpecSword],
		[],
		[::Legends.Perk.Duelist],
		[]
	]
};

::Const.Perks.DaggerTree <- {
	ID = "Dagger",
	Name = "Dagger",
	Descriptions = [
		"daggers"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[::Legends.Perk.Backstabber],
		[],
		[::Legends.Perk.SpecDagger],
		[::Legends.Perk.LegendDoubleStrike],
		[],
		[]
	]
};
::Const.Perks.PolearmTree <- {
	ID = "Polearm",
	Name = "Polearm",
	Descriptions = [
		"polearms"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[::Legends.Perk.CoupDeGrace],
		[],
		[::Legends.Perk.SpecPolearm],
		[::Legends.Perk.ReachAdvantage],
		[],
		[]
	]
};

::Const.Perks.SpearTree <- {
	ID = "Spear",
	Name = "Spear",
	Descriptions = [
		"spears"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[::Legends.Perk.LegendSpecSpearWall],
		[],
		[::Legends.Perk.SpecSpear],
		[::Legends.Perk.LegendSpecSpearThrust],
		[],
		[]
	]
};

::Const.Perks.CrossbowTree <- {
	ID = "Crossbow",
	Name = "Crossbow",
	Descriptions = [
		"crossbows"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[],
		[],
		[::Legends.Perk.SpecCrossbow],
		[::Legends.Perk.LegendHeightenedReflexes],
		[::Legends.Perk.LegendBallistics],
		[::Legends.Perk.LegendPiercingShot]
	]
};

::Const.Perks.BowTree <- {
	ID = "Bow",
	Name = "Bow",
	Descriptions = [
		"bows"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[::Legends.Perk.LegendLookout],//::Legends.Perk.BowRange
		[::Legends.Perk.Bullseye],
		[],
		[::Legends.Perk.SpecBow],
		[::Legends.Perk.LegendWindReader],
		[],
		[]
	]
};

::Const.Perks.ThrowingTree <- {
	ID = "Throwing",
	Name = "Throwing",
	Descriptions = [
		"throwing weapons"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[::Legends.Perk.QuickHands],
		[],
		[::Legends.Perk.SpecThrowing],
		[],
		[],
		[::Legends.Perk.LegendCloseCombatArcher]
	]
};

::Const.Perks.SlingTree <- {
	ID = "Sling",
	Name = "Sling"
	Descriptions = [
		"slings"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[::Legends.Perk.LegendSlingerSpins],
		[],
		[::Legends.Perk.LegendMasterySlings],
		[],
		[::Legends.Perk.LegendBarrage],
		[]
	]
};

::Const.Perks.StaffTree <- {
	ID = "Staff",
	Name = "Staff"
	Descriptions = [
		"staves"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[],
		[],
		[::Legends.Perk.LegendMasteryStaves],
		[::Legends.Perk.LegendSpecStaffStun],
		[::Legends.Perk.LegendStaffBlock],
		[::Legends.Perk.LegendPushTheAdvantage]
	]
};

::Const.Perks.ShieldTree <- {
	ID = "ShieldTree",
	Name = "Shield",
	Descriptions = [
		"shields"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[::Legends.Perk.ShieldBash],
		[],
		[::Legends.Perk.ShieldExpert],
		[::Legends.Perk.LegendSpecialistShieldSkill],
		[],
		[]
	]
};

::Const.Perks.WeaponTrees <- {
	Tree = [
		::Const.Perks.MaceTree,
		::Const.Perks.FlailTree,
		::Const.Perks.HammerTree,
		::Const.Perks.AxeTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.TwoHandedTree,
		::Const.Perks.SwordTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.SpearTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.BowTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.SlingTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.StaffTree
	],
	function getRandom(_exclude)
	{
		local L = [];
		foreach (i, t in this.Tree)
		{
			if (_exclude.find(t.ID) != null)
			{
				//this.logInfo("Excluding " + t.ID)
				continue;
			}
			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1);
		return this.Tree[L[r]];
	}
};

::Const.Perks.MeleeWeaponTrees <- {
	Tree = [
		::Const.Perks.MaceTree,
		::Const.Perks.FlailTree,
		::Const.Perks.HammerTree,
		::Const.Perks.AxeTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.TwoHandedTree,
		::Const.Perks.SwordTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.SpearTree,
		::Const.Perks.ShieldTree,
		::Const.Perks.StaffTree
	],
	function getRandom(_exclude)
	{
		local L = [];
		foreach (i, t in this.Tree)
		{
			if (_exclude.find(t.ID))
			{
				continue;
			}
			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1);
		return this.Tree[L[r]];
	}
};

::Const.Perks.RangedWeaponTrees <- {
	Tree = [
		::Const.Perks.CrossbowTree,
		::Const.Perks.BowTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.SlingTree
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
