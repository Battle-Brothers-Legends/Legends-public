this.perk_legend_levitation <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendLevitate);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendLevitatePerson))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendLevitatePerson);
		}
	}

	function onRemoved()
	{
		if (this.m.Container.hasActive(::Legends.Active.LegendLevitatePerson))
		{
			::Legends.Actives.remove(this, ::Legends.Active.LegendLevitatePerson);
		}
	}

});
