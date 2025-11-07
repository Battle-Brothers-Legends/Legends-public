// TODO Edit strings.nut
this.perk_legend_magic_circle_of_protection <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMagicCircleOfProtection);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendMagicCircleOfProtection))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendMagicCircleOfProtection);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMagicCircleOfProtection);
	}

});
