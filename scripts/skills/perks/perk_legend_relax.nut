this.perk_legend_relax <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendRelax);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendRelax))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendRelax);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendRelax);
	}

});
