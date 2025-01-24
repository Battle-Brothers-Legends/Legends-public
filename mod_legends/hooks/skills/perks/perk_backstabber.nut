::mods_hookExactClass("skills/perks/perk_backstabber", function(o) {

	o.onUpdate = function ( _properties )
	{
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
			return;

		local surroundedCount = _targetEntity.getSurroundedCount();
		if (surroundedCount > 0)
		{
			_properties.DamageRegularMult *= 1.0 + surroundedCount * 0.05;
		}

	}
});
