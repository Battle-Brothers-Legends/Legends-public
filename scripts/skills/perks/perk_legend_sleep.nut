this.perk_legend_sleep <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSleep);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendSleep))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendSleep);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendSleep);
	}

});
