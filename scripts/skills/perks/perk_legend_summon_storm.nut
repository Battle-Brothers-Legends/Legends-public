this.perk_legend_summon_storm <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSummonStorm);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendSummonStorm))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendSummonStorm);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendSummonStorm);
	}

});
