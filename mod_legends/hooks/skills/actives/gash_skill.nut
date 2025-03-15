::mods_hookExactClass("skills/actives/gash_skill", function(o)
{
	o.getTooltip = function ()
	{
		return this.getDefaultTooltip();
	}

	local onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		onAnySkillUsed( _skill, _targetEntity, _properties );
		if (_skill == this)
		{
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
			{
				_properties.MeleeSkill += 5;
				this.m.HitChanceBonus += 5;
				_properties.ThresholdToInflictInjuryMult *= 0.5;
			}
			else
			{
				_properties.ThresholdToInflictInjuryMult *= 0.66;
			}
		}
	}

	o.onBeforeTargetHit = function ( _skill, _targetEntity, _hitInfo )
	{
		if (_skill == this)
		{
			if (_targetEntity.isAlive() && !_targetEntity.getCurrentProperties().IsImmuneToBleeding)
			{
				this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
			}
		}
	}
});
