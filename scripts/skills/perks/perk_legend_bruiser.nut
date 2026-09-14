this.perk_legend_bruiser <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBruiser);
	}

	function onUpdate( _properties )
	{
		_properties.DamageArmorMult += 0.1;
	}

});


