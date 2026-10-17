this.legend_redback_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRedbackPotion);
		this.m.Description = "tbd";
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function getTooltip() {
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Attacks always apply redback poison, dealing 55 damage over 10 turns"
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations will cause a longer period of sickness"
			}
		];
		return ret;
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (_skill != this) {
			return;
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

		this.spawnIcon("status_effect_54", _targetEntity.getTile());
		local poison = ::Legends.Effects.get(_targetEntity, ::Legends.Effect.LegendRedbackSpiderPoison);
		if (poison == null) {
			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendRedbackSpiderPoison, function (_effect) {
				local actor = this.getContainer().getActor();
				if (actor.getFaction() == ::Const.Faction.Player) {
					_effect.setActor(actor);
				}
			}.bindenv(this));
		} else {
			poison.resetTime();
		}
	}

	function onDeath(_fatalityType) {
		if (_fatalityType != ::Const.FatalityType.Unconscious) {
			::World.Statistics.getFlags().set("isRedbackPotionAcquired", false);
		}
	}

	function onDismiss() {
		::World.Statistics.getFlags().set("isRedbackPotionAcquired", false);
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "Attacks apply Redback Poison";
	}
});
