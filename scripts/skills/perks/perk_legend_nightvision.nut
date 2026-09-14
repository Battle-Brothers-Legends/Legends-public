this.perk_legend_nightvision <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendNightvision);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendNightvision))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendNightvision);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendNightvision);
	}

});
