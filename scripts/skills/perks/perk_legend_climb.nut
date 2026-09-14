this.perk_legend_climb <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendClimb);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.Footwork))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendClimb);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendClimb);
	}

});

