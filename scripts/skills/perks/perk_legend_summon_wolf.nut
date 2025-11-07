this.perk_legend_summon_wolf <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSummonWolf);
	}


	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendUnleashWolf))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendUnleashWolf);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendUnleashWolf);
	}


});
