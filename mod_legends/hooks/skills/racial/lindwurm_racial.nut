::mods_hookExactClass("skills/racial/lindwurm_racial", function(o)
{	
	o.onBeforeDamageReceived <- function ( _attacker, _skill, _hitInfo, _properties )
	{
		switch (_hitInfo.DamageType)
		{
			case this.Const.Damage.DamageType.Piercing:
				_properties.DamageReceivedRegularMult *= 1.3;
				break;
			case this.Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 0.5;
				break;
			case ::Const.Damage.DamageType.Cutting:
				_properties.DamageReceivedRegularMult *= 0.75;
				break;
			case ::Const.Damage.DamageType.Blunt:
				_properties.DamageReceivedRegularMult *= 0.75;
				break;
		}
	}
});
