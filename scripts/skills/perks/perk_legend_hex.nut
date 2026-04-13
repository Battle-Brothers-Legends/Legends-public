this.perk_legend_hex <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHex);
		this.m.IsActive = true;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendHex))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendHex);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendHex);
	}

});
