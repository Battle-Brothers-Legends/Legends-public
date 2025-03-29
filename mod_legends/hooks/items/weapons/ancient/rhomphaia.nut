::mods_hookExactClass("items/weapons/ancient/rhomphaia", function(o) {
	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Slash))
			_skill.m.IsGreatSlash = true;

		this.weapon.addSkill(_skill);
	}
});
