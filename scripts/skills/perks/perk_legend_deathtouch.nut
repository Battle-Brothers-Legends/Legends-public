this.perk_legend_deathtouch <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendDeathtouch);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendDeathtouch))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendDeathtouch);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendDeathtouch);
	}

});
