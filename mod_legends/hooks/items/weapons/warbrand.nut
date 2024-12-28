::mods_hookExactClass("items/weapons/warbrand", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Value = 1700;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == "actives.slash")
			_skill.m.isGreatSlash = true;

		named_weapon.addSkill(_skill);
	}
});
