this.perk_legend_call_lightning <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendCallLightning);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendCallLightning))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendCallLightning);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendCallLightning);
	}

});
