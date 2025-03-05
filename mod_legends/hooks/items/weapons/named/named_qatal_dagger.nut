::mods_hookExactClass("items/weapons/named/named_qatal_dagger", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2];
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
