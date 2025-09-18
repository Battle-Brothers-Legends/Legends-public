::mods_hookExactClass("skills/perks/perk_head_hunter", function(o) {
	o.m.HeadHitChance <- 0;
	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_bodyPart == this.Const.BodyPart.Head)
		{
			if (this.m.Stacks == 0 && this.m.SkillCount != this.Const.SkillCounter)
			{
				this.m.Stacks = 1;
				this.m.SkillCount = this.Const.SkillCounter;
			}
			else if (this.m.Stacks == 1 && this.m.HeadHitChance > 50 && this.Math.rand(1, 100) <= (this.m.HeadHitChance - 50))
			{
				this.Tactical.EventLog.logEx("Head Hunter is refreshed");
				this.m.Stacks = 1;
				this.m.SkillCount = this.Const.SkillCounter;
			}
			else
			{
				this.m.Stacks = 0;
			}

			this.getContainer().getActor().setDirty(true);
		}
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		this.m.HeadHitChance = _properties.HitChance[this.Const.BodyPart.Head];
	}
});
