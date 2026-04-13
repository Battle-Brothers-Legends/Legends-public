this.perk_legend_push <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPush);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendRevolt))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendRevolt);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendRevolt);
	}

});
