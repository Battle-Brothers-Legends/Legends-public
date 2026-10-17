::mods_hookExactClass("skills/effects/bleeding_effect", function (o) {
	o.m.Actor <- null;

	o.getDescription = function () {
		return "Bleeding profusely from a recently received wound.";
	}

	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "[color=%negative%]" + this.getDamage() + "[/color] Hitpoints Damage Received every turn"
			}
		]);
		return tooltip;
	}

	o.getDamage = function () {
		return this.m.Damage * (this.getContainer().getActor().getSkills().hasEffect(::Legends.Effect.HyenaPotion) ? 0.5 : 1.0);
	}

	o.setActor <- function (_a) {
		this.m.Actor = ::MSU.asWeakTableRef(_a);
	}

	o.applyDamage = function () {
		if (this.m.LastRoundApplied != ::Time.getRound()) {
			this.m.LastRoundApplied = ::Time.getRound();
			local actor = this.getContainer().getActor();
			this.spawnIcon("status_effect_01", actor.getTile());
			local hitInfo = clone ::Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.getDamage();
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = ::Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			actor.onDamageReceived(this.getEffectOwner(), this, hitInfo);

			if (--this.m.TurnsLeft <= 0) {
				this.removeSelf();
			}
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]" + (this.getDamage() * _stacks) + "[/color] " + ::Legends.S.inlineIcon("damage_received") + " every turn";
	}
});
