this.perk_legend_incoming <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendIncoming);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendIncoming))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendIncoming);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendIncoming);
	}

});
