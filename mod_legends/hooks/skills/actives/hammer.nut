::mods_hookExactClass("skills/actives/hammer", function(o)
{
	o.getTooltip = function ()
	{
		return this.getDefaultTooltip();
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageMinimum += 10;
		}
	}
});
