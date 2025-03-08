::mods_hookExactClass("skills/effects/riposte_effect", function(o) {
	
	o.getDescription = function()
	{
		return "This character is prepared to immediately counter-attack on any failed attempt to attack them in melee.";
	}

	local onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (this.getContainer().getActor().getMainhandItem().isWeaponType(this.Const.Items.WeaponType.Staff))
		{
			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInStaves)
			{
				_properties.MeleeSkill -= 10;
			}
		}
		else
		{
			onAnySkillUsed( _skill, _targetEntity, _properties );
		}
	}
});