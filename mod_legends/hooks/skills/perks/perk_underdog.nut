::mods_hookExactClass("skills/perks/perk_underdog", function(o) {
	o.m.Stacks <- 0;
	o.m.Frame <- 0;
	o.m.SkillCount <- 0;

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Icon = "ui/perks/perk_60.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk | this.Const.SkillType.StatusEffect;
	}

	o.isBonusActive <- function ()
	{
		return this.m.Stacks != 0;
	}

	o.getDescription <- function ()
	{
		return "This character is used to getting underestimated so it\'s just a matter before they strike back. Gains an additional [color=%positive%]+" + this.m.Stacks * 5 + "%[/color] chance to hit on the next attack.";
	}

	o.onTargetHit <- function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity != null && this.isKindOf(_targetEntity, "actor"))
		{
			local dirty = this.m.Stacks != 0;
			this.m.Stacks = 0;
			this.m.Frame = 0;
			this.m.SkillCount = 0;
			this.m.IsHidden = true;

			if (dirty)
			{
				this.getContainer().getActor().setDirty(true);
			}
		}
	}

	o.onTargetMissed <- function ( _skill, _targetEntity )
	{
		if (_targetEntity != null && this.isKindOf(_targetEntity, "actor"))
		{
			local dirty = this.m.Stacks != 0;
			this.m.Stacks = 0;
			this.m.Frame = 0;
			this.m.SkillCount = 0;
			this.m.IsHidden = true;

			if (dirty)
			{
				this.getContainer().getActor().setDirty(true);
			}
		}
	}

	o.onCombatStarted <- function ()
	{
		this.m.Stacks = 0;
		this.m.Frame = 0;
		this.m.SkillCount = 0;
		this.m.IsHidden = true;
	}

	o.onCombatFinished <- function ()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
		this.m.Frame = 0;
		this.m.SkillCount = 0;
		this.m.IsHidden = true;
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (this.m.Stacks != 0 && _skill.isAttack())
		{
			local bonus = this.m.Stacks * 5;
			_properties.MeleeSkill += bonus;
			_properties.RangedSkill += bonus;
			if (!_skill.isUsingHitchance())
				return;
			if (!_skill.isRanged())
			{
				_skill.m.HitChanceBonus += bonus;
			}
			else if (_skill.isRanged())
			{
				if (::MSU.isIn("AdditionalAccuracy", _skill.m, true)) {
					_skill.m.AdditionalAccuracy += bonus;
				} else {
					::logError("AdditionalAccuracy not found in skill")
				}
			}
		}
	}

	o.onUpdate = function ( _properties )
	{
		this.m.IsHidden = this.m.Stacks == 0;
		if (!this.getContainer().hasPerk(::Legends.Perk.LegendBattleheart))
		{
			_properties.SurroundedDefense += 5;
		}
	}

	o.onMissed <- function ( _attacker, _skill )
	{
		this.m.Stacks += 1;
	}
});
