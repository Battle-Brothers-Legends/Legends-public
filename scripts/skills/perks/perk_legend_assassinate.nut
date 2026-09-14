this.perk_legend_assassinate <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		//All effects of this perk are contained within hidden_effect.nut
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendAssassinate);
	}

});

