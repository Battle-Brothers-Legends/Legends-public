this.perk_legend_summon_cat <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSummonCat);
	}


	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendUnleashCat))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendUnleashCat);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendUnleashCat);
	}


});
