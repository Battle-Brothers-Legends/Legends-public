this.perk_legend_gruesome_feast <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendGruesomeFeast);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendGruesomeFeast))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendGruesomeFeast);
		}
	}

	function onRemoved()
	{
		if (!this.m.Container.hasPerk(::Legends.Perk.LegendGruesomeFeast))
		{
			::Legends.Actives.remove(this, ::Legends.Active.LegendGruesomeFeast);
		}
	}

});
