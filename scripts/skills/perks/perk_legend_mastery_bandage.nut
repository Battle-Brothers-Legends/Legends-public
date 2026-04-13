this.perk_legend_mastery_bandage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecBandage);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendBandage))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendBandage);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendBandage);
	}

});
