this.perk_legend_return_favor <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendReturnFavor);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.ReturnFavor))
		{
			::Legends.Actives.grant(this, ::Legends.Active.ReturnFavor);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.ReturnFavor);
	}

});

