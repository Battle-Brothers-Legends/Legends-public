this.perk_legend_horse_leg_control <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHorseLegControl);
	}

	function onUpdate( _properties )
	{
		_properties.RangedSkillMult *= 1.25;
	}

});

