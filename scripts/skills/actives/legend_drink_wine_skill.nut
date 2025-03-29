this.legend_drink_wine_skill <- this.inherit("scripts/skills/actives/base/legend_drink_alcohol_skill", {
	m = {},

	function create()
	{
		this.legend_drink_alcohol_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDrinkWine);
		this.m.Description = "Give to an adjacent ally or drink wine to get tipsy, or drunk if already tipsy, or sick if already drunk. Can not be used while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
		this.m.Icon = "skills/wine_square.png";
		this.m.IconDisabled = "skills/wine_square_bw.png";
		this.m.Overlay = "active_144";
		this.m.Effect = ::Legends.Effect.LegendWineTipsyEffect;
	}

	function tacticalLogDrink(_user) {
		return this.Const.UI.getColorizedEntityName(_user) + " drinks wine"
	}

	function tacticalLogGive(_user, _target) {
		return this.Const.UI.getColorizedEntityName(_user) + " gives wine to " + this.Const.UI.getColorizedEntityName(_target);
	}
});

