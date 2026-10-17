this.legend_redback_poison_coat_effect <- this.inherit("scripts/skills/skill", {
	m = {
		AttacksLeft = 4
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRedbackPoisonCoat);
		this.m.Description = "This character is using a weapon coated with concentrated redback poison.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Next [color=%positive%]" + this.m.AttacksLeft + "[/color] apply Redback Poison"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Attacks need to deal at least " + ::Const.Combat.PoisonEffectMinDamage + " to Health"
			}
			/*{ redback psn effect here after its changed
				id = 13,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = ""
			}*/
		]);
		return tooltip;
	}

	function resetTime() {
		local actor = this.getContainer().getActor();
		if (actor.isPlacedOnMap()) {
			this.spawnIcon("status_effect_54", actor.getTile());
		}

		this.m.AttacksLeft = 4;
	}

	function onAdded() {
		if (::Legends.Perks.has(this.getContainer().getActor(), ::Legends.Perk.LegendPoisoner)) {
			this.m.AttacksLeft += 2;
		}
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
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

		::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendRedbackSpiderPoison, function (_effect) {
			local actor = this.getContainer().getActor();
			if (actor.getFaction() == ::Const.Faction.Player) {
				_effect.setActor(actor);
			}
		}.bindenv(this));
	}

	function onTargetMissed(_skill, _targetEntity) {
		--this.m.AttacksLeft;

		if (this.m.AttacksLeft <= 0) {
			this.removeSelf();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + this.m.AttacksLeft + "[/color] " + " next attacks apply Redback Poison";
	}
});
