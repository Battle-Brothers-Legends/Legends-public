local gt = this.getroottable();

if (!("Perks" in ::Const)) {
	::Const.Perks <- {};
}

::Const.Perks.ForcefulTree <- {
	ID = "ForcefulTree",
	Name = "Forceful",
	Icon = "ui/perks/legend_immovable_object.png",
	Attributes = clone ::Legends.Backgrounds.EmptyAttr,
	IsForEnemies = true,
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
