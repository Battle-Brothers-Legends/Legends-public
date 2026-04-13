this.perk_legend_magic_teleport <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMagicTeleport);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendMagicTeleport))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendMagicTeleport);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMagicTeleport);
	}

});

