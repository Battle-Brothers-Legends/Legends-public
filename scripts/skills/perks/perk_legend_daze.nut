this.perk_legend_daze <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendDaze);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendDaze))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendDaze);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendDaze);
	}

});
