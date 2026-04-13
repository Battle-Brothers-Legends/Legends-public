// TODO strings.nut
this.perk_legend_magic_healing_wind <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMagicHealingWind);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendMagicHealingWind))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendMagicHealingWind);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMagicHealingWind);
	}
});

