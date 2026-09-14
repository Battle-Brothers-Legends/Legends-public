this.perk_legend_horse_pirouette <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHorsePirouette);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendHorsePirouette))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_horse_pirouette"));
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendHorsePirouette);
	}

});

