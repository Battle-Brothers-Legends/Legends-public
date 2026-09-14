this.perk_legend_miasma <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMiasma);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendMiasma))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendMiasma);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMiasma);
	}

});
