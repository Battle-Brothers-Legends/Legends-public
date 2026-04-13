this.perk_legend_horrify <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHorrify);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendHorrificScream))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendHorrificScream);
		}
	}

	function onRemoved()
	{
		if (!this.m.Container.hasPerk(::Legends.Perk.LegendHorrify))
		{
			::Legends.Actives.remove(this, ::Legends.Active.LegendHorrificScream);
		}
	}

});
