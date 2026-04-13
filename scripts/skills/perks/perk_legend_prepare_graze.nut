this.perk_legend_prepare_graze <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPrepareGraze);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendPrepareGraze))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendPrepareGraze);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendPrepareGraze);
	}

});
