this.perk_legend_dogmaster <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendDogMaster);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendDogMaster))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendDogMaster);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendDogMaster);
	}

});
