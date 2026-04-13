::mods_hookExactClass("items/weapons/ancient/warscythe", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver | this.Const.Items.WeaponType.Polearm;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.setCategories("Cleaver/Polearm, Two-Handed");
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Strike))
		{
			::Legends.Actives.grant(this.weapon, ::Legends.Active.Cleave, function (_skill)
			{
				_skill.m.IsScytheCleave = true;
			}.bindenv(this));
			return;
		}

		weapon.addSkill(_skill);
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Decapitate, function (_skill) {
			_skill.m.IsScytheDecapitate = true;
		}.bindenv(this));
	}
});
