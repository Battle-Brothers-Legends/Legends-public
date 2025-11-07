this.perk_legend_nigredo <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendNigredo);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendNigredo))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendNigredo);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendNigredo);
	}

});
