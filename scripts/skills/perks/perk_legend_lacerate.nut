this.perk_legend_lacerate <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendLacerate);
		this.m.SoundOnHitHitpoints = ::Legends.S.setSounds("sounds/combat/cleave_hit_hitpoints", 3);
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (::Legends.S.isEntityNullOrDead(_targetEntity)) {
			return false;
		}

		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding) {
			return false;
		}

		if (_targetEntity.isNonCombatant()) {
			return false;
		}

		::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendGrazedEffect, function (_effect) {
			_effect.setActor(this.getContainer().getActor());
		}.bindenv(this));

		local user = _skill.getContainer().getActor();
		if (!user.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " lacerated " + this.Const.UI.getColorizedEntityName(_targetEntity) + " leaving them grazed");
		}

		return true;

	}

});
