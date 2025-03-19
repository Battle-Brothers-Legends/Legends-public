::mods_hookExactClass("skills/racial/vampire_racial", function(o)
{
	o.onBeforeDamageReceived <- function( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill != null)
		{
			local weapon = _skill.getItem();
			if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.Weapon))
			{

				if (weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow))
				{
					_properties.DamageReceivedRegularMult *= 1.2;
				}
				if (weapon.getID() == "weapon.goblin_crossbow")
				{
					_properties.DamageReceivedRegularMult *= 2.0;
				}
				if (weapon.getID() == "weapon.legend_wooden_stake")
				{
					_properties.DamageReceivedRegularMult *= 10.0;
				}
				if (weapon.getID() == "weapon.legend_wooden_spear")
				{
					_properties.DamageReceivedRegularMult *= 5.0;
				}
			}
		}

	local onTargetHit = o.onTargetHit;
	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity.isAlive() && !_targetEntity.isDying() && !_targetEntity.getCurrentProperties().IsImmuneToBleeding)
		{
			return;
		}
		onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);
	}
});
