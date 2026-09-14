this.legend_redback_poison_coat_effect <- this.inherit("scripts/skills/skill", {
	m = {
		AttacksLeft = 4
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRedbackPoisonCoat);
		this.m.Icon = "skills/status_effect_legend_redback_poison_coat.png";
		this.m.IconMini = "status_effect_legend_redback_poison_coat_mini";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription() {
		return "This character is using a weapon coated with concentrated redback poison. The next few hits doing at least [color=%negative%]" + ::Const.Combat.PoisonEffectMinDamage + "[/color] damage to hitpoints will apply it. Targets affected will lose hitpoints per turn equal to the poison's duration until the effect has faded.";
	}

	function getTooltip() {
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	function resetTime() {
		local actor = this.getContainer().getActor();
		if (actor.isPlacedOnMap()) {
			this.spawnIcon("status_effect_legend_redback_poison_coat", actor.getTile());
		}

		this.m.AttacksLeft = 4;
	}

	function onTargetHit (_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
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

		::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendRedbackSpiderPoison, function(_effect) {
			local actor = this.getContainer().getActor();
			if (actor.getFaction() == this.Const.Faction.Player )
				_effect.setActor(actor);
		}.bindenv(this));
	}

	function onTargetMissed(_skill, _targetEntity) {
		--this.m.AttacksLeft;

		if (this.m.AttacksLeft <= 0) {
			this.removeSelf();
		}
	}
});
