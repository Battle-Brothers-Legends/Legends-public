if (!("Perks" in ::Const)) {
	::Const.Perks <- {};
}

::Const.Perks.MaceTree <- {
	ID = "MaceTree",
	Name = "Mace",
	Icon = "ui/perks/perk_43.png",
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
		[::Legends.Perk.LegendPushTheAdvantage],
		[::Legends.Perk.LegendReturnFavor],
		[]
	]
};

::Const.Perks.FlailTree <- {
	ID = "FlailTree",
	Name = "Flail",
	Icon = "ui/perks/perk_47.png",
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
	ID = "HammerTree",
	Name = "Hammer",
	Icon = "ui/perks/perk_53.png",
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
		[::Legends.Perk.LegendBoneBreaker],
		[]
	]
};

::Const.Perks.AxeTree <- {
	ID = "AxeTree",
	Name = "Axe",
	Icon = "ui/perks/perk_44.png",
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
		[::Legends.Perk.LegendSlaughterer],
		[::Legends.Perk.LegendBloodyHarvest],
		[::Legends.Perk.KillingFrenzy]
	]
};

::Const.Perks.CleaverTree <- {
	ID = "CleaverTree",
	Name = "Cleaver",
	Icon = "ui/perks/perk_52.png",
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
		[::Legends.Perk.LegendCarnage],
		[::Legends.Perk.LegendBloodbath],
		[::Legends.Perk.Fearsome, ::Legends.Perk.LegendLacerate]
	]
};

::Const.Perks.SwordTree <- {
	ID = "SwordTree",
	Name = "Sword",
	Icon = "ui/perks/perk_46.png",
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
		[::Legends.Perk.LegendBackswing, ::Legends.Perk.Duelist],
		[]
	]
};

::Const.Perks.DaggerTree <- {
	ID = "DaggerTree",
	Name = "Dagger",
	Icon = "ui/perks/perk_51.png",
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
		[],
		[],
		[::Legends.Perk.SpecDagger],
		[::Legends.Perk.LegendDoubleStrike, ::Legends.Perk.Backstabber],
		[],
		[]
	]
};
::Const.Perks.PolearmTree <- {
	ID = "PolearmTree",
	Name = "Polearm",
	Icon = "ui/perks/perk_58.png",
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
		[::Legends.Perk.LegendSpecStaffStun],
		[::Legends.Perk.CoupDeGrace],
		[],
		[::Legends.Perk.SpecPolearm],
		[::Legends.Perk.ReachAdvantage, ::Legends.Perk.LegendPushTheAdvantage],
		[],
		[]
	]
};

::Const.Perks.SpearTree <- {
	ID = "SpearTree",
	Name = "Spear",
	Icon = "ui/perks/perk_45.png",
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
		[::Legends.Perk.LegendStrengthInNumbers],
		[::Legends.Perk.LegendSpecSpearWall],
		[],
		[::Legends.Perk.SpecSpear],
		[],
		[::Legends.Perk.LegendThrustMaster],
		[]
	]
};

::Const.Perks.CrossbowTree <- {
	ID = "CrossbowTree",
	Name = "Crossbow",
	Icon = "ui/perks/perk_48.png",
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
		[::Legends.Perk.LegendBarrage]
	]
};

::Const.Perks.BowTree <- {
	ID = "BowTree",
	Name = "Bow",
	Icon = "ui/perks/perk_49.png",
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
		[],
		[::Legends.Perk.Bullseye, ::Legends.Perk.LegendAnchor],
		[],
		[::Legends.Perk.SpecBow],
		[::Legends.Perk.LegendKeenEyesight, ::Legends.Perk.LegendPatientHunter],
		[],
		[]
	]
};

::Const.Perks.ThrowingTree <- {
	ID = "ThrowingTree",
	Name = "Throwing",
	Icon = "ui/perks/perk_50.png",
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
		[::Legends.Perk.LegendVersatile],
		[::Legends.Perk.SpecThrowing],
		[::Legends.Perk.LegendFirstBlood],
		[],
		[::Legends.Perk.LegendPointBlank]
	]
};

::Const.Perks.SlingTree <- {
	ID = "SlingTree",
	Name = "Sling",
	Icon = "ui/perks/perk_sling_mastery.png",
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
		[::Legends.Perk.LegendLookout],
		[],
		[::Legends.Perk.LegendMasterySlings],
		[],
		[::Legends.Perk.LegendBarrage, ::Legends.Perk.LegendWindReader],
		[]
	]
};

::Const.Perks.ShieldTree <- {
	ID = "ShieldTree",
	Name = "Shield",
	Icon = "ui/perks/perk_05.png",
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

::Const.Perks.FistsTree <- {
	ID = "FistsTree",
	Name = "Unarmed",
	Icon = "ui/perks/unarmed_mastery_circle.png",
	Descriptions = [
		"unarmed combat"
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
		[
			::Legends.Perk.LegendAmbidextrous,
			::Legends.Perk.LegendPugilist
		],
		[
			::Legends.Perk.LegendGrappler
		],
		[],
		[
			::Legends.Perk.LegendSpecUnarmed
		],
		[],
		[
			::Legends.Perk.LegendPummelIntoSubmission
		],
		[]
	]
};

::Const.Perks.WeaponTrees <- {
	GroupsCategory = "Weapon",
	Tree = [
		::Const.Perks.FistsTree,
		::Const.Perks.MaceTree,
		::Const.Perks.FlailTree,
		::Const.Perks.HammerTree,
		::Const.Perks.AxeTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.SwordTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.SpearTree,
		::Const.Perks.CrossbowTree,
		::Const.Perks.BowTree,
		::Const.Perks.ThrowingTree,
		::Const.Perks.SlingTree,
		::Const.Perks.ShieldTree
	],

	function getRandom(_exclude) {
		local L = [];
		foreach (i, t in this.Tree) {
			if (_exclude.find(t.ID) != null) {
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
		::Const.Perks.FistsTree,
		::Const.Perks.MaceTree,
		::Const.Perks.FlailTree,
		::Const.Perks.HammerTree,
		::Const.Perks.AxeTree,
		::Const.Perks.CleaverTree,
		::Const.Perks.SwordTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.PolearmTree,
		::Const.Perks.SpearTree,
		::Const.Perks.ShieldTree
	],

	function getRandom(_exclude) {
		local L = [];
		foreach (i, t in this.Tree) {
			if (_exclude.find(t.ID)) {
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

	function getRandom(_exclude) {
		local L = [];
		foreach (i, t in this.Tree) {
			if (_exclude != null && _exclude.find(t.ID)) {
				continue;
			}
			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1);
		return this.Tree[L[r]];
	}

	function getRandomPerk() {
		local tree = this.getRandom(null);
		local L = [];
		foreach (row in tree.Tree) {
			foreach (p in row) {
				L.push(p);
			}
		}

		local r = this.Math.rand(0, L.len() - 1);
		return L[r];
	}

};
