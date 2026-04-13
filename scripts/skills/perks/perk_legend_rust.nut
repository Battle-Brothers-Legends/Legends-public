this.perk_legend_rust <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendRust);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendRust))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendRust);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendRust);
	}

});
