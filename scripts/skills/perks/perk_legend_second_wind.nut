this.perk_legend_second_wind <- this.inherit("scripts/skills/skill", {
	m = {
		IsHitEligible = false
	},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSecondWind);
	}

	function onDamageReceived(_attacker, _damageHitpoints, _damageArmor) {
		this.m.IsHitEligible = _damageHitpoints > 0;
	}

	function onAfterDamageReceived() {
		local actor = this.getContainer().getActor();
		if (::Tactical.isActive() && actor.isPlacedOnMap() && !::Legends.S.isEntityNullOrDead(actor) && this.m.IsHitEligible && !::Legends.Effects.has(actor, ::Legends.Effect.LegendSecondWind) && actor.getHitpointsPct() < 0.5) {
			::Legends.Effects.grant(actor, ::Legends.Effect.LegendSecondWind);
		}
	}

	function onAdded() {
		if (!this.m.Container.hasActive(::Legends.Active.LegendSecondWind)) {
			::Legends.Actives.grant(this, ::Legends.Active.LegendSecondWind);
		}
	}

	function onRemoved() {
		::Legends.Actives.remove(this, ::Legends.Active.LegendSecondWind);
	}
});
