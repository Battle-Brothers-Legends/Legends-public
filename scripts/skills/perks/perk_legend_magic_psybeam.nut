this.perk_legend_magic_psybeam <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMagicPsybeam);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendMagicPsybeam))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendMagicPsybeam);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMagicPsybeam);
	}

});
