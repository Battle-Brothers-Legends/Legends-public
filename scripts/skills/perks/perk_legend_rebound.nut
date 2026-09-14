this.perk_legend_rebound <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendRebound);
	}

	function onUpdate( _properties )
	{
		_properties.FatigueRecoveryRate += this.Math.ceil(0.1 * this.getContainer().getActor().getFatigue());
	}

});

