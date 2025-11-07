this.perk_legend_danger_pay <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendDangerPay);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendDangerPay))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendDangerPay);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendDangerPay);
	}

});
