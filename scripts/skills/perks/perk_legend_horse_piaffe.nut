this.perk_legend_horse_piaffe <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHorsePiaffe);
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkillMult *= 1.25;
	}

});

