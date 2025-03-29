::mods_hookExactClass("items/weapons/named/named_warscythe", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver | this.Const.Items.WeaponType.Polearm;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == "actives.strike")
			_skill = ::new("scripts/skills/actives/legend_scythe_cleave_skill"); // replace strike with scythe cleave

		weapon.addSkill(_skill);
	}
});
