::mods_hookExactClass("items/weapons/named/named_qatal_dagger", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Deathblow))
		{
			::Legends.Actives.grant(this.weapon, ::Legends.Active.Deathblow, function (_skill)
			{
				_skill.m.DeathblowBonus = true;
			}.bindenv(this));
			return;
		}

		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Stab))
		{
			::Legends.Actives.grant(this.weapon, ::Legends.Active.Stab, function (_skill)
			{
				_skill.m.IsQatalStab = true;
			}.bindenv(this));
			return;
		}

		weapon.addSkill(_skill);
	}
});
