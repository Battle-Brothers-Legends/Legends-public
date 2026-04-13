this.perk_legend_tackle <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendTackle);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendTackle))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendTackle);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendTackle);
	}

});

