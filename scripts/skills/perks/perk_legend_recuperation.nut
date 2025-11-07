this.perk_legend_recuperation <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendRecuperation);
	}


	function onUpdate(_properties)
	{
		_properties.AdditionalHealingDays -= 1;
	}

	function onCombatFinished()
	{
		local actor = this.getContainer().getActor();
		if (actor.isAlive() && actor.getHitpointsPct() < 1.0)
		{
			local hp = ::Math.floor((actor.getHitpointsMax() - actor.getHitpoints()) * 0.3);
			actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), hp + actor.getHitpoints()));
			actor.setDirty(true);
		}
	}
});

