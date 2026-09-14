this.perk_legend_cheer_on <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendCheerOn);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendCheerOn))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendCheerOn);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendCheerOn);
	}



});

