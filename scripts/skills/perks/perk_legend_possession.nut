this.perk_legend_possession <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPossession);
		this.m.Icon = "ui/perks/possess56.png";
		this.m.IconDisabled = "ui/perks/possess56_bw.png";
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendPossession))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendPossession);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendPossession);
	}

});
