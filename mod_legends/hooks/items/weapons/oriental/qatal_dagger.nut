::mods_hookExactClass("items/weapons/oriental/qatal_dagger", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Value = 750;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == "actives.deathblow")
		{
			_skill = ::new("scripts/skills/actives/deathblow_skill"); // replace strike with scythe cleave
			_skill.m.DeathblowBonus = true;
		}

		weapon.addSkill(_skill);
	}
});
