// TODO Edit strings.nut
this.perk_legend_magic_hailstone <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMagicHailstone);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendMagicHailstone))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendMagicHailstone);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMagicHailstone);
	}

});
