::mods_hookExactClass("skills/perks/perk_fast_adaption", function(o) {

	local onTargetHit = o.onTargetHit;
	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity != null && this.isKindOf(_targetEntity, "actor"))
		{
			local actor = this.getContainer().getActor();
			actor.setActionPoints(this.Math.min(actor.getActionPointsMax(), actor.getActionPoints() + this.Math.min(3, this.m.Stacks)));
		}

		onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor );
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (this.m.Stacks != 0 && _skill.isAttack())
		{
			local bonus = this.m.Stacks * 10;
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
});
