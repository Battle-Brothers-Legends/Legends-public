this.perk_legend_summon_hound <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSummonHound);
	}


	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendUnleashHound))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendUnleashHound);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendUnleashHound);
	}


});
