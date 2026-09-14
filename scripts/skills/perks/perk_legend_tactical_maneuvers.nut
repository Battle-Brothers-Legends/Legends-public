this.perk_legend_tactical_maneuvers <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendTacticalManeuvers);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.Rotation))
		{
			::Legends.Actives.grant(this, ::Legends.Active.Rotation);
		}
		if (!this.m.Container.hasActive(::Legends.Active.Footwork))
		{
			::Legends.Actives.grant(this, ::Legends.Active.Footwork);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.Rotation);
		::Legends.Actives.remove(this, ::Legends.Active.Footwork);
	}

});
