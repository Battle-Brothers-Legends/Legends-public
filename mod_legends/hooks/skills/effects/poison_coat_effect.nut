::mods_hookExactClass("skills/effects/poison_coat_effect", function (o) {
	o.getDescription = function () {
		return "This character's weapon is coated with poison.";
	}

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Next [color=%positive%]" + this.m.AttacksLeft + "[/color] dealing at least " + ::Const.Combat.PoisonEffectMinDamage + " to Health apply Poison"
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
		--this.m.AttacksLeft;

		if (this.m.AttacksLeft <= 0) {
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

		local runePoison = ::Legends.Effects.get(_targetEntity, ::Legends.Effect.LegendRswPoisonPoison);
		local gobboPoison = ::Legends.Effects.get(_targetEntity, ::Legends.Effect.GoblinPoison);

		if (runePoison == null && gobboPoison == null) {
			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.GoblinPoison);
		} else if (runePoison != null && gobboPoison == null) {
			runePoison.resetTime();
		} else if (runePoison == null && gobboPoison != null) {
			gobboPoison.resetTime();
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + this.m.AttacksLeft + "[/color] " + " next attacks apply Poison";
	}
});
