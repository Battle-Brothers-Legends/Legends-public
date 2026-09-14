this.perk_legend_second_wind <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSecondWind);
	}

	function onDamageReceived ( _attacker, _damageHitpoints, _damageArmor )
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
			return;

		if (_damageHitpoints > 0 && actor.isAlive() && !actor.isDying())
		{
			if (!actor.getSkills().hasEffect(::Legends.Effect.LegendSecondWind) && actor.getHitpointsPct() < 0.5)
			{
				::Legends.Effects.grant(actor, ::Legends.Effect.LegendSecondWind);
			}
		}
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendSecondWind))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendSecondWind);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendSecondWind);
	}
});
