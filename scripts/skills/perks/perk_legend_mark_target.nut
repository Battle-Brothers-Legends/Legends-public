this.perk_legend_mark_target <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMarkTarget);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendMarkTarget))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendMarkTarget);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMarkTarget);
	}

});
