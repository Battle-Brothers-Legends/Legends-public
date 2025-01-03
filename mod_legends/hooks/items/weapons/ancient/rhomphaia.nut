::mods_hookExactClass("items/weapons/ancient/rhomphaia", function(o) {
	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == "actives.slash")
			_skill.m.isGreatSlash = true;

		named_weapon.addSkill(_skill);
	}
});