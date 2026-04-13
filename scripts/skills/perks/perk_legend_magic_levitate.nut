// TODO Edit strings, icon
this.perk_legend_magic_levitate <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMagicLevitate);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendMagicLevitate))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendMagicLevitate);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMagicLevitate);
	}

});
