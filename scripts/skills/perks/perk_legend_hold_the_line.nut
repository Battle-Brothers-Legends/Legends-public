this.perk_legend_hold_the_line <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHoldTheLine);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendHoldTheLine))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendHoldTheLine);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendHoldTheLine);
	}

});

