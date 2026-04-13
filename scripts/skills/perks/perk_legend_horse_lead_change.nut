this.perk_legend_horse_lead_change <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHorseLeadChange);
	}

	function onUpdate( _properties )
	{
		_properties.MovementFatigueCostMult *= 0.75;
	}

});

