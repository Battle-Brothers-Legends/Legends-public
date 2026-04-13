this.perk_legend_magic_soothing_wind <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMagicSoothingWind);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendMagicSoothingWind))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendMagicSoothingWind);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMagicSoothingWind);
	}

});

