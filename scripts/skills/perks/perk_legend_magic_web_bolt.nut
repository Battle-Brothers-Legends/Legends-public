this.perk_legend_magic_web_bolt <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMagicWebBolt);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendMagicWebBolt))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendMagicWebBolt);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMagicWebBolt);
	}

});

