this.perk_legend_read_omens_trance <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendReadOmensTrance);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendReadOmensTrance))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendReadOmensTrance);
		}
	}


});

