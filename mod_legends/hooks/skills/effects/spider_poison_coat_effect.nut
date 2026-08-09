::mods_hookExactClass("skills/effects/spider_poison_coat_effect", function (o) {
	o.onTargetHit = function (_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		--this.m.AttacksLeft;

		if (this.m.AttacksLeft <= 0) {
			this.removeSelf();
		}

		if (!_targetEntity.isAlive() || _targetEntity.getCurrentProperties().IsImmuneToPoison || _damageInflictedHitpoints < this.Const.Combat.PoisonEffectMinDamage || _targetEntity.getHitpoints() <= 0 || _targetEntity.getFlags().has("undead")) {
			return;
		}

		if (!_targetEntity.isHiddenToPlayer()) {
			if (this.m.SoundOnUse.len() != 0) {
				::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
			}

			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_targetEntity) + " is poisoned");
		}

		::Legends.Effects.grant(_targetEntity, ::Legends.Effect.SpiderPoison, function (_effect) {
			local actor = this.getContainer().getActor();
			if (actor.getFaction() == ::Const.Faction.Player) {
				_effect.setActor(actor);
			}
			_effect.setDamage(10);
		}.bindenv(this));
	}
});
