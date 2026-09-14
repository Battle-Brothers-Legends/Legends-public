this.perk_legend_scry <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendScry);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendScry))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendScry);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendScry);
	}

});
