if (!("Perks" in ::Const)) {
	::Const.Perks <- {};
}

::Const.Perks.ShadyTree <- {
	ID = "ShadyTree",
	Name = "Shady",
	Icon = "ui/perks/feint_circle.png",
	Attributes = clone ::Legends.Backgrounds.EmptyAttr,
	Tree = [
		[::Legends.Perk.LegendFeint],
		[::Legends.Perk.LegendStrengthInNumbers, ::Legends.Perk.CoupDeGrace],
		[],
		[],
		[],
		[],
		[]
	]
};
::Const.Perks.AggressiveTree <- {
	ID = "AggressiveTree",
	Name = "Aggressive",
	Icon = "ui/perks/perk_27.png",
	Attributes = clone ::Legends.Backgrounds.EmptyAttr,
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.Berserk],
		[::Legends.Perk.KillingFrenzy, ::Legends.Perk.Fearsome]
	]
};
::Const.Perks.SparringTree <- {
	ID = "SparringTree",
	Name = "Sparring",
	Icon = "ui/perks/back_to_basics_circle.png",
	Attributes = clone ::Legends.Backgrounds.EmptyAttr,
	Tree = [
		[::Legends.Perk.LegendBackToBasics],
		[::Legends.Perk.LegendTacticalManeuvers, ::Legends.Perk.Anticipation],
		[],
		[],
		[],
		[],
		[]
	]
};
::Const.Perks.RangerTree <- {
	ID = "RangerTree",
	Name = "Ranger",
	Icon = "ui/perks/lookout_circle.png",
	Attributes = clone ::Legends.Backgrounds.EmptyAttr,
	Tree = [
		[::Legends.Perk.LegendLookout, ::Legends.Perk.Pathfinder],
		[::Legends.Perk.Anticipation],
		[],
		[],
		[],
		[::Legends.Perk.LegendBallistics],
		[]
	]
};
::Const.Perks.GiantTree <- {
	ID = "GiantTree",
	Name = "Giant",
	Icon = "ui/perks/perk_06.png",
	Attributes = clone ::Legends.Backgrounds.EmptyAttr,
	Tree = [
		[::Legends.Perk.Colossus],
		[::Legends.Perk.HoldOut],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendMuscularity, ::Legends.Perk.Indomitable]
	]
};
