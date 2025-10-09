::mods_hookExactClass("skills/perks/perk_reach_advantage", function(o) {
	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _properties )
	{
		onUpdate(_properties);
		local actor = this.getContainer().getActor();
		if (actor.getMainhandItem() == null || !actor.getMainhandItem().isWeaponType(this.Const.Items.WeaponType.Staff))
			return;
		if (_properties.IsImmuneToSurrounding == true || actor.getSkills().hasPerk(::Legends.Perk.Underdog))
		{
			_properties.MeleeDefense += 5;
			_properties.RangedDefense += 5;
		}
		else
		{
			_properties.SurroundedDefense += 5;
		}
	}
});