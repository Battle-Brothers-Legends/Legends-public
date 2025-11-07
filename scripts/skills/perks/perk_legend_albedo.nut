this.perk_legend_albedo <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendAlbedo);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendAlbedo))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendAlbedo);
		}
	}
	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendAlbedo);
	}

});
