this.perk_legend_throw_sand <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendThrowSand);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.ThrowDirt))
		{
			::Legends.Actives.grant(this, ::Legends.Active.ThrowDirt);
		}
	}

});

