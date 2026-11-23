this.perk_legend_raise_undead <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendRaiseUndead);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendRaiseUndead))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendRaiseUndead);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendRaiseUndead);
	}

});
