::mods_hookExactClass("skills/effects/spider_poison_effect", function (o) {
	o.m.Actor <- null;

	o.getDescription = function () {
		return "Has a vicious poison running through %their% veins.";
	}

	o.getDamage = function () {
		return this.m.Damage * (::Legends.isLegendaryDifficulty() ? 2 : 1);
	}

	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "[color=%negative%]" + this.getDamage() + "[/color] Hitpoints Damage Received every turn"
			}
		]);
		return tooltip;
	}

	o.setActor <- function (_a) {
		this.m.Actor = ::MSU.asWeakTableRef(_a);
	}

	o.applyDamage = function () {
		if (this.m.LastRoundApplied != ::Time.getRound()) {
			local actor = this.getContainer().getActor();
			this.m.LastRoundApplied = ::Time.getRound();
			this.spawnIcon("status_effect_54", actor.getTile());

			if (actor.getCurrentProperties().IsImmuneToPoison) {
				return;
			}

			if (this.m.SoundOnUse.len() != 0) {
				::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.0, actor.getPos());
			}

			local hitInfo = clone ::Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.getDamage();
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = ::Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			actor.onDamageReceived(this.getEffectOwner(), this, hitInfo);
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]" + this.getDamage() + "[/color] " + ::Legends.S.inlineIcon("damage_received") + " every turn";
	}
});
