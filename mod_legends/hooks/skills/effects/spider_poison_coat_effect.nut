::mods_hookExactClass("skills/effects/spider_poison_coat_effect", function (o) {
	o.getDescription = function () {
		return "This character's weapon is coated with concentrated webknecht poison.";
	}

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Next [color=%positive%]" + this.m.AttacksLeft + "[/color] dealing at least " + ::Const.Combat.PoisonEffectMinDamage + " to Health apply webknecht Poison"
			},
		]);
		return tooltip;
	}

	o.onAdded <- function () {
		if (::Legends.Perks.has(this.getContainer().getActor(), ::Legends.Perk.LegendPoisoner)) {
			this.m.AttacksLeft += 2;
		}
	}

	o.onTargetHit = function (_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (--this.m.AttacksLeft <= 0) {
			this.removeSelf();
		}

		if (!_targetEntity.isAlive() || _targetEntity.getCurrentProperties().IsImmuneToPoison || _damageInflictedHitpoints < ::Const.Combat.PoisonEffectMinDamage || _targetEntity.getHitpoints() <= 0 || _targetEntity.getFlags().has("undead")) {
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

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + this.m.AttacksLeft + "[/color] " + " next attacks apply webknecht Poison";
	}
});
