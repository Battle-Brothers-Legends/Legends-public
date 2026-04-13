this.perk_legend_scry_trance <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendScryTrance);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendScryTrance))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendScryTrance);
		}
	}


});

