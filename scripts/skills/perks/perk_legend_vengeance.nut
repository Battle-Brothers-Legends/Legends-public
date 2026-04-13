this.perk_legend_vengeance <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendVengeance);
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		local actor = this.getContainer().getActor();

		if (_attacker != null && !_attacker.isAlliedWith(actor) && !actor.getSkills().hasEffect(::Legends.Effect.LegendVengeance))
		{
			::Legends.Effects.grant(actor, ::Legends.Effect.LegendVengeance);
		}
	}

	function onOtherActorDeath( _killer, _victim, _skill, _deathTile, _corpseTile, _fatalityType )
	{
		local actor = this.getContainer().getActor();
		if (_victim.getFaction() == actor.getFaction())
			::Legends.Effects.grant(actor, ::Legends.Effect.LegendVengeance);
		if (_victim.getFaction() == this.Const.Faction.PlayerAnimals && actor.getFaction() == this.Const.Faction.Player)
			::Legends.Effects.grant(actor, ::Legends.Effect.LegendVengeance);
	}

});

