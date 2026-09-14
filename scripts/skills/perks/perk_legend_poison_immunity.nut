this.perk_legend_poison_immunity <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPoisonImmunity);
	}

	function onUpdate( _properties )
	{
		_properties.IsImmuneToPoison = true;
	}

});
