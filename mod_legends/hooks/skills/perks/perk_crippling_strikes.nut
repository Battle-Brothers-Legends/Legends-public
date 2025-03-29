::mods_hookExactClass("skills/perks/perk_crippling_strikes", function(o) {
	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		if (!_targetEntity.m.BaseProperties.IsAffectedByInjuries)
		{
			_properties.DamageTotalMult *= 1.1;
		}
	}
});