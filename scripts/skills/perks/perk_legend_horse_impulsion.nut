this.perk_legend_horse_impulsion <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHorseImpulsion);
	}

	function onUpdate( _properties )
	{
		_properties.InitiativeMult *= 1.25;
	}

});

