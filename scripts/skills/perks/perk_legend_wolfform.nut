this.perk_legend_wolfform <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendWolfform);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendTransformIntoWolf))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendTransformIntoWolf);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendTransformIntoWolf);
	}

});
