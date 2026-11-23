::mods_hookExactClass("skills/racial/ghost_racial", function (o) {
	o.m.IsWicht <- false;

	o.onUpdate <- function (_properties) {
		_properties.DamageReceivedDirectMult *= 0.00; // ghosts don't have armor so this doesn't matter for regular ghosts, just ghost armor/wichts
		_properties.IsResistantToAnyStatuses = true; // not 100% on both of these properties but should make them highly resistant to debuffs
		_properties.IsResistantToPhysicalStatuses = true;
		if (this.getContainer().hasPerk(::Legends.Perk.BattleForged) && (this.getContainer().hasEffect(::Legends.Effect.LegendConsecratedEffect) || this.getContainer().hasEffect(::Legends.Effect.HolyWater)))
			::Legends.Perks.remove(this.getContainer(), ::Legends.Perk.BattleForged);
	}

	local onBeingAttacked = o.onBeingAttacked;
	o.onBeingAttacked = function (_attacker, _skill, _properties) {
		if (this.m.IsWicht) {
			return; // turn off the ranged dodge stuff for wichts
			onBeingAttacked(_attacker, _skill, _properties);
		}
	}

	o.onBeforeDamageReceived <- function (_attacker, _skill, _hitInfo, _properties) {
		_hitInfo.DamageDirect = 0;
		_hitInfo.DamageMinimum = 0;
	}
});
