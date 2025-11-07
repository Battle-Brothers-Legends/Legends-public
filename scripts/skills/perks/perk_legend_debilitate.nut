this.perk_legend_debilitate <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendDebilitate);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.Debilitate))
		{
			::Legends.Actives.grant(this, ::Legends.Active.Debilitate);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.Debilitate);
	}


});

