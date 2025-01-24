::mods_hookExactClass("items/weapons/ancient/warscythe", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver | this.Const.Items.WeaponType.Polearm;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Pitchfork;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == "actives.strike")
			_skill = ::new("scripts/skills/actives/legend_scythe_cleave_skill"); // replace strike with scythe cleave

		weapon.addSkill(_skill);
	}
});
