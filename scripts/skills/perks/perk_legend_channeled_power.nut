this.perk_legend_channeled_power <- this.inherit("scripts/skills/skill", {
	m = {
		FatigueMult = 0.7
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendChanneledPower);
	}

});
