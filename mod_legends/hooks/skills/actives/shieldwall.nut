::mods_hookExactClass("skills/actives/shieldwall", function(o)
{
	o.isUsable = function ()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}
		if (this.getContainer().hasSkill("effects.legend_fortify"))
		{
			return false;
		}
		if (this.getContainer().hasSkill("effects.legend_safeguarding"))
		{
			return false;
		}
		if (this.getContainer().hasSkill("effects.shieldwall"))
		{
			return false;
		}
		return true;
	}

	o.onVerifyTarget = function ( _originTile, _targetTile )
	{
		return true;
	}

	o.onAfterUpdate = function ( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInShields || _properties.IsProficientWithShieldWall || _properties.IsProficientWithShieldSkills ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

});
