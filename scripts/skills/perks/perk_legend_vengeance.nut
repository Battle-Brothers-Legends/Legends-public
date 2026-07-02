this.perk_legend_vengeance <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendVengeance);
	}

	function swearVengeance(_user, _condition) {
		local vengeanceEffect = ::Legends.Effects.get(_user, ::Legends.Effect.LegendVengeance);
		if (_condition) {
			if (vengeanceEffect == null) {
				::Legends.Effects.grant(_user, ::Legends.Effect.LegendVengeance);
			} else {
				vengeanceEffect.m.Stacks += 1;
			}
		}
	}

	function onBeforeDamageReceived(_attacker, _skill, _hitInfo, _properties) {
		local actor = this.getContainer().getActor();
		swearVengeance(actor, !_attacker.isAlliedWith(actor))	
	}

	function onOtherActorDeath(_killer, _victim, _skill, _deathTile, _corpseTile, _fatalityType) {
		local actor = this.getContainer().getActor();
		swearVengeance(actor, _victim.getFaction() == actor.getFaction());
		swearVengeance(actor, _victim.getFaction() == ::Const.Faction.PlayerAnimals	&& actor.getFaction() == ::Const.Faction.Player);
	}
});
