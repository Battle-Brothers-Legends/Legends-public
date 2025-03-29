::mods_hookExactClass("skills/racial/serpent_racial", function(o)
{
	o.onBeforeDamageReceived = function ( _attacker, _skill, _hitInfo, _properties )
	{
		if (_hitInfo.DamageType == this.Const.Damage.DamageType.Burning)
		{
			_properties.DamageReceivedRegularMult *= 0.66;
		}
	}
});
