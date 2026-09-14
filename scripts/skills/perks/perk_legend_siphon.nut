this.perk_legend_siphon <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSiphon);
		this.m.Overlay = "active_42";
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendSiphon))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendSiphon);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendSiphon);
	}

});
