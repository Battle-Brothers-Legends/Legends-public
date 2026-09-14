this.perk_legend_composure <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendComposure);
	}

	function onUpdate( _properties )
	{
		_properties.IsImmuneToStun = true;
	}

});
