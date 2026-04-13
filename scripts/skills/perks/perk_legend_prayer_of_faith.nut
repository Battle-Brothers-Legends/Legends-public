this.perk_legend_prayer_of_faith <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPrayerOfFaith);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendPrayerOfFaith))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendPrayerOfFaith);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendPrayerOfFaith);
	}

});

