::mods_hookExactClass("skills/effects/acid_effect", function(o) {
	o.applyDamage = function ()
	{
		if (this.m.LastRoundApplied != this.Time.getRound())
		{
			this.m.LastRoundApplied = this.Time.getRound();
			local actor = this.getContainer().getActor();
			local head_affected = !actor.getFlags().has("head_immune_to_acid");
			local body_affected = !actor.getFlags().has("body_immune_to_acid");
			local damage_applied = false;
			this.spawnIcon("status_effect_78", actor.getTile());

			if (head_affected)
			{
				local damage = actor.getArmor(::Const.BodyPart.Head) * 0.2;

				if (this.isKindOf(actor.get(), "kraken"))
				{
					damage = damage * 0.5;
				}

				local hitInfo = clone ::Const.Tactical.HitInfo;
				hitInfo.DamageRegular = 0.0;
				hitInfo.DamageArmor = damage * 0.2;
				hitInfo.DamageDirect = 0.0;
				hitInfo.BodyPart = ::Const.BodyPart.Head;
				hitInfo.BodyDamageMult = 1.0;
				hitInfo.FatalityChanceMult = 0.0;

				if (hitInfo.DamageArmor > 0)
				{
					damage_applied = true;
				}

				this.getContainer().getActor().onDamageReceived(this.getContainer().getActor(), this, hitInfo);
			}

			if (body_affected)
			{
				local damage = actor.getArmor(::Const.BodyPart.Body) * 0.2;

				if (this.isKindOf(actor.get(), "kraken"))
				{
					damage = damage * 0.5;
				}

				local hitInfo = clone ::Const.Tactical.HitInfo;
				hitInfo.DamageRegular = 0.0;
				hitInfo.DamageArmor = damage;
				hitInfo.DamageDirect = 0.0;
				hitInfo.BodyPart = ::Const.BodyPart.Body;
				hitInfo.BodyDamageMult = 1.0;
				hitInfo.FatalityChanceMult = 0.0;

				if (hitInfo.DamageArmor > 0)
				{
					damage_applied = true;
				}

				this.getContainer().getActor().onDamageReceived(this.getContainer().getActor(), this, hitInfo);
			}

			if (damage_applied && !actor.isHiddenToPlayer())
			{
				if (this.m.SoundOnUse.len() != 0)
				{
					::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.2, actor.getPos());
				}

				for( local i = 0; i < ::Const.Tactical.AcidParticles.len(); i = ++i )
				{
					::Tactical.spawnParticleEffect(true, ::Const.Tactical.AcidParticles[i].Brushes, this.getContainer().getActor().getTile(), ::Const.Tactical.AcidParticles[i].Delay, ::Const.Tactical.AcidParticles[i].Quantity, ::Const.Tactical.AcidParticles[i].LifeTimeQuantity, ::Const.Tactical.AcidParticles[i].SpawnRate, ::Const.Tactical.AcidParticles[i].Stages);
				}
			}

			if (--this.m.TurnsLeft <= 0)
			{
				this.removeSelf();
			}
		}
	}
});