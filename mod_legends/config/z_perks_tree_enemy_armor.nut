local gt = this.getroottable();

if (!("Perks" in ::Const)) {
	::Const.Perks <- {};
}

::Const.Perks.ForcefulTree <- {
	ID = "ForcefulTree",
	Name = "Forceful",
	Icon = "ui/perks/fullforce_circle.png",
	Attributes = clone ::Legends.Backgrounds.EmptyAttr,
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.BattleForged],
		[::Legends.Perk.LegendMuscularity, ::Legends.Perk.LegendImmovableObject]
	]
};
