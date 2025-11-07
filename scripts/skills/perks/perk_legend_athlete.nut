this.perk_legend_athlete <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendAthlete);
	}

	function onUpdate(_properties)
	{
		_properties.FatigueEffectMult *= 1.0 - 0.002 * this.getContainer().getActor().getFatigueMax();
	}

});

