::mods_hookExactClass("items/weapons/oriental/qatal_dagger", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 750;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		if (this.getVariant() == 0) {
			this.m.Icon = "weapons/melee/qatal_dagger_01_70x70.png";
			this.m.IconLarge = "weapons/melee/qatal_dagger_01.png";
			this.m.ArmamentIcon = "icon_qatal_dagger";
		} else {
			this.m.Icon = "weapons/melee/qatal_dagger_01_" + this.getVariant() + "_70x70.png";
			this.m.IconLarge = "weapons/melee/qatal_dagger_01_" + this.getVariant() + ".png";
			this.m.ArmamentIcon = "icon_qatal_dagger_01_" + this.getVariant();
		}
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == "actives.deathblow")
		{
			_skill = ::new("scripts/skills/actives/deathblow_skill");
			_skill.m.DeathblowBonus = true;
		}

		weapon.addSkill(_skill);
	}
});
