this.perk_legend_prepare_bleed <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPrepareBleed);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendPrepareBleed))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendPrepareBleed);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendPrepareBleed);
	}

});
