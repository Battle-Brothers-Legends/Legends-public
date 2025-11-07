this.perk_legend_terrifying_visage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendTerrifyingVisage);
	}

	function onUpdate( _properties )
	{

	_properties.Threat += 15;

	}

});

