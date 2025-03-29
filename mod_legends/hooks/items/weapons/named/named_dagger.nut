::mods_hookExactClass("items/weapons/named/named_dagger", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
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
