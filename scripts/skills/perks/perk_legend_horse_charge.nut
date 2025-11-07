this.perk_legend_horse_charge <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHorseCharge);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendHorseCharge))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendHorseCharge);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendHorseCharge);
	}

	function onUpdated( _properties )
	{
		_properties.TargetAttractionMult *= 1.33;
	}

});

