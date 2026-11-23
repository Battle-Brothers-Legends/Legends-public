this.perk_legend_violent_decomposition <- this.inherit("scripts/skills/skill", {
	m = {
		LootChance = 30
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendViolentDecomposition);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendViolentDecomposition))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendViolentDecomposition);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendViolentDecomposition);
	}


});
