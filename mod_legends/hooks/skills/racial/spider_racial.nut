::mods_hookExactClass("skills/racial/spider_racial", function (o) {
	o.onTargetHit = function (_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (::Legends.S.isEntityNullOrDead(_targetEntity) || _targetEntity.getCurrentProperties().IsImmuneToPoison || _damageInflictedHitpoints < this.Const.Combat.PoisonEffectMinDamage || _targetEntity.getHitpoints() <= 0) {
			return;
		}

		if (!_targetEntity.isHiddenToPlayer()) {
			if (this.m.SoundOnUse.len() != 0) {
				::Sound.play(::Legends.Array.rand(this.m.SoundOnUse), ::Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
			}
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_targetEntity) + " is poisoned");
		}
		this.spawnIcon("status_effect_54", _targetEntity.getTile());

		local poison = ::Legends.Effects.get(_targetEntity, ::Legends.Effect.SpiderPoison);

		if (poison == null) {
			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.SpiderPoison);
		} else {
			poison.resetTime();
		}
	}
});
