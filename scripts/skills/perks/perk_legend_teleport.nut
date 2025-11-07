this.perk_legend_teleport <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendTeleport);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendTeleport))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendTeleport);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendTeleport);
	}

});
