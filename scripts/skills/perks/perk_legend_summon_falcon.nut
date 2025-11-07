this.perk_legend_summon_falcon <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSummonFalcon);
	}


	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendFalcon))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendFalcon);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendFalcon);
	}


});
