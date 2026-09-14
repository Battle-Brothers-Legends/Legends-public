this.perk_legend_horse_collection <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHorseCollection);
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local maxFat = actor.getFatigueMax();
		local currentFat = actor.getFatigue();
		local ratio = currentFat / maxFat;

		if (ratio > 0.9)
		{
			_properties.FatigueRecoveryRate += 5;
		}
	}

});

