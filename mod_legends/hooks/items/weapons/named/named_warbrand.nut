::mods_hookExactClass("items/weapons/named/named_warbrand", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3]
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == "actives.slash")
			_skill.m.isGreatSlash = true;

		named_weapon.addSkill(_skill);
	}
});
