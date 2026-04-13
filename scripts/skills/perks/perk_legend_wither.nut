this.perk_legend_wither <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendWither);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendWither))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendWither);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendWither);
	}

});
