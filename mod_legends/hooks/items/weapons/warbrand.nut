::mods_hookExactClass("items/weapons/warbrand", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Value = 1700;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Slash))
			_skill.m.isGreatSlash = true;

		this.weapon.addSkill(_skill);
	}
});
