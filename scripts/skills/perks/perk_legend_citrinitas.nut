this.perk_legend_citrinitas <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendCitrinitas);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendCitrinitasTrance))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendCitrinitasTrance);
		}
	}


});

