// Burning Hands Perk - increase base damage
// TODO strings.nut
this.perk_legend_mastery_burning_hands <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMasteryBurningHands);
	}

});
