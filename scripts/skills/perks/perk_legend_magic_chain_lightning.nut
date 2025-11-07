// TODO Edit strings.nut
this.perk_legend_magic_chain_lightning <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMagicChainLightning);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendMagicChainLightning))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_magic_chain_lightning_skill"));
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMagicChainLightning);
	}

});
