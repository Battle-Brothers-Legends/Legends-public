this.perk_legend_manipulative <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendManipulative);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendEntice))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendEntice);
		}
		if (!this.m.Container.hasActive(::Legends.Active.LegendRevolt))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendRevolt);
		}
	}
	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendEntice);
		::Legends.Actives.remove(this, ::Legends.Active.LegendRevolt);
	}

});
