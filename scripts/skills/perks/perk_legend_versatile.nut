this.perk_legend_versatile <- this.inherit("scripts/skills/skill", {
	m = {
		MeleeStacks = 0,
		RangedStacks = 0,
		SkillCount = 0,
		Bonus = 10
	},
	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendVersatile);
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk | ::Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function getTooltip() {
		local ret = [{
			id = 1,
			type = "title",
			text = this.getName()
		},
		{
			id = 2,
			type = "description",
			text = this.getDescription()
		}];

		if (this.m.RangedStacks > 0) {
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]+" + (this.m.RangedStacks * 10) + "%[/color] Ranged Damage"
			});
		}
		if (this.m.MeleeStacks > 0) {
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]+" + (this.m.MeleeStacks * 10) + "%[/color] Melee Damage"
			});
		}
		return ret;
	}

	function getDescription() {
		return "Oftentimes better than a master of one."
	}

	function onCombatStarted() {
		this.m.MeleeStacks = 0;
		this.m.RangedStacks = 0;
		this.m.SkillCount = 0;
	}

	function onCombatFinished() {
		this.skill.onCombatFinished();
		this.m.MeleeStacks = 0;
		this.m.RangedStacks = 0;
		this.m.IsHidden = true;
	}

	function incrementMeleeStacks() {
		if (this.m.MeleeStacks < 3) this.m.MeleeStacks += 1;
	}

	function decrementMeleeStacks() {
		if (this.m.MeleeStacks > 0) this.m.MeleeStacks -= 1;
	}

	function incrementRangedStacks() {
		if (this.m.RangedStacks < 3) this.m.RangedStacks += 1;
	}

	function decrementRangedStacks() {
		if (this.m.RangedStacks > 0) this.m.RangedStacks -= 1;
	}

	function onUpdate(_properties) {
		local baseProperties = this.getContainer().getActor().getBaseProperties();
		local fraction = this.m.Bonus * 0.01;

		_properties.MeleeSkill += ::Math.floor(baseProperties.getRangedSkill() * fraction);
		_properties.RangedSkill += ::Math.floor(baseProperties.getMeleeSkill() * fraction);

		this.m.IsHidden = this.m.MeleeStacks == 0 && this.m.RangedStacks == 0;
		if (this.m.MeleeStacks > 0) {
			_properties.MeleeDamageMult *= (this.m.MeleeStacks * 0.10 + 1.00);
		}

		if (this.m.RangedStacks > 0) {
			_properties.RangedDamageMult *= (this.m.RangedStacks * 0.10 + 1.00);
		}
	}

	function onTargetMissed( _skill, _targetEntity ) {
		if (this.m.MeleeStacks != 0 && this.m.RangedStacks != 0 && this.m.SkillCount != ::Const.SkillCounter) {
			this.m.SkillCount = ::Const.SkillCounter;
			if (_skill.isRanged() && this.m.SkillCount != ::Const.SkillCounter) {
				this.decrementRangedStacks();
			}
			else if (!_skill.isRanged() && this.m.SkillCount != ::Const.SkillCounter) {
				this.decrementMeleeStacks();
			}
			if (this.m.MeleeStacks != 0 && this.m.RangedStacks != 0) {
				this.getContainer().getActor().setDirty(true);
			}
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor ) {
		if (_skill == null) {
			return;
		}

		if (!_skill.isAttack()) {
			return;
		}

		if (_skill.isRanged() && this.m.SkillCount != ::Const.SkillCounter) {
			this.incrementMeleeStacks();
			this.decrementRangedStacks();
			this.m.SkillCount = ::Const.SkillCounter;
		}
		else if (!_skill.isRanged() && this.m.SkillCount != ::Const.SkillCounter) {
			this.incrementRangedStacks();
			this.decrementMeleeStacks();
			this.m.SkillCount = ::Const.SkillCounter;
		}

		this.getContainer().getActor().setDirty(true);
	}
});
