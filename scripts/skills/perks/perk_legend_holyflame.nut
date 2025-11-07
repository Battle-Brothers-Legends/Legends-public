this.perk_legend_holyflame <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHolyFlame);
		this.m.Icon = "ui/perks/holyfire_circle.png";
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendHolyflame))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendHolyflame);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendHolyflame);
	}

});

