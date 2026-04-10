::mods_hookExactClass("items/weapons/falchion", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/sword_04" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/sword_04" + v + ".png";
		this.m.ArmamentIcon = "icon_sword_04" + v;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Slash))
			_skill.m.IsBreachSlash = true;

		this.weapon.addSkill(_skill);
	}

});
