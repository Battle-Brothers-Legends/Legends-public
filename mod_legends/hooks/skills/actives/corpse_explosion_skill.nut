::mods_hookExactClass("skills/actives/corpse_explosion_skill", function (o) {
	o.onApply = function (_data) {
		this.spawnBloodbath(_data.TargetTile);
		local isFleshCradle = _data.TargetTile.getEntity() != null && _data.TargetTile.getEntity().getType() == ::Const.EntityType.FleshCradle && !_data.TargetTile.getEntity().getIsDestroyed();

		if (!_data.User.isHiddenToPlayer() || _data.TargetTile.IsVisibleForPlayer) {
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_data.User) + (isFleshCradle ? " causes a flesh cradle to explode!" : " causes a corpse to explode!"));

			if (this.m.SoundOnUse.len() != 0) {
				::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.Skill * 1.2, _data.User.getPos());
			}
		}

		local targets = [_data.TargetTile];
		targets.extend([0, 1, 2, 3, 4, 5].filter(@(_, _direction) _data.TargetTile.hasNextTile(_direction)).map(@(_direction) _data.TargetTile.getNextTile(_direction)));

		foreach (targetTile in targets) {
			local particles = targetTile.ID == _data.TargetTile.ID ? ::Const.Tactical.CorpseExplosionParticles : ::Const.Tactical.CorpseExplosionOuterParticles;
			for (local i = 0; i < particles.len(); i = ++i) {
				local effect = particles[i];
				::Tactical.spawnParticleEffect(false, effect.Brushes, targetTile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 0));
			}
			if (targetTile.IsOccupiedByActor) {
				local entity = targetTile.getEntity();
				if (!entity.getSkills().hasTrait(::Legends.Trait.RacialGrandDiviner) && entity.getType() != ::Const.EntityType.FleshCradle) {
					local hitInfo = clone ::Const.Tactical.HitInfo;
					hitInfo.DamageRegular = targetTile.isSameTileAs(_data.TargetTile) ? ::Math.rand(30, 60) : ::Math.rand(25, 50);
					hitInfo.DamageArmor = hitInfo.DamageRegular * 0.75;
					hitInfo.DamageDirect = 0.2;
					hitInfo.BodyPart = 0;
					hitInfo.FatalityChanceMult = 0.0;
					hitInfo.Injuries = ::Const.Injury.BurningAndPiercingBody;
					entity.onDamageReceived(null, this, hitInfo);
				}
			}

			::Tactical.State.spawnMiasmaOnTile(targetTile, _data.User);
		}
	}
});
