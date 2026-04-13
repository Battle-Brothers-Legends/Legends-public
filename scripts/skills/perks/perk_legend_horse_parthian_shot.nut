this.perk_legend_horse_parthian_shot <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHorseParthianShot);
	}

	function onUpdate( _properties )
	{
		_properties.RangedSkillMult *= 1.25;
	}

});

