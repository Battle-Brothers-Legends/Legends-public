this.perk_legend_smashing_shields <- this.inherit("scripts/skills/skill", {
	m = {
		Modifier = 1.50
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSmashingShields);
	}

	function getModifier()
	{
		return this.m.Modifier;
	}

});

