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
		[::Const.Perks.PerkDefs.LegendOnslaught],
		[::Const.Perks.PerkDefs.SpecMace],
		[],
		[::Const.Perks.PerkDefs.LegendReturnFavor],
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
		[::Const.Perks.PerkDefs.SpecFlail],
		[],
		[::Const.Perks.PerkDefs.HeadHunter],
		[::Const.Perks.PerkDefs.BattleFlow]
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
		[::Const.Perks.PerkDefs.LegendSmackdown],
		[::Const.Perks.PerkDefs.SpecHammer],
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
		[::Const.Perks.PerkDefs.LegendSmashingShields],
		[],
		[::Const.Perks.PerkDefs.SpecAxe],
		[],
		[],
		[::Const.Perks.PerkDefs.KillingFrenzy]
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
		[::Const.Perks.PerkDefs.SpecCleaver],
		[],
		[::Const.Perks.PerkDefs.LegendBloodbath],
		[::Const.Perks.PerkDefs.Fearsome]
	]
};

::Const.Perks.GreatSwordTree <- {
	ID = "GreatSword",
	Name = "Two-Handed Sword",
	Descriptions = [
		"greatswords"
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
		[::Const.Perks.PerkDefs.LegendSpecGreatSword],
		[::Const.Perks.PerkDefs.LegendSlaughterer],
		[::Const.Perks.PerkDefs.LegendBloodyHarvest],
		[]
	]
};

::Const.Perks.SwordTree <- {
	ID = "Sword",
	Name = "One-Handed Sword",
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
		[::Const.Perks.PerkDefs.LegendFeint],
		[],
		[::Const.Perks.PerkDefs.SpecSword],
		[],
		[::Const.Perks.PerkDefs.Duelist],
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
		[::Const.Perks.PerkDefs.Backstabber],
		[],
		[::Const.Perks.PerkDefs.SpecDagger],
		[::Const.Perks.PerkDefs.LegendDoubleStrike],
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
		[::Const.Perks.PerkDefs.CoupDeGrace],
		[],
		[::Const.Perks.PerkDefs.SpecPolearm],
		[::Const.Perks.PerkDefs.ReachAdvantage],
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
		[::Const.Perks.PerkDefs.LegendSpecSpearWall],
		[],
		[::Const.Perks.PerkDefs.SpecSpear],
		[::Const.Perks.PerkDefs.LegendSpecSpearThrust],
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
		[::Const.Perks.PerkDefs.SpecCrossbow],
		[::Const.Perks.PerkDefs.LegendHeightenedReflexes],
		[::Const.Perks.PerkDefs.LegendBallistics],
		[::Const.Perks.PerkDefs.LegendPiercingShot]
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
		[::Const.Perks.PerkDefs.LegendLookout],//::Const.Perks.PerkDefs.BowRange
		[::Const.Perks.PerkDefs.Bullseye],
		[],
		[::Const.Perks.PerkDefs.SpecBow],
		[::Const.Perks.PerkDefs.LegendWindReader],
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
		[::Const.Perks.PerkDefs.QuickHands],
		[],
		[::Const.Perks.PerkDefs.SpecThrowing],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendCloseCombatArcher]
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
		[::Const.Perks.PerkDefs.LegendSpecialistSlingSkill],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendMasterySlings],
		[::Const.Perks.PerkDefs.LegendSpecialistSlingDamage],
		[],
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
		[::Const.Perks.PerkDefs.LegendSpecStaffSkill],
		[::Const.Perks.PerkDefs.LegendMasteryStaves],
		[::Const.Perks.PerkDefs.LegendSpecStaffStun],
		[],
		[::Const.Perks.PerkDefs.LegendPushTheAdvantage]
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
		[::Const.Perks.PerkDefs.ShieldBash],
		[],
		[::Const.Perks.PerkDefs.ShieldExpert],
		[::Const.Perks.PerkDefs.LegendSpecialistShieldSkill],
		[],
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
		[::Const.Perks.PerkDefs.LegendSpecStaffSkill],
		[::Const.Perks.PerkDefs.LegendMasteryStaves],
		[::Const.Perks.PerkDefs.LegendSpecStaffStun],
		[],
		[::Const.Perks.PerkDefs.LegendPushTheAdvantage]
	]
};

::Const.Perks.WeaponTrees <- {
	Tree = [
		::Const.Perks.MaceTree,
		::Const.Perks.FlailTree,
		::Const.Perks.HammerTree,
		::Const.Perks.AxeTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.GreatSwordTree,
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

		local r = this.Math.rand(0, L.len() - 1)
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
		::Const.Perks.GreatSwordTree,
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

		local r = this.Math.rand(0, L.len() - 1)
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
