if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

::Const.Perks.ShadyTree <- {
	ID = "ShadyTree",
	Name =  "Shady",
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
			::Legends.Perk.LegendFeint
		],
		[
			::Legends.Perk.Backstabber,
			::Legends.Perk.CoupDeGrace
		],
		[],
		[],
		[],
		[],
		[]
	]
};
::Const.Perks.AggressiveTree <- {
	ID = "AggressiveTree",
	Name =  "Aggressive",
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
		[],
		[
			::Legends.Perk.Berserk
		],
		[
			::Legends.Perk.KillingFrenzy,
			::Legends.Perk.Fearsome
		]
	]
};
::Const.Perks.SparringTree <- {
	ID = "SparringTree",
	Name =  "Sparring",
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
			::Legends.Perk.LegendBackToBasics
		],
		[
			::Legends.Perk.Rotation,
			::Legends.Perk.Anticipation
        ],
		[],
		[],
		[],
		[],
		[]
	]
};
::Const.Perks.RangerTree <- {
	ID = "RangerTree",
	Name =  "Ranger",
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
			::Legends.Perk.LegendLookout,
            ::Legends.Perk.Pathfinder
		],
		[
			::Legends.Perk.Anticipation
        ],
		[],
		[],
		[],
		[
			::Legends.Perk.LegendBallistics
		],
		[]
	]
};
::Const.Perks.GiantTree <- {
	ID = "GiantTree",
	Name =  "Giant",
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
		[
			::Legends.Perk.HoldOut
        ],
		[],
		[],
		[],
		[],
		[
            ::Legends.Perk.LegendMuscularity,
            ::Legends.Perk.Indomitable
        ]
	]
};
