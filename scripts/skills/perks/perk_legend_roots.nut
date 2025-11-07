this.perk_legend_roots <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendRoots);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendRoot))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendRoot);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendRoot);
	}

});
