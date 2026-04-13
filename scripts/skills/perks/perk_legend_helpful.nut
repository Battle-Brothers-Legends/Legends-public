this.perk_legend_helpful <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHelpful);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendPass))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendPass);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendPass);
	}

});

