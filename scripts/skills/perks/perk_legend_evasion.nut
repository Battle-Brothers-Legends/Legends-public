this.perk_legend_evasion <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendEvasion);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendEvasion))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendEvasion);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendEvasion);
	}

});
