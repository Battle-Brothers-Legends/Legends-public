this.perk_legend_horse_tempi_change <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHorseTempiChange);
	}

	function onUpdate( _properties )
	{
		_properties.RangedDefenseMult *= 1.25;
	}

});

