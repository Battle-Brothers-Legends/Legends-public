local gt = this.getroottable();

if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

::Const.Perks.ForcefulTree <- {
	ID = "ForcefulTree",
	Name =  "Forceful",
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
            ::Legends.Perk.BattleForged
        ],
		[
            ::Legends.Perk.LegendMuscularity,
            ::Legends.Perk.LegendImmovableObject
        ]
	]
};
