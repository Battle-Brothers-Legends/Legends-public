::mods_hookExactClass("skills/racial/ghost_racial", function (o) {
	o.m.IsWicht <- false;

	o.onUpdate <- function (_properties) {
		_properties.DamageReceivedDirectMult *= 0.00; // ghosts don't have armor so this doesn't matter for regular ghosts, just ghost armor/wichts
		_properties.IsResistantToAnyStatuses = true; // not 100% on both of these properties but should make them highly resistant to debuffs
		_properties.IsResistantToPhysicalStatuses = true;
	}

	local onBeingAttacked = o.onBeingAttacked;
	o.onBeingAttacked = function (_attacker, _skill, _properties) {
		if (this.m.IsWicht) {
			return; // turn off the ranged dodge stuff for wichts
			onBeingAttacked(_attacker, _skill, _properties);
		}
	}

	o.onBeforeDamageReceived <- function (_attacker, _skill, _hitInfo, _properties) {
		if (_attacker != null
			&& _attacker.getID() == this.getContainer().getActor().getID()
			|| _skill == null
			|| !_skill.isAttack()
			|| !_skill.isUsingHitchance()
			|| _skill.getID != ::Legends.Effects.getID(::Legends.Effect.LegendConsecratedEffect))
		{
			return;
		}

		_hitInfo.DamageDirect = 0;
		if (_skill.getID != ::Legends.Effects.getID(::Legends.Effect.LegendConsecratedEffect))
			_hitInfo.DamageMinimum = 0;
	}
});
