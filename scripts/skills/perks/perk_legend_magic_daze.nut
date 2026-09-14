// TODO edit strings, image
this.perk_legend_magic_daze <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMagicDaze);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendMagicDaze))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendMagicDaze);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMagicDaze);
	}

});
