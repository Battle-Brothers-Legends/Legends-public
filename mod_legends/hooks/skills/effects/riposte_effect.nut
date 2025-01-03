::mods_hookExactClass("skills/effects/riposte_effect", function(o) {
	
	o.getDescription = function()
	{
		return "This character is prepared to immediately counter-attack on any failed attempt to attack them in melee.";
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		local properties = this.getContainer().getActor().getCurrentProperties();
		if (this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() != this.getContainer().getActor().getID())
		{
			if (!properties.IsSpecializedInSwords)
			{
				_properties.MeleeSkill -= 10;
			}
		}
	}
});