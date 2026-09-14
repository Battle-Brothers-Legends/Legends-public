this.legend_drink_beer_skill <- this.inherit("scripts/skills/actives/base/legend_drink_alcohol_skill", {
	m = {},

	function create()
	{
		this.legend_drink_alcohol_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDrinkBeer);
		this.m.Description = "Give to an adjacent ally or drink beer to get buzzed, or drunk if already buzzed, or sick if already drunk. Can not be used while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
		this.m.Effect = ::Legends.Effect.LegendBeerBuzzEffect;
	}

	function tacticalLogDrink(_user) {
		return this.Const.UI.getColorizedEntityName(_user) + " drinks beer";
	}

	function tacticalLogGive(_user, _target) {
		return this.Const.UI.getColorizedEntityName(_user) + " gives beer to " + this.Const.UI.getColorizedEntityName(_target);
	}
});

