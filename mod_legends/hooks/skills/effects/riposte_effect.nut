::mods_hookExactClass("skills/effects/riposte_effect", function(o) {
	
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Riposting";
	}

	o.getDescription = function()
	{
		return "This character is prepared to immediately counter-attack on any failed attempt to attack them in melee.";
	}

	local onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		local actor = this.getContainer().getActor();		
		local item = actor.getMainhandItem();
		if (item != null && item.isWeaponType(this.Const.Items.WeaponType.Staff))
		{
			if (!actor.getCurrentProperties().IsSpecializedInPolearms)
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