this.legend_drink_mead_skill <- this.inherit("scripts/skills/actives/base/legend_drink_alcohol_skill", {
	m = {},

	function create()
	{
		this.legend_drink_alcohol_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDrinkMead);
		this.m.Description = "Give to an adjacent ally or drink mead to get warmed, or drunk if already warmed, or sick if already drunk. Can not be used while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
		this.m.Icon = "skills/mead_square.png";
		this.m.IconDisabled = "skills/mead_square_bw.png";
		this.m.Overlay = "active_144";
		this.m.Effect = ::Legends.Effect.LegendMeadWarmthEffect;
	}

	function tacticalLogDrink(_user) {
		return this.Const.UI.getColorizedEntityName(_user) + " drinks mead"
	}

	function tacticalLogGive(_user, _target) {
		return this.Const.UI.getColorizedEntityName(_user) + " gives mead to " + this.Const.UI.getColorizedEntityName(_target);
	}

});

