this.perk_legend_lionheart <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendLionheart);
	}

	function onUpdate( _properties )
	{
		_properties.IsAffectedByMovementMorale = false;
		_properties.BraveryMult *= 1.10;
	}

});
