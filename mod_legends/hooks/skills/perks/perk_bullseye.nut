::mods_hookExactClass("skills/perks/perk_bullseye", function(o) {
	o.onUpdate = function ( _properties )
	{
		_properties.RangedAttackBlockedChanceMult *= 0.33;
		_properties.Vision += 1;
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (_skill != null && _skill.getID().find("aimed") != null)
		{
			_properties.RangedAttackBlockedChanceMult *= 0.0;
		}
	}
});