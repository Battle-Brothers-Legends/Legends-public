this.perk_legend_possess_undead <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPossessUndead);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.PossessUndead))
		{
			::Legends.Actives.grant(this, ::Legends.Active.PossessUndead);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.PossessUndead);
	}

});
