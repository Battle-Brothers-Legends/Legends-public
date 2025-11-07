this.perk_legend_prayer_of_life <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPrayerOfLife);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendPrayerOfLife))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendPrayerOfLife);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendPrayerOfLife);
	}

});

