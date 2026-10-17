::mods_hookExactClass("skills/effects/acid_effect", function (o) {
	o.getDescription = function () {
		return "This character's armor is slowly being eaten away by acid.";
	}

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		local flags = this.getContainer().getActor().getFlags();
		if (!flags.has("head_immune_to_acid")) {
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/armor_head.png",
				text = "[color=%negative%]20%[/color] of head armor is lost each turn"
			});
		}
		if (!flags.has("body_immune_to_acid")) {
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = "[color=%negative%]20%[/color] of body armor is lost each turn"
			});
		}
		return tooltip;
	}

	o.applyDamage = function () {
		if (this.m.LastRoundApplied != ::Time.getRound()) {
			this.m.LastRoundApplied = ::Time.getRound();
			local actor = this.getContainer().getActor();
			local head_affected = !actor.getFlags().has("head_immune_to_acid");
			local body_affected = !actor.getFlags().has("body_immune_to_acid");
			local damage_applied = false;
			this.spawnIcon("status_effect_78", actor.getTile());

			if (head_affected) {
				local damage = actor.getArmor(::Const.BodyPart.Head) * 0.2;

				if (this.isKindOf(actor.get(), "kraken")) {
					damage = damage * 0.5;
				}

				local hitInfo = clone ::Const.Tactical.HitInfo;
				hitInfo.DamageRegular = 0.0;
				hitInfo.DamageArmor = damage * 0.2;
				hitInfo.DamageDirect = 0.0;
				hitInfo.BodyPart = ::Const.BodyPart.Head;
				hitInfo.BodyDamageMult = 1.0;
				hitInfo.FatalityChanceMult = 0.0;

				if (hitInfo.DamageArmor > 0) {
					damage_applied = true;
				}

				this.getContainer().getActor().onDamageReceived(this.getContainer().getActor(), this, hitInfo);
			}

			if (body_affected) {
				local damage = actor.getArmor(::Const.BodyPart.Body) * 0.2;

				if (this.isKindOf(actor.get(), "kraken")) {
					damage *= 0.5;
				}

				local hitInfo = clone ::Const.Tactical.HitInfo;
				hitInfo.DamageRegular = 0.0;
				hitInfo.DamageArmor = damage;
				hitInfo.DamageDirect = 0.0;
				hitInfo.BodyPart = ::Const.BodyPart.Body;
				hitInfo.BodyDamageMult = 1.0;
				hitInfo.FatalityChanceMult = 0.0;

				if (hitInfo.DamageArmor > 0) {
					damage_applied = true;
				}

				this.getContainer().getActor().onDamageReceived(this.getContainer().getActor(), this, hitInfo);
			}

			if (damage_applied && !actor.isHiddenToPlayer()) {
				if (this.m.SoundOnUse.len() != 0) {
					::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.2, actor.getPos());
				}

				for (local i = 0; i < ::Const.Tactical.AcidParticles.len(); i++) {
					::Tactical.spawnParticleEffect(true, ::Const.Tactical.AcidParticles[i].Brushes, this.getContainer().getActor().getTile(), ::Const.Tactical.AcidParticles[i].Delay, ::Const.Tactical.AcidParticles[i].Quantity, ::Const.Tactical.AcidParticles[i].LifeTimeQuantity, ::Const.Tactical.AcidParticles[i].SpawnRate, ::Const.Tactical.AcidParticles[i].Stages);
				}
			}

			if (--this.m.TurnsLeft <= 0) {
				this.removeSelf();
			}
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		local damage = this.isKindOf(this.getContainer().getActor().get(), "kraken") ? 10 : 20;
		local flags = this.getContainer().getActor().getFlags();
		local icons = "" + (!flags.has("body_immune_to_acid") ? ::Legends.S.inlineIcon("armor_body") : "") + (!flags.has("head_immune_to_acid") ? ::Legends.S.inlineIcon("armor_head") : "");
		return "[color=%negative%]-" + (damage * _stacks) + "%[/color] " + icons + " every turn";
	}
});
