if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

::Const.Perks.AgileTree <- {
	ID = "AgileTree",
	Name = "Agile",
	Descriptions = [
		"is agile",
		"moves gracefully",
		"carries themself with ease",
		"is impressively agile",
		"has an athletic physique",
		"is spry as a fox",
		"is particularly dexterous"
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
			::Legends.Perk.Pathfinder
		],
		[],
		[],
		[],
		[
			::Legends.Perk.LegendTacticalManeuvers 
		],
		[],
		[
			::Legends.Perk.LegendInTheZone
		]
	]
};
::Const.Perks.IndestructibleTree <- {
	ID = "IndestructibleTree",
	Name = "Tenacious",
	Descriptions = [
		"is practicaly indestructible",
		"is stubbornly relentless",
		"is staunchly perserverent",
		"has a strong will",
		"steadfastly persists",
		"seems unswervingly firm",
		"is adamantly resolute"
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
			::Legends.Perk.NineLives,
			::Legends.Perk.LegendRecuperation
		],
		[],
		[
			::Legends.Perk.HoldOut
		],
		[],
		[],
		[],
		[
			::Legends.Perk.Indomitable
		]
	]
};
::Const.Perks.MartyrTree <- {
	ID = "MartyrTree",
	Name = "Martyr",
	Descriptions = [
		"has martyr complex",
		"strictly penatant ",
		"strives for atonement in hardship",
		"sees their own torture as absolution",
		"seems to revel in self-suffering",
		"takes joy in feeling pain",
		"perversely enjoys to be tormented"
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
		[
			::Legends.Perk.Taunt
		],
		[],
		[],
		[
			::Legends.Perk.LoneWolf
		],
		[
			::Legends.Perk.LegendVengeance
		],
		[
			::Legends.Perk.LegendLastStand
		]
	]
};
::Const.Perks.ViciousTree <- {
	ID = "ViciousTree",
	Name = "Vicious",
	Descriptions = [
		"is vicious",
		"seems fiendishly barbarous",
		"is ferociously savage",
		"is brutally harsh",
		"appears diabolically fierce",
		"is beastially dangerous",
		"enjoys martial butchery"
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
			::Legends.Perk.CripplingStrikes
		],
		[],
		[
			::Legends.Perk.LegendDebilitate
		],
		[],
		[
			::Legends.Perk.Berserk
		],
		[
			::Legends.Perk.LegendAssuredConquest
		],
		[]
	]
};
::Const.Perks.DeviousTree <- {
	ID = "DeviousTree",
	Name = "Devious",
	Descriptions = [
		"is devious",
		"strikes you as shifty",
		"has a shady appearance",
		"comes across as insincere",
		"is slyly sneaky",
		"responds evasively",
		"is shrewdly deceitful"
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
			::Legends.Perk.LegendBlendIn
		],
		[
			::Legends.Perk.LegendTrueBeliever
		],
		[],
		[],
		[
			::Legends.Perk.LegendEvasion
		],
		[
			::Legends.Perk.Backstabber
		],
		[]
	]
};
::Const.Perks.InspirationalTree <- {
	ID = "InspirationalTree",
	Name = "Inspirational",
	Descriptions = [
		"is inspirational",
		"arouses loyalty in people",
		"galvanises trust in others",
		"emboldens people to action",
		"speaks with conviction",
		"gives impressive speeches",
		"instills motivation through words"
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
		[
			::Legends.Perk.RallyTheTroops
		],
		[
			::Legends.Perk.Taunt
		],
		[],
		[],
		[
			::Legends.Perk.InspiringPresence
		],
		[
			::Legends.Perk.LegendInspire
		]
	]
};
::Const.Perks.IntelligentTree <- {
	ID = "IntelligentTree",
	Name = "Intelligent",
	Descriptions = [
		"is intelligent",
		"is strikingly astute",
		"has a creative imagination",
		"seems well informed",
		"appears knowledgeable of many things",
		"approaches problems rationally",
		"inventively resolves challenges"
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
			::Legends.Perk.Student,
			::Legends.Perk.Gifted
		],
		[],
		[],
		[],
		[
			::Legends.Perk.LegendPromisedPotential,
		],
		[
			::Legends.Perk.LegendMindOverBody
		],
		[]
	]
};
::Const.Perks.CalmTree <- {
	ID = "CalmTree",
	Name = "Calm",
	Descriptions = [
		"is calm",
		"is soothingly relaxed",
		"projects peace of mind",
		"seems unflustered",
		"goes with the flow",
		"is unworried"
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
			::Legends.Perk.LegendAlert
		],
		[],
		[],
		[
			::Legends.Perk.LegendPeaceful
		],
		[
			::Legends.Perk.LegendClarity
		],
		[],
		[
			::Legends.Perk.LegendPerfectFocus
		]
	]
};
::Const.Perks.FastTree <- {
	ID = "FastTree",
	Name =  "Fast",
	Descriptions = [
		"is fast",
		"runs quickly",
		"is quick as a flash",
		"has fleet feet",
		"maneuvers rapidly",
		"steps briskly",
		"is a speedy sprinter"
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
			::Legends.Perk.FastAdaption,
			::Legends.Perk.Adrenaline
		],
		[
			::Legends.Perk.Anticipation,
			::Legends.Perk.LegendQuickStep
		],
		[],
		[],
		[],
		[],
		[]
	]
};
::Const.Perks.LargeTree <- {
	ID = "LargeTree",
	Name = "Large",
	Descriptions = [
		"is large",
		"has a hulking form",
		"has impressively broad shoulders",
		"is a hefty sort",
		"looms with immensity",
		"is a mountainous figure",
		"wields considerable musculature"
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
			::Legends.Perk.Colossus
		],
		[],
		[
			::Legends.Perk.LegendOnslaught
		],
		[],
		[
			::Legends.Perk.LegendSecondWind
		],
		[],
		[
			::Legends.Perk.LegendMuscularity
		]
	]
};
::Const.Perks.OrganisedTree <- {
	ID = "OrganisedTree",
	Name = "Organized",
	Descriptions = [
		"is organized",
		"coordinates activities effectively",
		"formulates detailed plans",
		"tabulates company expenses",
		"already classified your inventory",
		"alphabetizes the supplies",
		"is fastidiously organised"
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
			::Legends.Perk.BagsAndBelts,
			::Legends.Perk.LegendPacifist
		],
		[
			::Legends.Perk.LegendHelpful
		],
		[
			::Legends.Perk.LegendEfficientPacking
		],
		[],
		[
			::Legends.Perk.LegendSkillfulStacking
		],
		[],
		[]
	]
};
::Const.Perks.SturdyTree <- {
	ID = "SturdyTree",
	Name = "Sturdy",
	Descriptions = [
		"is sturdy",
		"is built to last",
		"has a rugged countenance",
		"is stouthearted",
		"is quite robust",
		"is well built",
		"seems hardy"
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
		[
			::Legends.Perk.FortifiedMind
		],
		[
			::Legends.Perk.Steadfast
		],
		[],
		[],
		[],
		[
			::Legends.Perk.LegendRebound
		]
	]
};
::Const.Perks.FitTree <- {
	ID = "FitTree",
	Name = "Fit",
	Descriptions = [
		"can run all day",
		"lifts weight for hours",
		"barely breaks a sweat",
		"has extraordinary endurance",
		"has superb stamina",
		"rarely loses breath"
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
			::Legends.Perk.Recover,
		],
		[],
		[
			::Legends.Perk.LegendAthlete
		],
		[],
		[],
		[
			::Legends.Perk.Overwhelm
		],
		[
			::Legends.Perk.LegendRebound
		]
	]
};
::Const.Perks.TrainedTree <- {
	ID = "TrainedTree",
	Name = "Trained",
	Descriptions = [
		"is well trained",
		"has great qualifications",
		"is well drilled",
		"is truly disciplined",
		"has practiced a great deal",
		"has been instructed by someone skillful",
		"has genuine experience"
	],
	Attributes =  {
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
			::Legends.Perk.LegendBackToBasics
		],
		[],
		[
			::Legends.Perk.LegendTacticalManeuvers,
			::Legends.Perk.Underdog
		],
		[],
		[],
		[],
		[]
	]
};
::Const.Perks.TraitsTrees <- {
	Tree = [
		::Const.Perks.AgileTree,
		::Const.Perks.IndestructibleTree,
		::Const.Perks.MartyrTree,
		::Const.Perks.ViciousTree,
		::Const.Perks.DeviousTree,
		::Const.Perks.InspirationalTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.CalmTree,
		::Const.Perks.FastTree,
		::Const.Perks.LargeTree,
		::Const.Perks.OrganisedTree,
		::Const.Perks.SturdyTree,
		::Const.Perks.FitTree,
		::Const.Perks.TrainedTree
	],
	function getRandom( _exclude )
	{
		local L = [];

		foreach( i, t in this.Tree )
		{
			if (_exclude != null && _exclude.find(t.ID) != null)
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

	function getBaseAttributes()
	{
		return {
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
		};
	}

};
