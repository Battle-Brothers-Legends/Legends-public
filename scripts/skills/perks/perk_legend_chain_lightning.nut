this.perk_legend_chain_lightning <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendChainLightning);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendChainLightning))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendChainLightning);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendChainLightning);
	}

});
