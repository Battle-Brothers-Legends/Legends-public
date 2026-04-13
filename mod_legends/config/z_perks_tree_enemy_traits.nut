if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

::Const.Perks.ShadyTree <- {
	ID = "ShadyTree",
	Name =  "Shady",
	Icon = "ui/perks/feint_circle.png",
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
			::Legends.Perk.LegendStrengthInNumbers,
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
	Icon = "ui/perks/perk_27.png",
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
	Icon = "ui/perks/back_to_basics_circle.png",
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
			::Legends.Perk.LegendTacticalManeuvers,
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
	Icon = "ui/perks/lookout_circle.png",
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
	Icon = "ui/perks/perk_06.png",
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
