this.perk_legend_hidden <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHidden);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendHidden))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendHidden);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendHidden);
	}

});
