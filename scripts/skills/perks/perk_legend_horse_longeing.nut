this.perk_legend_horse_longeing <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHorseLongeing);
	}

	function onUpdate( _properties )
	{
		_properties.BraveryMult *= 1.25;
	}

});

