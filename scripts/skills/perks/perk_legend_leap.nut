this.perk_legend_leap <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendLeap);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendLeap))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendLeap);
		}
	}
	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendLeap);
	}
});

