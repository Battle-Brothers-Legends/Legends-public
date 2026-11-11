this.perk_legend_underdog <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 0,
		Frame = 0,
		SkillCount = 0,
	},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendUnderdog);
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk | ::Const.SkillType.StatusEffect;
	}

	function isBonusActive () {
		return this.m.Stacks != 0;
	}

	function getDescription () {
		return "This character is used to getting underestimated so it\'s just a matter before they strike back. Gains an additional [color=%positive%]+" + this.m.Stacks * 5 + "%[/color] chance to hit on the next attack.";
	}

	function onTargetHit (_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (_targetEntity != null && this.isKindOf(_targetEntity, "actor")) {
			local dirty = this.m.Stacks != 0;
			this.m.Stacks = 0;
			this.m.Frame = 0;
			this.m.SkillCount = 0;
			this.m.IsHidden = true;

			if (dirty) {
				this.getContainer().getActor().setDirty(true);
			}
		}
	}

	function onTargetMissed (_skill, _targetEntity) {
		if (_targetEntity != null && this.isKindOf(_targetEntity, "actor")) {
			local dirty = this.m.Stacks != 0;
			this.m.Stacks = 0;
			this.m.Frame = 0;
			this.m.SkillCount = 0;
			this.m.IsHidden = true;

			if (dirty) {
				this.getContainer().getActor().setDirty(true);
			}
		}
	}

	function onCombatStarted () {
		this.m.Stacks = 0;
		this.m.Frame = 0;
		this.m.SkillCount = 0;
		this.m.IsHidden = true;
	}

	function onCombatFinished () {
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
		this.m.Frame = 0;
		this.m.SkillCount = 0;
		this.m.IsHidden = true;
	}

	function onAnySkillUsed (_skill, _targetEntity, _properties) {
		if (this.m.Stacks != 0 && _skill.isAttack()) {
			local bonus = this.m.Stacks * 10;
			_properties.MeleeSkill += bonus;
			_properties.RangedSkill += bonus;
			if (!_skill.isUsingHitchance()) {
				return;
			}
			_skill.m.HitChanceBonus += bonus;
		}
	}

	function onMissed (_attacker, _skill) {
		this.m.Stacks += 1;
	}

	function getActorHoverTooltip (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + this.m.Stacks * 5 + "[/color] chance to hit";
	}
});
