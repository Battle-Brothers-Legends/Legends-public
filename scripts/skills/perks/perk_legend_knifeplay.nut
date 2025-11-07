this.perk_legend_knifeplay <- this.inherit("scripts/skills/skill", {
	m = {},

	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendKnifeplay);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendThrowKnife))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendThrowKnife);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendThrowKnife);
	}

});

