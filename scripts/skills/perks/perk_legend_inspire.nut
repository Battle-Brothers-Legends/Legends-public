this.perk_legend_inspire <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendInspire);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendInspire))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendInspire);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendInspire);
	}



});

