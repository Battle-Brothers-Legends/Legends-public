this.perk_legend_kick <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendKick);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendKick))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendKick);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendKick);
	}



});

