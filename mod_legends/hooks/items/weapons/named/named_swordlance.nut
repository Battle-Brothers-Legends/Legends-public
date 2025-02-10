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
		local skill = this.new("scripts/skills/actives/legend_scythe_cleave_skill")
		skill.m.Icon = "skills/active_200.png";
		skill.m.IconDisabled = "skills/active_200_sw.png";
		skill.m.Overlay = "active_200";
			_skill = ::new("scripts/skills/actives/legend_scythe_cleave_skill"); // replace strike with scythe cleave

		weapon.addSkill(_skill);
	}
});
