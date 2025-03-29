::mods_hookExactClass("skills/actives/hand_to_hand_orc", function(o)
{
	local onUpdate = o.onUpdate;
	o.onUpdate = function( _properties )
	{
		onUpdate( _properties );
		if (this.isUsable())
		{
			//Untested fix, theoretically should fix being disarmed and getting extra weapon damage
			local mhand = this.getContainer().getActor().getMainhandItem();
			if (mhand != null)
			{
				_properties.DamageRegularMin -= mhand.m.RegularDamage;
				_properties.DamageRegularMax -= mhand.m.RegularDamageMax;
			}
		}
	}
});
