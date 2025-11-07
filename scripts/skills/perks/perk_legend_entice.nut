this.perk_legend_entice <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendEntice);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendEntice))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendEntice);
		}
	}
	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendEntice);
	}

});
