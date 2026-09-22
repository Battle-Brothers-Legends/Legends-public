this.perk_legend_cacophony <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendCacophony);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendCacophony))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendCacophony);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendCacophony);
	}

});
