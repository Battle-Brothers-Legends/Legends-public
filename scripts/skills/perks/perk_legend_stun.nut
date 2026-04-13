this.perk_legend_stun <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendStun);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendStun))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendStun);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendStun);
	}

});
