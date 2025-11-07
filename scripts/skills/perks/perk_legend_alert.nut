this.perk_legend_alert <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendAlert);
	}

	function onUpdate( _properties )
	{
		_properties.InitiativeMult *= 1.2;
	}

});

