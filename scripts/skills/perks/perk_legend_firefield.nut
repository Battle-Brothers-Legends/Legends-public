this.perk_legend_firefield <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendFirefield);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendFirefield))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendFirefield);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendFirefield);
	}

});
