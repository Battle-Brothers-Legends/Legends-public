this.perk_legend_coordinated_volleys <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendCoordinatedVolleys);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendCoordinatedVolleys))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendCoordinatedVolleys);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendCoordinatedVolleys);
	}

});
