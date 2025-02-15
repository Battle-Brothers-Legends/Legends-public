::mods_hookExactClass("items/weapons/named/named_swordlance", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver | this.Const.Items.WeaponType.Polearm;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == "actives.strike")
		{
			_skill = this.new("scripts/skills/actives/legend_scythe_cleave_skill"); // replace strike with scythe cleave
			_skill.m.Icon = "skills/active_200.png";
			_skill.m.IconDisabled = "skills/active_200_sw.png";
			_skill.m.Overlay = "active_200";
		}

		weapon.addSkill(_skill);
	}
});
