this.perk_legend_strength_in_numbers <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendStrengthInNumbers);
	}

	function onUpdate( _properties )
	{
		_properties.SurroundedBonusMult = 2.0;
	}

});

