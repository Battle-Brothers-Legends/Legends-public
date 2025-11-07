this.perk_legend_bribe <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBribe);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendBribe))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendBribe);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendBribe);
	}

});
