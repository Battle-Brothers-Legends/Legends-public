this.perk_legend_quick_step <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendQuickStep);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendQuickStep))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendQuickStep);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendQuickStep);
	}

});

